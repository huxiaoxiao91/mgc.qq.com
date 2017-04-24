package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildPositionDB extends ProtoBufSerializable
	{
		
		public function VideoGuildPositionDB()
		{
			registerField("vg_id", "", Descriptor.Int64, 101);
		}
		
		public var vg_id : Int64;
	}
}
