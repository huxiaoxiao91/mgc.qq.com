package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildDisbandNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildDisbandNotify;
		}
		
		public function CEventVideoGuildDisbandNotify()
		{
			registerField("chief_nick", "", Descriptor.TypeString, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("chief_zone", "", Descriptor.TypeString, 3);
			registerField("chief_id", "", Descriptor.Int64, 4);
		}
		
		public var chief_nick : String = "";
		public var player_id : Int64 = new Int64();
		public var chief_zone : String = "";
		public var chief_id : Int64 = new Int64();
	}
}
