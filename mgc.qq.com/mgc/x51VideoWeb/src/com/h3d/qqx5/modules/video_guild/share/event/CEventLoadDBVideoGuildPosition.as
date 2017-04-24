package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadDBVideoGuildPosition extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadDBVideoGuildPosition;
		}
		
		public function CEventLoadDBVideoGuildPosition()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
		}
		
		public var vgid : Int64;
	}
}
