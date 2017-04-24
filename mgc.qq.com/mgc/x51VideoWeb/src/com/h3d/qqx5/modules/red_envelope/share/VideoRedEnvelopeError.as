package com.h3d.qqx5.modules.red_envelope.share
{
	public class VideoRedEnvelopeError
	{
		public static const VREE_Success:int    = 0;
		public static const VREE_GrabFinish:int = 1;// 抢光了
		public static const VREE_Expired:int    = 2;// 红包失效了
		public static const VREE_Grabbed:int    = 3;// 已抢过了
		public static const VREE_CD:int         = 4;// CD时间
		public static const VREE_BeIgnore:int   = 5;// 被屏蔽了
		public static const VREE_Fail:int       = 6;// 其他各种失败
	}
}