package com.h3d.qqx5.common
{
	import com.h3d.qqx5.framework.network.MsgFactory;
	
	/**
	 * 	全局唯一单实例管理器，用于操作所有需要单实例实现的模块。
	 */
	public class SingletonMgr
	{
		private static var s_instance:SingletonMgr = null;
		/**
		 * 	消息工厂，用msgid生成消息类
		 */
		private var m_msgFactory:MsgFactory = null;
		
		function SingletonMgr()
		{
		}
		
		public static function Instance():SingletonMgr
		{
			if(s_instance == null)
			{
				s_instance = new SingletonMgr();
			}
			return s_instance;
		}
		
		public function GetMsgFactory():MsgFactory
		{
			if(m_msgFactory == null)
			{
				m_msgFactory = new MsgFactory();
			}
			return m_msgFactory;
		}
		
	}
}