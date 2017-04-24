package com.h3d.qqx5.modules.anchor_pk.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class PlayerAvatarInfo extends ProtoBufSerializable
	{
		public function PlayerAvatarInfo()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("avatar", "", Descriptor.TypeNetBuffer, 2);
			registerField("contribution", "", Descriptor.Int64, 3);
			registerField("vip_level", "", Descriptor.Int32, 4);
			registerField("guild_name", "", Descriptor.TypeString, 5);
			registerField("name", "", Descriptor.TypeString, 6);
			registerField("sex", "", Descriptor.Int32, 7);
			registerField("anchor_qq", "", Descriptor.Int64, 8);
		}
		
		public var player_id : Int64;
		public var avatar :NetBuffer;
		public var contribution : Int64;
		public var vip_level : int;
		public var guild_name : String;
		public var name : String;
		public var sex : int;
		public var anchor_qq : Int64;
	}
}
