package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoVipPlayerCardInfoForUI
	{		
		public var zone_id:int  = 0;
		public var player_id:String = "";
		public var wealth:String = "";
		public var signature:String = "";
		public var vip_level:int  = 0;
		public var vipIcon:String = "";//vip图标
		public var videoLevel:int;//梦工厂等级
		public var exp:int;//梦工厂经验
		public var levelup_exp:int;//达到下一级需要的梦工厂经验，为0表示满级
		public var vipCardParttern:String = "";//名片底板
		public var portrait_url:String = "";
		public var followed_anchors:Array = new Array;//std::vector<FollowAnchorAffinityInfoForUI> followed_anchors;
		public var player_sex:int  = 0;
		public var player_name:String = "";
		public var zone_name:String = "";
		public var vg_name:String = "";
		public var vgid:String = "";
		public var m_pk_richman_order:int  = 0; //英豪榜排名 AnchorPKOrder
		public var is_self:Boolean = false;
		public var love_nest_info_vec:Array = new Array();//最爱的小窝列表
		public var wealth_level:int;//财富等级
		public var wealth_exp:int;//当前财富
		public var wealth_levelup_exp:int;//还需要多少达到下一级
	}
}