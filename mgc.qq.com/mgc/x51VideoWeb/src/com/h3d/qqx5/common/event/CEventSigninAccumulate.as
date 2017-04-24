package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventSigninAccumulate extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventSigninAccumulate;
		}
		public function CEventSigninAccumulate()
		{
			registerField("day", "", Descriptor.Int32, 1);
		}
		public var day : int;
	}
}