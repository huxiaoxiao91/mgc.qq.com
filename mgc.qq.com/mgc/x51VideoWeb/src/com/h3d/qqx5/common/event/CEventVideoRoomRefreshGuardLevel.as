package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRefreshGuardLevel extends INetMessage
	{
		public override function CLSID():int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshGuardLevel;
		}
		
		public function CEventVideoRoomRefreshGuardLevel()
		{
			registerField("guard_level", "", Descriptor.Int32, 1);
		}
		
		public var guard_level:int;
	}
}
