package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CReward;

	import flash.utils.getQualifiedClassName;

	/**
	 * 打卡请求返回
	 * @author gaolei
	 *
	 */
	public class CEventPunchInRes extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventPunchInRes;
		}

		public function CEventPunchInRes() {
			super();
			registerField("res", "", Descriptor.Int32, 1);
			registerField("day_index", "", Descriptor.Int32, 2);
			registerField("retrieve", "", Descriptor.TypeBoolean, 3);
			registerField("charm", "", Descriptor.Int32, 4);
			registerFieldForList("rewards", getQualifiedClassName(CReward), Descriptor.Compound, 5);
			registerField("retrieve_punch_in_prce", "", Descriptor.Int32, 6);
			registerField("room_left", "", Descriptor.Int32, 7);
		}

		public static const RES_PIR_SUCCESS:int          = 0;
		public static const RES_PIR_FAIL:int             = 1;
		/**
		 * 数据不一致，需要界面重新刷新UI
		 */
		public static const RES_PIR_DATADIFFER:int       = 2;
		/**
		 * 达到打卡房间上限
		 */
		public static const RES_PIR_ROOM_LIMIT:int       = 3;
		/**
		 * 已经打过卡了
		 */
		public static const RES_PIR_HAS_PUNCHED_IN:int   = 4;
		/**
		 * 补打卡余额不足
		 */
		public static const RES_PIR_NOT_ENOUGH_COINS:int = 5;

		/**
		 * 结果码
		 */
		public var res:int;
		/**
		 * 打卡日期索引
		 */
		public var day_index:int;
		/**
		 * 是否补打卡
		 */
		public var retrieve:Boolean;
		/**
		 * 增加的魅力值
		 */
		public var charm:int;
		/**
		 * 触发累计打卡的奖励
		 */
		public var rewards:Array                         = [];
		/**
		 * 补打卡价格
		 */
		public var retrieve_punch_in_prce:int;
		/**
		 * 今天还剩多少个房间可以打卡
		 */
		public var room_left:int;
	}
}
