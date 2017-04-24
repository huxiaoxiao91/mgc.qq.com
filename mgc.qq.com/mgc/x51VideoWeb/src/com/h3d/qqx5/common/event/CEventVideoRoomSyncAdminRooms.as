package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomSyncAdminRooms extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomSyncAdminRooms;
		}
		
		public function CEventVideoRoomSyncAdminRooms()
		{
			registerField("acc_id", "", Descriptor.Int64, 1);
			registerFieldForDict("rooms","",Descriptor.Int32,"", Descriptor.Int32, 2);
		}
		
		public var acc_id : Int64;
		public var rooms :Dictionary;
	}
}
