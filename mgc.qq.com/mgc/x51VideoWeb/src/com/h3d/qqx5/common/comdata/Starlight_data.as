package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;

	public class Starlight_data  extends ProtoBufSerializable
	{
		public function Starlight_data()
		{
			registerField("day_starlight", "", Descriptor.Int32, 1);
			registerField("week_starlight", "", Descriptor.Int32, 2);
			registerField("month_starlight", "", Descriptor.Int32, 3);
			registerField("day_starlight_modify_time", "", Descriptor.Int32, 4);
			registerField("week_starlight_modify_time", "", Descriptor.Int32, 5);
			registerField("month_starlight_modify_time", "", Descriptor.Int32, 6);
		}
		
		public var day_starlight:int;
		public var week_starlight:int;
		public var month_starlight:int;
		public var day_starlight_modify_time:int;
		public var week_starlight_modify_time:int;
		public var month_starlight_modify_time:int;
	}
}