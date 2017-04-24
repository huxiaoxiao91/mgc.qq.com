package com.h3d.qqx5.modules.nest_task.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventClearNestTaskInfoTable extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventClearNestTaskInfoTable;
	  }
	  public function CEventClearNestTaskInfoTable()
	  {
	  }
	}
}
