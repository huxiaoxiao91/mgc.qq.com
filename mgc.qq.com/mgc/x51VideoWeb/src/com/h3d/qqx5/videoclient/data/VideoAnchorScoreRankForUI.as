package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoAnchorScoreRankForUI
	{
		public var m_anchor_id:String = "0";
		public var m_score:String = "0";
		public var m_anchor_name:String = "";
		public var m_anchor_portrait_url:String = "";
		public var m_anchor_status:int = 0;
		public var m_room_id:int = 0;
		public var m_anchor_gender:int;//主播性别 0 男 1 女
		public var m_is_nest:Boolean = false;//是否是在小窝中直波播
		public var m_order_change:int = 0;//名词次变化
		public var m_anchor_level:int = 0;//主播等级
	}
}