package com.h3d.qqx5.modules.nest_task.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventTakeNestTreasureBoxErrRes extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return AnchorNestTaskEventID.CLSID_CEventTakeNestTreasureBoxErrRes;
	  }
	  public function CEventTakeNestTreasureBoxErrRes()
	  {
	    registerField("result", "", Descriptor.Int32, 1);
	  }
	  public var result : int;
	}
}
