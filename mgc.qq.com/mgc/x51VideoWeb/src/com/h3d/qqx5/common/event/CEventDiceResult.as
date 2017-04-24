package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventDiceResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventDiceResult;
		}
		
		public function CEventDiceResult()
		{
			registerField("anchor", "", Descriptor.Int64, 1);
			registerField("anchor_nick", "", Descriptor.TypeString, 2);
			registerField("dice_number", "", Descriptor.Int32, 3);
		}
		
		public var anchor : Int64;
		public var anchor_nick : String= "";
		public var dice_number : int;
	}
}
