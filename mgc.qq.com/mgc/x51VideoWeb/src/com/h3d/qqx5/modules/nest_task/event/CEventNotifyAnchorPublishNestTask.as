package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventNotifyAnchorPublishNestTask extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventNotifyAnchorPublishNestTask;
	  }
	  public function CEventNotifyAnchorPublishNestTask()
	  {
	    registerField("is_published", "", Descriptor.TypeBoolean, 1);
	  }
	  public var is_published : Boolean;
	}
}
