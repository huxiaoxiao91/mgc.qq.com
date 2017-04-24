package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRequestDeputyAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRequestDeputyAnchor;
		}
		
		public function CEventVideoRoomRequestDeputyAnchor()
		{
			registerField("rs_transid", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("deputy_anchor", "", Descriptor.Int64, 3);
			registerField("video_server_id", "", Descriptor.Int32, 5);
			registerField("room_id", "", Descriptor.Int32, 6);
			registerField("anchor_video_server_id", "", Descriptor.Int32, 7);
		}
		
		public var rs_transid : Int64;
		public var result : int;
		public var deputy_anchor : Int64;
		public var video_server_id : int;
		public var room_id : int;
		public var anchor_video_server_id : int;
	}
}
