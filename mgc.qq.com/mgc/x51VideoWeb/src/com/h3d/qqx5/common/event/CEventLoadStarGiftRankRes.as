package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftAnchorRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftPlayerRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftRankContainer;
	
	import flash.utils.getQualifiedClassName;

	public class CEventLoadStarGiftRankRes extends INetMessage
	{
		
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadStarGiftRankRes;
		}
		
		public function CEventLoadStarGiftRankRes()
		{
			registerFieldForList("gift_rank", getQualifiedClassName(VideoStarGiftRankContainer), Descriptor.Compound, 1);
			registerFieldForList("next_star_gifts","", Descriptor.Int32, 2);
			registerField("next_session","", Descriptor.Int32, 3);
		}
		
		public var gift_rank : Array = [];
		public var next_star_gifts : Array = [];
		public var next_session:int;
	}
}