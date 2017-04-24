package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomLiveBeStoped extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomLiveBeStoped;
		}
		
		public function CEventVideoRoomLiveBeStoped()
		{
			registerField("reason", "", Descriptor.Int32, 1);
			registerField("anchor_pstid", "", Descriptor.Int64, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("vid", "", Descriptor.Int32, 4);
		}
		
		public var reason : int;
		public var anchor_pstid : Int64;
		public var room_id : int;
		public var vid : int;
	}
}
