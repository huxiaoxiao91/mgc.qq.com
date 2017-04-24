package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildDisband extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildDisband;
		}
		
		public function CEventVideoGuildDisband()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("game_transid", "", Descriptor.Int64, 2);
			registerField("op_type", "", Descriptor.Int32, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("disband_t", "", Descriptor.Int32, 5);
			registerField("vg_id", "", Descriptor.Int64, 6);
			registerField("serial_id", "", Descriptor.Int32, 7);
		}
		
		public var player_id : Int64  = new Int64();
		public var game_transid : Int64  = new Int64();
		public var op_type : int;
		public var result : int;
		public var disband_t : int;
		public var vg_id : Int64  = new Int64();
		public var serial_id : int;
		
		public static const Disband:int  = 0;
		public static const CancelDisband:int  = 1;
	}
}
