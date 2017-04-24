package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadTalentShowScore extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadTalentShowScore;
		}
		
		public function CEventLoadTalentShowScore()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var player_id : Int64;
		public var room_id : int;
	}
}
