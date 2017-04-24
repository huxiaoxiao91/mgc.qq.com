package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomLoadPlayerList extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomLoadPlayerList;
		}
		
		public function CEventVideoRoomLoadPlayerList()
		{
			registerField("page_index", "", Descriptor.Int32, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("is_x5client", "", Descriptor.TypeBoolean, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
		}
		
		public var page_index : int;
		public var room_id : int;
		public var is_x5client : Boolean;
		public var player_id : Int64;
	}
}
