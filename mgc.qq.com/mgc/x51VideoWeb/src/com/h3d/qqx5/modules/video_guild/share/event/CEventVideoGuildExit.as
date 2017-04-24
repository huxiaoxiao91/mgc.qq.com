package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGuildExit extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildExit;
		}
		
		public function CEventVideoGuildExit()
		{
			registerField("vg_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("game_transid", "", Descriptor.Int64, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("serial_id", "", Descriptor.Int32, 5);
		}
		
		public var vg_id : Int64 = new Int64();
		public var player_id : Int64 = new Int64();
		public var game_transid : Int64 = new Int64() ;
		public var result : int = 0;
		public var serial_id : int = 0;
	}
}
