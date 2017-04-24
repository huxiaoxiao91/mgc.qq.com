package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class VideoAnchorPKWinnerRank extends ProtoBufSerializable
	{
		
		public function VideoAnchorPKWinnerRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("anchor_nick", "", Descriptor.TypeString, 2);
			registerField("session", "", Descriptor.Int32, 3);
			registerField("guild_id","",Descriptor.Int64, 4);
			registerField("guild_name", "", Descriptor.TypeString, 5);
			registerField("rank", "", Descriptor.Int32, 6);
			registerField("onboard_time", "", Descriptor.Int32, 7);
			registerField("record_id", "", Descriptor.Int64, 8);
			registerField("score", "", Descriptor.Int32, 9);
			registerField("anchor_status", "", Descriptor.Int32, 10);
			registerField("room_id", "", Descriptor.Int32, 11);
			registerField("m_anchor_url", "", Descriptor.TypeString, 12);
			registerField("is_nest", "", Descriptor.TypeString, 13);
		}
		
		public var anchor_id : Int64 = new Int64(0,0);
		public var anchor_nick : String = "";
		public var session : int;
		public var guild_id:Int64 = new Int64(0,0);
		public var guild_name : String = "";
		public var rank : int;
		public var onboard_time :int;//hss
		public var record_id : Int64= new Int64(0,0);
		public var score : int;
		public var anchor_status:int;//主播状态 0 离线 1 在线为直播 2 直播中
		public var room_id:int;//直播中表示直播房间id
		public var m_anchor_url:String = "";
		public var is_nest:Boolean;//是否是在小窝中直波
	}
}
