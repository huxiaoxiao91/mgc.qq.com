package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoTwoweekStarlightRank extends ProtoBufSerializable
	{
		public function VideoTwoweekStarlightRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 2);
			registerField("score", "", Descriptor.Int64, 3);
			registerField("session", "", Descriptor.Int32, 4);
			registerField("onboard_time", "", Descriptor.Int32, 5);
			registerField("record_id", "", Descriptor.Int64, 6);
			registerField("rank_type", "", Descriptor.Int32, 7);
			registerField("starlight", "", Descriptor.Int64, 8);
			registerField("anchor_status", "", Descriptor.Int32, 9);
			registerField("room_id", "", Descriptor.Int32, 10);
			registerField("m_anchor_url", "", Descriptor.TypeString, 11);
			registerField("anchor_gender", "", Descriptor.Int32, 12);
			registerField("is_nest", "", Descriptor.TypeBoolean, 13);
			
		}
		public var anchor_id : Int64;
		public var anchor_nick_str : String ="";
		public var score : Int64;
		public var session : int;
		public var onboard_time : int;
		public var record_id : Int64;
		public var rank_type : int;
		public var starlight : Int64;
		public var anchor_status:int;//主播状态0 离线 1 在线为直播 2直播中
		public var room_id:int;//房间号，如果主播在直播中
		public var m_anchor_url:String = "";//
		public var anchor_gender:int;//主播性别 0 女 1男
		public var is_nest:Boolean;//是否是小窝
	}
}
