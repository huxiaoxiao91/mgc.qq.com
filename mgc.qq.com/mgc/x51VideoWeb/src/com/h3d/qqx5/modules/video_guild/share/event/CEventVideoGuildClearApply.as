package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildClearApply extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildClearApply;
		}
		
		public function CEventVideoGuildClearApply()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
		}
		
		public var player_id : Int64;
	}
}
