package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoVIPRank extends ProtoBufSerializable
	{
		public function VideoVIPRank()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("player_nick_str", "", Descriptor.TypeString, 2);
			registerField("vip_level", "", Descriptor.Int32, 3);
			registerField("onboard_time", "", Descriptor.Int32, 4);
			registerField("record_id", "", Descriptor.Int64, 5);
			registerField("video_wealth", "", Descriptor.Int64, 6);
			registerField("session", "", Descriptor.Int32, 7);
			registerField("score", "", Descriptor.Int32, 8);
			registerField("player_zone_str", "", Descriptor.TypeString, 9);
		}
		public var player_id : Int64;
		public var player_nick_str : String ="";
		public var vip_level : int;
		public var onboard_time : int;
		public var record_id : Int64;
		public var video_wealth : Int64;
		public var session : int;
		public var score : int;
		public var player_zone_str : String ="";
	}
}
