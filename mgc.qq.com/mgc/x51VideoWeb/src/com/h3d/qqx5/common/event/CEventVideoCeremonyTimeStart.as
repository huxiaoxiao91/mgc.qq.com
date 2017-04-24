package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyTimeStart extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyTimeStart;
		}
		
		public function CEventVideoCeremonyTimeStart()
		{
			registerField("main_room_id", "", Descriptor.Int32, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
		}
		
		public var main_room_id : int;
		public var anchor_id : Int64;
	}
}
