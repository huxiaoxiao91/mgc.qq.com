package com.h3d.qqx5.modules.nest_task.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.nest_task.shared.NestTaskInfo;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventTakeNestTaskRes extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventTakeNestTaskRes;
	  }
	  public function CEventTakeNestTaskRes()
	  {
	    registerField("result", "", Descriptor.Int32, 1);
	    registerFieldForList("task_info_list", getQualifiedClassName(NestTaskInfo), Descriptor.Compound, 2);
	  }
	  public var result : int;
	  public var task_info_list : Array = new Array;
	}
}
