package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventGuildServerRequestAnchorRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGuildServerRequestAnchorRank;
		}
		
		public function CEventGuildServerRequestAnchorRank()
		{
			registerField("guild_server", "", Descriptor.Int64, 1);
		}
		
		public var guild_server : Int64;
	}
}
