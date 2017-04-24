package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarlightRank;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	
	public class CEventRefreshStarlightRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRefreshStarlightRank;
		}
		
		public function CEventRefreshStarlightRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoStarlightRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("rank_type", "", Descriptor.Int32, 3);
			registerField("rank_timedimension", "", Descriptor.Int32, 4);
		}
		
		public var rank : Array = new Array;
		public var req_rank_player : Int64;
		public var rank_type : int;
		public var rank_timedimension:int;
	}
}
