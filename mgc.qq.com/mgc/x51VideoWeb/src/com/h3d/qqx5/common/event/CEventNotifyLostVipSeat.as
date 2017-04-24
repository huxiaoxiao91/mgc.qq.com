package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyLostVipSeat extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventNotifyLostVipSeat;
		}
		public function CEventNotifyLostVipSeat()
		{
			registerField("seat_index", "", Descriptor.Int32, 1);
			registerField("cost", "", Descriptor.Int32, 2);
			registerField("player_nick", "", Descriptor.TypeString, 3);
			registerField("player_zone", "", Descriptor.TypeString, 4);
		}
		public var seat_index : int;
		public var cost : int;
		public var player_nick : String = "";
		public var player_zone : String = "";
	}
}
