package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class SimpleAnchor extends ProtoBufSerializable
	{
		public function SimpleAnchor()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("anchor_name", "", Descriptor.TypeString, 2);
		}
		public var anchor_qq : Int64;
		public var anchor_name : String = "";
	}
}
