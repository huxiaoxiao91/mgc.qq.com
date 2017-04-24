package com.h3d.qqx5.modules.video_guild.share.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorQueryScoreRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoGuildEventID.CLSID_CEventAnchorQueryScoreRank;
		}
		
		public function CEventAnchorQueryScoreRank()
		{
			registerField("anchor", "", Descriptor.Int64, 1);
			registerField("anchor_rank", "", Descriptor.Int32, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
			registerField("query_type", "", Descriptor.Int32, 4);
		}
		
		public var anchor : Int64;
		public var anchor_rank : int;
		public var trans_id : Int64;
		public var query_type : int;
	}
}
