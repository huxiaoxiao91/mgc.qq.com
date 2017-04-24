package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventBanCustomFansBoard extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventBanCustomFansBoard;
		}
		
		public function CEventBanCustomFansBoard()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("vg_name", "", Descriptor.TypeString, 2);
			registerField("vg_id", "", Descriptor.Int64, 3);
		}
		
		public var trans_id : Int64;
		public var vg_name : String;
		public var vg_id : Int64;
	}
}
