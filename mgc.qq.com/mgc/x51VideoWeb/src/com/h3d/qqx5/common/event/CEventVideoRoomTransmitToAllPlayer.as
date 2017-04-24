package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomTransmitToAllPlayer extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToAllPlayer;
		}
		
		public function CEventVideoRoomTransmitToAllPlayer()
		{
			registerField("videoroom_id", "", Descriptor.Int32, 101);
		}
		
		public var videoroom_id : int;
	}
}
