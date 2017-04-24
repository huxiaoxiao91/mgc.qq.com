package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventAnchorTaskRewardNotifyNewRole extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorTaskEventID.CLSID_CEventAnchorTaskRewardNotifyNewRole;
		}
		public function CEventAnchorTaskRewardNotifyNewRole()
		{
			registerField("task_type", "", Descriptor.Int32, 1);
			registerFieldForList("rewards", "",Descriptor.TypeString, 2);
		}
		public var task_type : int;
		public var rewards : Array = new Array;
	}
}
