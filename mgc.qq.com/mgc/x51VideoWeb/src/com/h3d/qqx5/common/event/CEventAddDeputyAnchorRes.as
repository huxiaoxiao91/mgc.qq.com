package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventAddDeputyAnchorRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventAddDeputyAnchorRes;
		}
		
		public function CEventAddDeputyAnchorRes()
		{
			registerField("error_code", "", Descriptor.Int32, 1);
		}
		
		public var error_code : int;
	}
}
