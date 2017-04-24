package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class AnchorPKInfo extends ProtoBufSerializable
	{
		
		public function AnchorPKInfo()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerField("anchor_qq", "", Descriptor.Int64, 2);
			registerField("guild_id", "", Descriptor.Int64, 3);
			registerField("contribution", "", Descriptor.Int64, 4);
			registerField("guild_name", "", Descriptor.TypeString, 5);
		}
		
		public var activity_id : int;
		public var anchor_qq : Int64;
		public var guild_id : Int64;
		public var contribution : Int64;
		public var guild_name : String = "";
	}
}
