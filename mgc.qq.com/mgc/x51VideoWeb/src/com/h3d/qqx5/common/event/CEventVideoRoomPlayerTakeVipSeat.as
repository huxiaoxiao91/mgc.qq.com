package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomPlayerTakeVipSeat extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomPlayerTakeVipSeat;
		}
		
		public function CEventVideoRoomPlayerTakeVipSeat()
		{
			registerField("zoneName", "", Descriptor.TypeString, 1);
			registerField("player_nick", "", Descriptor.TypeString, 2);
			registerField("first_vip_seat", "", Descriptor.TypeBoolean, 3);
		}
		
		public var zoneName : String = "";
		public var player_nick : String = "";
		public var first_vip_seat : Boolean;
	}
}
