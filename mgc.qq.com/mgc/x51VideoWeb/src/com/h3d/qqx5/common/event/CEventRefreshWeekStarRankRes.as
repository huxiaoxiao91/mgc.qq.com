package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.WeekStarMatchGroupConfigInfo;
	import com.h3d.qqx5.common.comdata.WeekStarMatchRankInfo;
	import com.h3d.qqx5.common.comdata.WeekStarPlayerContributeRank;
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshWeekStarRankRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return WeekStarEventID.CLSID_CEventRefreshWeekStarRankRes;
		}
		
		public function CEventRefreshWeekStarRankRes()
		{
			registerField("res", "", Descriptor.Int32, 1);//错误码
			registerFieldForList("rank", getQualifiedClassName(WeekStarMatchRankInfo), Descriptor.Compound, 2);//排行榜数据
			registerField("contribute_player", getQualifiedClassName(WeekStarPlayerContributeRank), Descriptor.Compound, 3);//贡献王数据
			registerFieldForList("groups", getQualifiedClassName(WeekStarMatchGroupConfigInfo), Descriptor.Compound, 4);//配置中的分组
			registerField("total_size", "", Descriptor.Int32, 5);//当前榜的总人数
			registerField("settle_time", "", Descriptor.Int32, 6);//结算时间
			registerField("group_id", "", Descriptor.Int32, 7);//分组id //0表示总榜
		}
		
		public var res: int;
		public var rank:Array;
		public var contribute_player: WeekStarPlayerContributeRank = new WeekStarPlayerContributeRank();
		public var groups:Array;
		public var total_size: int;
		public var settle_time:int;
		public var group_id:int;
	}
}