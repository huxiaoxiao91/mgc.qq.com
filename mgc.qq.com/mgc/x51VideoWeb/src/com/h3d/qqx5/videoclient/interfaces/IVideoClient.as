package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	public interface IVideoClient
	{
		function Init():void;
		function Update(itime:int):void;
		function SetVideoClientAdapter(bridge:IVideoClientAdapter):void;
		function SetVideoAdUrl(url:String):void;
		function GetInterfacesForUI():IVideoClientLogic;
		function GetSurpriseBox():ISurpriseBox;
		function GetVideoClientPlayer():IVideoClientPlayer;    
		function GetVideoGroupID():int;
		function GetRoomsIcons():Dictionary;
		function GetVipUrl():String;
		function GetPicDownloadUrl():String;
		function ClearRoomProxy():void;
		function AddRoomProxy(ip:String, port:int):void;
		function GetVideoRoomTicketUrl():String;
		function HandleServerEvent(ev:INetMessage):void;
		function SendEvent(ev:INetMessage, roomid:int,deviceType:int = 0):void;
		function ConnectRoomProxy(qq:Int64,verify:String,zoneid:int,needCache:Boolean,channel:int,appid:int,skey:String):void;
	}
}