package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventNofityDeputyAnchorChange extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventNofityDeputyAnchorChange;
		}
		
		public function CEventNofityDeputyAnchorChange()
		{
			registerField("player_name", "", Descriptor.TypeString, 1);
			registerField("zone_name", "", Descriptor.TypeString, 2);
			registerField("deputy_id", "", Descriptor.Int64, 3);
		}
		
		public var player_name : String;
		public var zone_name : String;
		public var deputy_id : Int64;
	}
}
