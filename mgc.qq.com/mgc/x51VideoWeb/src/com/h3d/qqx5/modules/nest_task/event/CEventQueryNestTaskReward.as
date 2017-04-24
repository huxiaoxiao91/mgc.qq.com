package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventQueryNestTaskReward extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventQueryNestTaskReward;
	  }
	  public function CEventQueryNestTaskReward()
	  {
		  registerField("nest_id", "", Descriptor.Int32, 1);
	  }
	  public var nest_id:int;
	}
}
