package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventTakeVipSeat extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventTakeVipSeat;
		}
		public function CEventTakeVipSeat()	
		{
			registerField("cost", "", Descriptor.Int32, 1);
			registerField("seat_index", "", Descriptor.Int32, 2);
		}
		public var cost : int;
		public var seat_index : int;
	}
}
