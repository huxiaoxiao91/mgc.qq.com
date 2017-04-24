package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class AnchorPlayerAffinityDBData extends ProtoBufSerializable
	{
		public function AnchorPlayerAffinityDBData()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("day_seq", "", Descriptor.Int32, 3);
			registerField("affinity_value", "", Descriptor.Int32, 4);
		}
		
		public var player_id : Int64;
		public var anchor_id : Int64;
		public var day_seq : int;
		public var affinity_value : int;
	}
}
