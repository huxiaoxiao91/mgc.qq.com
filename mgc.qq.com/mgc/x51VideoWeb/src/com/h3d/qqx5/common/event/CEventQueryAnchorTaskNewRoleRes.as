package com.h3d.qqx5.common.event	
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventQueryAnchorTaskNewRoleRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorTaskEventID.CLSID_CEventQueryAnchorTaskNewRoleRes;
		}
		public function CEventQueryAnchorTaskNewRoleRes()
		{
			registerField("stat", "", Descriptor.Int32, 1);
			registerField("description", "", Descriptor.TypeString, 2);
			registerFieldForList("rewards", "", Descriptor.TypeString, 3);
		}
		public var stat : int;
		public var description : String = "";
		public var rewards : Array = new Array;
	}
}
