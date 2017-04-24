package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventAdminOpenOrCloseRoomRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventAdminOpenOrCloseRoomRes;
		}
		
		public function CEventAdminOpenOrCloseRoomRes()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("is_open", "", Descriptor.TypeBoolean, 2);
		}
		
		public var room_id : int;
		public var is_open : Boolean;
	}
}
