package com.h3d.qqx5.modules.dream_box.event
{
	import com.h3d.qqx5.framework.callcenter.event.CallCenterMessageID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxClientInfo;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventPublishDreamBox extends INetMessage
	{
		public override function CLSID() : int
		{
			return DreamBoxEventID.CLSID_CEventPublishDreamBox;
		}
		public function CEventPublishDreamBox()
		{
			registerField("box", getQualifiedClassName(DreamBoxClientInfo), Descriptor.Compound, 1);
			registerField("box_count", "", Descriptor.Int32, 2);
		}
		public var box : DreamBoxClientInfo = new DreamBoxClientInfo;
		public var box_count : int;
	}
}
