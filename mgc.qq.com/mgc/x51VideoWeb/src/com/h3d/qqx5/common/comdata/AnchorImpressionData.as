package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class AnchorImpressionData extends ProtoBufSerializable
	{
		
		public function AnchorImpressionData()
		{
			registerField("count", "", Descriptor.Int32, 1);
			registerField("impression_id", "", Descriptor.Int32, 2);
		}
		
		public var count : int;
		public var impression_id : int;
	}
}
