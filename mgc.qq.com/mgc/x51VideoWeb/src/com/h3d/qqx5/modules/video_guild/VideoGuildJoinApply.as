package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildJoinApply extends ProtoBufSerializable
	{
		
		public function VideoGuildJoinApply()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("pstid", "", Descriptor.Int64, 2);
			registerField("apptime", "", Descriptor.Int32, 3);
			registerField("nick", "", Descriptor.TypeString, 4);
			registerField("zone_name", "", Descriptor.TypeString, 5);
			registerField("vip_level", "", Descriptor.Int32, 6);
			registerField("wealth", "", Descriptor.Int64, 7);
			registerField("sex", "", Descriptor.Int32, 8);
			registerField("qq", "", Descriptor.Int64, 9);
			registerField("wealth_level", "", Descriptor.Int32, 10);
		}
		
		public var vgid : Int64 = new Int64();
		public var pstid : Int64 = new Int64();
		public var apptime : int;
		public var nick : String = "";
		public var zone_name : String = "";
		public var vip_level : int;
		public var wealth : Int64 = new Int64();
		public var sex : int;
		public var qq : Int64 = new Int64();
		public var wealth_level:int;
	}
}
