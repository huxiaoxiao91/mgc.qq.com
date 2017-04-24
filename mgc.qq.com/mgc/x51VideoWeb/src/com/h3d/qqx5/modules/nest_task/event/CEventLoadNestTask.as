package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventLoadNestTask extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventLoadNestTask;
	  }
	  public function CEventLoadNestTask()
	  {
	    registerField("nest_id", "", Descriptor.Int32, 1);
	    registerField("trans_id", "", Descriptor.Int64, 2);
	  }
	  public var nest_id : int;
	  public var trans_id : Int64;
	}
}
