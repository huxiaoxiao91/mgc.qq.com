package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorPKRichmanRank;
	
	import flash.utils.getQualifiedClassName;

	public class CEventUpdateAnchorPKRichmanRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventUpdateAnchorPKRichmanRank;
		}
		
		public function CEventUpdateAnchorPKRichmanRank()
		{
			registerField("richman", getQualifiedClassName(VideoAnchorPKRichmanRank), Descriptor.Compound, 1);
		}
		
		public var richman :VideoAnchorPKRichmanRank = new VideoAnchorPKRichmanRank;
	}
}
