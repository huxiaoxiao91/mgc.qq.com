package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildMemberInfo;
	
	import flash.utils.getQualifiedClassName;

	public class CEventSaveDBVideoGuildMember extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSaveDBVideoGuildMember;
		}
		
		public function CEventSaveDBVideoGuildMember()
		{
			registerField("info", getQualifiedClassName(VideoGuildMemberInfo), Descriptor.Compound, 1);
		}
		
		public var info :VideoGuildMemberInfo = new VideoGuildMemberInfo;
	}
}
