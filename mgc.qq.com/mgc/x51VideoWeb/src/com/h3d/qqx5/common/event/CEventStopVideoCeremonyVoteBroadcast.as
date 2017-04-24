package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventStopVideoCeremonyVoteBroadcast extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventStopVideoCeremonyVoteBroadcast;
		}
		
		public function CEventStopVideoCeremonyVoteBroadcast()
		{
			registerFieldForList("anchors", "", Descriptor.TypeString, 1);
		}
		
		public var anchors : Array;
	}
}
