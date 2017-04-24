package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventRoomGuardSeatLostNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRoomGuardSeatLostNotify;
		}
		
		public function CEventRoomGuardSeatLostNotify()
		{
			registerField("m_room_id", "", Descriptor.Int32, 1);
			registerField("m_seat_index", "", Descriptor.Int32, 2);
			registerField("m_nick", "", Descriptor.TypeString, 3);
			registerField("m_zone", "", Descriptor.TypeString, 4);
			registerField("m_player_id", "", Descriptor.Int64, 5);
			registerField("m_cost", "", Descriptor.Int32, 6);
			registerField("m_last_cost", "", Descriptor.Int32, 7);
		}
		
		public var  m_room_id:int = 0;
		public var  m_seat_index:int = 0;
		public var  m_nick:String = "";
		public var  m_zone:String = "";
		public var  m_player_id:Int64 = new Int64();
		public var  m_cost:int = 0;
		public var  m_last_cost:int = 0;//指被别人用多少钱抢下来的
	}
}