package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoRaffle extends INetMessage
	{
		public override function CLSID() : int
		{
			return RaffleEventID.CLSID_CEventVideoRaffle;
		}
		public function CEventVideoRaffle()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("vip_level", "", Descriptor.Int32, 3);
			registerField("nick", "", Descriptor.TypeString, 4);
			registerField("gender", "", Descriptor.Int32, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
		}
		public var player_id : Int64;
		public var room_id : int;
		public var vip_level : int;
		public var nick : String= "";
		public var gender : int;
		public var serial_id:int;
	}
}
