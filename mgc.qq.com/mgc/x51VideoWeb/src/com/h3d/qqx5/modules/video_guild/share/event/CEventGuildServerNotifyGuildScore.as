package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventGuildServerNotifyGuildScore extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGuildServerNotifyGuildScore;
		}
		
		public function CEventGuildServerNotifyGuildScore()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("score", "", Descriptor.Int32, 2);
			registerField("anchor_id", "", Descriptor.Int64, 3);
		}
		
		public var vgid : Int64;
		public var score : int;
		public var anchor_id : Int64;
	}
}
