package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoStarGiftAnchorRank extends ProtoBufSerializable
	{
		public function VideoStarGiftAnchorRank()
		{
			registerField("gift_id", "", Descriptor.Int32, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 3);
			registerField("anchor_level", "", Descriptor.Int32, 4);
			registerField("last_order", "", Descriptor.Int32, 5);
//			registerField("m_onboard_time", "", Descriptor.Int32, 6);DB用的无须转
			registerField("session", "", Descriptor.Int32, 7);
			registerField("score", "", Descriptor.Int32, 8);
			
			registerField("portrait_url", "", Descriptor.TypeString, 10);
			registerField("anchor_status", "", Descriptor.Int32, 11);
			registerField("room_id", "", Descriptor.Int32, 12);
		}
		
		public var gift_id:int;
		public var anchor_id:Int64 = new Int64();
		public var anchor_nick_str : String = "";
		public var anchor_level:int;
		public var last_order:int;
		public var session:int;
		public var score:int;
		public var portrait_url:String = "";
		public var anchor_status:int;
		public var room_id:int;
	}
}