package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventStopVideoCeremonyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventStopVideoCeremonyRes;
		}
		
		public function CEventStopVideoCeremonyRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("transid", "", Descriptor.Int64, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
		}
		
		public var result : int;
		public var transid : Int64;
		public var room_id : int;
	}
}
