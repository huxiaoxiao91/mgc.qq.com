package com.h3d.qqx5.modules.video_activity.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyActivityCompletedCount extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventNotifyActivityCompletedCount;
		}
		public function CEventNotifyActivityCompletedCount()
		{
			registerField("completed_cnt","",Descriptor.Int32, 1);
			registerField("has_taken_wage_today", "",Descriptor.TypeBoolean, 2);
		}
		public var completed_cnt:int;
		public var has_taken_wage_today:Boolean;		
	}
}