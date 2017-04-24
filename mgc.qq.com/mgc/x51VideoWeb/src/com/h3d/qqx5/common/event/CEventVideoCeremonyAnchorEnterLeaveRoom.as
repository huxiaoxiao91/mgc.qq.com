package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyAnchorEnterLeaveRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyAnchorEnterLeaveRoom;
		}
		
		public function CEventVideoCeremonyAnchorEnterLeaveRoom()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("enter_room", "", Descriptor.TypeBoolean, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
		}
		
		public var anchor_id : Int64;
		public var enter_room : Boolean;
		public var room_id : int;
	}
}
