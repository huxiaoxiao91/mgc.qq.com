package com.h3d.qqx5.modules.video_chat.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventSetVideoPublicChatCoolDownOnEnterRes extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return VideoChatEventID.CLSID_CEventSetVideoPublicChatCoolDownOnEnterRes;
	  }
	  public function CEventSetVideoPublicChatCoolDownOnEnterRes()
	  {
	    registerField("result", "", Descriptor.Int32, 1);
	    registerField("roomid", "", Descriptor.Int32, 2);
	    registerField("operator", "", Descriptor.Int64, 3);
	    registerField("cd_seconds", "", Descriptor.Int32, 4);
	  }
	  public var result : int;
	  public var roomid : int;
	  public var operator : Int64;
	  public var cd_seconds : int;
	}
}
