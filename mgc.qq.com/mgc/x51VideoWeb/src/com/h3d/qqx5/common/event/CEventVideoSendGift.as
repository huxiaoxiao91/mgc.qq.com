package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoSendGift extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoSendGift;
		}
		
		public function CEventVideoSendGift()
		{
			registerField("sender_id", "", Descriptor.Int64, 1);
			registerField("gift_id", "", Descriptor.Int32, 2);
			registerField("gift_count", "", Descriptor.Int32, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("anchor_qq", "", Descriptor.Int64, 5);
			registerField("avatar", "", Descriptor.TypeNetBuffer, 6);
			registerField("open_id", "", Descriptor.TypeString, 7);
			registerField("open_key", "", Descriptor.TypeString, 8);
			registerField("pay_token", "", Descriptor.TypeString, 9);
			registerField("pf", "", Descriptor.TypeString, 10);
			registerField("pf_key", "", Descriptor.TypeString, 11);
			registerField("star_gift", "", Descriptor.TypeBoolean, 12);
		}
		
		public var sender_id : Int64;
		public var gift_id : int;
		public var gift_count : int;
		public var room_id : int;
		public var anchor_qq : Int64;
		public var avatar :NetBuffer = new NetBuffer;
		public var open_id : String = "";
		public var open_key : String = "";
		public var pay_token : String = "";
		public var pf : String = "";
		public var pf_key : String = "";
		public var star_gift:Boolean;
	}
}
