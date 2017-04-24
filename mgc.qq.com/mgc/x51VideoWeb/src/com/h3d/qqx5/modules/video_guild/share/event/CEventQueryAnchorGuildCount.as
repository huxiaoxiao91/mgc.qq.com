package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventQueryAnchorGuildCount extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventQueryAnchorGuildCount;
		}
		
		public function CEventQueryAnchorGuildCount()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("count", "", Descriptor.Int32, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
		}
		
		public var anchor_id : Int64;
		public var count : int;
		public var trans_id : Int64;
	}
}
