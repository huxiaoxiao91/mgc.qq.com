package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventUpdateMyVideoGuildInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventUpdateMyVideoGuildInfoRes;
		}
		
		public function CEventUpdateMyVideoGuildInfoRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("vg_id", "", Descriptor.Int64, 2);
			registerField("update_type", "", Descriptor.Int32, 3);
			registerField("update_str", "", Descriptor.TypeString, 4);
			registerField("player_id", "", Descriptor.Int64, 5);
			registerField("trans_id", "", Descriptor.Int64, 6);
//			registerField("serial_id", "", Descriptor.Int32, 7);
		}
		
		public var result : int;
		public var vg_id : Int64 = new Int64();
		public var update_type : int;
		public var update_str : String = "";
		public var player_id : Int64 = new Int64();;
		public var trans_id : Int64 = new Int64();
//		public var serial_id : int;
	}
}
