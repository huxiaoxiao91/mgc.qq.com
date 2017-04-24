package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoVoteInfo extends ProtoBufSerializable
	{
		public function VideoVoteInfo()
		{
			registerField("vote_id", "", Descriptor.Int64, 1);
			registerField("vote_topic", "", Descriptor.TypeString, 2);
			registerField("anchor", "", Descriptor.Int64, 3);
			registerField("anchor_name", "", Descriptor.TypeString, 4);
			registerField("start_voting_time", "", Descriptor.Int32, 5);
			registerField("end_voting_time", "", Descriptor.Int32, 6);
			registerField("optional_max_count", "", Descriptor.Int32, 7);
			registerFieldForList("vote_entries", getQualifiedClassName(VideoVoteEntry), Descriptor.Compound, 8);
		}
		
		public var vote_id : Int64 = new Int64;
		public var vote_topic : String ="";
		public var anchor : Int64 = new Int64;
		public var anchor_name : String = "";
		public var start_voting_time : int;
		public var end_voting_time : int;
		public var optional_max_count : int;
		public var vote_entries : Array = new Array;
	}
}
