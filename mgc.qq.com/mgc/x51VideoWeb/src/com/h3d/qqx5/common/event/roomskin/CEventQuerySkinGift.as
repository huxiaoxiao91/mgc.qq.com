package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 询问皮肤礼物信息
	 * @author gaolei
	 *
	 */
	public class CEventQuerySkinGift extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventQuerySkinGift;
		}

		public function CEventQuerySkinGift() {
			super();
		}
	}
}
