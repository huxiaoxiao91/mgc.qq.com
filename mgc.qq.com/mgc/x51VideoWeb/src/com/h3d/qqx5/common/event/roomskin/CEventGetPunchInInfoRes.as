package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	/**
	 * 获取打卡界面信息应答。
	 * @author gaolei
	 *
	 */
	public class CEventGetPunchInInfoRes extends INetMessage {

		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventGetPunchInInfoRes;
		}

		public function CEventGetPunchInInfoRes() {
			super();

			registerField("punch_in_id", "", Descriptor.Int32, 1);
			registerField("punch_in_rec", "", Descriptor.Int32, 2);
			registerField("punch_in_count", "", Descriptor.Int32, 3);
			registerField("today_index", "", Descriptor.Int32, 4);
			registerField("room_left", "", Descriptor.Int32, 5);
			registerField("retrieve_punch_in_left", "", Descriptor.Int32, 6);
			registerFieldForDict("reward_boxes", "", Descriptor.Int32, getQualifiedClassName(PunchInInfoRewardList), Descriptor.Compound, 7);
			registerField("mutiply_guard_level", "", Descriptor.Int32, 8);
			registerField("mutiply", "", Descriptor.Int32, 9);
			registerField("retrieve_punch_in_prce", "", Descriptor.Int32, 10);
		}
		/**
		 * 打卡周期id（月初0点的UTC时间）
		 */
		public var punch_in_id:int;
		/**
		 * 该房间打卡记录，对应二进制位0-1表示是否签到过
		 */
		public var punch_in_rec:int;
		/**
		 * 本月本房间签到了多少次
		 */
		public var punch_in_count:int;
		/**
		 * 今日索引
		 */
		public var today_index:int;
		/**
		 * 今天还剩多少个房间可以打卡
		 */
		public var room_left:int;
		/**
		 * 本房间本月还可以补打多少次
		 */
		public var retrieve_punch_in_left:int;
		/**
		 * 累计打开对应的奖励
		 */
		public var reward_boxes:Dictionary = new Dictionary();
		/**
		 * 守护等级达到多少奖励加倍
		 */
		public var mutiply_guard_level:int;
		/**
		 * 守护奖励加倍倍数
		 */
		public var mutiply:int;
		/**
		 * 补打卡价格
		 */
		public var retrieve_punch_in_prce:int;
	}
}
