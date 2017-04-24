package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	public class AnchorPlayerAffinityStatstics extends ProtoBufSerializable
	{
		public function AnchorPlayerAffinityStatstics()
		{
			registerField("total","", Descriptor.Int32,  1);
			registerField("today","", Descriptor.Int32,  2);
			registerField("yesterday","", Descriptor.Int32,  3);
			registerField("this_week","", Descriptor.Int32,  4);
			registerField("last_week","", Descriptor.Int32,  5);
			registerField("this_month","", Descriptor.Int32,  6);
			registerField("last_month","", Descriptor.Int32,  7);
			registerFieldForList("recent", "", Descriptor.Int32, 8);
			registerField("update_time", "", Descriptor.Int32, 9);
			registerField("guard_level", "", Descriptor.Int32, 10);
			registerField("gain_guard_time", "", Descriptor.Int32, 11);
		}
		
		public var total:int = 0;    // 总亲密度
		public var today:int = 0;    // 当日亲密度
		public var yesterday:int = 0;    // 昨日亲密度
		public var this_week:int = 0;   // 本周亲密度
		public var last_week:int = 0;   // 上周亲密度
		public var this_month:int = 0;   // 本月亲密度
		public var last_month:int = 0;    // 上月亲密度
		public var recent:Array = new Array();   // 最近N天亲密度
		public var update_time:int = 0;   // 数据更新时间
		public var guard_level:int = 0;   // 守护等级
		public var gain_guard_time:int = 0;// 获得守护的时间
	}
}