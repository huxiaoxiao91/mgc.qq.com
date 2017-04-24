package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoQueryVideoMoneyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoQueryVideoMoneyRes;
		}
		public function CEventVideoQueryVideoMoneyRes()
		{
			registerField("succ", "", Descriptor.Int32, 1);
			registerField("video_money", "", Descriptor.Int32, 2);
		}
		public var succ : int;
		public var video_money : int;
	}
}
