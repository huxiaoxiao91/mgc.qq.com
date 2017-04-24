package com.h3d.qqx5.modules.video_activity.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyWebActivityGuide extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoActivityEventID.CLSID_CEventNotifyWebActivityGuide;
		}
		public function CEventNotifyWebActivityGuide()
		{
		}
	}
}
