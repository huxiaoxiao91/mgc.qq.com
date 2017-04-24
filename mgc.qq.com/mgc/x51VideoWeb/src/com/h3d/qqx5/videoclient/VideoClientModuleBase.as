package com.h3d.qqx5.videoclient
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.framework.interfaces.ICallCenter;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.media.Video;

	/**
	 * @author liuchui
	 */
	public class VideoClientModuleBase
	{
		/**
		 * 	视频逻辑管理器
		 */
		private var m_videoModuleManager:VideoClientModuleManager = null;
		/**
		 *	视频逻辑模块名称
		 */
		private var m_moduleName:String = "";
		public function GetModuleName():String
		{
			return m_moduleName;
		}
		
		public function VideoClientModuleBase(name:String,mgr:VideoClientModuleManager)
		{
			this.m_moduleName = name;
			this.m_videoModuleManager = mgr;
		}
		
		public function GetModule(name:String):Object
		{
			return m_videoModuleManager.GetModule(name);
		}
		
		public function SendRequestToServer(msg:INetMessage) : void
		{
			if(msg == null)
			{
				//Todo:错误日志
				return;
			}
			if(m_videoModuleManager.GetCallCenter() == null)
			{
				//Todo:错误日志
				return;
			}
			m_videoModuleManager.GetCallCenter().sendMessageToRoomProxy(msg, Globals.SelfRoomID);
		}
		
		/**
		 *	模块加载，暂时无用 
		 */
		public function Initialize() : void
		{
			
		}
		/**
		 *	模块卸载，暂时无用
		 */
		public function Uninitialize() : void
		{
			
		}
	}	
}
