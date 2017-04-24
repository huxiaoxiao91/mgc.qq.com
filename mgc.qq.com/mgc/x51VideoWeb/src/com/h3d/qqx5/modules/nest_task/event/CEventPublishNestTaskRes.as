package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventPublishNestTaskRes extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventPublishNestTaskRes;
	  }
	  public function CEventPublishNestTaskRes()
	  {
	    registerField("result", "", Descriptor.Int32, 1);
	  }
	  public var result : int;
	}
}
