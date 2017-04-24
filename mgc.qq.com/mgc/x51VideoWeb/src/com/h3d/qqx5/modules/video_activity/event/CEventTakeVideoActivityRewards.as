package com.h3d.qqx5.modules.video_activity.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventTakeVideoActivityRewards extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventTakeVideoActivityRewards;
		}
		public function CEventTakeVideoActivityRewards()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerField("activity_category", "", Descriptor.Int32, 2);
		}
		public var activity_id : int;
		public var activity_category : int;
	}
}
