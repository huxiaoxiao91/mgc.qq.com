package com.h3d.qqx5.videoclient.data
{
	public class VideoVipConfigInfo
	{
		public function VideoVipConfigInfo()
		{
			daily_rewards = new Array;
		}
			
		public var enter_broadcast_type:int = 0;      // 入场公告类型，目前只有文字公告
		public var daily_rewards:Array;          		// 每日福利
		public var exclusive_car:int = 0;           // vip的专属座驾的类型
		public var exclusive_medal:int = 0;			// vip专属徽章的类型
		public var vip_name:String = "";                // vip的名字
		public var vip_icon:String = "";                // vip的图标
		public var vip_font:String = "";                // vip的字体
		public var free_whistle_resource:String = "";   // vip免费飞屏的资源
		public var whistle_font:String = "";			// 飞屏字体
		public var card_pattern:String = "";            // 名片的方案，用int来作为一个索引
		public var entereffect:String = "";             // 入场座驾特效
		public var invisible:Boolean = false;  			//隐身权限		
	}
}