package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGuildJoinApplyDelFromDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildJoinApplyDelFromDB;
		}
		
		public function CEventVideoGuildJoinApplyDelFromDB()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("expired_time", "", Descriptor.Int32, 3);
		}
		
		public var player_id : Int64;
		public var vgid : Int64;
		public var expired_time : int;
	}
}
