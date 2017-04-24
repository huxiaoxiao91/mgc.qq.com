package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventNotifySendLotsOfGifts extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventNotifySendLotsOfGifts;
		}
		
		public function CEventNotifySendLotsOfGifts()
		{
			registerField("sender_id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("gift_id", "", Descriptor.Int32, 3);
			registerField("gift_count", "", Descriptor.Int32, 4);
			registerField("zone_name", "", Descriptor.TypeString, 5);
			registerField("sender_name", "", Descriptor.TypeString, 6);
			registerField("anchor_name", "", Descriptor.TypeString, 7);
		}
		
		public var sender_id : Int64;
		public var room_id : int;
		public var gift_id : int;
		public var gift_count : int;
		public var zone_name : String;
		public var sender_name : String;
		public var anchor_name : String;
	}
}
