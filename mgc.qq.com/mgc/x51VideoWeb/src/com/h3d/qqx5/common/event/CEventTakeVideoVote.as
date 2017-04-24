package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;

	public class CEventTakeVideoVote extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVoteEvent.CLSID_CEventTakeVideoVote;
		}
		
		public function CEventTakeVideoVote()
		{
			registerField("zone_id", "", Descriptor.Int32, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("player_pid", "", Descriptor.Int64, 3);
			registerField("vote_id", "", Descriptor.Int64, 4);
			registerFieldForList("selects", "", Descriptor.Int32, 5);
		}
		
		public var zone_id : int;
		public var room_id : int;
		public var player_pid : Int64;
		public var vote_id : Int64;
		public var selects : Array;
	}
}
