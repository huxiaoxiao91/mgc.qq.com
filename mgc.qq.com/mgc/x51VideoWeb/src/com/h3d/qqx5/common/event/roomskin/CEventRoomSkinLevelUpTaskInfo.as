package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	/**
	 * 下发房间皮肤升级任务信息
	 * @author gaolei
	 *
	 */
	public class CEventRoomSkinLevelUpTaskInfo extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventRoomSkinLevelUpTaskInfo;
		}

		public function CEventRoomSkinLevelUpTaskInfo() {
			super();

			registerField("charm_total", "", Descriptor.Int32, 1);
			registerField("current_charm_rank", "", Descriptor.Int32, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("room_skin_level", "", Descriptor.Int32, 4);
			registerField("room_skin_id", "", Descriptor.Int32, 5);

			registerField("current_charm", "", Descriptor.Int32, 6);
			registerField("current_punchin_count", "", Descriptor.Int32, 7);
			registerField("total_punchin_count", "", Descriptor.Int32, 8);
			registerField("current_takeseat_count", "", Descriptor.Int32, 9);
			registerField("total_takeseat_count", "", Descriptor.Int32, 10);

			registerField("next_level_charm", "", Descriptor.Int32, 11);
			registerFieldForList("gift_info", getQualifiedClassName(RoomSkinTaskInfo), Descriptor.Compound, 12);
			registerField("next_level_punchin_count", "", Descriptor.Int32, 13);
			registerField("next_level_takeseat_count", "", Descriptor.Int32, 14);
			registerField("next_level_skin_gift_count", "", Descriptor.Int32, 15);

			registerField("is_max_level", "", Descriptor.TypeBoolean, 16);
			registerFieldForList("today_gift_info", getQualifiedClassName(RoomSkinTaskInfo), Descriptor.Compound, 17);
			registerField("need_charm", "", Descriptor.Int32, 18);

			registerField("config_changed", "", Descriptor.TypeBoolean, 19);
			registerField("daily_clear", "", Descriptor.TypeBoolean, 20);
		}

		/**
		 * 总魅力值
		 */
		public var charm_total:int;
		/**
		 * 在魅力榜总榜的名次
		 */
		public var current_charm_rank:int;
		/**
		 * 房间id
		 */
		public var room_id:int;
		/**
		 * 房间皮肤等级
		 */
		public var room_skin_level:int;
		/**
		 * 皮肤ID
		 */
		public var room_skin_id:int;

		/**
		 * 当前魅力值
		 */
		public var current_charm:int;
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
		 * 距下个等级差的魅力值
		 */
		public var next_level_charm:int;
		/**
		 * 礼物相关的信息
		 */
		public var gift_info:Array       = new Array();
		/**
		 * 距下个等级所需打卡次数
		 */
		public var next_level_punchin_count:int;
		/**
		 * 距下个等级所需抢座次数
		 */
		public var next_level_takeseat_count:int;
		/**
		 * （弃用）距下个等级所需专属礼物个数
		 */
		public var next_level_skin_gift_count:int;

		/**
		 * (弃用)是否达到最大级别
		 */
		public var is_max_level:Boolean;
		/**
		 * 当日的礼物信息
		 */
		public var today_gift_info:Array = new Array();
		/**
		 * 当前等级总魅力值
		 */
		public var need_charm:int;
		/**
		 * 配置变更
		 */
		public var config_changed:Boolean;
		/**
		 * 每日零点清空
		 */
		public var daily_clear:Boolean;
	}
}
