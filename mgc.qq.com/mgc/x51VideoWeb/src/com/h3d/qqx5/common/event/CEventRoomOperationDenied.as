package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventRoomOperationDenied extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRoomOperationDenied;
		}
		
		public function CEventRoomOperationDenied()
		{
			registerField("res", "", Descriptor.Int32, 1);
		}
		
		public var res : int;
	}
}
