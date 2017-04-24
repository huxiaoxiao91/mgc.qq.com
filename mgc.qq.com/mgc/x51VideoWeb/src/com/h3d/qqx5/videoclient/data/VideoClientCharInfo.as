package com.h3d.qqx5.videoclient.data {

	/**
	 * @author liuchui
	 */
	public class VideoClientCharInfo {
		public var pstid:String             = "";
		public var nick:String              = "";
		public var signature:String         = "";
		public var photo_url:String         = "";
		public var sex_male:int;
		public var video_wealth:String;
		public var video_money_balance:String;
		public var free_gift_count:int;
		public var daily_free_whistle_count:int;
		public var vip_level:int;
		public var vip_remaining_time:int;
		public var block_public_chat:Boolean;
		public var zone_name:String         = "";
		public var video_dream_money:int;
		public var video_level:int;
		public var followinfo_vec:Array     = new Array; //std::vector<>,
		public var invisible:Boolean;
		public var zone_id:int;
		public var video_exp:int;
		public var video_levelup_exp:int;
		public var vipIcon:String           = "";
		public var vipName:String           = "";
		public var forbidAllPrivate:Boolean = false;
		public var wealth_level:int; //玩家财富等级
		public var wealth_exp:int; //玩家财富经验
		public var wealth_levelup_exp:int; //玩家达到下一级财富等级所需要的经验值

		public var vip_anchor_name:String   = "";
		public var vip_anchor_id:String     = "0";
		public var is_show_week_star_url:Boolean;
	}
}
