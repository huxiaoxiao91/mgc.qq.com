package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventNotifyAnchorScoreChange extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventNotifyAnchorScoreChange;
		}
		
		public function CEventNotifyAnchorScoreChange()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("score", "", Descriptor.Int32, 2);
		}
		
		public var anchor_id : Int64;
		public var score : int;
	}
}
