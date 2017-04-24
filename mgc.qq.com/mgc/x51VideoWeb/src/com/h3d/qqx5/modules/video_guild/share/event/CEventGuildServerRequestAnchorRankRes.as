package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CEventGuildServerRequestAnchorRankRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGuildServerRequestAnchorRankRes;
		}
		
		public function CEventGuildServerRequestAnchorRankRes()
		{
			registerFieldForDict("guildRankInfo", "",Descriptor.Int64, getQualifiedClassName(Anchorrank_guildrank),Descriptor.Compound, 1);
		}
		
		public var guildRankInfo :Dictionary = new Dictionary();
	}
}
