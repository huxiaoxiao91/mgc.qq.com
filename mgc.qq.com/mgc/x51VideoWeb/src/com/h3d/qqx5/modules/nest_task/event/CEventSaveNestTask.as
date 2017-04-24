package com.h3d.qqx5.modules.nest_task.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.nest_task.shared.NestTaskInfoDB;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventSaveNestTask extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventSaveNestTask;
	  }
	  public function CEventSaveNestTask()
	  {
		registerField("nest_id", "", Descriptor.Int32, 1);
	    registerFieldForList("task_list", getQualifiedClassName(NestTaskInfoDB), Descriptor.Compound, 2);
	  }
	  public var nest_id : int;
	  public var task_list : Array = new Array;
	}
}
