package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventDelDBVideoGuildPosition extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventDelDBVideoGuildPosition;
		}
		
		public function CEventDelDBVideoGuildPosition()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
		}
		
		public var vgid : Int64;
	}
}
