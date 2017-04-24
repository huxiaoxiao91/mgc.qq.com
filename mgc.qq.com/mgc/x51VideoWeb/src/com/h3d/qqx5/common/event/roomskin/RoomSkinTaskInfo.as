package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	/**
	 * 皮肤任务信息
	 * @author gaolei
	 *
	 */
	public class RoomSkinTaskInfo extends ProtoBufSerializable {
		public function RoomSkinTaskInfo() {
			super();
			registerField("gift_id", "", Descriptor.Int32, 1);
			registerField("current_gift_count", "", Descriptor.Int32, 2);
			registerField("total_gift_count", "", Descriptor.Int32, 3);
		}

		/**
		 * 礼物ID
		 */
		public var gift_id:int;
		/**
		 * 当前获得的礼物数
		 */
		public var current_gift_count:int;
		/**
		 * 需要的总礼物数量
		 */
		public var total_gift_count:int;
	}
}
