package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildBriefInfoForUI
	{
		public var vgid:String = "";//后援团ID
		public var chief_zone:String = "";//团长的zone名字
		public var chief_name:String = "";//团长的pstid
		public var anchor_name:String = "";//支持的主播名字
		public var vg_name:String = "";//后援团名字
		public var vg_score:int = 0;//后援团活跃积分
		public var vg_total_score:int = 0;//后援团总积分
		public var member_count:int = 0;//团员人数
		public var member_limit:int = 0;//团最大人数
		public var anchor_qq:String = "";
		public var chief_wealth_level:int = 0;//团长的财富等级
		public var chief_wealth:int = 0;//团长财富值
		public var anchor_level:int = 0;//主播等级
	}
}