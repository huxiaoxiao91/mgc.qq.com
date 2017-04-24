package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class TalentShowJudgeScore extends ProtoBufSerializable
	{
		public function TalentShowJudgeScore()
		{
			registerField("judge_id", "", Descriptor.Int64, 1);
			registerField("judge_name", "", Descriptor.TypeString, 2);
			registerField("judge_zone", "", Descriptor.TypeString, 3);
			registerField("talent_show_score", "", Descriptor.Int32, 4);
		}
		
		public var judge_id : Int64;
		public var judge_name : String = "";
		public var judge_zone : String = "";
		public var talent_show_score : int;
	}
}
