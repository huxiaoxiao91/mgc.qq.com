package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventDianZanResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventDianZanResult;
		}
		
		public function CEventDianZanResult()
		{
			registerField("player", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("anchor_name", "", Descriptor.TypeString, 3);
			registerField("transid", "", Descriptor.Int64, 4);
		}
		
		public var player : Int64;
		public var result : int;
		public var anchor_name : String;
		public var transid : Int64;
	}
}
