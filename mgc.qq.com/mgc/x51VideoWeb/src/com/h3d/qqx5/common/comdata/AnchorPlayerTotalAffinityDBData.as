package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class AnchorPlayerTotalAffinityDBData extends ProtoBufSerializable
	{
		public function AnchorPlayerTotalAffinityDBData()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("data_version", "", Descriptor.Int32, 3);
			registerField("affinity_value", "", Descriptor.Int32, 4);
		}
		
		public var player_id : Int64;
		public var anchor_id : Int64;
		public var data_version : int;
		public var affinity_value : int;
	}
}
