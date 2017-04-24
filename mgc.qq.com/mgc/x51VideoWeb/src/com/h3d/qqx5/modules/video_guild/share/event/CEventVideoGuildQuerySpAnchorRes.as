package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildQuerySpAnchorRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildQuerySpAnchorRes;
		}
		
		public function CEventVideoGuildQuerySpAnchorRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("vg_id", "", Descriptor.Int64, 2);
			registerField("anchor", "", Descriptor.Int64, 3);
		}
		
		public var trans_id : Int64;
		public var vg_id : Int64;
		public var anchor : Int64;
	}
}