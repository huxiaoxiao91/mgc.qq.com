package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventQueryAnchorTaskNewRole extends INetMessage
	{
		public override function CLSID() : int
		{
		    return AnchorTaskEventID.CLSID_CEventQueryAnchorTaskNewRole;
		}
		public function CEventQueryAnchorTaskNewRole()
		{
			
		}
	}
}
