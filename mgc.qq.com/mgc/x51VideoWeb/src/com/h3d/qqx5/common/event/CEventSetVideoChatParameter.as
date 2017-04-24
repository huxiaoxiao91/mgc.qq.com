package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventSetVideoChatParameter extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventSetVideoChatParameter;
		}
		
		public function CEventSetVideoChatParameter()
		{
			registerField("forbid_public_chat", "", Descriptor.TypeBoolean, 1);
			registerField("open_chat_cd_check", "", Descriptor.TypeBoolean, 2);
			registerField("chat_cd_time", "", Descriptor.Int32, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("player_id", "", Descriptor.Int64, 5);
		}
		
		public var forbid_public_chat : Boolean;
		public var open_chat_cd_check : Boolean;
		public var chat_cd_time : int;
		public var room_id : int;
		public var player_id : Int64;
	}
}
