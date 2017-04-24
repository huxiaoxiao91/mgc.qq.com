package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoStarGiftPlayerRank extends ProtoBufSerializable
	{
		public function VideoStarGiftPlayerRank()
		{
			registerField("gift_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("player_nick_str", "", Descriptor.TypeString, 3);
			registerField("zone_str", "", Descriptor.TypeString, 4);
			registerField("sex", "", Descriptor.Int32, 5);
			registerField("have_portrait", "", Descriptor.Int32, 6);
			registerField("wealth_level", "", Descriptor.Int32, 7);
			registerField("last_order", "", Descriptor.Int32, 8);
			registerField("session", "", Descriptor.Int32, 10);
			registerField("score", "", Descriptor.Int32, 11);
			registerField("record_id", "", Descriptor.Int32, 12);
			registerField("portrait_url", "", Descriptor.TypeString, 13);
		}
		
		public var gift_id:int;
		public var player_id:Int64 = new Int64();
		public var player_nick_str:String ="";
		public var zone_str:String="";
		public var sex:int;
		public var have_portrait:int;
		public var wealth_level:int;
		public var last_order:int;
		public var session:int;
		public var score:int;
		public var record_id:int;
		public var portrait_url:String="";
	}
}