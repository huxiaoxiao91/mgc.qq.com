package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoVoteInfoDBData extends ProtoBufSerializable
	{
		public function VideoVoteInfoDBData()
		{
			registerField("vote_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("vote_topic", "", Descriptor.TypeString, 3);
			registerField("anchor", "", Descriptor.Int64, 4);
			registerField("anchor_name", "", Descriptor.TypeString, 5);
			registerField("start_voting_time", "", Descriptor.Int32, 6);
			registerField("end_voting_time", "", Descriptor.Int32, 7);
			registerField("optional_max_count", "", Descriptor.Int32, 8);
			registerField("option0", "", Descriptor.TypeString, 9);
			registerField("selcount0", "", Descriptor.Int32, 10);
			registerField("option1", "", Descriptor.TypeString, 11);
			registerField("selcount1", "", Descriptor.Int32, 12);
			registerField("option2", "", Descriptor.TypeString, 13);
			registerField("selcount2", "", Descriptor.Int32, 14);
			registerField("option3", "", Descriptor.TypeString, 15);
			registerField("selcount3", "", Descriptor.Int32, 16);
			registerField("option4", "", Descriptor.TypeString, 17);
			registerField("selcount4", "", Descriptor.Int32, 18);
		}
		
		public var vote_id : Int64;
		public var room_id : int;
		public var vote_topic : String;
		public var anchor : Int64;
		public var anchor_name : String;
		public var start_voting_time : int;
		public var end_voting_time : int;
		public var optional_max_count : int;
		public var option0 : String;
		public var selcount0 : int;
		public var option1 : String;
		public var selcount1 : int;
		public var option2 : String;
		public var selcount2 : int;
		public var option3 : String;
		public var selcount3 : int;
		public var option4 : String;
		public var selcount4 : int;
	}
}
