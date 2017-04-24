package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	import flash.utils.getQualifiedClassName;

	/**
	 * 解锁皮肤任务进度信息
	 * @author gaolei
	 *
	 */
	public class CEventUnlockRoomSkinTaskInfo extends INetMessage {
		override public function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventUnlockRoomSkinTaskInfo;
		}

		public function CEventUnlockRoomSkinTaskInfo() {
			super();

			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("room_skin_id", "", Descriptor.Int32, 2);
			registerFieldForList("gift_info", getQualifiedClassName(RoomSkinTaskInfo), Descriptor.Compound, 3);
			registerField("config_changed", "", Descriptor.TypeBoolean, 4);
		}

		/**
		 * 1.房间id
		 */
		public var room_id:int;
		/**
		 * 2.房间选择的皮肤id
		 */
		public var room_skin_id:int;
		/**
		 * 3.房间专属礼物列表
		 */
		public var gift_info:Array = new Array();
		/**
		 * 配置变更
		 */
		public var config_changed:Boolean;
	}
}
