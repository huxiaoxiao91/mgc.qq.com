package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VipSeatInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshVipSeats extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshVipSeats;
		}
		public function CEventRefreshVipSeats()
		{
			registerFieldForList("seat_list", getQualifiedClassName(VipSeatInfo), Descriptor.Compound, 1);
		}
		public var seat_list : Array = new Array();
	}
}
