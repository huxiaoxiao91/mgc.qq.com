package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomTransmitToAllOtherRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToAllOtherRoom;
		}
		
		public function CEventVideoRoomTransmitToAllOtherRoom()
		{
			registerField("had_attached", "", Descriptor.TypeBoolean, 1);
			registerField("buf", "", Descriptor.TypeNetBuffer, 2);
		}
		
		public var had_attached : Boolean;
		public var buf :NetBuffer;
	}
}
