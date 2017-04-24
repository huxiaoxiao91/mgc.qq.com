package com.h3d.qqx5.video_rank_server.shared
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoStarAnchorRank extends ProtoBufSerializable
	{
		public function VideoStarAnchorRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("talent_show_starlight", "", Descriptor.Int32, 2);
			registerField("talent_show_scores", "", Descriptor.Int32, 3);
			registerField("talent_show_vote", "", Descriptor.Int32, 4);
			registerField("score", "", Descriptor.Int64, 5);
			registerField("session", "", Descriptor.Int32, 6);
			registerField("onboard_time", "", Descriptor.Int32, 7);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 8);
			registerField("record_id", "", Descriptor.Int64, 9);
		}
		public var anchor_id : Int64;
		public var talent_show_starlight : int;
		public var talent_show_scores : int;
		public var talent_show_vote : int;
		public var score : Int64;
		public var session : int;
		public var onboard_time : int;
		public var anchor_nick_str : String;
		public var record_id : Int64;
	}
}
