package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventDianZan extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventDianZan;
		}
		
		public function CEventDianZan()
		{
			registerField("player", "", Descriptor.Int64, 1);
			registerField("anchor", "", Descriptor.Int64, 2);
			registerField("transid", "", Descriptor.Int64, 3);
		}
		
		public var player : Int64;
		public var anchor : Int64;
		public var transid : Int64;
	}
}
