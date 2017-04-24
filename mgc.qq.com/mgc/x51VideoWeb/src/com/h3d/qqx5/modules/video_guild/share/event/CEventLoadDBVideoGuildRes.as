package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadDBVideoGuildRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadDBVideoGuildRes;
		}
		
		public function CEventLoadDBVideoGuildRes()
		{
			registerFieldForList("guild_loaded", getQualifiedClassName(VideoGuildInfo), Descriptor.Compound, 1);
			registerField("count", "", Descriptor.Int32, 2);
		}
		
		public var guild_loaded :Array = new Array();
		public var count : int;
	}
}
