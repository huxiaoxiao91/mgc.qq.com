package com.h3d.qqx5.common.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadPreviewVideoTreasureBoxNewRole extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadPreviewVideoTreasureBoxNewRole;
		}
		public function CEventLoadPreviewVideoTreasureBoxNewRole()
		{
			registerField("box_id", "", Descriptor.Int32, 1);
			registerField("activity_id", "", Descriptor.Int32, 2);
			registerField("device_type", "", Descriptor.Int32, 3);
		}
		public var box_id : int;
		public var activity_id : int;
		public var device_type : int;
	}
}
