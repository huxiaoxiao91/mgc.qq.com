package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomUploadAnchorImage extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorImage;
		}
		
		public function CEventVideoRoomUploadAnchorImage()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("image_data", "", Descriptor.TypeNetBuffer, 2);
			registerField("path", "", Descriptor.TypeString, 3);
			registerField("video_server_id", "", Descriptor.Int32, 4);
			registerField("room_id", "", Descriptor.Int32, 5);
		}
		
		public var anchor_qq : Int64;
		public var image_data :NetBuffer;
		public var path : String;
		public var video_server_id : int;
		public var room_id : int;
	}
}
