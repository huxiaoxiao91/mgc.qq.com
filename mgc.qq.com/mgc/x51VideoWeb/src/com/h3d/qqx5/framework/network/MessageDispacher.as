package com.h3d.qqx5.framework.network
{
	import com.junkbyte.console.Cc;
	import com.h3d.qqx5.common.SingletonMgr;
	import flash.events.Event;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.Globals;
	public class MessageDispacher
	{
		private var _msg_map:Dictionary;
		private var _netCallBack:INetCallback;
		
		public function MessageDispacher():void
		{
			_msg_map = new Dictionary();
		}
		
		public function add_message_handler(msgid:uint, msgname:String, func:Function):void
		{
			_msg_map[msgid] = func;
			SingletonMgr.Instance().GetMsgFactory().AddMessage(msgid,msgname);
		}
		
		public function setNetCallBack(cb:INetCallback):void
		{
			_netCallBack = cb;
		}
		
		public function dispatch_connectted():void
		{
			if(_netCallBack != null)
			{
				_netCallBack.onRawConnected();
			}
		}
		
		public function dispatch_error(err:Event):void
		{
			if(_netCallBack != null)
			{
				_netCallBack.onRawDisConnected(err);
			}
		}
		
		public function dispatch_close(err:Event):void
		{
			if(_netCallBack != null)
			{
				_netCallBack.onRawDisConnected(err,true);
			}
		}
		
		public function dispatch(resType:int, p : INetMessage, serialID:int):void
		{
			if(_netCallBack != null)
			{
				_netCallBack.onDispatchEvent(p, serialID);
			}
			dispatch2(resType, p.CLSID(), p);
		}		
		
		public function dispatch2(resType:int, clsid : int, p : INetMessage):void
		{
			var func:Function = _msg_map[clsid];
//			if(p != null)
//			{
//				Globals.s_logger.debug("debug debug debug  dispatch msg:" + p.CLSID() );
//			}
//			else
			if(p == null )
			{
				Globals.s_logger.warn("message is null,resType:" + resType + ",clsid:" + clsid);
			}
			if(func != null)
			{
				func(resType, p);
			}
			else
			{
				if(p != null)
				{
					Globals.s_logger.error("dispatch msg:" + p.CLSID() + " failure, not find handler");
				}
			}
		}
	}
}