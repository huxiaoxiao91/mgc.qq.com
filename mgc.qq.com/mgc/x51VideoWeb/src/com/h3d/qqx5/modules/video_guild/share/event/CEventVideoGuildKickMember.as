package com.h3d.qqx5.modules.video_guild.share.event
{
	
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildKickMember extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildKickMember;
		}
		
		public function CEventVideoGuildKickMember()
		{
			registerField("target", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("game_transid", "", Descriptor.Int64, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("vg_id", "", Descriptor.Int64, 5);
			registerField("serial_id", "", Descriptor.Int32, 6);
		}
		
		public var target : Int64  = new Int64(0,0);
		public var player_id : Int64  = new Int64();
		public var game_transid : Int64  = new Int64();
		public var result : int = 1000;
		public var vg_id : Int64 = new Int64(0,0);
		public var serial_id : int;
	}
}
