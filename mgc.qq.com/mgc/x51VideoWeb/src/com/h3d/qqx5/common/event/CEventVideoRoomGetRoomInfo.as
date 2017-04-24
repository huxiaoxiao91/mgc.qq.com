package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoRoomGetRoomInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomInfo;
		}
		
		public function CEventVideoRoomGetRoomInfo()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
		}
		
		public var room_id : int;
	}
}
