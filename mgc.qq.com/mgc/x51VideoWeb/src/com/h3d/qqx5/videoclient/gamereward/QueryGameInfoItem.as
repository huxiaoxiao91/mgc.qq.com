package com.h3d.qqx5.videoclient.gamereward
{
	/**
	 * 记录查询游戏测的临时奖励信息
	 **/
	public class QueryGameInfoItem
	{
		public function QueryGameInfoItem()
		{
		}
		public var rewards:Array = new Array;//奖励数据//GameRewardInfoForUI
		public var tips_index:Array = new Array;//要查询的tips，分别所在的索引
		public var cnt_index:Array = new Array;//要查询的cnt，分别所在的索引
		public var func:Function = new Function;
		public var argsArr:Array = new Array;//回调函数对应的参数
	}
}