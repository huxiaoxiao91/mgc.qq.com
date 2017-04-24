package com.h3d.qqx5.videoclient.interfaces
{
	/**
	 * @author liuchui
	 */
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.AnchorPKFansAvatar;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;

	public interface IAnchorPKClient
	{
		//活动状态(无活动 pk阶段 展示结果阶段)
		function GetAnchorPKActivityStatus():int;
		//客户端当前是否在活动房间中
		function InActivityRoom():Boolean;
		//比赛状态（准备阶段 缓冲阶段 进攻阶段等等）
		function GetAnchorPKMatchStatus():int;
		//土豪形象
		function GetTopFansAvatar(anchor_id:String, buff:AnchorPKFansAvatar):void;
		//比分详情
		function GetAnchorPKScoreInfo(player_id:Int64):void;
		//获得参赛直播信息
		function GetPKAnchorDataForUI(anchor_qq:Int64, data:ClientAnchorData):void;
		function HandleServerEvent(evt:INetMessage):Boolean;
		function RefreshMatchAnchorStarLightAndPopular(anchor_id:Int64, star:Int64,popular:Int64):void;
		function RefreshAnchorInfoByData(data:ClientAnchorData):void;
		function RefreshAnchorInfo(anchor_id:Int64, name:String, intro:String) :void;
		function RefreshAnchorFollowedNum(anchor_id:Int64, followed:int ):void;
		function RefreshAnchorImage(anchor_id:Int64 ):void;
		function ShowActivityButton():Boolean;
		//获取在本次PK阶段玩家的贡献值
		function GetPlayerContributionInCurPK(player_id:Int64 ):void;
		function SetPKRooms(rooms:Array):void;
		function ClearAvatarCathe():void;
	}	
}