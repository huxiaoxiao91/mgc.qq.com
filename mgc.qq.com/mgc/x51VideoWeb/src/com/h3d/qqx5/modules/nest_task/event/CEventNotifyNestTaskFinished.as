package com.h3d.qqx5.modules.nest_task.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.nest_task.shared.NestTaskInfo;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyNestTaskFinished extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventNotifyNestTaskFinished;
	  }
	  public function CEventNotifyNestTaskFinished()
	  {
	    registerField("nest_task_info", getQualifiedClassName(NestTaskInfo), Descriptor.Compound, 1);
	  }
	  public var nest_task_info : NestTaskInfo = new NestTaskInfo;
	}
}
