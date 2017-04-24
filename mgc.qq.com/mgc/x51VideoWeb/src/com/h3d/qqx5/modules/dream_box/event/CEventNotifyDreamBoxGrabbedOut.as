package com.h3d.qqx5.modules.dream_box.event
{
	import com.h3d.qqx5.framework.callcenter.event.CallCenterMessageID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyDreamBoxGrabbedOut extends INetMessage
	{
		public override function CLSID() : int
		{
			return DreamBoxEventID.CLSID_CEventNotifyDreamBoxGrabbedOut;
		}
		public function CEventNotifyDreamBoxGrabbedOut()
		{
		}
	}
}
