package com.h3d.qqx5.modules.video_activity.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventTakeDailyWageRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventTakeDailyWageRes;
		}
		public function CEventTakeDailyWageRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("wage", "", Descriptor.Int32, 2);
			registerField("attached_wage", "", Descriptor.Int32, 3);
		}
		public var res : int;
		public var wage : int;
		public var attached_wage : int;
	}
}
