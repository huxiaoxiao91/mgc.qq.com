package com.h3d.qqx5.modules.video_chat.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventSetVideoPublicChatCoolDownOnEnter extends INetMessage
	{
	  public override function CLSID() : int
	  {
	    return VideoChatEventID.CLSID_CEventSetVideoPublicChatCoolDownOnEnter;
	  }
	  public function CEventSetVideoPublicChatCoolDownOnEnter()
	  {
	    registerField("cd_seconds", "", Descriptor.Int32, 1);
	    registerField("roomid", "", Descriptor.Int32, 2);
	    registerField("anchor", "", Descriptor.Int64, 3);
	  }
	  public var cd_seconds : int;
	  public var roomid : int;
	  public var anchor : Int64;
	}
}
