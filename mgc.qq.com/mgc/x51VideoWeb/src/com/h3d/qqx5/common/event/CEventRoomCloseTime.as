package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventRoomCloseTime extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRoomCloseTime;
		}
		
		public function CEventRoomCloseTime()
		{
		}
		
	}
}
