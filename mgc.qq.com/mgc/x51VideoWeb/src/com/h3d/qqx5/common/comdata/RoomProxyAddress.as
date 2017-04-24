package com.h3d.qqx5.common.comdata
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class RoomProxyAddress extends ProtoBufSerializable
	{
		public function RoomProxyAddress()
		{
			registerField("ip", "", Descriptor.TypeString, 1);
			registerField("port", "", Descriptor.Int32, 2);
		}
		public var ip : String = "";
		public var port : int;
	}
}
