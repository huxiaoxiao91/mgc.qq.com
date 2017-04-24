package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadNestIDRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadNestIDRes;
		}
		
		public function CEventLoadNestIDRes()
		{
		}
		
	}
}
