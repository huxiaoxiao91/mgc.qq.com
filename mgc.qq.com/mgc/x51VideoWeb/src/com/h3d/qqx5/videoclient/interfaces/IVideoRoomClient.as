package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.framework.network.INetMessage;

	/**
	 * @author liuchui
	 */
	public interface IVideoRoomClient
	{
		function HandleServerEvent(event:INetMessage):Boolean;
		function GetRoomType():int;
		function GetPrivateChatList():Array;
	}	
}