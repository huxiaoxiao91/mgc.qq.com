package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventSyncPlayerVideoGuildID extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSyncPlayerVideoGuildID;
		}
		
		public function CEventSyncPlayerVideoGuildID()
		{
			registerField("video_guild_id", "", Descriptor.Int64, 1);
		}
		
		public var video_guild_id : Int64;
	}
}
