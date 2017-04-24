package com.h3d.qqx5.modules.anchor_task.shared.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	public class CEventTakeAnchorTaskRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorTaskEventID.CLSID_CEventTakeAnchorTaskRes;
		}
		
		public function CEventTakeAnchorTaskRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
		}
		public var res:int;
	}
}
