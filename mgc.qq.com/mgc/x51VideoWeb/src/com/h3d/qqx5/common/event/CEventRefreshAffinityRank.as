package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.VideoAffinityRank;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventRefreshAffinityRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRefreshAffinityRank;
		}
		
		public function CEventRefreshAffinityRank()
		{
			registerFieldForList("rank", getQualifiedClassName(VideoAffinityRank), Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerField("rank_type", "", Descriptor.Int32, 3);
			registerField("rank_timedimension", "", Descriptor.Int32, 4);
			registerField("trans_id", "", Descriptor.Int64, 5);
		}
		
		public var rank:Array = new Array;
		public var req_rank_player:Int64 = new Int64();
		public var rank_type:int;
		public var rank_timedimension:int;//时间维度
		public var trans_id:Int64 = new Int64();
	}
}
