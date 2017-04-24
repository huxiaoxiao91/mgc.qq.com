package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventCheckVideoGuildNameDupRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventCheckVideoGuildNameDupRes;
		}
		
		public function CEventCheckVideoGuildNameDupRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var result : int;
		public var trans_id : Int64;
	}
}
