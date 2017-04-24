package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorScoreRank;
	
	import flash.utils.getQualifiedClassName;

	public class CEventRefreshAnchorScoreRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRefreshAnchorScoreRank;
		}
		
		public function CEventRefreshAnchorScoreRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoAnchorScoreRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("rank_timedimension", "", Descriptor.Int32, 3);
		}
		
		public var rank : Array = new Array;
		public var req_rank_player : Int64 = new Int64();
		public var rank_timedimension:int;
	}
}
