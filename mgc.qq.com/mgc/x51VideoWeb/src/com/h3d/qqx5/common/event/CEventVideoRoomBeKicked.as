package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoRoomBeKicked extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomBeKicked;
		}
		
		public function CEventVideoRoomBeKicked()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("reason", "", Descriptor.Int32, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("device_type", "", Descriptor.Int32, 4);
		}
		
		public var room_id : int;
		public var reason : int;//
		public var player_id : Int64;
		public var device_type:int;
	}
}
