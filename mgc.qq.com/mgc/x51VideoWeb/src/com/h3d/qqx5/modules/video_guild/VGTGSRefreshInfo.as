package com.h3d.qqx5.modules.video_guild
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.getQualifiedClassName;
	public class VGTGSRefreshInfo extends ProtoBufSerializable
	{

		public function VGTGSRefreshInfo()
		{
			registerField("vg_info", getQualifiedClassName(VideoGuildBriefInfo), Descriptor.Compound, 1);
			registerField("refresh_type", "", Descriptor.Int32, 2);
		}
		
		public var vg_info :VideoGuildBriefInfo = new VideoGuildBriefInfo;
		public var refresh_type : int;
	}
}
