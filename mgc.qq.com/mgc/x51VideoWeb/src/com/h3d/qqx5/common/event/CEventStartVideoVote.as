package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteStartInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;

	public class CEventStartVideoVote extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVoteEvent.CLSID_CEventStartVideoVote;
		}
		
		public function CEventStartVideoVote()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("zone_id", "", Descriptor.Int32, 2);
			registerField("start_info", getQualifiedClassName(VideoVoteStartInfo), Descriptor.Compound, 3);
		}
		
		public var room_id : int;
		public var zone_id : int;
		public var start_info :VideoVoteStartInfo = new VideoVoteStartInfo;
	}
}
