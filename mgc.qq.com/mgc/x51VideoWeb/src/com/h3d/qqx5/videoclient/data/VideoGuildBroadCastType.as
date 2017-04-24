package com.h3d.qqx5.videoclient.data
{
	public class VideoGuildBroadCastType
	{
		public static const VGBT_Invalid:int                   = 0;
		public static const VGBT_Join :int                     = 1; // 新的团员被批准加入
		public static const VGBT_Quit:int                      = 2; // 有团员被踢出或者主动退出后援团
		public static const VGBT_VipMemberDailyFirstLogin:int  = 3; // 有VIP身份的团员当日第一次上线
		public static const VGBT_VipMemberBringActiveScore:int = 4; // VIP玩家登录给予活跃积分
		public static const VGBT_ChiefDemise:int               = 5; // 团长将团长的职位传给了其他团员
		public static const VGBT_ChangeAnchor:int              = 6; // 更改支持的主播
		public static const VGBT_AnchorStartBroadcast:int      = 7; // 本团支持的主播开始直播
		public static const VGBT_AnchorDistributeScore:int     = 8; // 主播为本团分配积分
		public static const VGBT_AnchorCancelContract:int      = 9; // 主播与所有房间解约
		public static const VGBT_SignInBringAsset:int          = 10; // 可获得团资产的签到操作
		public static const VGBT_ApplyDisband:int              = 11; // 团长发起了解散团的操作或者团处于解散中，每天团员&团长每天登录游戏时收到此消息
		public static const VGBT_CancelDisband:int             = 12; // 团长取消了对团的解散
		public static const VGBT_ApplyDemise:int               = 13; // 团长发起了传位操作或者团处于传位中，每天团员&团长第一次登录梦工厂时收到此消息
		public static const VGBT_CancelDemise:int              = 14; // 团长取消对传位操作
	}
}