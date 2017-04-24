package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;

	public class CEventVideoVoteHistoryRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVoteEvent.CLSID_CEventVideoVoteHistoryRes;
		}
		
		public function CEventVideoVoteHistoryRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("anchor_pid", "", Descriptor.Int64, 2);
			registerFieldForList("vote_infos", getQualifiedClassName(VideoVoteInfo), Descriptor.Compound, 3);
		}
		
		public var result :int;
		public var anchor_pid : Int64;
		public var vote_infos : Array = new Array;
	}
}
