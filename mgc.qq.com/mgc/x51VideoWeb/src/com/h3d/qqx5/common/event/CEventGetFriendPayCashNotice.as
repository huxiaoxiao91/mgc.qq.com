package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.FriendPayInfo;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetFriendPayCashNotice extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventGetFriendPayCashNotice;
		}
		public function CEventGetFriendPayCashNotice()
		{
		}
	}
}