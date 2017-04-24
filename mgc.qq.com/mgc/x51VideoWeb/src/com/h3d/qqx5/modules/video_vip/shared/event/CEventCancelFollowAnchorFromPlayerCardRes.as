package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventCancelFollowAnchorFromPlayerCardRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventCancelFollowAnchorFromPlayerCardRes;
		}
		
		public function CEventCancelFollowAnchorFromPlayerCardRes()
		{
		}
		
	}
}
