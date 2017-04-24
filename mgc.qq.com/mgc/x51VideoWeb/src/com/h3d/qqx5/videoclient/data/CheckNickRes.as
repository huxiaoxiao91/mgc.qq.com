package com.h3d.qqx5.videoclient.data
{
	public class CheckNickRes
	{
		//检查昵称是否可用
		public static const CNR_OK=0;					//可用
		public static const CNR_NullNickname=1;		//昵称为空
		public static const CNR_InvalidNickname=2;	//昵称不符合规范
		public static const CNR_RepeatNickname=3;		//重复昵称
		public static const CNR_UNKNOWN=4;			//未知原因
	}
}