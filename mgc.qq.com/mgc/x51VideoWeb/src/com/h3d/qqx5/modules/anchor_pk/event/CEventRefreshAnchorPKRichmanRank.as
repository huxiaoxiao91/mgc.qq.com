package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorPKRichmanRank;
	
	import flash.utils.getQualifiedClassName;

	public class CEventRefreshAnchorPKRichmanRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventRefreshAnchorPKRichmanRank;
		}
		
		public function CEventRefreshAnchorPKRichmanRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoAnchorPKRichmanRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("show_end_time", "", Descriptor.Int32, 3);
		}
		
		public var rank :Array = new Array();
		public var req_rank_player : Int64 = new Int64(0,0);
		public var show_end_time : int;
	}
}
