package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorCardGetVideoGuildList extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorCardGetVideoGuildList;
		}
		
		public function CEventAnchorCardGetVideoGuildList()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("transid", "", Descriptor.Int64, 2);
		}
		
		public var anchor_qq : Int64;
		public var transid : Int64;
	}
}
