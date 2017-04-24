package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoRoomCreateVideoRole extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomCreateVideoRole;
		}

		public function CEventVideoRoomCreateVideoRole() {
			registerField("nick", "", Descriptor.TypeString, 1);
			registerField("gender", "", Descriptor.Int32, 2);
			registerField("in_game_hall", "", Descriptor.TypeBoolean, 3);
			registerField("rand_nick_pool", "", Descriptor.Int32, 4);
			registerField("nick_record_id", "", Descriptor.Int32, 5);
			registerField("m_is_auto_create", "", Descriptor.TypeBoolean, 6);
		}

		public var nick:String        = "";
		public var gender:int;
		public var in_game_hall:Boolean;
		public var rand_nick_pool:int = -1; //默认值-1
		public var nick_record_id:int;
		public var m_is_auto_create:Boolean;
	}
}
