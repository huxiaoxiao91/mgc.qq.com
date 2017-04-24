package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventVideoRoomCheckNickRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomCheckNickRes;
		}
		public function CEventVideoRoomCheckNickRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("recommend_nick", "", Descriptor.TypeString, 2);
		}
		public var res : int;
		public var recommend_nick : String= "";
	}
}
