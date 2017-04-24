package com.h3d.qqx5.videoclient.interfaces
{
	public interface IFansGuardConfig
	{
		function GetChatFont(level:int):String;
		function ShowChatFace(level:int):Boolean;
		function GetSWordNum(level:int):int;
		function GetPlayerListFont(level:int):String;
		function GetGuardName(level:int):String;
		function GetMaxNumCount(level:int):int;
		function GetRequireAffinity(level:int):int;
		function GetIcon(level:int):String;
		function CanUseChatImg(guard_level:int,img:String):Boolean;
		function GetSuperGuardLevel():int;
		function CanBanChat(level:int):Boolean;
		function CanShowInSuperGuardList(level:int):Boolean;//是否可以显示在UI的守护榜上
	}
}