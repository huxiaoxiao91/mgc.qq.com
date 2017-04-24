package com.h3d.qqx5.videoclient.data {

	/**
	 * 主播小窝皮肤信息
	 * 注意：必须与AnchorNestSkinInfo属性一一对应。
	 * @author gaolei
	 *
	 */
	public class AnchorNestSkinInfoUI {
		public function AnchorNestSkinInfoUI() {
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
