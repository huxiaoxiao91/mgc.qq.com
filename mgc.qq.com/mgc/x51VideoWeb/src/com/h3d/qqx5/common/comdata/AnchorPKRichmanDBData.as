package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class AnchorPKRichmanDBData extends ProtoBufSerializable
	{
		
		public function AnchorPKRichmanDBData()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("activity_id", "", Descriptor.Int32, 2);
			registerField("contribution", "", Descriptor.Int64, 3);
		}
		
		public var player_id : Int64;
		public var activity_id : int;
		public var contribution : Int64;
	}
}
