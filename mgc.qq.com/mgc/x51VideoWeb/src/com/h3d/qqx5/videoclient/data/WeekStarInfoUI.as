package com.h3d.qqx5.videoclient.data {

	/**
	 * 主播小窝皮肤信息
	 * 注意：必须与AnchorNestSkinInfo属性一一对应。
	 * @author gaolei
	 *
	 */
	public class WeekStarInfoUI {
//		public function WeekStarInfoUI() {
//		}

		/**
		 * 周星赛活动状态
		 */
		public var status:int;
		/**
		 * 总积分
		 */
		public var total_score:int;
		/**
		 * 总排名
		 */
		public var total_rank:int;
		/**
		 * 分组排名
		 */
		public var sub_rank:int;
		/**
		 * 分组名
		 */
		public var group_name:String;
		/**
		 * 段位
		 */
		public var grade:int;
		/**
		 * /段位下的等级
		 */
		public var sub_level:int;
		/**
		 * 包括点亮和未点亮的勋章
		 */
		public var week_star_medals:Array = [];
	}
}
