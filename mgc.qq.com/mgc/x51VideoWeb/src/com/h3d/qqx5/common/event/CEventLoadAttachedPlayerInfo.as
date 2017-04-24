package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadAttachedPlayerInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfo;
		}
		
		public function CEventLoadAttachedPlayerInfo()
		{
			registerField("transid", "", Descriptor.Int64, 1);
			registerField("anchor_account", "", Descriptor.Int64, 2);
		}
		
		public var transid : Int64;
		public var anchor_account : Int64;
	}
}
