package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class VideoVoteEntry extends ProtoBufSerializable
	{
		
		public function VideoVoteEntry()
		{
			registerField("content", "", Descriptor.TypeString, 1);
			registerField("curr_count", "", Descriptor.Int32, 2);
		}
		
		public var content : String = "";
		public var curr_count : int;
	}
}
