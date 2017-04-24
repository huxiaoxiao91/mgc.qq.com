package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventPublishNestTask extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventPublishNestTask;
	  }
	  public function CEventPublishNestTask()
	  {
	    registerField("nest_id", "", Descriptor.Int32, 1);
	    registerField("owner_qq", "", Descriptor.Int64, 2);
	  }
	  public var nest_id : int;
	  public var owner_qq : Int64;
	}
}
