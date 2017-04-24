package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class VideoRoomLiveInfo extends ProtoBufSerializable
	{
		public function VideoRoomLiveInfo()
		{
			registerField("vid", "", Descriptor.Int32, 1);
			registerField("split_screen_vid", "", Descriptor.Int32, 2);
		}
		
		public var vid : int;
		public var split_screen_vid : int;
	}
}