package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VGTGSRefreshInfo;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoGuildRefreshToGuildSummary extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildRefreshToGuildSummary;
		}
		
		public function CEventVideoGuildRefreshToGuildSummary()
		{
			registerFieldForList("data", getQualifiedClassName(VGTGSRefreshInfo), Descriptor.Compound, 1);
		}
		
		public var data :VGTGSRefreshInfo = new VGTGSRefreshInfo;
	}
}
