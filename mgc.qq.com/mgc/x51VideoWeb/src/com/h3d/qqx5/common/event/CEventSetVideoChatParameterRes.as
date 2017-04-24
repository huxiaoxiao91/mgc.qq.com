package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventSetVideoChatParameterRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventSetVideoChatParameterRes;
		}
		
		public function CEventSetVideoChatParameterRes()
		{
			registerField("res","", Descriptor.Int32, 1);
		}
		
		public var res : int;
	}
}
