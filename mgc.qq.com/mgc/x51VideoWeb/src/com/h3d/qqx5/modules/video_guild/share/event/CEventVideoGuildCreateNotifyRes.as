package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoGuildCreateNotifyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildCreateNotifyRes;
		}
		
		public function CEventVideoGuildCreateNotifyRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
			registerField("vg_info", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 3);
		}
		
		public var result : int;
		public var trans_id : Int64;
		public var vg_info :VideoGuildInfo = new VideoGuildInfo;
	}
}
