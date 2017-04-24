package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventCheckVideoGuildNameDup extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventCheckVideoGuildNameDup;
		}
		
		public function CEventCheckVideoGuildNameDup()
		{
			registerField("vg_name", "", Descriptor.TypeString, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var vg_name : String;
		public var trans_id : Int64;
	}
}
