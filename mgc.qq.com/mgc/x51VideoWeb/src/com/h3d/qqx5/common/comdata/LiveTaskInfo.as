package com.h3d.qqx5.common.comdata
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class LiveTaskInfo extends ProtoBufSerializable
	{
		public function LiveTaskInfo()
		{
			registerField("task_id", "", Descriptor.Int32, 1);
			registerField("condition_id", "", Descriptor.Int32, 2);
			registerField("desc", "", Descriptor.TypeString, 3);
			registerField("current_progress", "", Descriptor.Int64, 4);
			registerField("finish_progress", "", Descriptor.Int64, 5);
			registerField("status", "", Descriptor.Int32, 6);
		}
		public var task_id : int;
		public var condition_id : int;
		public var desc : String;
		public var current_progress : Int64;
		public var finish_progress : Int64;
		public var status : int;
	}
}
