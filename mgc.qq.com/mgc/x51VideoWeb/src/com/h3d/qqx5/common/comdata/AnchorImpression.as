package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AnchorImpression extends ProtoBufSerializable
	{
		public function AnchorImpression()
		{
			registerField("impression_id", "", Descriptor.Int32, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
		}
		
		public var impression_id : int;
		public var anchor_id : Int64 = new Int64(0,0) ;
	}
}
