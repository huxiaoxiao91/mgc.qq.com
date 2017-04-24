package com.h3d.qqx5.videoclient.interfaces
{
	public interface IVideoClientLogicInternal extends IVideoClientLogic
	{
//		// 获取玩家头像url
//		function RequestPlayerHeadPortraitUrl(zone_id:int ,qq:Int64 ,pstid:Int64 ):void;
//		// 禁言/取消禁言，异步，forbid为true表示禁言，fobid为false表示取消禁言
//		function ForbidTalk(playerName:String, playerZoneName:String, forbid:Boolean , perpetual:Boolean  = false):Boolean;
//		// 踢出房间，异步
//		function KickPlayer(playerName:String, playerZoneName:String):Boolean;
//		// 视频投票
//		// 发起投票
//		function StartVote(vote_info:VideoVoteStartInfo):void;
//		// 停止投票
//		function StopVote():void;
//		// 请求投票历史，异步
//		function GetVoteHistory():void;
		// 获取服务器时间
		function GetServerTime():int;
//		// 加载守护榜数据，异步
//		function LoadSuperGuards():void;
	}
}