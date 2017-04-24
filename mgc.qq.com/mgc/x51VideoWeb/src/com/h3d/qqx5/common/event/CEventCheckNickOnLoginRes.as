package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventCheckNickOnLoginRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventCheckNickOnLoginRes;
		}
		
		public function CEventCheckNickOnLoginRes()
		{
			registerField("m_status", "", Descriptor.Int32, 1);
			registerField("m_nick", "", Descriptor.TypeString, 2);
		}
		
		public var m_status : int;
		public var m_nick : String;
	}
}