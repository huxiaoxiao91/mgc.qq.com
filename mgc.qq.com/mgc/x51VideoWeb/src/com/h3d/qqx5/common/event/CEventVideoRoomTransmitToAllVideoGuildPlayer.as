package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomTransmitToAllVideoGuildPlayer extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToAllVideoGuildPlayer;
		}
		
		public function CEventVideoRoomTransmitToAllVideoGuildPlayer()
		{
			registerField("videoguild_id", "", Descriptor.Int64, 101);
			registerField("clsid", "", Descriptor.Int32, 102);
		}
		
		public var videoguild_id : Int64;
		public var clsid : int;
	}
}
