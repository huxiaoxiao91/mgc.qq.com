package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * web端通知服务器：任务中心提示引导弹出信息
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomWebTipsNotify extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomWebTipsNotify;
		}

		public function CEventVideoRoomWebTipsNotify() {
			super();
		}
	}
}
