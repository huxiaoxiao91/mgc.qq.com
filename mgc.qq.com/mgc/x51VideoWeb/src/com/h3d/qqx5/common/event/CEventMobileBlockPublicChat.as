package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventMobileBlockPublicChat extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventMobileBlockPublicChat;
		}
		
		public function CEventMobileBlockPublicChat()
		{
			registerField("block_public_chat", "", Descriptor.TypeBoolean, 1);
		}
		
		public var block_public_chat : Boolean;
	}
}
