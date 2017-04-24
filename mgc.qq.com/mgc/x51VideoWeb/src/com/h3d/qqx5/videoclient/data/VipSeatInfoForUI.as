package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VipSeatInfoForUI
	{
			public var player_id : String = "";
			public var nick : String = "";
			public var zone : String = "";
			public var has_portrait : Boolean ;
			public var pic_url : String = "";
			public var gender : int ;
			public var guard_level : int ;
			public var level : int;//视频等级
			public var vip_level : int;//贵族等级
			public var video_room_wealth : String = "";//财富值
			public var taken_cnt : int;//座位被抢次数
			public var take_cost : int;//座位当前价格
			public var wealth_level : int;//财富等级
			public var protect_time : int;//座位被保护时间
			public var begin_time : int;//座位被保护结束时间
			public var cost_seat:Boolean;
	}
}