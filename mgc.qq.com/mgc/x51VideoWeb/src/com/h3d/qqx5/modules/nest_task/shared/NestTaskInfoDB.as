package com.h3d.qqx5.modules.nest_task.shared
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	public class NestTaskInfoDB extends ProtoBufSerializable
	{
	  public function NestTaskInfoDB()
	  {
	    registerField("nest_id", "", Descriptor.Int32, 1);
	    registerField("task_id", "", Descriptor.Int32, 2);
	    registerField("condition_id", "", Descriptor.Int32, 3);
	    registerField("need_finish_times", "", Descriptor.Int32, 4);
	    registerField("first_player_name", "", Descriptor.TypeString, 5);
	    registerField("first_player_zone_id", "", Descriptor.Int32, 6);
	  }
	  public var nest_id : int;
	  public var task_id : int;
	  public var condition_id : int;
	  public var need_finish_times : int;
	  public var first_player_name : String ="";
	  public var first_player_zone_id : int;
	}
}
