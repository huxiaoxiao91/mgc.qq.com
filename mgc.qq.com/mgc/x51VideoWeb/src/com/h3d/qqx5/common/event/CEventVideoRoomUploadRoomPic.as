package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomUploadRoomPic extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomUploadRoomPic;
		}
		
		public function CEventVideoRoomUploadRoomPic()
		{
			registerField("uploader_qq", "", Descriptor.Int64, 1);
			registerField("pic_index", "", Descriptor.Int32, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("pic_data", "", Descriptor.TypeNetBuffer, 4);
			registerField("video_server_id", "", Descriptor.Int32, 5);
			registerField("path", "", Descriptor.TypeString, 6);
		}
		
		public var uploader_qq : Int64;
		public var pic_index : int;
		public var room_id : int;
		public var pic_data :NetBuffer ;
		public var video_server_id : int;
		public var path : String;
	}
}
