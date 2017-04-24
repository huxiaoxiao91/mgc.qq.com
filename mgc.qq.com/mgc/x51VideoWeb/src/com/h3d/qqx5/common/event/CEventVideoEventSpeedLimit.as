package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoEventSpeedLimit extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoEventSpeedLimit;
		}
		
		public function CEventVideoEventSpeedLimit()
		{
			registerField("QQ", "", Descriptor.Int64, 1);
			registerField("playerid", "", Descriptor.Int64, 2);
			registerField("clsid", "", Descriptor.Int32, 3);
		}
		
		public var QQ : Int64;
		public var playerid : Int64;
		public var clsid : int;
	}
}
