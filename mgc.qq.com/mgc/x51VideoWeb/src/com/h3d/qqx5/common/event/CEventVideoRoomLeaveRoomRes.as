package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventVideoRoomLeaveRoomRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomLeaveRoomRes;
		}
		
		public function CEventVideoRoomLeaveRoomRes()
		{
				registerField("status", "", Descriptor.Int32, 1);// 0 成功 1 失败
		}
		public var status:int;
	}
}