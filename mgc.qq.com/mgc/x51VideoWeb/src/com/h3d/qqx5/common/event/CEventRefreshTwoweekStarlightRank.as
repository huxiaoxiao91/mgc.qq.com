package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoTwoweekStarlightRank;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	import flash.utils.getQualifiedClassName;

	public class CEventRefreshTwoweekStarlightRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventRefreshTwoweekStarlightRank;
		}
		
		public function CEventRefreshTwoweekStarlightRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoTwoweekStarlightRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("rank_type", "", Descriptor.Int32, 3);
			registerField("freeze_rank", "", Descriptor.TypeBoolean, 4);
		}
		
		public var rank : Array = new Array;
		public var req_rank_player : Int64;
		public var rank_type : int;
		public var freeze_rank : Boolean;
	}
}
