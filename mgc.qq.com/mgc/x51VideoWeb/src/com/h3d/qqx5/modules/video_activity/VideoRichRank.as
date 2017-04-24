package com.h3d.qqx5.modules.video_activity
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoRichRank extends ProtoBufSerializable
	{
		public function VideoRichRank()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("player_nick_str", "", Descriptor.TypeString, 2);
			registerField("onboard_time", "", Descriptor.Int64, 3);
			registerField("record_id", "", Descriptor.Int64, 4);
			registerField("video_wealth", "", Descriptor.Int64, 5);
			registerField("session", "", Descriptor.Int32, 6);
			registerField("player_zone_str", "", Descriptor.TypeString, 7);
			registerField("score", "", Descriptor.Int32, 8);
			registerField("have_portrait", "", Descriptor.Int32, 9);
			registerField("vip_level", "", Descriptor.Int32, 10);
			registerField("last_order", "", Descriptor.Int32, 11);
			registerField("rank_timedimension", "", Descriptor.Int32, 12);
			registerField("face_url", "", Descriptor.TypeString, 13);
			registerField("wealth_level", "", Descriptor.Int32, 14);
			registerField("video_wealth_total", "", Descriptor.Int64, 15);
		}
		public var player_id : Int64 = new Int64();
		public var player_nick_str : String ="";
		public var onboard_time : Int64 = new Int64();
		public var record_id : Int64 = new Int64();
		public var video_wealth : Int64 = new Int64();
		public var session : int;
		public var player_zone_str : String = "";
		public var score : int;
		public var have_portrait:int; 
		public var vip_level:int;
		public var last_order:int;
		public var rank_timedimension:int;
		public var face_url:String = "";
		public var wealth_level:int;//财富等级
		public var video_wealth_total:Int64 = new Int64(0);
	}
}
