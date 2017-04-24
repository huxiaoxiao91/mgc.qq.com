package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadAnchorGuildsRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadAnchorGuildsRes;
		}
		
		public function CEventLoadAnchorGuildsRes()
		{
			registerFieldForList("guild_loaded", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 1);
			registerField("count", "", Descriptor.Int32, 2);
			registerField("player", "", Descriptor.Int64, 3);
			registerField("transid", "", Descriptor.Int64, 4);
			registerField("to_sdk", "", Descriptor.TypeBoolean, 5);
		}
		
		public var guild_loaded : Array = new Array();
		public var count : int;
		public var player : Int64;
		public var transid : Int64;
		public var to_sdk : Boolean;
	}
}
