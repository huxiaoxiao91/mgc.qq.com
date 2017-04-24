package com.h3d.qqx5.common.event
{

		import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
		import com.h3d.qqx5.framework.network.INetMessage;
		
		public class CEventGetGuestInfo extends INetMessage
		{
			public override function CLSID() : int
			{
				return EEventIDVideoRoomExt.CLSID_CEventGetGuestInfo;
			}
			
			public function CEventGetGuestInfo()
			{
			}
		}
}