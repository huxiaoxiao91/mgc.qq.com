package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGuildAddScore extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildAddScore;
		}
		
		public function CEventVideoGuildAddScore()
		{
			registerField("guildID", "", Descriptor.Int64, 1);
			registerField("vipLevel", "", Descriptor.Int32, 2);
			registerField("player", "", Descriptor.Int64, 3);
			registerField("playername", "", Descriptor.TypeString, 4);
			registerField("zonename", "", Descriptor.TypeString, 5);
		}
		
		public var guildID : Int64;
		public var vipLevel : int;
		public var player : Int64;
		public var playername : String;
		public var zonename : String;
	}
}
