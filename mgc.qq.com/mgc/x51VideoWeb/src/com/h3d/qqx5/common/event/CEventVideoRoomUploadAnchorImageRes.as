package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomUploadAnchorImageRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorImageRes;
		}
		
		public function CEventVideoRoomUploadAnchorImageRes()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("res", "", Descriptor.Int32, 2);
			registerField("video_server_id", "", Descriptor.Int32, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
		}
		
		public var anchor_qq : Int64;
		public var res : int;
		public var video_server_id : int;
		public var room_id : int;
	}
}
