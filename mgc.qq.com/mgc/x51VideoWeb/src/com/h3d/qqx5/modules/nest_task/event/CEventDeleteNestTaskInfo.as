package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventDeleteNestTaskInfo extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventDeleteNestTaskInfo;
	  }
	  public function CEventDeleteNestTaskInfo()
	  {
		registerField("trans_id", "", Descriptor.Int64, 1);
	    registerField("nest_id", "", Descriptor.Int32, 2);
	  }
	  public var trans_id : int;
	  public var nest_id : int;
	}
}
