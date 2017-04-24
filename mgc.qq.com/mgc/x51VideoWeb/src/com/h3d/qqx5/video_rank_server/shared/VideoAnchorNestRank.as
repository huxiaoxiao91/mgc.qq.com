package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class VideoAnchorNestRank extends ProtoBufSerializable
	{
		public function VideoAnchorNestRank()
		{
			registerField("room_id", "", Descriptor.Int64, 1);
			registerField("nest_id", "", Descriptor.Int32, 2);
			registerField("anchor_id", "", Descriptor.Int64, 3);
			registerField("anchor_name", "", Descriptor.TypeString, 4);
			registerField("score", "", Descriptor.Int64, 5);
			registerField("status", "", Descriptor.Int32, 6);
			registerField("date_time", "", Descriptor.Int32, 7);
			registerField("record_id", "", Descriptor.Int64, 8);
			registerField("session", "", Descriptor.Int32, 9);
		}
		
		public var room_id : Int64;
		public var nest_id : int;
		public var anchor_id : Int64;
		public var anchor_name : String = "";
		public var score : Int64;
		public var status : int;
		public var date_time : int;
		public var record_id : Int64;
		public var session : int;
	}
}
