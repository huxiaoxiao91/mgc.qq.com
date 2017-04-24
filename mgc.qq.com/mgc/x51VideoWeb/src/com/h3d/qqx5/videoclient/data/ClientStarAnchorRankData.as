package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	//星主播排行榜
	public class ClientStarAnchorRankData
	{
//		public var m_anchor_id:Int64; //主播qq
		public var m_anchor_id:String = ""; //主播qq
		public var m_talent_show_starlight:int = 0;//（全民选秀）活动星耀
		public var m_talent_show_scores:int = 0; //全民选秀评委给打的分
		public var m_talent_show_vote:int = 0; //全民选秀获得的选票数量
//		public var m_score:Int64;			//根据m_talent_show_starlight、m_talent_show_scores和m_talent_show_vote计算的分数
		public var m_score:String = "";			//根据m_talent_show_starlight、m_talent_show_scores和m_talent_show_vote计算的分数
		public var m_anchor_nick:String = "";
	}
}