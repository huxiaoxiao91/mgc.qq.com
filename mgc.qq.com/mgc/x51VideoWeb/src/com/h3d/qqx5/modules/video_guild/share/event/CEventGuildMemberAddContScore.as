package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventGuildMemberAddContScore extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventGuildMemberAddContScore;
		}
		
		public function CEventGuildMemberAddContScore()
		{
			registerField("member", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("score", "", Descriptor.Int32, 3);
			registerField("vg_id", "", Descriptor.Int64, 4);
		}
		
		public var member : Int64;
		public var anchor_id : Int64;
		public var score : int;
		public var vg_id : Int64;
	}
}
