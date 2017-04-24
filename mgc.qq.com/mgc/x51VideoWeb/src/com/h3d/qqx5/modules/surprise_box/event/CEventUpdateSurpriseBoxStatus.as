package com.h3d.qqx5.modules.surprise_box.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.share.SurpriseBoxStatus;
	
	import flash.utils.getQualifiedClassName;

	public class CEventUpdateSurpriseBoxStatus extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoSurpriseBoxEventID.CLSID_CEventUpdateSurpriseBoxStatus;
		}
		
		public function CEventUpdateSurpriseBoxStatus()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerField("box_status", getQualifiedClassName(SurpriseBoxStatus), Descriptor.Compound, 2);
		}
		
		public var activity_id : int;
		public var box_status :SurpriseBoxStatus = new SurpriseBoxStatus;
	}
}
