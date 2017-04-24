package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 打开抽奖界面
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomOpenLuckyDrawWindow extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomOpenLuckyDrawWindow;
		}

		public function CEventVideoRoomOpenLuckyDrawWindow() {
			super();

			registerField("begin_time", "", Descriptor.Int32, 1);
			registerField("config_refresh_time", "", Descriptor.Int32, 2);
		}

		/**
		 * 当前抽奖配置的开始时间
		 */
		public var begin_time:int;
		/**
		 * 更新配置的时间
		 */
		public var config_refresh_time:int;
	}
}
