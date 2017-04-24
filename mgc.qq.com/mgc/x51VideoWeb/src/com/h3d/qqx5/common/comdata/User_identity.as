package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;
	
	public class User_identity extends ProtoBufSerializable
	{
		public function User_identity()
		{
			registerField("account", "", Descriptor.Int64, 1);
			registerField("channel", "", Descriptor.Int32, 2);
			registerField("zoneid", "", Descriptor.Int32, 3);
		}
		
		public var account:Int64 = new Int64();
		public var channel:int;
		public var zoneid:int;
	}
}