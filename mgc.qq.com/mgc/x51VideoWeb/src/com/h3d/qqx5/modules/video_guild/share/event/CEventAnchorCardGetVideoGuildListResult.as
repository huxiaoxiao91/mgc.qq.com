package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.common.comdata.AnchorCardVideoGuildInfo;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorCardGetVideoGuildListResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorCardGetVideoGuildListResult;
		}
		
		public function CEventAnchorCardGetVideoGuildListResult()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerFieldForList("video_guilds", getQualifiedClassName(AnchorCardVideoGuildInfo), Descriptor.Compound, 2);
			registerField("transid", "", Descriptor.Int64, 3);
			registerField("video_guild_num", "", Descriptor.Int32, 4);
		}
		
		public var anchor_qq : Int64;
		public var video_guilds :Array =new Array();
		public var transid : Int64;
		public var video_guild_num : int;
	}
}
