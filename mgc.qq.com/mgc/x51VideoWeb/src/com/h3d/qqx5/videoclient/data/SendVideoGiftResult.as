package com.h3d.qqx5.videoclient.data
{
	public class SendVideoGiftResult
	{
		public static var SVGR_Succ :int = 0;
		public static var SVGR_Invalid:int = 1;
		public static var SVGR_Fail:int = 2;
		public static var SVGR_Internal:int = 3;              //内部错误，比如player指针为空等
		public static var SVGR_Gift_Not_Exist:int = 4;        //礼物不存在
		public static var SVGR_Not_Enough_Coins:int = 5;      //代币数量不足
		public static var SVGR_Not_Enough_Flowers:int = 6;    //献花数量不足
		public static var SVGR_Not_In_Live_Show:int = 7;      //不在直播中
		public static var SVGR_Room_Not_Exist:int = 8;		//房间不存在
		public static var SVGR_Room_Not_Find_Sender:int = 9;	//房间中没找到送礼人
		public static var SVGR_Room_Not_Find_Anchor:int = 10;	//房间中没找到主播
		public static var SVGR_Room_Not_Find_GiftData:int = 11;	//房间中没找到礼物数据配置
		public static var SVGR_Guard_Level_Error:int = 12;		//守护等级不够
		public static var SVGR_NotEnough_Score:int = 13;		//积分不够
		public static var SVGR_NoVideoGuild:int = 14;			//找不到后援团
		public static var SVGR_NoVideoGuildMember:int = 15;	//找不到后援团成员
		public static var SVGR_TargetAnchorError:int = 16;		//错误的主播对象
		public static var SVGR_Not_In_AnchorNest:int = 17;		//不在主播小窝中，不能送超级捧场卡
	}
}