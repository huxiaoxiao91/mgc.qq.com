package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 下发解锁皮肤成功走马灯消息
	 * @author gaolei
	 *
	 */
	public class CEventNewRoomSkinBroadcastAllPlayer extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventNewRoomSkinBroadcastAllPlayer;
		}

		public function CEventNewRoomSkinBroadcastAllPlayer() {
			super();

			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("room_name", "", Descriptor.TypeString, 2);
			registerField("room_skin_level", "", Descriptor.Int32, 3);
			registerField("room_skin_id", "", Descriptor.Int32, 4);
		}

		public var room_id:int;

		public var room_name:String;
		/**
		 * 皮肤等级
		 */
		public var room_skin_level:int;
		/**
		 * 房间皮肤id
		 */
		public var room_skin_id:int;
	}
}
