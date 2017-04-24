package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventNotifyConcertVideoGiftUsableIDs extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventNotifyConcertVideoGiftUsableIDs;
		}
		public function CEventNotifyConcertVideoGiftUsableIDs()
		{
			registerFieldForList("gift_ids", "", Descriptor.Int32, 1);// 可用礼物ID列表
		}
		public var gift_ids : Array = new Array;
	}
}
