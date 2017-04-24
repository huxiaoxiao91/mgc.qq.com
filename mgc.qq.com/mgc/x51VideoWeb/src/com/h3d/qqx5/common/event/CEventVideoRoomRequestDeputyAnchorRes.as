package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRequestDeputyAnchorRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRequestDeputyAnchorRes;
		}
		
		public function CEventVideoRoomRequestDeputyAnchorRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("deputy_anchor", "", Descriptor.Int64, 2);
			registerField("deputy_anchor_zoneid", "", Descriptor.Int32, 3);
			registerField("video_server_id", "", Descriptor.Int32, 5);
			registerField("room_id", "", Descriptor.Int32, 6);
		}
		
		public var result : int;
		public var deputy_anchor : Int64;
		public var deputy_anchor_zoneid : int;
		public var video_server_id : int;
		public var room_id : int;
	}
}
