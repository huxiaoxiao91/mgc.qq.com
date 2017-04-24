package com.h3d.qqx5.modules.anchor_task.shared.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class CEventPublishAnchorTaskRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorTaskEventID.CLSID_CEventPublishAnchorTaskRes;
		}
		
		public function CEventPublishAnchorTaskRes()
		{
		}
		
	}
}
