package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	/**
	 * @author liuchui
	 */
	public interface IAnchorNestClient
	{
		function HandleServerEvent(evt:INetMessage):Boolean;
		//获得捧场界面信息
		function LoadSupportInfo(player_id:Int64):void;
		//普通捧场
		function SendNormalSupport(player_id:Int64):void;
		//高级捧场
//		function SendAdvancedSupport(player_id:Int64):void;//直接走送礼逻辑
		//获得小窝的人气和排名及差值,bool load_advanced_support_rank = false不需要，在捧场界面中显示的是高级捧场每次的文字提示
		function LoadAnchorNestSimpleInfo():void;
//		//获得小窝明星值排行榜
//		function LoadAnchorNestStarRank():void;
		//离开房间
		function OnLeaveRoom():void;
		//领取团务
		function TakeNestTask():void;
		//领取人气宝箱奖励
		function TakeNestTreasureBox( ):void;
		//查询人气宝箱奖励
		function QueryNestTreasureBox():void;
		//查询团务奖励
		function QueryNestTaskReward(index:int ):void;
//		//获取小窝列表
		function GetNestList(room_id:int =0) :void;
//		function LoadNestAssistantList(room_id:int ):void;
//		//增加、删除小窝助手
//		function DelNestAssistant(player_id:Int64):void;
//		function AddNestAssistant(player_id:Int64):void;
		//是否为小窝
		function IsAnchorNestRoom():Boolean;
		//置为小窝
		function ToAnchorNestRoom(is_nest:Boolean ):void;
		//是否为小窝助手
		function IsNestAssistant():Boolean;
		//置为小窝助手
		function SetNestAssistant(is_assistant:Boolean ):void;
		function GetAssistantCount():int;
		function GetMaxPicCount():int;
		//成长相关
		// 获取小窝头衔，同步
		function GetNestCreditsLevel():int;
		// 获取小窝积分，同步
		function GetNestCredits():int;
//		// 获取小窝头衔表情特权，同步
//		function GetNestCreditsExpressionPrivilege():int;
		// 获取成长信息，异步
		function GetNestGrowUpInfo() :void;
		// 领取守护工资，异步
		function GetGuardWage():void;
	}	
}