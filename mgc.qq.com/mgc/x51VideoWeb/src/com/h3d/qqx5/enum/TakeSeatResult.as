package com.h3d.qqx5.enum
{
	public class TakeSeatResult
	{
		public static const 	TSR_Success:int = 0; // 成功
		public static const 	TSR_Internal:int = 1; // 内部错误 
		public static const 	TSR_Initing:int = 2; // 系统正在初始化
		public static const 	TSR_Taking:int = 3; // 正在被抢
		public static const 	TSR_NotEnoughCoins:int = 4; // 余额不足
		public static const 	TSR_NoVipFreeCount:int = 5; // vip免费次数用尽
		public static const 	TSR_SeatProtect:int = 6;  // 皇帝/亲王 座位保护中
		public static const 	TSR_VipLevelLow:int = 7;     // 免费抢等级比座位上的人低
		public static const 	TSR_FreeTakeCoinSeat:int = 8;	 // 不能用贵族免费次数抢花钱的座位
		public static const 	TGR_IsSelfNotTake:int = 9;		 //自己的座位不能抢
	}
}