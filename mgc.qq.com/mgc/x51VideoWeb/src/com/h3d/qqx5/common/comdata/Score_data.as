package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	public class Score_data extends ProtoBufSerializable
	{
		public function Score_data() 
		{
			registerField("day_score", "", Descriptor.Int32, 1);
			registerField("week_score", "", Descriptor.Int32, 2);
			registerField("day_score_modify_time", "", Descriptor.Int32, 3);
			registerField("week_score_modify_time", "", Descriptor.Int32, 4);
		}
		
		public var day_score:int = 0;
		public var week_score:int = 0;
		public var day_score_modify_time:int = 0;
		public var week_score_modify_time:int = 0;
	}
}