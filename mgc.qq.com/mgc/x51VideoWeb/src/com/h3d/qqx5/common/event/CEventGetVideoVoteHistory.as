package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;

	public class CEventGetVideoVoteHistory extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVoteEvent.CLSID_CEventGetVideoVoteHistory;
		}
		
		public function CEventGetVideoVoteHistory()
		{
			registerField("anchor_pid", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var anchor_pid : Int64;
		public var room_id : int;
	}
}
