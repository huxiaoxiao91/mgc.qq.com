package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomNotifyAnchorStartLive extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomNotifyAnchorStartLive;
		}
		
		public function CEventVideoRoomNotifyAnchorStartLive()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
		}
		
		public var anchor_id : Int64;
	}
}
