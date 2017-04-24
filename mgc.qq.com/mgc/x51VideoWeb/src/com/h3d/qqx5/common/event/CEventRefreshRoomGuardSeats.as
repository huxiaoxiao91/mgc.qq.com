package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoGuardSeatInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshRoomGuardSeats extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshRoomGuardSeats;
		}
		
		public function CEventRefreshRoomGuardSeats()
		{
			registerField("m_room_id", "", Descriptor.Int32, 1);
			registerField("m_weath_req", "", Descriptor.Int32, 2);
			registerFieldForList("m_seats", getQualifiedClassName(VideoGuardSeatInfo), Descriptor.Compound, 3);
		}
		public var m_room_id:int = 0;
		public var m_weath_req:int = 0;
		public var m_seats:Array = new Array;
	}
}