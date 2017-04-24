package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomTransmitToOnePlayer extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToOnePlayer;
		}
		
		public function CEventVideoRoomTransmitToOnePlayer()
		{
			registerField("player_pstid", "", Descriptor.Int64, 101);
			registerField("videoroom_id", "", Descriptor.Int32, 102);
			registerField("clsid", "", Descriptor.Int32, 103);
		}
		
		public var player_pstid : Int64;
		public var videoroom_id : int;
		public var clsid : int;
	}
}
