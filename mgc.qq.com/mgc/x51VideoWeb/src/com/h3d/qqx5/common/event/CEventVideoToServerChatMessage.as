package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoToServerChatMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoToServerChatMessage extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoToServerChatMessage;
		}
		
		public function CEventVideoToServerChatMessage()
		{
			registerField("message", getQualifiedClassName(VideoToServerChatMessage), Descriptor.Compound, 1);
		}
		
		//设置信息
		public function SetMessage( msg : VideoToServerChatMessage):void
		{
			message = msg;
		}
		public var message :VideoToServerChatMessage = new VideoToServerChatMessage;
	}
}
