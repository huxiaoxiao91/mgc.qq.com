package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.CReward;

	import flash.utils.getQualifiedClassName;

	/**
	 * 房间皮肤满级后，每日任务达成下发奖励消息
	 * @author gaolei
	 *
	 */
	public class CEventRoomDailyTaskRewards extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventRoomDailyTaskRewards;
		}

		public function CEventRoomDailyTaskRewards() {
			super();

			registerField("room_id", "", Descriptor.Int32, 1);
			registerFieldForList("reward_list", getQualifiedClassName(CReward), Descriptor.Compound, 2);
		}

		public var room_id:int;

		public var reward_list:Array = [];
	}
}
