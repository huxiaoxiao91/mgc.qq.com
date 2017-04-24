package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoPopularityRank;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventRefreshPopularityRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRefreshPopularityRank;
		}
		
		public function CEventRefreshPopularityRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoPopularityRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
		}
		
		public var rank : Array = new Array;
		public var req_rank_player : Int64;
	}
}
