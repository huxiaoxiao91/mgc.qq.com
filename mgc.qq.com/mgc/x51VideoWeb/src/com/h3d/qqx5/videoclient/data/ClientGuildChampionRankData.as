package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;
	
	import flash.globalization.NumberParseResult;

	//舞团联盟争霸排行榜
	public class ClientGuildChampionRankData
	{
//		public var m_anchor_id:Int64;
		public var m_anchor_id:String = "";
		public var m_anchor_nick:String ="";
		public var m_zone_id:int = 0;//代表的大区id
		public var m_gc_starlight:int  = 0;//活动星耀，不是主播总星耀
		public var m_guild_vote:int = 0;//团票
//		public var m_zone_honor:Int64;//大区荣耀
		public var m_zone_honor:String = "";//大区荣耀
//		public var m_score:Int64;//根据上面3个算出来的分数
		public var m_score:String = "";//根据上面3个算出来的分数
		public var m_zone_name:String = "";//大区名
		public var m_guild_name:String = "";//所代表的舞团名
	}
}