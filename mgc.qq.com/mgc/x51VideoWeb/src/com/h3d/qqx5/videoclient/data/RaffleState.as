package com.h3d.qqx5.videoclient.data
{
	public class RaffleState
	{
		public function RaffleState()
		{
		}
		
		public static const RS_EndRaffle:int =0;  //抽奖结束
		public static const RS_ShowReward:int = 1; //展示奖品
		public static const RS_Raffling:int = 2;   //正在抽奖
		public static const RS_ShowResult:int = 3; //展示结果
		public static const RS_TakenRaffle:int =4;//已经抽过
	}
}