package com.h3d.qqx5.common.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoVersion;
	
	public class CEventQueryVideoAccountInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoVersion.CLSID_CEventQueryVideoAccountInfo;
		}
		public function CEventQueryVideoAccountInfo()
		{
			registerField("time_stamp", "", Descriptor.UInt32, 1);
			registerField("device_type", "", Descriptor.Int32, 2);
			registerField("m_appid", "", Descriptor.UInt32, 3);
			registerField("m_skey", "", Descriptor.TypeString, 4);
		}
		public var time_stamp : uint;
		public var device_type : int;
		public var m_appid : uint;
		public var m_skey : String;
	}
}
