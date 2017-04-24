package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.common.comdata.VideoChannelType;

	public class RewardForUI
	{
		public var count_desc:String;//数量描述
		public var tips:String;//礼物提示信息
		public var url:String = "";//礼物图标url
		public var name:String = "";//礼物名称
		public var channel:int = VideoChannelType.VCT_VIDEO;//奖励来源,默认是视频测
		
		public var type:int;
		public var id:int;
		public var price:Number = 0;
		public var CCY:String;
		
		public var rare:int;
//		public var star_gift:Boolean;
	}
}