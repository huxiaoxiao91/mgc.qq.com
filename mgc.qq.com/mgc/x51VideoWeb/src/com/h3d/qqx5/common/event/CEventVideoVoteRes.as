package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;

	public class CEventVideoVoteRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVoteEvent.CLSID_CEventVideoVoteRes;
		}
		
		public function CEventVideoVoteRes()
		{
			registerField("player_pid", "", Descriptor.Int64, 1);
			registerField("operation", "", Descriptor.Int32, 2);
			registerField("result", "", Descriptor.Int32, 3);
		}
		
		public var player_pid:Int64;
		public var operation:int;
		public var result:int;
	}
}
