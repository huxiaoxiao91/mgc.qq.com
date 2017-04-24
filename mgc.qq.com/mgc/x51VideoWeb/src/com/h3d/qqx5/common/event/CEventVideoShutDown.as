package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoShutDown extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoShutDown;
		}
		
		public function CEventVideoShutDown()
		{
			registerField("kick_anchors", "", Descriptor.Int32, 1);
			registerField("kick_players", "", Descriptor.Int32, 2);
		}
		
		public var kick_anchors : int;
		public var kick_players : int;
	}
}
