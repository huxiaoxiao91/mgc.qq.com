package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	/**
	 * 下发房间每日任务信息
	 * @author gaolei
	 *
	 */
	public class CEventRoomSkinDailyTaskInfo extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventRoomSkinDailyTaskInfo;
		}

		public function CEventRoomSkinDailyTaskInfo() {
			super();

			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("charm_total", "", Descriptor.Int32, 2); //总魅力值
			registerField("current_charm_rank", "", Descriptor.Int32, 3); //在魅力榜总榜的名次
			registerField("current_punchin_count", "", Descriptor.Int32, 4); //当前打卡次数
			registerField("total_punchin_count", "", Descriptor.Int32, 5); //总的打卡次数
			registerField("current_takeseat_count", "", Descriptor.Int32, 6); //当前抢座次数
			registerField("total_takeseat_count", "", Descriptor.Int32, 7); //总的抢座次数
			registerFieldForList("gift_info", getQualifiedClassName(RoomSkinTaskInfo), Descriptor.Compound, 8);
			registerField("current_level_charm", "", Descriptor.Int32, 9); // 当前等级的魅力值
			registerField("current_level_need_charm", "", Descriptor.Int32, 10); //当前等级总的所需魅力值

			registerField("room_skin_level", "", Descriptor.Int32, 11); //当前皮肤等级
			registerField("config_changed", "", Descriptor.TypeBoolean, 12); //配置更改
			registerField("task_id", "", Descriptor.Int32, 13); //任务id
		}

		public var room_id:int;
		/**
		 * 总魅力值
		 */
		public var charm_total:int;
		/**
		 * 在魅力榜总榜的名次
		 */
		public var current_charm_rank:int;
		/**
		 * 当前打卡次数
		 */
		public var current_punchin_count:int;
		/**
		 * 总的打卡次数
		 */
		public var total_punchin_count:int;
		/**
		 * 当前抢座次数
		 */
		public var current_takeseat_count:int;
		/**
		 * 总的抢座次数
		 */
		public var total_takeseat_count:int;
		/**
		 *
		 */
		public var gift_info:Array = new Array();
		/**
		 * 当前等级的魅力值
		 */
		public var current_level_charm:int;
		/**
		 * 当前等级总的所需魅力值
		 */
		public var current_level_need_charm:int;
		/**
		 * 当前皮肤等级
		 */
		public var room_skin_level:int;
		/**
		 * 配置变更
		 */
		public var config_changed:Boolean;
		/**
		 * 任务id
		 */
		public var task_id:int;
	}
}
