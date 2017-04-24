package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomEnterRoomBroadcast extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcast;
		}

		public function CEventVideoRoomEnterRoomBroadcast() {
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("guard_level", "", Descriptor.Int32, 2);
			registerField("player_name", "", Descriptor.TypeString, 3);
			registerField("player_zone", "", Descriptor.TypeString, 4);
			registerField("vip_level", "", Descriptor.Int32, 5);
			registerField("broadcast_type", "", Descriptor.Int32, 6);
			registerField("avatar", "", Descriptor.TypeNetBuffer, 7);
			registerField("sex_male", "", Descriptor.TypeBoolean, 8);
			registerField("guard_level_new", "", Descriptor.Int32, 9);
			registerField("invisible", "", Descriptor.TypeBoolean, 10);// 是否隐身 true：隐身

			registerField("is_assistant", "", Descriptor.TypeBoolean, 11);
			registerField("credits_level", "", Descriptor.Int32, 12);
			registerField("DeviceType", "", Descriptor.Int32, 13);
			registerField("room_id", "", Descriptor.Int32, 14);
			registerField("is_new_role", "", Descriptor.TypeBoolean, 15);
			registerField("wealth_level", "", Descriptor.Int32, 16);
			//xw81899
			registerField("attached_anchor_id", "", Descriptor.Int64, 17);
		}

		public var pstid:Int64              = new Int64();
		public var guard_level:int;
		public var player_name:String       = "";
		public var player_zone:String       = "";
		public var vip_level:int;
		public var broadcast_type:int;
		public var avatar:NetBuffer;
		public var sex_male:Boolean;
		public var guard_level_new:int;
		public var invisible:Boolean;

		public var is_assistant:Boolean;
		public var credits_level:int;
		public var DeviceType:int;
		public var room_id:int;
		public var is_new_role:Boolean;
		public var wealth_level:int;
		/**
		 * 玩家绑定的主播id
		 * 注：xw81899新增。
		 */
		public var attached_anchor_id:Int64 = new Int64();
	}
}
