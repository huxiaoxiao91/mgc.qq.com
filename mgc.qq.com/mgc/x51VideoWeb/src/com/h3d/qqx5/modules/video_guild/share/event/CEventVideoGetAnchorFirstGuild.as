package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGetAnchorFirstGuild extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGetAnchorFirstGuild;
		}
		
		public function CEventVideoGetAnchorFirstGuild()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var anchor_qq : Int64;
		public var room_id : int;
	}
}
