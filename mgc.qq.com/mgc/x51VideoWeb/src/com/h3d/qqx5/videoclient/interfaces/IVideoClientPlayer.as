package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.common.comdata.VideoCharInfo;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.VideoClientCharInfo;
	
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	public interface IVideoClientPlayer
	{
		// 设置回调对象
		function SetPlayerOpCallback(call_back:IVideoClientPlayerOPCallback):void
		// 同步玩家视频区信息，一般只需在业务侧第一次登录时拉取
		function SyncVideoClientPlayerInfo(requestfromUI:Boolean = false,reqtype:int = 0) : void;
		// 得到视频区昵称
		function GetVideoNick() : String;
		// 获取视频区玩家id
		function GetVideoID():Int64;
		// 视频区性别
		function IsMale() : Boolean;
		// 得到财富值
		function GetWealth() : Int64;
		//弃用
		//function SetFollowingAnchorIDs(follow_anchors:Array):void;
		// 获得关注主播id列表,弃用
		//function GetFollowingAnchorIDs() : Array;
		// 是否自己已关注的主播
		function IsFollowingAnchor(anchor:Int64) : Boolean;
//		// 获得视频区代币数量
//		function GetVideoMoneyNum() : int;
		// 获得梦幻币数量
		function GetDreamMoneyNum() : int;
		// 更新关注的主播开播时间
		function UpdateFollowedAnchorStartTime(id:Int64,start_time:uint):void;
		// 是否需要开播提醒
		function NeedNotifyLiveStart(id:Int64,start_time:uint):Boolean;
		// 获得视频服务器时间,单位ms
		function GetVideoServerTime() : Number;
		// 关注主播，异步
		function FollowAnchor(anchor_id:Int64, anchor_nick:String) : Boolean;
		// 取消关注主播，异步
		function CancelFollowAnchor(anchor_id:Int64, anchor_nick:String) : Boolean;
		// 获得关注主播的详细信息，异步
		function LoadFollowingAnchorInfos() : void;
		// 获得免费礼物数量
		function GetFreeGiftCount() : int;
		// 获得视频区pstid
		function GetVideoPersistID() : Int64;
		// 得到视频区玩家charinfo
		function GetVideoClientCharInfo(reqType:int):VideoClientCharInfo;
		// 隐身
		function SetInvisible(invisible:Boolean, only_client:Boolean):void;
		// 是否隐身
		function IsInvisible():Boolean;
		/**
		 * 是否提示过任务提示。
		 * @return
		 *
		 */
		function IsTipsNoticed():Boolean;
		// 用客户端时间初始化时钟
		function InitServerTime(server_time:int):void;
		function Gender() :int;
		function GetVideoLevel():int;
		
		function GetPhotoUrl():String;
		//修改昵称
		function ModifyNick(nick:String,source_type:int,rand_nick_pool:int,nick_record_id:int):void;
		function ForceUpdate():void;
		function  ClearClientData():void;
		//获取贵族等级
		function GetVipLevel():int;
		function GetZoneName():String;
		//获取贵族剩余时间
		function GetVipRemainTime():int;
		//获取vip的名称(近卫，骑士等)
		function GetVipName():String;
		/**
		 * 获取绑定的主播名
		 * @return
		 *
		 */
		function GetAttachedAnchorName():String;
		/**
		 * 获取绑定的主播ID
		 * @return 
		 * 
		 */		
		function GetAttachedAnchorID():String;
		
		function SetVideoMoney(dream_money:int,balance:Int64):void;
		function SetVipInfo( vip_level:int , vip_expire :int):void;
		
		function GetNestCreditsLevel():int;
		function SetNestCreditsLevel(roomid:int,credits:int, level:int):void;
		function  GetNestCredits():int;
		
		function getSkinGiftList():Dictionary;
	}	
}