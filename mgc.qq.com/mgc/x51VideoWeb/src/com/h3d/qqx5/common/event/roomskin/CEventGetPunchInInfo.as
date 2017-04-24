package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 获取打卡界面信息请求
	 * @author gaolei
	 *
	 */
	public class CEventGetPunchInInfo extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventGetPunchInInfo;
		}

		public function CEventGetPunchInInfo() {
			super();
		}
	}
}
