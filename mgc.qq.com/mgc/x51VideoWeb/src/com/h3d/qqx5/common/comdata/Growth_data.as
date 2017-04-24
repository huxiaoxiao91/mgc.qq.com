package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	public class Growth_data extends ProtoBufSerializable {
		public function Growth_data() {
			registerField("live_time", "", Descriptor.Int32, 1);
			registerField("live_reward_cnt", "", Descriptor.Int32, 2);
			registerField("live_max_audiences", "", Descriptor.Int32, 3);
			registerField("live_exp_today", "", Descriptor.Int32, 4);
			registerField("task_exp_today", "", Descriptor.Int32, 5);
			registerField("starlight_exp_today", "", Descriptor.Int32, 6);
			registerField("bottleneck_count", "", Descriptor.Int32, 7);
			registerField("daily_dream_gift_exp", "", Descriptor.Int32, 8);
			registerField("lucky_draw_exp_today", "", Descriptor.Int32, 9);
		}

		public var live_time:int; //直播未领奖的时长
		public var live_reward_cnt:int; //直播领奖的次数
		public var live_max_audiences:int; //直播本次领奖阶段房间人数峰值
		public var live_exp_today:int; //今日已获得直播经验
		public var task_exp_today:int; //今日发布主播任务所得经验
		public var starlight_exp_today:int; //今日增加星耀所获经验值
		public var bottleneck_count:int; //瓶颈已收到的礼物格式,非瓶颈为-1
		public var daily_dream_gift_exp:int; //每日通过梦幻币礼物增加的经验值
		/**
		 * 每日通过幸运抽奖增加的经验值
		 */
		public var lucky_draw_exp_today:int;
	}
}
