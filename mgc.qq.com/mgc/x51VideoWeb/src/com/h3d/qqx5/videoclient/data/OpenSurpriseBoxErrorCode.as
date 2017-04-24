package com.h3d.qqx5.videoclient.data
{
	public class OpenSurpriseBoxErrorCode
	{
		public static var OSBEC_Succ:int = 0;             //成功
		public static var OSBEC_System:int = 1;           //系统错误
		public static var OSBEC_Unknown:int = 2;          //位置错误    
		public static var OSBEC_NoActiveBox:int = 3;      //宝箱未激活
		public static var OSBEC_ServerBusy:int = 4;       //服务器繁忙
		public static var OSBEC_NoReward:int = 5;         //系统错误：没有配置奖励
		public static var OSBEC_Timeout:int = 6;          //Game服务器超时
		public static var OSBEC_NotInVideoRoom:int = 7;   //不在视频房间内
		public static var OSBEC_NotLiving:int = 8;        //视频不在直播中
		public static var OSBEC_NoActivity:int = 9;       //不在活动中或者活动已结束
		public static var OSBEC_NoRoomServer:int = 10;     //系统错误，GameServer找不到RoomServer
		public static var OSBEC_AnchorCantOpen:int = 11;   //主播端不能开宝箱
	}
}