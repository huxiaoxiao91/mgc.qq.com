package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoAnchorScoreRank extends ProtoBufSerializable
	{
		public function VideoAnchorScoreRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("score", "", Descriptor.Int64, 2);
			registerField("anchor_name", "", Descriptor.TypeString, 3);
			registerField("session", "", Descriptor.Int32, 4);
			registerField("onboard_time", "", Descriptor.Int32, 5);
			registerField("record_id", "", Descriptor.Int64, 6);
			registerFieldForList("guildrank", getQualifiedClassName(GuildRank), Descriptor.Compound, 7);
			registerField("anchor_status", "", Descriptor.Int32, 8);
			registerField("room_id", "", Descriptor.Int32, 9);
			registerField("m_anchor_url", "", Descriptor.TypeString, 10);
			registerField("anchor_gender", "", Descriptor.Int32, 11);
			registerField("is_nest", "", Descriptor.TypeBoolean, 12);
			registerField("last_order", "", Descriptor.Int32, 13);
			registerField("rank_timedimension", "", Descriptor.Int32, 14);
			registerField("anchor_level", "", Descriptor.Int32, 15);
		}
		public var anchor_id : Int64 = Int64.fromNumber(0);//主播qq
		public var score : Int64 = Int64.fromNumber(0);//上个月积分
		public var anchor_name : String ="";//主播昵称
		public var session : int = 0;
		public var onboard_time : int = 0;
		public var record_id : Int64 = Int64.fromNumber(0);
		public var guildrank : Array = new Array;
		public var anchor_status:int;
		public var room_id:int;//
		public var m_anchor_url:String = "";
		public var anchor_gender:int;//主播性别 0 女 1 男
		public var is_nest:Boolean;//是否是在小窝中直播
		public var last_order:int;   //排名变化
		public var rank_timedimension:int ;
		public var anchor_level:int;//主播等级
	}
}
