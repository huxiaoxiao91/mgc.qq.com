package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.FriendPayInfo;
	
	import flash.utils.getQualifiedClassName;
	
	/**
	 * 好友充值消息推送。
	 * @author Administrator
	 * 
	 */	
	public class CEventNotifyFriendPayCash extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventNotifyFriendPayCash;
		}
		
		public function CEventNotifyFriendPayCash()
		{
			registerFieldForList("info", getQualifiedClassName(FriendPayInfo), Descriptor.Compound, 1);
		}
		
		public var info:Array;
	}
}