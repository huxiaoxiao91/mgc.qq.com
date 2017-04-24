package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGuildBuyFansBoardRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildBuyFansBoardRes;
		}
		
		public function CEventVideoGuildBuyFansBoardRes()
		{
			registerField("game_transid", "", Descriptor.Int64, 1);
			registerField("vgid", "", Descriptor.Int64, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("boardtype", "", Descriptor.Int32, 5);
			registerField("add_time", "", Descriptor.Int32, 6);
			registerField("result", "", Descriptor.Int32, 7);
			registerField("cur_vg_wealth", "", Descriptor.Int32, 8);
			registerField("cur_time_limit", "", Descriptor.Int32, 9);
			registerField("sender_qq", "", Descriptor.Int64, 10);
			registerField("serial_id", "", Descriptor.Int32, 11);
		}
		
		public var game_transid : Int64;
		public var vgid : Int64;
		public var player_id : Int64;
		public var room_id : int;
		public var boardtype : int;
		public var add_time : int;
		public var result : int;
		public var cur_vg_wealth : int;
		public var cur_time_limit : int;
		public var sender_qq : Int64;
		public var serial_id : int;
	}
}
