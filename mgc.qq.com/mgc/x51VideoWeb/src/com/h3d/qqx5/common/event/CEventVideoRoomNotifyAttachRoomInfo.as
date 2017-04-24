package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoRoomNotifyAttachRoomInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomNotifyAttachRoomInfo;
		}
		
		public function CEventVideoRoomNotifyAttachRoomInfo()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("anchor_name", "", Descriptor.TypeString, 2);
			registerField("room_name", "", Descriptor.TypeString, 3);
		}
		
		public var room_id : int;
		public var anchor_name : String = "";
		public var room_name : String = "";
	}
}
