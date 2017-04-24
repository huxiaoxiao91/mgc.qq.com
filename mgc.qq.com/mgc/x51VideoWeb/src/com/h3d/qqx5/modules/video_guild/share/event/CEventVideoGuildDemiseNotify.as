package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildDemiseNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildDemiseNotify;
		}
		
		public function CEventVideoGuildDemiseNotify()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("old_chief_pstid", "", Descriptor.Int64, 2);
			registerField("old_chief_name", "", Descriptor.TypeString, 3);
			registerField("old_chief_zone_name", "", Descriptor.TypeString, 4);
			registerField("new_chief_pstid", "", Descriptor.Int64, 5);
			registerField("new_chief_name", "", Descriptor.TypeString, 6);
			registerField("new_chief_zone", "", Descriptor.TypeString, 7);
		}
		
		public var player_id:Int64 = new Int64();
		public var old_chief_pstid:Int64 = new Int64();
		public var old_chief_name:String = "";
		public var old_chief_zone_name:String = "";
		public var new_chief_pstid:Int64 = new Int64();
		public var new_chief_name:String = "";
		public var new_chief_zone:String = "";
	}
}
