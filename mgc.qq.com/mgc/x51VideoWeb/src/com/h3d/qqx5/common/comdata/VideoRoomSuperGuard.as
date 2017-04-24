package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoRoomSuperGuard extends ProtoBufSerializable
	{
		
		public function VideoRoomSuperGuard()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("guard_level", "", Descriptor.Int32, 3);
			registerField("player_name", "", Descriptor.TypeString, 4);
			registerField("total_affinity", "", Descriptor.Int32, 5);
			registerField("wealth", "", Descriptor.Int64, 6);
			registerField("player_sex", "", Descriptor.Int32, 7);
			registerField("vip_level", "", Descriptor.Int32, 8);
			registerField("player_zone", "", Descriptor.TypeString, 9);
			registerField("pk_richman_order", "", Descriptor.Int32, 10);
			registerField("is_new_super_guard", "", Descriptor.Int32, 11);
		}
		
		public var anchor_id : Int64;
		public var player_id : Int64;
		public var guard_level : int;
		public var player_name : String = "";
		public var total_affinity : int;
		public var wealth : Int64;
		public var player_sex : int;
		public var vip_level : int;
		public var player_zone : String = "";
		public var pk_richman_order : int;
		public var is_new_super_guard : int;
	}
}
