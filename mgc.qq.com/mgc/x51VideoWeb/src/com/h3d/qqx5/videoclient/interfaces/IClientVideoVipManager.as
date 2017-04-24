package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.framework.network.INetMessage;

	public interface IClientVideoVipManager
	{
		function Update() :void;    
		function OnEnterRoom() :void;
		function OnLeaveRoom() :void;
		function OnEventLimit(clsid:int) :void;
		function HandleServerEvent(ev:INetMessage) :Boolean;
	}
}