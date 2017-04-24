package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventNotifyNestIsFreezing extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventNotifyNestIsFreezing;
		}
		
		public function CEventNotifyNestIsFreezing()
		{
		}
		
	}
}
