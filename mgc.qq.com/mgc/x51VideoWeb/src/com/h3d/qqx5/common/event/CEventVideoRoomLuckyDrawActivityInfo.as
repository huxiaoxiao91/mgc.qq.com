package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * TODO:待完成
	 * 玩家进房返回上一次免费抽奖时间
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomLuckyDrawActivityInfo extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawActivityInfo;
		}

		public function CEventVideoRoomLuckyDrawActivityInfo() {
			super();

			registerField("last_free_lucky_draw_time", "", Descriptor.Int32, 1);
			registerField("free_lucky_draw_interval", "", Descriptor.Int32, 2);
			registerField("activity_begin_time", "", Descriptor.Int32, 3);
			registerField("config_refresh_time", "", Descriptor.Int32, 4);
		}

		/**
		 * 1.上一次免费抽奖的时间
		 */
		public var last_free_lucky_draw_time:int;
		/**
		 * 2.获取免费抽奖次数间隔
		 */
		public var free_lucky_draw_interval:int;
		/**
		 * 3.开始时间
		 */
		public var activity_begin_time:int;
		/**
		 * 4.配置刷新时间
		 */
		public var config_refresh_time:int;
	}
}
