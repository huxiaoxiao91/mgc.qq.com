package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventTakeRoomGuardSeat extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventTakeRoomGuardSeat;
		}
		
		public function CEventTakeRoomGuardSeat()
		{
			registerField("m_room_id", "", Descriptor.Int32, 1);
			registerField("m_seat_index", "", Descriptor.Int32, 2);
			registerField("m_owner", "", Descriptor.Int64, 3);
			registerField("m_cost", "", Descriptor.Int32, 4);
		}
		
		public var m_room_id:int = 0;
		public var m_seat_index:int = 0;
		public var m_owner:Int64 = new Int64();
		public var m_cost:int = 0;
	}
}