package com.h3d.qqx5.videoclient.data
{
	public class QuerySurpriseBoxErrorCode
	{
		public static var QSBEC_Succ:int = 0;        //查询成功
		public static var QSBEC_NoActivity:int = 1;   //没有开活动
		public static var QSBEC_ServerBusy:int = 2;   //服务器繁忙
		public static var QSBEC_Anchor:int = 3;       //主播端不能开宝箱
		public static var QSBEC_NoRoom:int = 4;       //找不到视频房间(可能是玩家不在视频房间中)
		public static var QSBEC_NoPlayer:int = 5;     //在视频服务器上找不到玩家，（可能玩家没有进入到该房间）
		public static var QSBEC_System:int = 6;       //系统错误
		public static var QSBEC_NoReward:int = 7;     //配置错误，没有配置奖励
		public static var QSBEC_ConfigError:int = 8;  //配置错误
	}
}