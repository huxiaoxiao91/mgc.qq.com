package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class Anchorrank_guildrank extends INetMessage
	{
		public function Anchorrank_guildrank()
		{
			registerField("anchorrank", "",Descriptor.Int32, 1);
			registerField("guildrank", "",Descriptor.Int32, 2);
		}
		
		public var anchorrank :int;
		public var guildrank :int;
	}
}