package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;

	public class CEventGetVideoVoteStartInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVoteEvent.CLSID_CEventGetVideoVoteStartInfoRes;
		}
		
		public function CEventGetVideoVoteStartInfoRes()
		{
			registerField("player_pid", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("vote_info", getQualifiedClassName(com.h3d.qqx5.video_service.serviceinf.VideoVoteInfo), Descriptor.Compound, 3);
			registerFieldForList("selects", "", Descriptor.Int32, 4);
		}
		
		public var player_pid : Int64;
		public var result : int;
		public var vote_info :VideoVoteInfo;
		public var selects : Array;
	}
}
