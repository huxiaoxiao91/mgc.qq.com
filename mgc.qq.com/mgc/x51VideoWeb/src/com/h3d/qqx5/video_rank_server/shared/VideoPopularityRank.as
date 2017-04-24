package com.h3d.qqx5.video_rank_server.shared
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoPopularityRank extends ProtoBufSerializable
	{
		public function VideoPopularityRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 2);
			registerField("score", "", Descriptor.Int64, 3);
			registerField("session", "", Descriptor.Int32, 4);
			registerField("onboard_time", "", Descriptor.Int32, 5);
			registerField("record_id", "", Descriptor.Int64, 6);
		}
		public var anchor_id : Int64;
		public var anchor_nick_str : String ="";
		public var score : Int64;
		public var session : int;
		public var onboard_time :int;
		public var record_id : Int64;
	}
}
