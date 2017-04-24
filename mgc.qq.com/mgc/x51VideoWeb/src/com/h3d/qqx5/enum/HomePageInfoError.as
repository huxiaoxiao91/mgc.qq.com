package com.h3d.qqx5.enum
{
	public class HomePageInfoError
	{
		public static const PI_Success : int = 0;
		public static const PI_NoCardInfo : int = 1;
		public static const PI_NoFollowAnchor : int = 2;
		// 为了兼容加载关注主播信息的错误码
		public static const PI_VRFEN_FULL : int = 3;			//关注列表已满
		public static const PI_VRFEN_NO_ANCHOR : int= 4;	//没有该主播
		public static const PI_VRFEN_UNKNOWN  : int= 5;	//其它未知错误
		public static const PI_VRFEN_ALREADY : int = 6;		//已关注
		public static const PI_VRFEN_SERVER_BUSY : int=7; //服务器忙
		public static const PI_VRFEN_DB_ERROR : int=8;  //读写数据库出错
		public static const PI_VRFEN_NAME_TOO_LONG : int = 9;//主播名字太长
		public static const PI_VRFEN_NO_ACCOUNT : int = 10//没有此账号
	}
}