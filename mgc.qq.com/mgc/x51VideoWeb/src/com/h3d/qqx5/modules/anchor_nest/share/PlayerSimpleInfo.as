package com.h3d.qqx5.modules.anchor_nest.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class PlayerSimpleInfo extends ProtoBufSerializable
	{
		public function PlayerSimpleInfo()
		{
			registerField("name", "", Descriptor.TypeString, 1);
			registerField("zone_id", "", Descriptor.Int32, 2);
			registerField("zone_name", "", Descriptor.TypeString, 3);
		}
		public var name : String = "";
		public var zone_id : int;
		public var zone_name : String = "";
	}
}
