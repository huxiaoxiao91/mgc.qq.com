package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoStarlightRank extends ProtoBufSerializable
	{
		public function VideoStarlightRank()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("anchor_nick_str", "", Descriptor.TypeString, 2);
			registerField("score", "", Descriptor.Int64, 3);
			registerField("session", "", Descriptor.Int32, 4);
			registerField("onboard_time", "", Descriptor.Int32, 5);
			registerField("record_id", "", Descriptor.Int64, 6);
			registerField("rank_type", "", Descriptor.Int32, 7);
			registerField("anchor_status", "", Descriptor.Int32, 8);
			registerField("room_id", "", Descriptor.Int32, 9);		
			registerField("m_anchor_url", "", Descriptor.TypeString, 10);
			registerField("anchor_gender", "", Descriptor.Int32, 11);
			registerField("is_nest", "", Descriptor.TypeBoolean, 12);
			registerField("last_order", "", Descriptor.Int32, 13);
			registerField("rank_timedimension", "", Descriptor.Int32, 14);
			registerField("anchor_level", "", Descriptor.Int32, 15);
		}
		
		public var anchor_id : Int64 = new Int64(0,0);
		public var anchor_nick_str : String = "";
		public var score : Int64 = new Int64(0,0);
		public var session : int;
		public var onboard_time : int;
		public var record_id : Int64 = new Int64(0,0);
		public var rank_type : int;
		public var anchor_status:int;
		public var room_id:int;
		public var m_anchor_url:String = "";
		public var anchor_gender:int;//主播性别 0 女 1 男
		public var is_nest:Boolean;//是否是小窝房间
		public var last_order:int;//排名变化
		public var rank_timedimension:int;//排名维度
		public var anchor_level:int;//主播等级
	}
}
