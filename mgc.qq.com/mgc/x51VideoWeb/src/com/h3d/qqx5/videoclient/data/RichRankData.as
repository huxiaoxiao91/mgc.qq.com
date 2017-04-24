package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class RichRankData
	{
		public var m_player_id:String = "";
		public var m_player_nick:String = "";
		public var m_video_wealth:String="";
		public var m_player_zone:String = "";
		public var m_order_change:int = 0;//名次变化 0 无变化，大于零表示上升，小于0表示下降
		public var m_wealth_level:int = 0;//财富等级
		public var m_video_wealth_total:String = "";
	}
}