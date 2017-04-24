package com.h3d.qqx5.modules.video_vip.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventQueryFreeWhistleLeftRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoVipEventID.CLSID_CEventQueryFreeWhistleLeftRes;
		}
		
		public function CEventQueryFreeWhistleLeftRes()
		{
			registerField("left_count", "", Descriptor.Int32, 1);
		}
		
		public var left_count : int;
	}
}
