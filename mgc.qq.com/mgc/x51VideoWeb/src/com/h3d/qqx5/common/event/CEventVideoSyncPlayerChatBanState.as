package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoSyncPlayerChatBanState extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoSyncPlayerChatBanState;
		}
		
		public function CEventVideoSyncPlayerChatBanState()
		{
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("chat_banned","", Descriptor.Int32,  2);
			registerField("room_id", "", Descriptor.Int32, 3);
		}
		
		public var pstid : Int64;
		public var chat_banned : int;
		public var room_id : int;
	}
}
