package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadDBVideoGuildMember extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadDBVideoGuildMember;
		}
		
		public function CEventLoadDBVideoGuildMember()
		{
			registerField("vg_id", "", Descriptor.Int64, 1);
		}
		
		public var vg_id : Int64;
	}
}
