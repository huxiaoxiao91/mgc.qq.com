package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoGuildDismiss extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildDismiss;
		}
		
		public function CEventVideoGuildDismiss()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("game_transid", "", Descriptor.Int64, 2);
			registerField("result", "", Descriptor.Int32, 3);
			registerField("target", "", Descriptor.Int64, 4);
			registerField("vg_id", "", Descriptor.Int64, 5);
			registerField("target_name", "", Descriptor.TypeString, 6);
			registerField("target_zone", "", Descriptor.TypeString, 7);
			registerField("op_type", "", Descriptor.Int32, 8);
			registerField("demise_t", "", Descriptor.Int32, 9);
			registerField("serial_id", "", Descriptor.Int32, 10);
		}
		
		public var player_id : Int64 = new Int64();
		public var game_transid : Int64 = new Int64();
		public var result : int;
		public var target : Int64 = new Int64();
		public var vg_id : Int64 = new Int64();
		public var target_name : String = "";
		public var target_zone : String = "";
		public var op_type : int;
		public var demise_t : int;
		public var serial_id : int;
		
		public static const Demise:int = 0;
		public static const CancelDemise:int = 1;
	}
}
