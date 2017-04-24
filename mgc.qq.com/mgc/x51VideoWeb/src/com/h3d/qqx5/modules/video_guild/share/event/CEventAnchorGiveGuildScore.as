package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorGiveGuildScore extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorGiveGuildScore;
		}
		
		public function CEventAnchorGiveGuildScore()
		{
			registerField("vgid", "", Descriptor.Int64, 1);
			registerField("score", "", Descriptor.Int32, 2);
			registerField("anchor_id", "", Descriptor.Int64, 3);
			registerField("trans_id", "", Descriptor.Int64, 4);
			registerField("errcode", "", Descriptor.Int32, 5);
			registerField("guild_been_given", "", Descriptor.Int32, 6);
			registerField("anchorname", "", Descriptor.TypeString, 7);
		}
		
		public var vgid : Int64;
		public var score : int;
		public var anchor_id : Int64;
		public var trans_id : Int64;
		public var errcode : int;
		public var guild_been_given : int;
		public var anchorname : String;
	}
}
