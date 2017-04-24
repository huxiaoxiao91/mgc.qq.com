package com.h3d.qqx5.videoclient
{
	import com.h3d.qqx5.framework.interfaces.ICallCenter;
	import com.h3d.qqx5.videologic.IVideoModule;
	
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	public class VideoClientModuleManager
	{
		/**
		 * 	客户端逻辑模块
		 */
		private var video_modules:Dictionary = new Dictionary;
		/**
		 * 与videoroomproxy连接、消息收发中心
		 */
		private var m_callcenter:ICallCenter = null;
		/**
		 * 	与videoversion连接、消息收发中心
		 */
//		private var m_verCallcenter:VersionCallCenter = null;
		
		public function VideoClientModuleManager()
		{
		}
		
		/**
		 * 	加入视频逻辑模块
		 */
		public function AddVideoModule(module:VideoClientModuleBase, name:String) : void
		{
			video_modules[name] = module;
		}
		/**
		 * 	获得视频逻辑模块
		 */
		public function GetModule(name:String) : VideoClientModuleBase
		{
			return video_modules[name];
		}
		/**
		 *	用CallCenter初始化已加入的各个模块
		 */
//		public function InitVideoModules(call_center:ICallCenter,version_call_center:VersionCallCenter) : void
//		{
//			this.m_callcenter = call_center;
//			this.m_verCallcenter = version_call_center;
//			for(var key:String in video_modules)
//			{
//				var module:VideoClientModuleBase = video_modules[key] as VideoClientModuleBase;
//				if(module is IVideoModule)
//				{
//					var m:IVideoModule= module as IVideoModule;
//					if(m != null)
//					{
//						m.AddMessageHandler();
//						m.AddNeedResponseEventIDs();
//					}
//				}
//			}
//		}
		
		public function GetCallCenter() : ICallCenter
		{
			return m_callcenter;
		}
		
//		public function GetVerCallCenter():VersionCallCenter
//		{
//			return m_verCallcenter;
//		}
		
		public function UpdateModules():void
		{
			for each(var module:VideoClientModuleBase in this.video_modules)
			{
				var m:IVideoModule = module as IVideoModule;
				if(m != null)
				{
					m.UpdateModule();
				}
			}
		}
		
		public function DestroyVideoModuleManager() : void
		{
			m_callcenter = null;
			video_modules.clear();
			video_modules = null;
			m_verCallcenter = null;
		}
		
		public function InitializeModules() : void
		{
			for(var key:String in video_modules)
			{
				var module:VideoClientModuleBase = video_modules[key] as VideoClientModuleBase;
				module.Initialize();
			}
		}
		
		public function UninitializeModules() : void
		{
			for(var key:String in video_modules)
			{
				var module:VideoClientModuleBase = video_modules[key] as VideoClientModuleBase;
				module.Uninitialize();
			}
		}
	}	
}
