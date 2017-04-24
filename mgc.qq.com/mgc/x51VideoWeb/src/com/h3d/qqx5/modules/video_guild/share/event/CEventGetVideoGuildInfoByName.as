package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventGetVideoGuildInfoByName extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGetVideoGuildInfoByName;
		}
		
		public function CEventGetVideoGuildInfoByName()
		{
			registerField("vgname", "", Descriptor.TypeString, 1);
			registerField("transid", "", Descriptor.Int64, 2);
			registerField("err", "", Descriptor.Int32, 3);
			registerField("guild", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 4);
		}
		
		public var vgname : String ="";
		public var transid : Int64;
		public var err : int;
		public var guild :VideoGuildInfo = new VideoGuildInfo;
	}
}
