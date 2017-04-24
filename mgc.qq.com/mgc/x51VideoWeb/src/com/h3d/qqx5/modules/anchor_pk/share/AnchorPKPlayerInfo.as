package com.h3d.qqx5.modules.anchor_pk.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AnchorPKPlayerInfo extends ProtoBufSerializable
	{
		public function AnchorPKPlayerInfo()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("contribution", "", Descriptor.Int64, 2);
			registerField("name", "", Descriptor.TypeString, 3);
			registerField("guild_name", "", Descriptor.TypeString, 4);
		}
		
		public var player_id : Int64;
		public var contribution : Int64;
		public var name : String ="";
		public var guild_name : String = "";
	}
}
