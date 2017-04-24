package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadAnchorGuilds extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadAnchorGuilds;
		}
		
		public function CEventLoadAnchorGuilds()
		{
			registerField("sort_desc", "", Descriptor.TypeBoolean, 1);
			registerField("begin_index", "", Descriptor.Int32, 2);
			registerField("count", "", Descriptor.Int32, 3);
			registerField("player", "", Descriptor.Int64, 4);
			registerField("sort_by_guild_contribution_last_month", "", Descriptor.TypeBoolean, 5);
			registerField("sort_by_guild_contribution_this_month", "", Descriptor.TypeBoolean, 6);
			registerField("sort_by_guild_score_been_given", "", Descriptor.TypeBoolean, 7);
			registerField("transid", "", Descriptor.Int64, 8);
			registerField("sdk_req", "", Descriptor.TypeBoolean, 9);
		}
		
		public var sort_desc : Boolean;
		public var begin_index : int;
		public var count : int;
		public var player : Int64;
		public var sort_by_guild_contribution_last_month : Boolean;
		public var sort_by_guild_contribution_this_month : Boolean;
		public var sort_by_guild_score_been_given : Boolean;
		public var transid : Int64;
		public var sdk_req : Boolean;
	}
}
