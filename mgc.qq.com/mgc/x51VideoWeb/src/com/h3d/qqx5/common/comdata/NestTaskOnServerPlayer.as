package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;

	public class NestTaskOnServerPlayer extends ProtoBufSerializable
	{
	  public function NestTaskOnServerPlayer()
	  {
		  registerFieldForDict("task_state", "",Descriptor.Int32,"", Descriptor.Int32, 1);
		  registerField("take_time", "", Descriptor.Int32, 2);
	    registerField("last_accept_treasure_box_time", "", Descriptor.Int32, 3);
	  }
	
	  public var last_accept_treasure_box_time : int;
	  public var task_state : Dictionary = new Dictionary;
	  public var take_time : int;
	}
}
