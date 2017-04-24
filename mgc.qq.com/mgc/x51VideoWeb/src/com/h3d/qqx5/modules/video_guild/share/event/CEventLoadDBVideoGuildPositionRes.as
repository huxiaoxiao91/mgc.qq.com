package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.modules.video_guild.VideoGuildPositionDB;
	import com.h3d.qqx5.modules.video_guild.VideoGuildPositionInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadDBVideoGuildPositionRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventLoadDBVideoGuildPositionRes;
		}
		
		public function CEventLoadDBVideoGuildPositionRes()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerFieldForList("positions", getQualifiedClassName(VideoGuildPositionDB), Descriptor.Compound, 2);
		}
		
		public var vgid : Int64;
		public var positions :Array = new Array();
	}
}
