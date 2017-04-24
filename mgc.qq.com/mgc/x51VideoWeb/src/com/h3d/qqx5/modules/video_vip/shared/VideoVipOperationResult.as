package com.h3d.qqx5.modules.video_vip.shared
{
	public class VideoVipOperationResult
	{	
		public static const VVOR_Success :int = 0;
		public static const VVOR_Failed :int = 1;
		public static const VVOR_Timeout :int = 2;          //超时失败
		public static const VVOR_Interanl :int = 3;         //内部错误，各种数据找不到之类的
		public static const VVOR_NotInVideoRoom :int = 4;   //不在视频房间内
		public static const VVOR_NotEnoughMoney :int = 5;   //没有足够的炫贝
		public static const VVOR_DeductMoneyFailed :int = 6;//扣除炫贝失败
		public static const VVOR_ServerBusy :int = 7;       //服务器繁忙，发送消息失败
		public static const VVOR_DBNotLoadVipInfo :int = 8; //购买或者续费VIP时，db尚未加载出来玩家的VIP信息
		public static const VVOR_BuyTypeError :int = 9;     //购买类型错误，比如没有vip，却是续费
		public static const VVOR_SaveDBFailed :int = 10;    //保存DB失败
		public static const VVOR_DailyRewardAlreadyTaken :int = 11;	//每日福利已领取
		public static const VVOR_NotVIP	:int = 12;			//不是VIP
		public static const VVOR_NotAudience :int = 13;      //不是观众
		public static const VVOR_AlreadyForCompatible :int = 14;	//旧版本（显示领取每日福利）连新服务器时，本周已领取过，第二天尝试再领
		public static const VVOR_NotEnoughVideoMoney:int = 15; //没有足够的梦幻币
		public static const VVOR_VideoPlayerCardSignatureLength:int = 16; // 玩家个性签名长度超过限制
		public static const VVOR_DeviceTypeError:int = 17;	//设备错误，支付方式和设备不匹配
	}
}