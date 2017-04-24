package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;

	import flash.utils.getQualifiedClassName;
	import flash.utils.Dictionary;

	/**
	 * 抽奖回调
	 * @author gaolei
	 *
	 */
	public class CEventVideoRoomLuckyDrawRes extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawRes;
		}

		public function CEventVideoRoomLuckyDrawRes() {
			super();

			registerField("res", "", Descriptor.Int32, 1);
			registerField("last_free_lucky_draw_time", "", Descriptor.Int32, 2);
			registerFieldForList("rewards", getQualifiedClassName(RewardBasicItem), Descriptor.Compound, 3);
			registerField("balance", "", Descriptor.Int32, 4);
			registerFieldForList("star_gifts","",Descriptor.Int32, 5);
		}

		/**
		 * 0 -> 抽奖成功
		 */
		public static const LDEC_SUCCESS:int           = 0;
		/**
		 * 1 -> 抽奖活动已更新
		 */
		public static const LDEC_ACTIVITY_UPDATE:int   = 1;
		/**
		 * 2 -> 不在直播中
		 */
		public static const LDEC_NOT_LIVE:int          = 2;
		/**
		 * 3 -> 玩家不在房间内
		 */
		public static const LDEC_NOT_IN_ROOM:int       = 3;
		/**
		 * 4 -> 免费抽奖次数已用尽
		 */
		public static const LDEC_FREE_DRAW_EXHAUST:int = 4;
		/**
		 * 5 -> 余额不足
		 */
		public static const LDEC_COIN_NOT_ENOUGH:int   = 5;
		/**
		 * 6 -> 有免费抽奖机会
		 */
		public static const LDEC_FREE_DRAW:int         = 6;
		/**
		 * 7 -> 抽奖失败
		 */
		public static const LDEC_FAILED:int            = 7;
		

		/**
		 * 抽奖结果
		 */
		public var res:int;
		/**
		 * 上次免费抽奖的时间
		 */
		public var last_free_lucky_draw_time:int;
		/**
		 * 抽中的奖品（抽一次，只有1个；连抽多次，有多个）
		 */
		public var rewards:Array                       = new Array();
		/**
		 * 钻石/炫豆/炫贝余额
		 */
		public var balance:int;
		public var star_gifts:Array = new Array();
	}
}
