package com.h3d.qqx5.common.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventVideoQueryBalance extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoQueryBalance;
		}
		public function CEventVideoQueryBalance()
		{
			registerField("open_id", "", Descriptor.TypeString, 1);
			registerField("open_key", "", Descriptor.TypeString, 2);
			registerField("pay_token", "", Descriptor.TypeString, 3);
			registerField("pf", "", Descriptor.TypeString, 4);
			registerField("pf_key", "", Descriptor.TypeString, 5);
			registerField("save_num", "", Descriptor.Int32, 6);
			registerField("device_type", "", Descriptor.Int32, 7);
		}
		public var open_id : String = "";
		public var open_key : String = "";
		public var pay_token : String = "";
		public var pf : String = "";
		public var pf_key : String = "";
		public var save_num : int;
		public var device_type : int;
	}
}
