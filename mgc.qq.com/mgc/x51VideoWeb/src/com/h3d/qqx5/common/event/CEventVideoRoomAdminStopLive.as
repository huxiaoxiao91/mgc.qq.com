package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomAdminStopLive extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomAdminStopLive;
		}
		
		public function CEventVideoRoomAdminStopLive()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("op_player_id", "", Descriptor.Int64, 2);
		}
		
		public var room_id : int;
		public var op_player_id : Int64;
	}
}
