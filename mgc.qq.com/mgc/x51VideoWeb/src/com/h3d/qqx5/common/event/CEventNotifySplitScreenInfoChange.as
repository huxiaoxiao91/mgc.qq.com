package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.SplitScreenEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.SplitScreenInfo;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifySplitScreenInfoChange extends INetMessage
	{
		public override function CLSID():int
		{
			return SplitScreenEventID.CLSID_CEventNotifySplitScreenInfoChange;
		}
		
		public function CEventNotifySplitScreenInfoChange()
		{
			registerField("info", getQualifiedClassName(SplitScreenInfo), Descriptor.Compound, 1);
		}
		
		public var info:SplitScreenInfo = new SplitScreenInfo();
	}
}