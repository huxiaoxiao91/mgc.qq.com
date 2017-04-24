package com.h3d.qqx5.video_rank_server.shared
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoGuildRank extends ProtoBufSerializable
	{
		public function VideoGuildRank()
		{
			registerField("guild_id", "", Descriptor.Int64, 1);
			registerField("active_score", "", Descriptor.Int32, 2);
			registerField("guild_chairman", "", Descriptor.TypeString, 3);
			registerField("guild_name", "", Descriptor.TypeString, 4);
			registerField("session", "", Descriptor.Int32, 5);
			registerField("onboard_time", "", Descriptor.Int32, 6);
			registerField("record_id", "", Descriptor.Int64, 7);
			registerField("anchor_id", "", Descriptor.Int64, 8);
			registerField("score", "", Descriptor.Int32, 9);
			registerField("anchor_name", "", Descriptor.TypeString, 10);
			registerField("chief_id", "", Descriptor.Int64, 11);
			registerField("anchor_url", "", Descriptor.TypeString, 12);
			registerField("player_url", "", Descriptor.TypeString, 13);
			
		}
		public var guild_id : Int64 = new Int64();
		public var active_score : int;
		public var guild_chairman : String ="";
		public var guild_name : String ="";
		public var session : int;
		public var onboard_time : int;
		public var record_id : Int64 = new Int64() ;
		public var anchor_id : Int64 = new Int64();
		public var score : int;
		public var anchor_name : String ="";
		public var chief_id : Int64 = new Int64();
		public var anchor_url : String ="";
		public var player_url : String ="";
	}
}
