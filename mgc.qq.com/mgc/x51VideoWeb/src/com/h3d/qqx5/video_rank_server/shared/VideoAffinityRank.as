package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoAffinityRank extends ProtoBufSerializable
	{
		public function VideoAffinityRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("nick_str", "", Descriptor.TypeString, 3);
			registerField("zone_str", "", Descriptor.TypeString, 4);
			registerField("score", "", Descriptor.Int64, 5);
			registerField("session", "", Descriptor.Int32, 6);
			registerField("onboard_time", "", Descriptor.Int32, 7);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 8);
			registerField("record_id", "", Descriptor.Int64, 9);
			registerField("guard_level", "", Descriptor.Int32, 10);
			registerField("vip_level", "", Descriptor.Int32, 11);
			registerField("rank_type", "", Descriptor.Int32, 12);
			registerField("player_portrait", "", Descriptor.Int32, 13);
			registerField("anchor_status", "", Descriptor.Int32, 14);
			registerField("room_id", "", Descriptor.Int32, 15);
			registerField("m_anchor_url", "", Descriptor.TypeString, 16);
			registerField("m_player_url", "", Descriptor.TypeString, 17);
			registerField("player_gender", "", Descriptor.Int32, 18);
			registerField("anchor_gender", "", Descriptor.Int32, 19);
			registerField("last_order", "", Descriptor.Int32, 20);
			registerField("anchor_level", "", Descriptor.Int32, 21);
		}
		public var anchor_id : Int64;
		public var player_id : Int64;
		public var nick_str : String = "";
		public var zone_str : String = "";
		public var score : Int64;
		public var session : int;
		public var onboard_time : int;
		public var anchor_nick_str : String = "";
		public var record_id : Int64;
		public var guard_level : int;
		public var vip_level : int;
		public var rank_type : int;
		public var player_portrait : int;//0表示没有，非0表示有上传是
		public var anchor_status:int;//主播状态0 离线 1 在线为直播 2直播中
		public var room_id:int;//若主播正在直播，表示房间号
		public var m_anchor_url:String = "";
		public var m_player_url:String = "";
		public var player_gender:int;//玩家性别 0 女 1 男
		public var anchor_gender:int;//主播性播
		public var last_order:int;//排名变化
		public var anchor_level:int;//主播等级
	}
}
