package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadRecommendVideoRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadRecommendVideoRoom;
		}
		
		public function CEventLoadRecommendVideoRoom()
		{
			registerField("type", "", Descriptor.Int32, 1);
		}
	
		public var type : int;
	}
}
