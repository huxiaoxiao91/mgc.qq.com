package com.h3d.qqx5.modules.dream_box.event
{
import com.h3d.qqx5.framework.network.Descriptor;
import com.h3d.qqx5.framework.network.INetMessage;
import com.h3d.qqx5.modules.dream_box.event.DreamBoxEventID;
import com.h3d.qqx5.util.Int64;

import flash.utils.getQualifiedClassName;

public class CEventGrabDreamBoxRes extends INetMessage
{
  public override function CLSID() : int
  {
    return DreamBoxEventID.CLSID_CEventGrabDreamBoxRes;
  }
  public function CEventGrabDreamBoxRes()
  {
    registerField("box_id", "", Descriptor.Int64, 1);
    registerField("res", "", Descriptor.Int32, 2);
    registerField("money_type", "", Descriptor.Int32, 3);
    registerField("money_count", "", Descriptor.Int32, 4);
  }
  public var box_id : Int64 = new Int64(0,0);
  public var res : int;
  public var money_type : int;
  public var money_count : int;
}
}
