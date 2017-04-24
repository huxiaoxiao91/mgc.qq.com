package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyVipTakeSeatProtectTime extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventNotifyVipTakeSeatProtectTime;
		}
		public function CEventNotifyVipTakeSeatProtectTime()
		{
			registerFieldForDict("seat_protect_time", "", Descriptor.Int32, "", Descriptor.Int32, 1);
		}
		public var seat_protect_time : Dictionary = new Dictionary();
	}
}
