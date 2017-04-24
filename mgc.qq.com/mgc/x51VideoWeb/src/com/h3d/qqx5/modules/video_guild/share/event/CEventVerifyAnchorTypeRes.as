package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVerifyAnchorTypeRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVerifyAnchorTypeRes;
		}
		
		public function CEventVerifyAnchorTypeRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
		}
		
		public var trans_id : Int64;
		public var result : int;
	}
}
