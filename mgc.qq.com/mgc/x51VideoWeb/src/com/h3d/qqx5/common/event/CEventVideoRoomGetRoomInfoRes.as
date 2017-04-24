package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoRoomGetRoomInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomInfoRes;
		}
		
		public function CEventVideoRoomGetRoomInfoRes()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("room_name", "", Descriptor.TypeString, 2);
			registerField("anchor_name", "", Descriptor.TypeString, 3);
			registerField("room_state", "", Descriptor.Int32, 4);
			registerField("audience_cnt", "", Descriptor.Int32, 5);
			registerField("result", "", Descriptor.Int32, 7);
		}
		
		public var room_id : int;
		public var room_name : String ="";
		public var anchor_name : String = "";
		public var room_state : int;
		public var audience_cnt : int;
		public var result : int;
	}
}
