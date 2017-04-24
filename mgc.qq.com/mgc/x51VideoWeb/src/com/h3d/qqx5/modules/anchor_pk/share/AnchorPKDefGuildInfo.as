package com.h3d.qqx5.modules.anchor_pk.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AnchorPKDefGuildInfo extends ProtoBufSerializable
	{
		
		public function AnchorPKDefGuildInfo()
		{
			registerField("guild_id", "", Descriptor.Int64, 1);
			registerField("contribution", "", Descriptor.Int64, 2);
			registerField("name", "", Descriptor.TypeString, 3);
		}
		
		public var guild_id : Int64;
		public var contribution : Int64;
		public var name : String ="";
	}
}
