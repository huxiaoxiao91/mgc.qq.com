package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildJoinApply;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoGuildJoinApplySaveToDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildJoinApplySaveToDB;
		}
		
		public function CEventVideoGuildJoinApplySaveToDB()
		{
			registerField("join_apply", getQualifiedClassName(VideoGuildJoinApply), Descriptor.Compound, 1);
		}
		
		public var join_apply :VideoGuildJoinApply = new VideoGuildJoinApply;
	}
}
