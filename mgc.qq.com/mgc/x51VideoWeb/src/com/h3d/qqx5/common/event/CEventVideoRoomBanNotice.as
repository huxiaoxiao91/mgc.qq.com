package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;

	public class CEventVideoRoomBanNotice extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomBanNotice;
		}
		public function CEventVideoRoomBanNotice()
		{
			registerField("m_room_id", "", Descriptor.Int32, 1);
			registerField("m_banned", "", Descriptor.TypeBoolean, 2);
		}
		public var m_room_id : int;
		public var m_banned : Boolean;
	}
}
