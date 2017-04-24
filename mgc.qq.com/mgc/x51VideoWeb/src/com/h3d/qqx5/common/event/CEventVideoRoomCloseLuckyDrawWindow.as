package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 关闭抽奖界面
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomCloseLuckyDrawWindow extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomCloseLuckyDrawWindow;
		}

		public function CEventVideoRoomCloseLuckyDrawWindow() {
			super();
		}
	}
}
