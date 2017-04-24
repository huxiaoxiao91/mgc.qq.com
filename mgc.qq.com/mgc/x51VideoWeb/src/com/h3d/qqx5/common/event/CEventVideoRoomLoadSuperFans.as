package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomLoadSuperFans extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomLoadSuperFans;
		}
		
		public function CEventVideoRoomLoadSuperFans()
		{
			registerField("fans_type", "", Descriptor.Int32, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
		}
		
		public var fans_type : int;
		public var room_id : int;
		public var player_id : Int64;
	}
}
