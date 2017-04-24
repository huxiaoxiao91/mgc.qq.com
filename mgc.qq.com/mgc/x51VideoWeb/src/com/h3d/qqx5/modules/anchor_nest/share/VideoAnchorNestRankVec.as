package com.h3d.qqx5.modules.anchor_nest.share
{
	
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorNestRank;
	
	import flash.utils.getQualifiedClassName;

	public class VideoAnchorNestRankVec extends INetMessage
	{
		public function VideoAnchorNestRankVec()
		{
			registerFieldForList("nestrank",getQualifiedClassName(VideoAnchorNestRank),Descriptor.Compound,1);
		}
		override public function isPureContainerWrapper():Boolean	
		{
			return true;
		}
		public var nestrank :Array = new Array;
	}
}