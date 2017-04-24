package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadVideoGuildLogFromDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadVideoGuildLogFromDB;
		}
		
		public function CEventLoadVideoGuildLogFromDB()
		{
			registerField("video_guild_id", "", Descriptor.Int64, 1);
		}
		
		public var video_guild_id : Int64;
	}
}
