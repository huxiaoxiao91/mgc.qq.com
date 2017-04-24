package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuardSeatInfo extends ProtoBufSerializable
	{
		public function VideoGuardSeatInfo()
		{
			registerField("m_seat_id", "", Descriptor.Int32, 1);
			registerField("m_player_id", "", Descriptor.Int64, 2);
			registerField("m_nick", "", Descriptor.TypeString, 3);
			registerField("m_zone", "", Descriptor.TypeString, 4);
			registerField("m_has_portrait", "", Descriptor.TypeBoolean, 5);
			registerField("m_pic_url", "", Descriptor.TypeString, 6);
			registerField("m_gender", "", Descriptor.Int32, 7);
			registerField("m_level", "", Descriptor.Int32, 8);
			registerField("m_vip_level", "", Descriptor.Int32, 9);
			registerField("m_guard_level", "", Descriptor.Int32, 10);
			registerField("m_affinity", "", Descriptor.Int32, 11);
			registerField("m_wealth", "", Descriptor.Int32,12);
			registerField("m_in_room", "", Descriptor.TypeBoolean, 13);
			registerField("m_taken_times", "", Descriptor.Int32, 14);
			registerField("m_take_cost", "", Descriptor.Int32, 15);
			registerField("m_taking_id", "", Descriptor.Int64, 16);
			registerField("m_taking_time", "", Descriptor.Int32, 17);
			registerField("m_wealth_level", "", Descriptor.Int32, 18);
		}
		
		public var m_seat_id:int = 0;           // 宝座ID
		public var m_player_id:Int64 = new Int64();// 宝座上的玩家ID
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
		public var m_taken_times:int = 0;     // 抢座次数
		public var m_take_cost:int = 0;      // 抢座开销
		public var m_taking_id:Int64 = new Int64();//抢座的玩家did
		public var m_taking_time:int;//抢座的时间	
		public var m_wealth_level:int;//财富等级
	}
}