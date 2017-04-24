package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.comdata.VideoLuckyDrawInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	/**
	 * 抽奖信息更新
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomSyncLuckyDrawInfo extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomSyncLuckyDrawInfo;
		}

		public function CEventVideoRoomSyncLuckyDrawInfo() {
			super();

			registerField("config_refresh_time", "", Descriptor.Int32, 1);
			registerField("info", getQualifiedClassName(VideoLuckyDrawInfo), Descriptor.Compound, 2);
		}

		/**
		 * 配置的刷新时间
		 */
		public var config_refresh_time:int;
		/**
		 * 本期抽奖信息
		 */
		public var info:VideoLuckyDrawInfo = new VideoLuckyDrawInfo();
	}
}
