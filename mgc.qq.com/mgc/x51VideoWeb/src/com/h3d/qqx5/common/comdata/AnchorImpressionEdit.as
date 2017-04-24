package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class AnchorImpressionEdit extends ProtoBufSerializable
	{
		public function AnchorImpressionEdit()
		{
			registerField("impression_id", "", Descriptor.Int32, 1);
			registerField("op_type", "", Descriptor.Int32, 2);
		}
		
		public var impression_id : int;
		public var op_type : int;
	}
}
