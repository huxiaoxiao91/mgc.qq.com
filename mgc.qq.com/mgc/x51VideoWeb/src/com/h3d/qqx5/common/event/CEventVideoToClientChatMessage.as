package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoToClientChatMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	
	public class CEventVideoToClientChatMessage extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoToClientChatMessage;
		}
		
		public function CEventVideoToClientChatMessage()
		{
			registerField("message", getQualifiedClassName(VideoToClientChatMessage), Descriptor.Compound, 1);
			registerField("anchor_id","", Descriptor.Int32,  2);
			registerField("starlight", "", Descriptor.Int32, 3);
			registerField("popularity","", Descriptor.Int32,  4);
			registerField("add_anchor_exp", "", Descriptor.Int32, 5);
		}

		public var message :VideoToClientChatMessage = new VideoToClientChatMessage;
		public var anchor_id:int;
		public var starlight:int;
		public var popularity:int;
		public var add_anchor_exp:int;//主播增加的经验
	}
}
