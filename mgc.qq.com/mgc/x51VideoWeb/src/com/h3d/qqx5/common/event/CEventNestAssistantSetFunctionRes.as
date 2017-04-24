package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventNestAssistantSetFunctionRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventNestAssistantSetFunctionRes;
		}
		
		public function CEventNestAssistantSetFunctionRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
		}
		
		public var res : int;
	}
}
