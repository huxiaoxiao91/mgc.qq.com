package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * 打卡请求（上传数据）
	 * @author gaolei
	 *
	 */
	public class CEventPunchIn extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventPunchIn;
		}

		public function CEventPunchIn() {
			super();

			registerField("punch_in_id", "", Descriptor.Int32, 1);
			registerField("today_index", "", Descriptor.Int32, 2);
			registerField("day_index", "", Descriptor.Int32, 3);
			registerField("retrieve", "", Descriptor.TypeBoolean, 4);
			registerField("retrieve_price", "", Descriptor.Int32, 5);
		}

		/**
		 * 打卡周期id
		 */
		public var punch_in_id:int;
		/**
		 * 今日索引
		 */
		public var today_index:int;
		/**
		 * 打卡日期索引
		 */
		public var day_index:int;
		/**
		 * 是否补打卡
		 */
		public var retrieve:Boolean;
		/**
		 * 补打卡的价格
		 */
		public var retrieve_price:int;
	}
}
