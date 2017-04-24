package com.h3d.qqx5.common.comdata {

	import com.h3d.qqx5.common.event.roomskin.RoomSkinTaskInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	import flash.utils.getQualifiedClassName;

	public class AnchorNestSkinInfo extends ProtoBufSerializable {
		public function AnchorNestSkinInfo() {
			super();

			registerField("room_skin_level", "", Descriptor.Int32, 1);
			registerField("current_charm", "", Descriptor.Int32, 2);
			registerField("current_need_charm", "", Descriptor.Int32, 3);
			registerField("skin_subject_name", "", Descriptor.TypeString, 4);
			registerField("room_total_charm", "", Descriptor.Int32, 5);

			registerField("charm_rank_order", "", Descriptor.Int32, 6);
			registerField("current_punchin_count", "", Descriptor.Int32, 7);
			registerField("total_punchin_count", "", Descriptor.Int32, 8);
			registerField("current_takeseat_count", "", Descriptor.Int32, 9);
			registerField("total_takeseat_count", "", Descriptor.Int32, 10);

			registerField("room_skin_id", "", Descriptor.Int32, 11);
			registerFieldForList("skin_task_info", getQualifiedClassName(RoomSkinTaskInfo), Descriptor.Compound, 12);
		}

		/**
		 * 房间皮肤等级
		 */
		public var room_skin_level:int;
		/**
		 * 当前魅力值
		 */
		public var current_charm:int;
		/**
		 * 当前等级所需魅力值
		 */
		public var current_need_charm:int;
		/**
		 * 皮肤主题名字
		 */
		public var skin_subject_name:String;
		/**
		 * 总魅力值
		 */
		public var room_total_charm:int;
		/**
		 * 总魅力榜排名
		 */
		public var charm_rank_order:int;
		/**
		 * 当前打卡次数
		 */
		public var current_punchin_count:int;
		/**
		 * 总的打卡次数
		 */
		public var total_punchin_count:int;
		/**
		 * /当前抢座次数
		 */
		public var current_takeseat_count:int;
		/**
		 * 总的抢座次数
		 */
		public var total_takeseat_count:int;
		/**
		 * 房间皮肤id
		 */
		public var room_skin_id:int;
		/**
		 * 任务进度
		 */
		public var skin_task_info:Array = [];
	}
}
