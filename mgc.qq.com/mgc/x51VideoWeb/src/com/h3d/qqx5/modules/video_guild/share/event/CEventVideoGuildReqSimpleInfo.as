package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventVideoGuildReqSimpleInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventVideoGuildReqSimpleInfo;
		}
		
		public function CEventVideoGuildReqSimpleInfo()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("player", "", Descriptor.Int64, 3);
		}
		
		public var vgid : Int64;
		public var player : Int64;
	}
}
