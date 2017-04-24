package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.util.Int64;
	import flash.utils.getQualifiedClassName;

	public class CEventInviteToJoinVideoGuildNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuildNotify;
		}
		
		public function CEventInviteToJoinVideoGuildNotify()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("inviter_name", "", Descriptor.TypeString, 2);
			registerField("inviter_zname", "", Descriptor.TypeString, 3);
			registerField("vg_name", "", Descriptor.TypeString, 4);
			registerField("inviter_id", "", Descriptor.Int64, 5);
			registerField("vg_info", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 6);
		}
		
		public var vgid : Int64 = new Int64;
		public var inviter_name : String = "";
		public var inviter_zname : String = "";
		public var vg_name : String = "";
		public var inviter_id : Int64 = new Int64;
		public var vg_info:VideoGuildInfo = new VideoGuildInfo();
	}
}
