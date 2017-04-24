package com.h3d.qqx5.videologic
{
	public interface IVideoModule
	{
		/**
		 *	设置该模块处理的消息和消息接收处理函数。 
		 */
		function AddMessageHandler() : void;
		/**
		 *	设置该模块的关键消息，如果关键消息接收不到或者出现问题，应该中断当前连接，提示用户错误。
		 */
		function AddNeedResponseEventIDs() : void;
		/**
		 *	 模块内容更新。
		 */
		function UpdateModule():void;
	}
}