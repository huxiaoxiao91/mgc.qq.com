package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventGetAnchorVideoGuildCount extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGetAnchorVideoGuildCount;
		}
		
		public function CEventGetAnchorVideoGuildCount()
		{
			registerField("anchor", "", Descriptor.Int64, 1);
			registerField("count", "", Descriptor.Int32, 2);
			registerField("transid", "", Descriptor.Int64, 3);
		}
		
		public var anchor : Int64;
		public var count : int;
		public var transid : Int64;
	}
}
