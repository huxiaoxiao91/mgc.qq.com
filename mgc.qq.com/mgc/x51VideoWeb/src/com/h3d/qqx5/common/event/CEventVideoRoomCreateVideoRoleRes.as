package com.h3d.qqx5.common.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventVideoRoomCreateVideoRoleRes extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return EEventIDVideoRoomExt.CLSID_CEventVideoRoomCreateVideoRoleRes;
	  }
	  public function CEventVideoRoomCreateVideoRoleRes()
	  {
	    registerField("res", "", Descriptor.Int32, 1);
	    registerField("recommend_nick", "", Descriptor.TypeString, 2);
	  }
	  public var res : int;
	  public var recommend_nick : String= "";
	}
}
