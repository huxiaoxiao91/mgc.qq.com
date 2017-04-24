package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftAnchorRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftPlayerContributionContainer;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftPlayerRank;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventLoadStarGiftChampionRankRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadStarGiftChampionRankRes;
		}
		
		public function CEventLoadStarGiftChampionRankRes()
		{
			registerFieldForList("m_anchor_rank", getQualifiedClassName(VideoStarGiftAnchorRank), Descriptor.Compound, 1);
			registerFieldForList("m_player_rank", getQualifiedClassName(VideoStarGiftPlayerRank), Descriptor.Compound, 2);
			registerField("none_config","", Descriptor.TypeBoolean, 5);
			registerFieldForList("m_player_contribution",getQualifiedClassName(VideoStarGiftPlayerContributionContainer), Descriptor.Compound ,6);//贡献王数据
		}
		
		public var m_anchor_rank : Array = [];
		public var m_player_rank : Array = [];
		public var none_config : Boolean;
		public var m_player_contribution : Array = [];
	}
}