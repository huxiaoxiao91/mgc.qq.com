package com.h3d.qqx5.modules.anchor_pk.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AnchorPKGuildInfoForDB extends ProtoBufSerializable
	{
		
		public function AnchorPKGuildInfoForDB()
		{
			registerField("name", "", Descriptor.TypeString, 1);
			registerField("contribution", "", Descriptor.Int64, 2);
			registerField("videoguild_id", "", Descriptor.Int64, 3);
		}
		
		public var name : String = "";
		public var contribution : Int64;
		public var videoguild_id : Int64;
	}
}
