package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventVideoQueryBalanceRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoQueryBalanceRes;
		}
		public function CEventVideoQueryBalanceRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("msg", "", Descriptor.TypeString, 2);
			registerField("total", "", Descriptor.Int32, 3);
			registerField("present", "", Descriptor.Int32, 4);
			registerField("firstsave", "", Descriptor.TypeBoolean, 5);
		}
		public var res : int;
		public var msg:String ="";
		public var total : int;
		public var present : int;
		public var firstsave : Boolean;
	}
}
