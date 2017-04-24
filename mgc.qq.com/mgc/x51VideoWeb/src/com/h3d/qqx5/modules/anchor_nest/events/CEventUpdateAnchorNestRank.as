package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorNestRank;
	
	import flash.utils.getQualifiedClassName;
	public class CEventUpdateAnchorNestRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventUpdateAnchorNestRank;
		}
		
		public function CEventUpdateAnchorNestRank()
		{
			registerField("rank", getQualifiedClassName(VideoAnchorNestRank), Descriptor.Compound, 1);
		}
		
		public var rank :VideoAnchorNestRank = new VideoAnchorNestRank;
	}
}
