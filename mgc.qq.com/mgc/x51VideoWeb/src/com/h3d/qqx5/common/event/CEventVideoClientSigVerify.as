package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoVersion;

	public class CEventVideoClientSigVerify extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoVersion.CLSID_CEventVideoClientSigVerify;
		}
		
		public function CEventVideoClientSigVerify()
		{
			registerField("appid", "", Descriptor.Int32, 1);
			registerField("key", "", Descriptor.TypeString, 2);
		}
		
		public var appid : int;
		public var key : String;
	}
}
