package com.h3d.qqx5.common.event
{
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventVideoRoomCheckNick extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomCheckNick;
		}
		public function CEventVideoRoomCheckNick()
		{
			registerField("nick", "", Descriptor.TypeString, 1);
		}
		public var nick : String= "";
	}
}
