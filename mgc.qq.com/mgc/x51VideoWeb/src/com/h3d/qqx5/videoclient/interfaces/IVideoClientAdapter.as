package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.VideoWebPayParam;
	
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	public interface IVideoClientAdapter
	{
		function GetLocalPlayerQQ():Int64;
		function GetLocalPlayerPstid():Int64;
		function GetLocalPlayerName():String;
		function IsLocalPlayerMale():Boolean;
		function GetZoneID():int;
		function GetPlayerLevel():int;
//		function GetVideoMoneyAmount():int;
		function RefreshMobilePlayerDiamondBalance(balance:int):void;
		
		function GetVideoWebPayParam():VideoWebPayParam;
		//演唱会相关
		function SaveRaffleID(room_id:int, raffle_id:Int64) :void;
		function GetRaffleID( raffle_id:Dictionary) :void;
	}	
}