package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventAcceptJoinApplyTargetOnlineNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAcceptJoinApplyTargetOnlineNotify;
		}
		
		public function CEventAcceptJoinApplyTargetOnlineNotify()
		{
			registerField("target_id", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("vg_info", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 3);
		}
		
		public var target_id : Int64;
		public var vgid : Int64;
		public var vg_info :VideoGuildInfo = new VideoGuildInfo;
	}
}
