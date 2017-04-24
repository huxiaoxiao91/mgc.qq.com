package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventUpdateVideoGuildMemberVipLevel extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventUpdateVideoGuildMemberVipLevel;
		}
		
		public function CEventUpdateVideoGuildMemberVipLevel()
		{
			registerField("vip_level", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("vgid", "", Descriptor.Int64, 3);
		}
		
		public var vip_level : int;
		public var player_id : Int64;
		public var vgid : Int64;
	}
}
