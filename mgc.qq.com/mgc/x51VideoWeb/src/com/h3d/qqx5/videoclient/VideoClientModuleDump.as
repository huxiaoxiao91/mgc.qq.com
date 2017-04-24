package com.h3d.qqx5.videoclient
{
	import com.h3d.qqx5.videologic.IVideoModule;

	public class VideoClientModuleDump extends VideoClientModuleBase implements IVideoModule,IDump
	{
		public function VideoClientModuleDump(mgr:VideoClientModuleManager)
		{
			super("com.h3d.qqx5.videoclient.IDump",mgr);
		}
		public function Haha():void
		{
			trace("haha");
		}
		
		/**
		 *	设置该模块处理的消息和消息接收处理函数。 
		 */
		public function AddMessageHandler() : void
		{
			trace("AddMessageHandler");
		}
		/**
		 *	设置该模块的关键消息，如果关键消息接收不到或者出现问题，应该中断当前连接，提示用户错误。
		 */
		public function AddNeedResponseEventIDs() : void
		{
			trace("AddNeedResponseEventIDs");
		}
		/**
		 *	 模块内容更新。
		 */
		public function UpdateModule() : void
		{
			trace("UpdateModule");
		}
	}
}