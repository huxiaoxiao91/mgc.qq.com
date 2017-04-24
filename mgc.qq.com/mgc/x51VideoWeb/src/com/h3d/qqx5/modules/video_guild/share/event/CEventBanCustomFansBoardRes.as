package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventBanCustomFansBoardRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventBanCustomFansBoardRes;
		}
		
		public function CEventBanCustomFansBoardRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("reason", "", Descriptor.TypeString, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
		}
		
		public var res : int;
		public var reason : String;
		public var trans_id : Int64;
	}
}
