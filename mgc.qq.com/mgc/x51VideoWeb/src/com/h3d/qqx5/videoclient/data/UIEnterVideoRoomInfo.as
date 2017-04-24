package com.h3d.qqx5.videoclient.data {

	public class UIEnterVideoRoomInfo {
		public var m_room_id:int                   = 0;
		public var m_player_count:int              = 0;
		public var m_vip_level:int                 = 0;
		public var m_vip_expire:int                = 0;
		public var m_remain_crowdroom_count:int    = 0; // 剩余挤房次数
		public var m_redenvelopes:Array            = new Array(); // 房间内所有发出的红包
		public var m_cooldown_second:int; //进入失败，多少秒以后再试
		public var is_concert:Boolean;
		public var has_concert_ticket:Boolean;
		public var concert_is_open:Boolean;
		public var nest_count:int; //旗下主播数量
		public var red_envelope_duration:int; // //大红包持续时间 单位秒
		public var small_red_envelope_duration:int; //小红包持续时间单位 秒
		public var free_times:int;
		public var seat_price_reset_notice:int;
//		public var lucky_draw_rest_exp_tody:int //今日抽奖还可增加的主播经验值
		public var activity_type:int;
		/**
		 * 红点
		 */
		public var can_punch_in_room:Boolean;

		public var room_skin_id:int;

		public var room_skin_level:int;
		/**
		 * 贵族绑定的主播名称
		 */
		public var vip_attached_anchor_name:String = "";
		/**
		 * 族绑定的主播id
		 */
		public var vip_attached_anchor_id:String   = "0";
		public var edu_flag:int;
		public var concert_id:int;
	}
}
