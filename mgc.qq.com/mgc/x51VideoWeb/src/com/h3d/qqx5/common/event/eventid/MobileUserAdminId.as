package com.h3d.qqx5.common.event.eventid
{
	public class MobileUserAdminId
	{
		public static const CLSID_CEventNotifyUserAdminSystemInfo : int 	= 62124;	//任命/解除移动管理员的系统广播消息
		public static const CLSID_CEventNotifyAllUserAdmin : int 			= 62125; //通知所有移动管理员的pstid信息:在主播和玩家进房时，或者任命/解除移动管理员时，服务器推送CEventNotifyAllUserAdmin，通知当前房间中所有移动管理员的pstid信息	
	}
}