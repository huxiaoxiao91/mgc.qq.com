package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRecedeSuperGuardRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRecedeSuperGuardRes;
		}
		
		public function CEventVideoRoomRecedeSuperGuardRes()
		{
			registerField("op_player_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("result", "", Descriptor.Int32, 3);
		}
		
		public var op_player_id : Int64;
		public var player_id : Int64;
		public var result : int;
	}
}
