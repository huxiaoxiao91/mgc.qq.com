package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVSStopDeputyAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVSStopDeputyAnchor;
		}
		
		public function CEventVSStopDeputyAnchor()
		{
			registerField("deputy_anchor", "", Descriptor.Int64, 1);
			registerField("deputy_anchor_zone_id", "", Descriptor.Int32, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("stop_reason", "", Descriptor.Int32, 4);
		}
		
		public var deputy_anchor : Int64;
		public var deputy_anchor_zone_id : int;
		public var room_id : int;
		public var stop_reason : int;
	}
}
