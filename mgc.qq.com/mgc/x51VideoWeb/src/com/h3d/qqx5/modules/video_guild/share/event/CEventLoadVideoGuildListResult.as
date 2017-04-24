package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.modules.video_guild.VideoGuildBriefInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadVideoGuildListResult extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadVideoGuildListResult;
		}
		
		public function CEventLoadVideoGuildListResult()
		{
			registerField("page", "", Descriptor.Int32, 1);
			registerField("total_count", "", Descriptor.Int32, 2);
			registerFieldForList("guilds", getQualifiedClassName(VideoGuildBriefInfo), Descriptor.Compound, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("player_id", "", Descriptor.Int64, 5);
			registerField("room_id", "", Descriptor.Int32, 6);
			registerField("game_transid", "", Descriptor.Int64, 7);
		}
		
		public var page : int;
		public var total_count : int;
		public var guilds : Array =new Array();
		public var result : int;
		public var player_id : Int64 = new Int64();
		public var room_id : int;
		public var game_transid : Int64 = new Int64();
	}
}
