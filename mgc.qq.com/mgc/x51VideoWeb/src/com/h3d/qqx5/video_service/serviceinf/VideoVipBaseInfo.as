package com.h3d.qqx5.video_service.serviceinf {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoVipBaseInfo extends ProtoBufSerializable {
		public function VideoVipBaseInfo() {
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("vip_level", "", Descriptor.Int32, 2);
			registerField("vip_expire_time", "", Descriptor.Int32, 3);
			registerField("last_take_daily_reward", "", Descriptor.Int32, 4);
			registerField("last_send_whistle_time", "", Descriptor.Int32, 5);
			registerField("daily_whistle_count", "", Descriptor.Int32, 6);
			registerField("last_send_super_star_horn", "", Descriptor.Int32, 8);
			registerField("daily_super_star_horn_count", "", Descriptor.Int32, 9);
			registerField("extra_room_cap_remain_count", "", Descriptor.Int32, 10);

			registerField("extra_room_cap_update_time", "", Descriptor.Int32, 11);
			registerField("last_take_weekly_reward", "", Descriptor.Int32, 12);
			registerField("free_whistle_plus", "", Descriptor.Int32, 13);
			registerField("last_free_take_seat_time", "", Descriptor.Int32, 14);
			registerField("daily_free_take_seat_count", "", Descriptor.Int32, 15);
		}

		public var player_id:Int64 = new Int64();
		public var vip_level:int;
		public var vip_expire_time:int;
		public var last_take_daily_reward:int;
		public var last_send_whistle_time:int;
		public var daily_whistle_count:int;
		public var last_send_super_star_horn:int;
		public var daily_super_star_horn_count:int;
		public var extra_room_cap_remain_count:int;

		public var extra_room_cap_update_time:int;
		public var last_take_weekly_reward:int;
		public var free_whistle_plus:int;
		public var last_free_take_seat_time:int;
		public var daily_free_take_seat_count:int;
	}
}
