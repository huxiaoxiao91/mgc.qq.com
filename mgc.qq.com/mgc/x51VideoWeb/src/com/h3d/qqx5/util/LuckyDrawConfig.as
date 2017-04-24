package com.h3d.qqx5.util {

	import com.h3d.qqx5.common.comdata.LuckyDrawNotice;
	import com.h3d.qqx5.common.comdata.VideoLuckyDrawInfo;
	
	import flash.utils.clearInterval;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * 幸运抽奖配置信息
	 * @author gaolei
	 *
	 */
	public class LuckyDrawConfig extends Cookie {
		public function LuckyDrawConfig(file_name:String = "") {
			super(NAME);
			if (_instance != null) {
				throw new Error("已经实例化，请使用instance方法操作。");
			}
		}

		private static var _instance:LuckyDrawConfig;

		public static function get instance():LuckyDrawConfig {
			if (_instance == null) {
				_instance = new LuckyDrawConfig();
			}
			return _instance;
		}

		public static const NAME:String              = "lucyDrawConfig";

		private static const KEY_REFRESH_TIME:String = "refreshTiem";
		private static const KEY_CONFIG_DATA:String  = "configData";
		private static const KEY_NOTICE_LIST:String  = "noticeList";

		public function updateConfig(refreshTime:int, info:VideoLuckyDrawInfo):void {
			_confitData = info;
			flushData(KEY_REFRESH_TIME, refreshTime);
			flushData(KEY_CONFIG_DATA, JSON.stringify(info));
		}

		public function get refreshTime():int {
			var timestr:String = getData(KEY_REFRESH_TIME);
			if (timestr != null) {
				return parseInt(timestr);
			} else {
				return 0;
			}
		}

		private var _confitData:VideoLuckyDrawInfo;

		public function get confitData():VideoLuckyDrawInfo {
			if (_confitData == null) {
				var configJson:String = getData(KEY_CONFIG_DATA);
				_confitData = VideoLuckyDrawInfo.parseJson(configJson);
			}
			return _confitData;
		}



		private var noticeList:Array = [];

		private var saveNoticeListTimerIndex:uint;

		public function pushNotice(notice:LuckyDrawNotice):void {
			noticeList.push(notice);
			while (noticeList.length > 4) {
				noticeList.shift();
			}
			clearTimeout(saveNoticeListTimerIndex);
			saveNoticeListTimerIndex = setTimeout(saveNotices, 2000);
		}

		public function getNoticeList():Array {
			if (noticeList == null || noticeList.length == 0) {
				var jsonList:Array = getData(KEY_NOTICE_LIST);
				if (jsonList != null && jsonList.length > 0) {
					for each (var noticeJsonStr:String in jsonList) {
						var noticeJson:Object = JSON.parse(noticeJsonStr); 
						var notice:LuckyDrawNotice = new LuckyDrawNotice();
						for (var key:String in noticeJson) {
							if (notice.hasOwnProperty(key)) {
								if (key == "reward") {
									for (var rkey:String in noticeJson[key]) {
										if (notice.reward.hasOwnProperty(rkey)) {
											notice.reward[rkey] = noticeJson[key][rkey];
										}
									}
								} else {
									notice[key] = noticeJson[key];
								}
							}
						}
						noticeList.push(notice);
					}
				}
			}
			return noticeList;
		}

		public function saveNotices():void {
			clearTimeout(saveNoticeListTimerIndex);
			if (noticeList != null && noticeList.length > 0) {
				var jsonList:Array = [];
				for each (var notice:LuckyDrawNotice in noticeList) {
					jsonList.push(JSON.stringify(notice));
				}
				flushData(KEY_NOTICE_LIST, jsonList);
			}
		}
	}
}
