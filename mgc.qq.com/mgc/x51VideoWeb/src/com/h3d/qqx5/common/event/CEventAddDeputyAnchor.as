package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventAddDeputyAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventAddDeputyAnchor;
		}
		
		public function CEventAddDeputyAnchor()
		{
			registerField("deputy_name", "", Descriptor.TypeString, 1);
			registerField("deputy_zone_name", "", Descriptor.TypeString, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("anchor_qq", "", Descriptor.Int64, 4);
		}
		
		public var deputy_name : String;
		public var deputy_zone_name : String;
		public var room_id : int;
		public var anchor_qq : Int64;
	}
}
