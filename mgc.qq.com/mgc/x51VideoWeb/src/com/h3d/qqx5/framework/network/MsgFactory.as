package com.h3d.qqx5.framework.network
{
	import com.h3d.qqx5.common.Globals;
	
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;	
	/**
	 * 	消息工厂，从id生成消息
	 */
	public class MsgFactory
	{
		/**
		 * 	id与消息类名映射关系
		 */
		private var _msg_name:Dictionary;
		
		public function MsgFactory()
		{
			_msg_name = new Dictionary();
			AddMessage(MessageID.CLSID_CEventRoomProxyWrapEvent, getQualifiedClassName(CEventRoomProxyWrapEvent));
		}
		
		/**
		 *	加入需要处理的消息关系。
		 */
		public function AddMessage(msgid:uint,msgname:String):void
		{
			_msg_name[msgid] = msgname;
		}
		
		/**
		 * 	利用反射生成msgId对应的消息类
		 */
		public function CreateMessage(msgId : uint):INetMessage
		{
			var name:String = _msg_name[msgId];
			if (name == null)
			{
				return null;
			}
			var classref:Class = getDefinitionByName(name) as Class;
			var instance:INetMessage = new classref();	
			return instance;
		}
	}
}