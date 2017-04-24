package com.h3d.qqx5.util
{
	import flash.events.StatusEvent;
	import flash.net.LocalConnection;
	
	public class X51VideoWebLoadConn
	{
		private var connRecv:LocalConnection;
		private var connSend:LocalConnection;
		
		private var recvConnName:String = "";
		private var sendConnName:String = "";
		private var handleName:String = "";
		private var onOff:Boolean = true;
		
		
		public function X51VideoWebLoadConn(recv:String,send:String,swf:Object)
		{
			recvConnName = recv;
			sendConnName = send;
			
			connRecv = new LocalConnection;
			connRecv.client = swf;
			
			connSend = new LocalConnection;		
			connSend.addEventListener(StatusEvent.STATUS, onStatus);		
		}
		public function turnOnOff(isOpen:Boolean):void
		{
			onOff = isOpen; 
		}
		//链接
		public function connect():void
		{
			try 
			{
				connRecv.connect(recvConnName);
			}
			catch (error:ArgumentError)
			{
				trace("Can't connect...the connection name is already being used by another SWF");
			}
		}
		//关闭链接
		public function close():void
		{
			connRecv.close();
		}
		//色泽处理函数名称
		public function setHandleName(handle:String):void
		{
			handleName = handle;
		}
		//发送消息
		public function send(argc:String):void
		{
			if(onOff)
				connSend.send(sendConnName, handleName,argc);
		}
		
		private function onStatus(event:StatusEvent):void
		{
			switch (event.level) 
			{
				case "status":
					trace("LocalConnection.send() succeeded");
					break;
				case "error":
					trace("LocalConnection.send() failed");
					break;
			}
		}		
	}
}