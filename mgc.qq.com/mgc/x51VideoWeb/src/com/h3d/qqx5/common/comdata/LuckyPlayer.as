package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class LuckyPlayer extends ProtoBufSerializable
	{
		public function LuckyPlayer()
		{
			registerField("nick", "", Descriptor.TypeString, 1);
			registerField("zone_name", "", Descriptor.TypeString, 2);
			registerField("reward_desc", "", Descriptor.TypeString, 3);
			registerField("gender", "", Descriptor.Int32, 4);
			registerField("vip_level", "", Descriptor.Int32, 5);
			registerField("get_time", "", Descriptor.Int32, 6);
			registerField("player_id", "", Descriptor.Int64, 7);
		}
		public var nick : String = "";
		public var zone_name : String = "";
		public var reward_desc : String = "";
		public var gender : int;
		public var vip_level : int;
		public var get_time : int;
		public var player_id : Int64;
	}
}
