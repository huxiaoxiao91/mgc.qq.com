package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildInfoForUI
	{	
		public var vgid:String                    = "";  //后援团ID
		public var chief_pstid:String             = "";	 //团长的pstid
		public var level:int                      = 0;   //后援团级别
		public var anchor_pstid:String            = "";  //支持的主播ID
		public var anchorAvatarUrl:String         = "";//主播头像url
		public var vg_desc:String                 = "";  //后援团描述(简介）
		public var vg_name:String                 = "";  //后援团名字
		public var vg_wealth:int                  = 0;   //后援团资产
		public var vg_score:int                   = 0;   //本月后援团活跃积分
		public var vg_dismiss:int                 = 0;   //后援团解散时间
		public var chief_name:String              = "";  //团长的名字
		public var chief_zname:String             = "";  //团长所在的大区名
		public var anchor_cont_score:int          = 0;   //本月给关注主播贡献的积分
		public var anchor_give_score:int          = 0;   //本月主播给该后援团分配的积分
		public var anchor_name:String             = "";  //主播名字
		public var total_score:String             = "";  //后援团总积分
		public var create_time:int                = 0;   //建团时间
		public var member_count:int               = 0;   //团员人数
		public var member_limit:int               = 0;   //团员最大人数
		public var vg_notice:String               = "";  //后援团公告
		public var last_month_score:int           = 0;   //上个月活跃积分数
		public var last_month_cont:int            = 0;   //上个月贡献主播积分数
		public var last_score_rank:int            = 0;   //！！！“本月”的积分排名
		public var last_cont_rank:int             = 0;   //上个月的贡献主播积分排名
		public var system_score:int               = 0;   //本月自动获取的积分数目
		public var today_ticket_acc:int           = 0;   //今日献月票计数
		public var last_send_ticket_time:int      = 0;   //最后一次献月票时间
		public var fans_board_type:int            = 0;   //粉丝牌类别
		public var fans_board_time_limit:int      = 0;   //粉丝牌失效时间
		public var system_score_clear_time:int    = 0;	 //自动发放后援团活跃积分的时间
		public var forbid_join_apply:int          = 0;   //设置是否拒绝入团申请，0表示允许，1表示不允许
		public var chief_qq:String                = "";
		public var vg_demise_time:int             = 0;   //后援团传位时间
		public var demised_chief_pstid:String     = "";  //即将被传位的团长的pstid
		public var demised_chief_name:String      = "";//即将被传位的团长的昵称
		public var demised_chief_zone:String      = "";//即将被传位的团长的大区
		public var m_pk_anchor_winner_order:int   = 0;   //优胜主播榜排名 AnchorPKOrder
		public var fans_board_name:String         = "";
		public var ban_custom_fans_board_time:int = 0;
		public var customed_fans_board_name:Boolean = false;
		public var anchor_level:int               = 0;//主播等级
		public var chief_wealth_level:int         = 0;//团长财富等级
		public var chief_wealth:int               = 0;//团长财富值
		public var result:int					  = 0;
	}
}