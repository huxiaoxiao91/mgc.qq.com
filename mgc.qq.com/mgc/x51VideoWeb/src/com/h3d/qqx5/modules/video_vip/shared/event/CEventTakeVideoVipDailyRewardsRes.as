package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventTakeVideoVipDailyRewardsRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventTakeVideoVipDailyRewardsRes;
		}
		
		public function CEventTakeVideoVipDailyRewardsRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("video_vip_level", "", Descriptor.Int32, 2);
		}
		
		public var result : int;
		public var video_vip_level : int;
	}
}
