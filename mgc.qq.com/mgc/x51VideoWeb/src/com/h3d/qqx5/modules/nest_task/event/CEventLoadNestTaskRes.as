package com.h3d.qqx5.modules.nest_task.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.nest_task.shared.NestTaskInfoDB;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventLoadNestTaskRes extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventLoadNestTaskRes;
	  }
	  public function CEventLoadNestTaskRes()
	  {
	    registerFieldForList("task_list", getQualifiedClassName(NestTaskInfoDB), Descriptor.Compound, 1);
	    registerField("result", "", Descriptor.Int32, 2);
	    registerField("trans_id", "", Descriptor.Int64, 3);
	  }
	  public var task_list : Array = new Array;
	  public var result : int;
	  public var trans_id :Int64;
	}
}
