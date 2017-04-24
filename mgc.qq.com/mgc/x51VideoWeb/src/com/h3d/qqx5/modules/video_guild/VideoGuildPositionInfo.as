package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class VideoGuildPositionInfo extends ProtoBufSerializable
	{
		public function VideoGuildPositionInfo()
		{
			registerField("position_id", "", Descriptor.Int32, 1);
			registerField("position_name", "", Descriptor.TypeString, 2);
			registerField("rights", "", Descriptor.Int32, 3);
		}
		
		public var position_id : int;
		public var position_name : String = "";
		public var rights : int;
	}
}
