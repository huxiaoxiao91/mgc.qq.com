package com.h3d.qqx5.videoclient.data
{
	public class VideoGuardSeatInfoUI
	{	
		public var m_seat_id:int = 0;           // 宝座ID
		public var m_player_id:String = "";// 宝座上的玩家ID
		public var m_nick:String = "";         // 宝座上的玩家昵称
		public var m_zone:String = "";         // 宝座上的玩家来自哪个大区
		public var m_has_portrait:Boolean = true;// 是否有头像
		public var m_pic_url:String = "";      // 头像URL（Web端使用）
		public var m_gender:int = 0;           // 性别
		public var m_level:int = 0;            // 视频等级
		public var m_vip_level:int = 0;        // 贵族等级
		public var m_guard_level:int = 0;      // 守护等级
		public var m_affinity:int = 0;         // 亲密度
		public var m_wealth:int = 0;           // 日财富值
		public var m_in_room:Boolean = false; //玩家是否在房间中
		public var m_taken_times:int = 0;      // 抢座次数
		public var m_take_cost:int = 0;        // 抢座开销
		public var m_taking_id:String = "";   //抢座的玩家did
		public var m_taking_time:int;//抢座的时间	
		public var m_wealth_level:int;//财富等级
	}
}