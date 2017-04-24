package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventQueryNestTaskRewardNewRole extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventQueryNestTaskRewardNewRole;
	  }
	  public function CEventQueryNestTaskRewardNewRole()
	  {
		  registerField("index", "", Descriptor.Int32, 1);
		  registerField("is_treasure_box", "", Descriptor.TypeBoolean, 2);
	  }
	  public var index:int;
	  public var is_treasure_box:Boolean;
	}
}
