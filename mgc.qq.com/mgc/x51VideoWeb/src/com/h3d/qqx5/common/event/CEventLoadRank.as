package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.RankTitle;
	import com.h3d.qqx5.common.event.eventid.EVENT_ID_ZONE_RANK;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return EVENT_ID_ZONE_RANK.CLSID_CEventLoadRank;
		}
		public function CEventLoadRank()
		{
			registerField("title", getQualifiedClassName(RankTitle), Descriptor.Compound, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
			registerField("begin_index", "", Descriptor.Int32, 3);
			registerField("end_index", "", Descriptor.Int32, 4);
			registerField("rank_timedimension", "", Descriptor.Int32, 5);
			registerField("TopN_count", "", Descriptor.Int32, 6);
			registerField("time_req", "", Descriptor.Int32, 7);
			registerField("source", "", Descriptor.Int32, 8);//拉排行榜来源 : 1:其他来源    2:页签点击
		}
		public var title : RankTitle = new RankTitle;
		public var trans_id : Int64 = new Int64;
		public var begin_index : int;
		public var end_index : int;
		public var rank_timedimension:int;
		public var TopN_count:int;
		public var time_req:int;
		public var source:int;
	}
}
