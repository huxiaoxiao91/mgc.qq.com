package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.VideoClientCharInfo;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;

	/**
	 * @author liuchui
	 */
	public interface IVideoClientPlayerOPCallback
	{
		function OnFollowAnchorRes(type:int, res:int, anchorID:Int64, anchor_nick:String):void;
		function OnCancelFollowAnchor(type:int, res:int, anchorID:Int64, anchor_nick:String):void;
		function OnLoadFollowingAnchorsInfo(type:int, infos:Array):void;
		//function OnRefreshVideoClientCharInfo(type:int, sync_res:Boolean, charinfo:VideoClientCharInfo):void;
		function OnSetVisibleRes(type:int, res:int, invisble:Boolean):void; 
		function OnIsFollowedAnchorRes(res:Boolean):void;
		function OnLoadPlayerInfoForHomePage(res:int, playerinfo:VideoClientCharInfo):void;
		function OnModifyNickRes(type:int,res:int,recommend_nick:String,source_type:int):void;
		
//		function OnFirstGetHomePage(playerinfo:CVideoPlayerInfo):void;
		
		//三次拉取首页信息147失败
		function OnGetHomePageFail(res:int):void;
		
		function NotifyMoneyChange(dream_money:int,balance:int):void;
		function OnReceiveChatMsg(msg:VideoRoomMsgData):void
	}	
}