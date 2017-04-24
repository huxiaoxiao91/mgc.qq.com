package com.h3d.qqx5.common.event
{
		import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
		import com.h3d.qqx5.framework.network.Descriptor;
		import com.h3d.qqx5.framework.network.INetMessage;
		
		public class CEventAllVipSeatsOccupiedBroadcastAllRoom extends INetMessage
		{
			public override function CLSID() : int
			{
				return EEventIDVideoRoomExt.CLSID_CEventAllVipSeatsOccupiedBroadcastAllRoom;
			}
			
			public function CEventAllVipSeatsOccupiedBroadcastAllRoom()
			{
				registerField("room_id", "", Descriptor.Int32, 1);
				registerField("room_name", "", Descriptor.TypeString, 2);
			}
			
			public var room_id : int;
			public var room_name : String = "";
		}
}