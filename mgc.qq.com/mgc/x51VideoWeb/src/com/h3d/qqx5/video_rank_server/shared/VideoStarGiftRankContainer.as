package com.h3d.qqx5.video_rank_server.shared
{
		import com.h3d.qqx5.framework.network.Descriptor;
		import com.h3d.qqx5.framework.network.ProtoBufSerializable;
		
		import flash.utils.getQualifiedClassName;
		
		public class VideoStarGiftRankContainer extends ProtoBufSerializable
		{
			public function VideoStarGiftRankContainer()
			{
				registerField("gift_id","",Descriptor.Int32, 1);
				registerFieldForList("anchor_rank_vec", getQualifiedClassName(VideoStarGiftAnchorRank), Descriptor.Compound, 2);
				registerFieldForList("player_rank_vec", getQualifiedClassName(VideoStarGiftPlayerRank), Descriptor.Compound, 3);
				
			}
			public var gift_id : int;
			public var player_rank_vec : Array = [];
			public var anchor_rank_vec : Array = [];
				
		}
}