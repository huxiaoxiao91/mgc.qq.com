package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.comdata.LuckyDrawNotice;
	import com.h3d.qqx5.common.comdata.VideoLuckyDrawInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	public class CEventVideoRoomOpenLuckyDrawWindowRes extends INetMessage {
		//TODO 返回消息号
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomOpenLuckyDrawWindowRes;
		}

		public function CEventVideoRoomOpenLuckyDrawWindowRes() {
			super();

			registerField("res", "", Descriptor.Int32, 1);
			registerField("last_free_lucky_draw_time", "", Descriptor.Int32, 2);
			registerField("config_refresh_time", "", Descriptor.Int32, 3);
			registerField("info", getQualifiedClassName(VideoLuckyDrawInfo), Descriptor.Compound, 4);
			registerFieldForList("notices", getQualifiedClassName(LuckyDrawNotice), Descriptor.Compound, 5);
		}

		/**
		 * 0 -> 成功，活动没有更新
		 */
		public static const RES_SUCC:int            = 0;
		/**
		 * 1 -> 成功，活动已经更新
		 */
		public static const RES_ACTIVITY_UPDATE:int = 1;
		/**
		 * 2 -> 成功，没有活动
		 */
		public static const RES_NO_ACTIVITY:int     = 2;
		/**
		 * 3 -> 失败，房间没有直播
		 */
		public static const RES_NOT_LIVE:int        = 3;


		public var res:int;
		/**
		 * 上次免费抽奖的时间
		 */
		public var last_free_lucky_draw_time:int;
		/**
		 * 更新配置的时间
		 */
		public var config_refresh_time:int;
		/**
		 * 本期抽奖信息
		 */
		public var info:VideoLuckyDrawInfo          = new VideoLuckyDrawInfo();
		/**
		 * 缓存的抽奖公告
		 */
		public var notices:Array                    = new Array();
	}
}
