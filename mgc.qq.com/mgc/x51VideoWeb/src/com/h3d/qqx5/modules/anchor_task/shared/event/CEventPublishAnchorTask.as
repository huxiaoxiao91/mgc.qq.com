package com.h3d.qqx5.modules.anchor_task.shared.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventPublishAnchorTask extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorTaskEventID.CLSID_CEventPublishAnchorTask;
		}
		
		public function CEventPublishAnchorTask()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
		}
		
		public var room_id : int;
		public var anchor_id : Int64;
	}
}
