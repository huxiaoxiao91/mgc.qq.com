package com.h3d.qqx5.framework.interfaces
{
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * @author liuchui
	 */
	public interface ICallCenter
	{
		function addNeedResponseEventID(reqId:int, ressponseID:int):void;
		function add_message_handler(msgid:uint, msgname:String, func:Function):void;		
//		function setRoomProxyIp(ip:String):void;
//		function setRoomProxyPort(port:int):void;
//		function setUserAccountInfo(id:uint, key:String):void;
		function sendMessageToRoomProxy(msg:INetMessage, roomID:int):void;
//		function setZoneId(zoneid:int):void;
		function setRoomProxys(room_proxy_infos:Array,account_infos:Array):void;
		function DoConnect():void;
		function onDispatchEvent(p:INetMessage, serialID:int):void;
		function Init(id:uint, key:String,zoneid:int,appid:int,skey:String):void;
		function connectionClose():void;
		function Ready():Boolean;
		function GetQQ():uint;
		function GetZoneId():int;
		function GetPort():int;
		function GetRPip():String;
		function GetConnected() : Boolean;
		function GetConnecting() : Boolean;
		function HasCharactor():Boolean;
		function SetCharactor(has:Boolean):void;
		function SetCookieData():void;
		function ClearCookieData(qq:Number):void;
		function ClearGuestCookieData(needMark:Boolean = true):void;
		function setRoomProxysAddress(ip:String,port:int):void;
		/**
		 * 断开链接，接收到服务器断开链接请求消息后，断开网络连接。
		 * 
		 */		
		function Disconnect():void;
		
		/**
		 * 续签
		 * @param appid
		 * @param key
		 * 
		 */		
		function ClientSigVerify(appid:int, key:String):void;
	}	
}