package com.h3d.qqx5.videoclient.data
{
	public class VideoGuardConditionType
	{
		public static const VGCT_Affinity		:int =  0;	//因为亲密度达成而获得守护
		public static const VGCT_Follower		:int =  1;	//因为鲜花达成而获得守护
		public static const VGCT_ManualAssign	:int =  2;	//因为手动赋予而获得
		public static const VGCT_ManualRecede	:int =  3;	//手动撤销
		public static const VGCT_UnFollow		:int =  4;	//取消关注而失去守护
	}
}