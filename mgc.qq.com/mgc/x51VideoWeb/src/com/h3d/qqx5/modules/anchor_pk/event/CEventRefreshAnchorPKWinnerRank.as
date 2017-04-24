package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorPKWinnerRank;
	
	import flash.utils.getQualifiedClassName;

	public class CEventRefreshAnchorPKWinnerRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventRefreshAnchorPKWinnerRank;
		}
		
		public function CEventRefreshAnchorPKWinnerRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoAnchorPKWinnerRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("show_end_time", "", Descriptor.Int32, 3);
		}
		
		public var rank : Array = new Array();
		public var req_rank_player : Int64 = new Int64(0,0);
		public var show_end_time : int;
	}
}
