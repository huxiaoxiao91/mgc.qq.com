package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.modules.anchor_nest.share.RankNumberMap;
	import com.h3d.qqx5.modules.anchor_nest.share.VideoAnchorNestRankVec;

	public class CEventRefreshVideoAnchorNestRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventRefreshVideoAnchorNestRank;
		}
		
		public function CEventRefreshVideoAnchorNestRank()
		{
			registerFieldForDict("ranks", "",Descriptor.Int64,getQualifiedClassName(VideoAnchorNestRankVec),Descriptor.Compound, 1);
			registerField("req_rank_player", "", Descriptor.Int64, 2);
			registerFieldForDict("nums", "",Descriptor.Int64,getQualifiedClassName(RankNumberMap), Descriptor.Compound ,3);
		}
		
		public var ranks :Dictionary = new Dictionary();
		public var req_rank_player : Int64;
		public var nums :Dictionary = new Dictionary();
	}
}
