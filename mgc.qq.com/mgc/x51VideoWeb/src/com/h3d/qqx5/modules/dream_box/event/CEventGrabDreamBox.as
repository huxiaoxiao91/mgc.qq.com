package com.h3d.qqx5.modules.dream_box.event
{
	import com.h3d.qqx5.framework.callcenter.event.CallCenterMessageID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGrabDreamBox extends INetMessage
	{
		public override function CLSID() : int
		{
			return DreamBoxEventID.CLSID_CEventGrabDreamBox;
		}
		public function CEventGrabDreamBox()
		{
			registerField("box_id", "", Descriptor.Int64, 1);
		}
		public var box_id : Int64 = new Int64(0,0);
	}
}
