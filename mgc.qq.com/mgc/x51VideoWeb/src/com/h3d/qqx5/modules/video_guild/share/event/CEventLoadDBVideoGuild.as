package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventLoadDBVideoGuild extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadDBVideoGuild;
		}
		
		public function CEventLoadDBVideoGuild()
		{
			registerField("from", "", Descriptor.Int32, 1);
			registerField("count", "", Descriptor.Int32, 2);
			registerField("server_count", "", Descriptor.Int32, 3);
			registerField("selfindex", "", Descriptor.Int32, 4);
		}
		
		public var from : int;
		public var count : int;
		public var server_count : int;
		public var selfindex : int;
	}
}
