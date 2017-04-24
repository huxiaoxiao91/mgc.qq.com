package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventNestAssistantSetFunction extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventNestAssistantSetFunction;
		}
		
		public function CEventNestAssistantSetFunction()
		{
			registerField("forbid_public_chat", "", Descriptor.TypeBoolean, 1);
			registerField("chat_cd_time", "", Descriptor.Int32, 2);
			registerField("cooldown_cd", "", Descriptor.Int32, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("player_id", "", Descriptor.Int64, 5);
			registerField("open_chat_cd", "", Descriptor.TypeBoolean, 6);
		}
		
		public var forbid_public_chat : Boolean;
		public var chat_cd_time : int;
		public var cooldown_cd : int;
		public var room_id : int;
		public var player_id : Int64;
		public var open_chat_cd : Boolean;
	}
}
