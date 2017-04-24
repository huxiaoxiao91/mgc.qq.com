package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventVideoGuildHashError extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildHashError;
		}
		
		public function CEventVideoGuildHashError()
		{
			registerField("error_type", "", Descriptor.Int32, 1);
		}
		
		public var error_type : int;
	}
}
