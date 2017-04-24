package com.h3d.qqx5.videoclient.data {

	public class ClientAnchorData {
		public var male:Boolean                           = false; //性别
		public var followedAudiences:int                  = 0; // 粉丝
		public var anchorID:String                        = ""; // 主播ID，不同于游戏内角色ID
		public var anchorQQ:String                        = ""; // 主播QQ号
		public var gameID:String                          = ""; //游戏内对应的gameID
		public var popularity:String                      = "0"; // 人气值
		public var starlight:String                       = "0"; // 星耀值
		public var twoweek_starlight:String               = "0"; // 双周星耀值
		public var intro:String                           = "";
		public var name:String                            = "";
		public var from:String                            = ""; // 籍贯
		public var photoUrl:String                        = ""; // 头像url
		public var imageUrl:String                        = ""; // 照片url
		public var deputy_name:String                     = ""; //副麦名字
		public var deputy_zone_name:String                = ""; //副麦大区名字	
		public var talent_show_rank:int                   = 0; //全民选秀主播的名次
		public var star_anchor:Boolean                    = false; //是否是星级主播
		public var anchor_score:int                       = 0; //主播积分。后援团系统中的那个
		public var m_pk_anchor_winner_order:int           = 0; //优胜主播排名 AnchorPKOrder
		public var m_starlight_today_needed:int           = 0; //当天还需要的星耀值
		public var m_impression_data:ClientImpressionData = new ClientImpressionData; //主播印象数据
		public var status:int                             = 0;
		public var room_id:int                            = 0;
		public var anchor_gender:int; //主播性别 0女1男
		public var is_nest:Boolean; //是否是小窝房间
		public var is_anchor_with_dance_mark:Boolean      = false;
		public var order_change:int; //名次变化0 无变化，大于零表示上升，小于0表示下降
		public var anchor_level:int; //主播等级
		public var anchor_exp:int; //主播经验值
		public var anchor_levelup_exp:int; //主播升级所需经验
		public var is_bottleneck:Boolean; //是否是瓶颈期
		public var bottleneck_count:int; //已送数量
		public var bottleneck_need_count:int; //突破需要的礼物数量
		public var bottleneck_gift_id:int; //突破评价需要的礼物id
		public var starlight_rest_exp_today:int; //通过涨星耀值还可增加的主播经验
		public var dream_gift_rest_exp_today:int; //收梦幻币礼物还可增加的主播经验
		public var anchor_badge:int;
		public var lucky_draw_rest_exp_today:int; //今日抽奖还可增加的主播经验值

		public var is_basic_info:Boolean                  = false;
	}
}
