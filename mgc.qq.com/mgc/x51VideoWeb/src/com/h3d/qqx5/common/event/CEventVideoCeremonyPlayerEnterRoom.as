package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyPlayerEnterRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerEnterRoom;
		}
		
		public function CEventVideoCeremonyPlayerEnterRoom()
		{
			registerField("player_pstid", "", Descriptor.Int64, 1);
			registerField("sender_room_id", "", Descriptor.Int32, 2);
		}
		
		public var player_pstid : Int64;
		public var sender_room_id : int;
	}
}
