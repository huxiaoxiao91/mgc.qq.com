package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventUpdateMyVideoGuildInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventUpdateMyVideoGuildInfo;
		}
		
		public function CEventUpdateMyVideoGuildInfo()
		{
			registerField("vg_id", "", Descriptor.Int64, 1);
			registerField("update_type", "", Descriptor.Int32, 2);
			registerField("update_str", "", Descriptor.TypeString, 3);
			registerField("player_id", "", Descriptor.Int64, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
//			registerField("serial_id", "", Descriptor.Int32, 6);
		}
		
		public var vg_id : Int64  = new Int64();
		public var update_type : int;
		public var update_str : String = "";
		public var player_id : Int64  = new Int64();
		public var trans_id :Int64  = new Int64();
//		public var serial_id : int;
	}
}
