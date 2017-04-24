package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class AffinityLogicData extends ProtoBufSerializable
	{
		public function AffinityLogicData()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerFieldForList("affinity_value", "", Descriptor.Int32, 3);
			registerField("sum_affinity", "", Descriptor.Int32, 4);
			registerField("total_affinity", "", Descriptor.Int32, 5);
		}
		
		public var player_id : Int64;
		public var anchor_id : Int64;
		public var affinity_value : Array = new Array;
		public var sum_affinity : int;
		public var total_affinity : int;
	}
}
