package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	//顶条签到通知
	public class CEventGetSigninRewardNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventGetSigninRewardNotify;
		}
		public function CEventGetSigninRewardNotify()
		{
		}
	}
}
