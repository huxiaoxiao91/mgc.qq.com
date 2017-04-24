package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class TalentShowJudgeInfo extends ProtoBufSerializable
	{
		public function TalentShowJudgeInfo()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
			registerField("judge_type", "", Descriptor.Int32, 2);
			registerField("player_id", "", Descriptor.Int64, 3);
			registerField("zone_id", "", Descriptor.Int32, 4);
			registerField("free_whistle_used", "", Descriptor.Int32, 5);
			registerField("player_name_str", "", Descriptor.TypeString, 6);
			registerField("zone_name_str", "", Descriptor.TypeString, 7);
			registerField("last_operation", "", Descriptor.Int32, 8);
		}
		
		public var activity_id : int;
		public var judge_type : int;
		public var player_id : Int64;
		public var zone_id : int;
		public var free_whistle_used : int;
		public var player_name_str : String;
		public var zone_name_str : String;
		public var last_operation : int;
	}
}
