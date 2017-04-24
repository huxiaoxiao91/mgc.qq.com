package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildPositionDB;
	
	import flash.utils.getQualifiedClassName;

	public class CEventSaveDBVideoGuildPosition extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventSaveDBVideoGuildPosition;
		}
		
		public function CEventSaveDBVideoGuildPosition()
		{
			registerField("vg_position", getQualifiedClassName(VideoGuildPositionDB), Descriptor.Compound, 1);
		}
		
		public var vg_position :VideoGuildPositionDB = new VideoGuildPositionDB;
	}
}
