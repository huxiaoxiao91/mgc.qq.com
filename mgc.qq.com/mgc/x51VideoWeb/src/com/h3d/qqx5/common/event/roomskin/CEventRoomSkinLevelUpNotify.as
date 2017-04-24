package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 通知房间皮肤升级
	 * @author gaolei
	 *
	 */
	public class CEventRoomSkinLevelUpNotify extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventRoomSkinLevelUpNotify;
		}

		public function CEventRoomSkinLevelUpNotify() {
			super();

			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("skin_level", "", Descriptor.Int32, 2);
			registerField("room_size", "", Descriptor.Int32, 3);
			registerField("skin_id", "", Descriptor.Int32, 4);
		}

		public var room_id:int;
		/**
		 * 皮肤等级
		 */
		public var skin_level:int;
		/**
		 * 房间人数上限
		 */
		public var room_size:int;
		/**
		 * 皮肤id
		 */
		public var skin_id:int;
	}
}
