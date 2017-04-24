package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * 本期抽奖信息
	 * @author gaolei
	 *
	 */
	public class VideoLuckyDrawInfo extends ProtoBufSerializable {
		public function VideoLuckyDrawInfo() {
			super();

			registerField("begin_time", "", Descriptor.Int32, 1);
			registerField("end_time", "", Descriptor.Int32, 2);
			registerField("continuous_draw_count", "", Descriptor.Int32, 3);
			registerField("continuous_draw_reward_id", "", Descriptor.Int32, 4);
			registerFieldForList("rewards", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 5);
			registerFieldForList("rewards_x51", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 6);
			registerFieldForList("sub_rewards", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 7);
			registerFieldForList("sub_rewards_x51", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 8);
			registerField("once_draw_price", "", Descriptor.Int32, 9);
			registerField("free_lucky_draw_interval", "", Descriptor.Int32, 10);
			registerFieldForList("rewards_x52", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 11);
			registerFieldForList("sub_rewards_x52", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 12);
			registerFieldForList("star_gifts","",Descriptor.Int32, 13);
		}

		/**
		 * 1.本期抽奖开始时间
		 */
		public var begin_time:int;
		/**
		 * 2.本期抽奖结束时间
		 */
		public var end_time:int;
		/**
		 * 3.连抽次数——固定10连抽，此数据无用
		 */
		public var continuous_draw_count:int;
		/**
		 * 4.连抽必出奖品序号
		 */
		public var continuous_draw_reward_id:int;
		/**
		 * 5.梦工厂玩家奖池
		 */
		public var rewards:Array         = new Array();
		/**
		 * 6.炫舞1玩家奖池
		 */
		public var rewards_x51:Array     = new Array();
		/**
		 * 7.梦工厂替换掉专属礼物奖池
		 */
		public var sub_rewards:Array     = new Array();
		/**
		 * 8.炫舞1换掉专属礼物奖池
		 */
		public var sub_rewards_x51:Array = new Array();
		/**
		 * 9.付费一次的抽奖价格
		 */
		public var once_draw_price:int;
		/**
		 * 10.免费抽奖时间间隔
		 */
		public var free_lucky_draw_interval:int;
		/**
		 * 11.炫舞2玩家奖池
		 */
		public var rewards_x52:Array     = new Array();
		/**
		 * 12.炫舞2换掉专属礼物奖池
		 */
		public var sub_rewards_x52:Array = new Array();
		public var star_gifts:Array = new Array();


		public static function parseJson(json:String):VideoLuckyDrawInfo {
			var config:VideoLuckyDrawInfo = new VideoLuckyDrawInfo();
			try {
				var obj:Object = JSON.parse(json);
				for (var key:String in obj) {
					if (config.hasOwnProperty(key)) {
						if (obj[key] is Array) {
							var rewards:Array = [];
							for each (var rewardObj:Object in obj[key]) {
								var reward:RewardBasicItem = new RewardBasicItem();
								for (var rewardKey:String in rewardObj) {
									reward[rewardKey] = rewardObj[rewardKey];
								}
								rewards.push(reward);
							}
							config[key] = rewards;
						} else {
							config[key] = obj[key];
						}
					}
				}
			} catch (error:Error) {
				config = null;
			}
			return config;
		}
	}
}
