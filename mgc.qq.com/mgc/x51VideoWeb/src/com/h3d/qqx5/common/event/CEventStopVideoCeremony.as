package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventStopVideoCeremony extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventStopVideoCeremony;
		}
		
		public function CEventStopVideoCeremony()
		{
			registerField("transid", "", Descriptor.Int64, 1);
			registerField("sender_room_id", "", Descriptor.Int32, 2);
			registerField("sender_id", "", Descriptor.Int64, 3);
		}
		
		public var transid : Int64;
		public var sender_room_id : int;
		public var sender_id : Int64;
	}
}
