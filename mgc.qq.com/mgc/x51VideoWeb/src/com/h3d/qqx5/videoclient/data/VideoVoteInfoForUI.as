package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoVoteInfoForUI
	{
		public var vote_id:String = "";
		public var vote_topic:String = "";
		public var anchor:String = "";
		public var anchor_name:String = "";
		public var start_voting_time:int = 0;
		public var end_voting_time:int = 0;
		public var optional_max_count:int = 0;
		public var vote_entries:Array = new Array;		
	}
}