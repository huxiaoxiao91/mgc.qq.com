package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildChangeAnchorRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildChangeAnchorRes;
		}
		
		public function CEventVideoGuildChangeAnchorRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("vg_name", "", Descriptor.TypeString, 3);
		}
		
		public var trans_id : Int64;
		public var result : int;
		public var vg_name : String;
	}
}
