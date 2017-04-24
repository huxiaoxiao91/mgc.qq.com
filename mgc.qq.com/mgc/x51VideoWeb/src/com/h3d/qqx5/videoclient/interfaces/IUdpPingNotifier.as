package com.h3d.qqx5.videoclient.interfaces
{
	public interface IUdpPingNotifier
	{
		function NotifyPing(conn:IUdpConnection,ping_value:int,online:int):void;
	}
}