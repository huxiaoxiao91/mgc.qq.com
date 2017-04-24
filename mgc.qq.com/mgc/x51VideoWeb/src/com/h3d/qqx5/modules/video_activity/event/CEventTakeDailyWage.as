package com.h3d.qqx5.modules.video_activity.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	public class CEventTakeDailyWage extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventTakeDailyWage;
		}
		public function CEventTakeDailyWage()
		{
		}
	}
}
