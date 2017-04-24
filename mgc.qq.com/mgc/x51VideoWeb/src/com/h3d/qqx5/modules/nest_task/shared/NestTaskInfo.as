package com.h3d.qqx5.modules.nest_task.shared
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class NestTaskInfo extends ProtoBufSerializable
	{
		public function NestTaskInfo()
		{
			registerField("task_id", "", Descriptor.Int32, 1);
			registerField("description", "", Descriptor.TypeString, 2);
			registerField("need_finish_times", "", Descriptor.Int32, 3);
			registerField("is_self_finished", "", Descriptor.TypeBoolean, 4);
			registerField("first_finish_zone_name", "", Descriptor.TypeString, 5);
			registerField("first_finish_player", "", Descriptor.TypeString, 6);
		}
		
		public var task_id : int;
		public var description : String = "";
		public var need_finish_times : int;
		public var is_self_finished : Boolean;
		public var first_finish_zone_name : String = "";
		public var first_finish_player : String = "";
	}
}
