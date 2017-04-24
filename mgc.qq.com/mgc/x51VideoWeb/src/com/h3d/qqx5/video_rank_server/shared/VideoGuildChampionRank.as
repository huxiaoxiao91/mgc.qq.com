package com.h3d.qqx5.video_rank_server.shared
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoGuildChampionRank extends ProtoBufSerializable
	{
		public function VideoGuildChampionRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("gc_starlight", "", Descriptor.Int32, 2);
			registerField("guild_vote", "", Descriptor.Int32, 3);
			registerField("zone_honor", "", Descriptor.Int64, 4);
			registerField("score", "", Descriptor.Int64, 5);
			registerField("session", "", Descriptor.Int32, 6);
			registerField("onboard_time", "", Descriptor.Int32, 7);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 8);
			registerField("record_id", "", Descriptor.Int64, 9);
			registerField("zone_name", "", Descriptor.TypeString, 10);
			registerField("guild_name", "", Descriptor.TypeString, 11);
			registerField("zone_id", "", Descriptor.Int32, 12);
		}
		public var anchor_id : Int64;
		public var gc_starlight : int;
		public var guild_vote : int;
		public var zone_honor : Int64;
		public var score : Int64;
		public var session : int;
		public var onboard_time : int;
		public var anchor_nick_str : String ="";
		public var record_id : Int64;
		public var zone_name : String = "";
		public var guild_name : String = "";
		public var zone_id : int;
	}
}
