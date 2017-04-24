package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class BottleneckInfo extends ProtoBufSerializable
	{
		public function BottleneckInfo()
		{
			registerField("giftid", "", Descriptor.Int32, 1);
			registerField("count", "", Descriptor.Int32, 2);
		}
		public var giftid:int;
		public var count:int;
	}
}