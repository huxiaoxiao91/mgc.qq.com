package com.h3d.qqx5.videoclient.gamereward
{
	/**
	 * 游戏测奖励的数据结构
	 * */
	public class GameRewardInfoForUI
	{
		public function GameRewardInfoForUI()
		{
		}
		public var id:int = 0;//id
		public var url:String = "";//图片地址
		public var name:String = "";//名称
		//public var type:int;//礼物类型
		public var tips:String = "";//tips
		public var count_desc:String = "";//奖励数量描述
		public var channel:int;//奖励来源
		public var rare:int;//是否稀有
	}
}