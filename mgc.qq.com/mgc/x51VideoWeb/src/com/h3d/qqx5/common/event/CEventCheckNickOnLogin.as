package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventCheckNickOnLogin extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventCheckNickOnLogin;
		}
		
		public function CEventCheckNickOnLogin()
		{
			
		}
	}
}