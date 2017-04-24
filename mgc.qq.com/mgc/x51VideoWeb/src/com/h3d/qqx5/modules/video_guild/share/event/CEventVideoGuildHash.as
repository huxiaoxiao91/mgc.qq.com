package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventVideoGuildHash extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildHash;
		}
		
		public function CEventVideoGuildHash()
		{
			registerField("server_count", "", Descriptor.Int32, 1);
			registerField("self_index", "", Descriptor.Int32, 2);
		}
		
		public var server_count : int;
		public var self_index : int;
	}
}
