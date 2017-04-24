package com.h3d.qqx5.videoclient.interfaces {

	import com.h3d.qqx5.LoginManager;
	import com.h3d.qqx5.framework.interfaces.ICallCenter;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.gamereward.ReawardCookieManager;
	import com.h3d.qqx5.videoclient.main.CVideoClientBase;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoVipConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.IImpressionConfig;

	import flash.utils.Dictionary;

	public interface IVideoClientInternal extends IVideoClient {
		function GetUICallback():IVideoClientLogicCallback;
		function GetLocalAccountID():Int64;
		function GetLocalAccountType():int;
		function GetVideoClientAdapter():IVideoClientAdapter;
		function GetAnchor():IClientAnchor;
		function GetSelfPersistID():Int64;
		function IsSelfMale():Boolean;
		function GetType():int;
		function GetConfigPath():String;
		function GetLogicInternal():IVideoClientLogicInternal;
		function GetVideoClientBase():CVideoClientBase;
		function GetRoomID():int;
		function IsInRoom():Boolean;
		function SetRoomIcons(icons:Dictionary):void;
		function SetVipUrl(url:String):void;
		function GetImpressionConfig():IImpressionConfig;
		function GetGuardConfig():IFansGuardConfig;
		function GetVipConfig():CVideoVipConfig;
		function GetCallCenter():ICallCenter;
		function GetLoginManager():LoginManager;
		function OnConnectFailCallback():void;
		function OnConnectSuccessCallback():void;
		function OnSyncServerTimeCallback(time:int):void;
		function LoginChangeToDo():void;
		function OnDisConnected():void;
		function GetIsGuest():Boolean;

		function SetQgame_item_image_url(url:String):void;
		function GetQgame_item_image_url():String;
		// 游戏测奖励缓存的管理类
		function GetReawardCookieManager():ReawardCookieManager;
		/**
		 * 初始化连接失败回调
		 * @param res
		 *
		 */
		function OnInitConnectFailCallback(res:int):void;
		/**
		 * 重连验证失败回调
		 * @param res
		 *
		 */
		function OnReconnectVerifyFailCallback(res:int):void;
	}
}
