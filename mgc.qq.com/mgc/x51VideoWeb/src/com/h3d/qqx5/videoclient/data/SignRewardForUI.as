package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.common.comdata.VideoChannelType;

	public class SignRewardForUI
	{
		public var count_desc:String;//数量描述
		public var tips:String = "";//礼物提示信息
		public var url:String = "";//礼物图标url
		public var name:String = "";//礼物名称
		public var level:int ;//贵族等级
		public var multiply:int;//翻倍数
		public var channel:int  = VideoChannelType.VCT_VIDEO;//奖励来源,默认是视频测
	}
}