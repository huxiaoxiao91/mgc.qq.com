package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventGetVideoRoomLiveInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventGetVideoRoomLiveInfo;
		}
		public function CEventGetVideoRoomLiveInfo()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
		}
		public var room_id : int;
	}
}