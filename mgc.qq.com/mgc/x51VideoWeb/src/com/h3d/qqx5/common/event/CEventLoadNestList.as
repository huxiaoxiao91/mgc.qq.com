package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadNestList extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadNestList;
		}
		
		public function CEventLoadNestList()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
		}
		
		public var room_id : int;
	}
}
