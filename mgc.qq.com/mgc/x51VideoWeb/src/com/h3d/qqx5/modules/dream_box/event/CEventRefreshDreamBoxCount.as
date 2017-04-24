package com.h3d.qqx5.modules.dream_box.event
{
	import com.h3d.qqx5.framework.callcenter.event.CallCenterMessageID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventRefreshDreamBoxCount extends INetMessage
	{
		public override function CLSID() : int
		{
			return DreamBoxEventID.CLSID_CEventRefreshDreamBoxCount;
		}
		public function CEventRefreshDreamBoxCount()
		{
			registerField("box_count", "", Descriptor.Int32, 1);
		}
		public var box_count : int;
	}
}
