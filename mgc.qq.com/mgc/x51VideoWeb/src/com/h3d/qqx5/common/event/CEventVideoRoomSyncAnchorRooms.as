package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomSyncAnchorRooms extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomSyncAnchorRooms;
		}
		
		public function CEventVideoRoomSyncAnchorRooms()
		{
			registerField("acc_id", "", Descriptor.Int64, 1);
			registerFieldForList("rooms", "", Descriptor.Int32, 2);
			registerField("nest_id", "", Descriptor.Int32, 3);
		}
		
		public var acc_id : Int64;
		public var rooms : Array = new Array;
		public var nest_id : int;
	}
}
