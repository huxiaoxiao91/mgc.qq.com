package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoResolution extends ProtoBufSerializable
	{
		public function VideoResolution()
		{
			registerField("m_width", "", Descriptor.Int32, 1);
			registerField("m_height", "", Descriptor.Int32, 2);
		}
		
		public var m_width:int;
		public var m_height:int;
	}
}