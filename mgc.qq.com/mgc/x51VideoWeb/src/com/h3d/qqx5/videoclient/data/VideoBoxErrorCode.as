package com.h3d.qqx5.videoclient.data
{
	public class VideoBoxErrorCode
	{
		public static var OVBEC_Success:int = 0;    			// 成功
		public static var OVBEC_Fail:int = 1;           		// 失败
		public static var OVBEC_InternalError:int = 2;        // 内部错误
		public static var OVBEC_ConfigError:int = 3;          // 配置错误
		public static var OVBEC_BoxIDError:int = 4;			// 宝箱ID错误
		public static var OVBEC_HasBeenOpened:int = 5;		// 宝箱已经被打开过
		public static var OVBEC_HeightError:int = 6;			// 热度不够
		public static var OVBEC_ActivityError:int = 7;		// 开宝箱活动未开启
		public static var OVBEC_BoxFreezeState:int = 8;		// 热度宝箱冷却状态（玩家进入视频房间不超过5分钟）
		public static var OVBEC_BoxUnFreezeState:int = 9;		// 热度宝箱解除冷却状态（玩家进入视频房间超过5分钟）
	}
}