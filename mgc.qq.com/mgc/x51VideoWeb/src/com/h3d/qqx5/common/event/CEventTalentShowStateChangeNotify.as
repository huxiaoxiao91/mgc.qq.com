package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventTalentShowStateChangeNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventTalentShowStateChangeNotify;
		}
		
		public function CEventTalentShowStateChangeNotify()
		{
			registerField("new_state", "", Descriptor.Int32, 1);
			registerField("type", "", Descriptor.Int32, 2);
		}
		
		public var new_state : int;
		public var type : int;
	}
}
