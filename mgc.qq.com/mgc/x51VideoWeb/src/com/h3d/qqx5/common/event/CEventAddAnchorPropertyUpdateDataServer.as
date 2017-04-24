package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAddAnchorPropertyUpdateDataServer extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventAddAnchorPropertyUpdateDataServer;
		}
		
		public function CEventAddAnchorPropertyUpdateDataServer()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("add_starlight", "", Descriptor.Int32, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
		}
		
		public var player_id :Int64 = new Int64(0,0);
		public var anchor_id : Int64 = new Int64(0,0);
		public var add_starlight : int;
		public var room_id : int;
	}
}
