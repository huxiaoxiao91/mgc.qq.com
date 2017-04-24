package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRefreshRoomAttribute extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshRoomAttribute;
		}
		
		public function CEventVideoRoomRefreshRoomAttribute()
		{
			registerField("room_name", "", Descriptor.TypeString, 1);
			registerField("forbid_public_chat", "", Descriptor.TypeBoolean, 2);
			registerField("open_chat_cd_check", "", Descriptor.TypeBoolean, 3);
			registerField("chat_cd_time", "", Descriptor.Int32, 4);
			registerField("player_capacity", "", Descriptor.Int32, 5);
		}
		
		public var room_name : String = "";
		public var forbid_public_chat : Boolean;
		public var open_chat_cd_check : Boolean;
		public var chat_cd_time : int;
		public var player_capacity : int;
	}
}
