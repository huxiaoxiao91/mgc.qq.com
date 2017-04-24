package com.h3d.qqx5.videoclient.data
{
	public class AnchorNestSupportInfo
	{
		public var m_popularity_info:AnchorNestPopularityInfo = new AnchorNestPopularityInfo;//小窝人气
		public var m_player_info:AnchorNestPlayerStarInfo = new AnchorNestPlayerStarInfo;//玩家小窝明星值
		public var m_adv_support_logs:Array= new Array;//最近三次高级捧场记录
		public var m_normal_support_today:Boolean = false;//当日是否有过普通捧场
	}
}