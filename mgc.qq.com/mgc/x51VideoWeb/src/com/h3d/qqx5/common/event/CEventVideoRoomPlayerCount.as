package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoRoomPlayerCount extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoom.CLSID_CEventVideoRoomPlayerCount;
		}

		public function CEventVideoRoomPlayerCount() {
			registerField("player_count", "", Descriptor.Int32, 1);
			registerField("default_chat_cd", "", Descriptor.Int32, 2);
			registerField("player_capacity", "", Descriptor.Int32, 3);
		}

		public var player_count:int;

		public var default_chat_cd:int;
		/**
		 * 房间总人数
		 */
		public var player_capacity:int;
	}
}
