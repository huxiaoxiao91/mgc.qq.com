package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomGetLiveCDN extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoom.CLSID_CEventVideoRoomGetLiveCDN;
		}

		public function CEventVideoRoomGetLiveCDN() {
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("client_ip", "", Descriptor.UInt32, 3);
			registerField("client_ip_str", "", Descriptor.TypeString, 4);
			registerField("qq", "", Descriptor.Int64, 5);
		}

		public var room_id:int;
		public var player_id:Int64      = Int64.fromNumber(0);
		public var client_ip:uint       = 0;
		public var client_ip_str:String = "";
		public var qq:Int64             = new Int64(0);
	}
}
