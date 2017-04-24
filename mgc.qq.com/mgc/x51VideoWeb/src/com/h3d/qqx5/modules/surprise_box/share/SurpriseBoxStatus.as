package com.h3d.qqx5.modules.surprise_box.share
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class SurpriseBoxStatus extends ProtoBufSerializable
	{
		public function SurpriseBoxStatus()
		{
			registerField("active", "", Descriptor.TypeBoolean, 1);
			registerField("precent", "", Descriptor.Int32, 2);
			registerField("cd_seconds", "", Descriptor.Int32, 3);
			registerField("need_flower", "", Descriptor.Int32, 4);
			registerField("left_open_times", "", Descriptor.Int32, 5);
			registerField("total_cd_seconds", "", Descriptor.Int32, 6);
			registerField("nest_left_open_times", "", Descriptor.Int32, 7);
		}
		
		public var active : Boolean;
		public var precent : int;
		public var cd_seconds : int;
		public var need_flower : int;
		public var left_open_times : int;
		public var total_cd_seconds : int;
		public var nest_left_open_times : int;
	}
}
