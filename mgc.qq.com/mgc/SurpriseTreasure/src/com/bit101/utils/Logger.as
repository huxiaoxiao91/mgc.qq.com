package com.bit101.utils
{
	import flash.events.TimerEvent;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.Timer;

	public class Logger
	{
		public function Logger()
		{
			if (instance) {  
				throw new Error("只能用getInstance()来获取实例");  
			}
			else
			{
				_timer = new Timer(delay);
				_timer.addEventListener(TimerEvent.TIMER,timerComplete);
				_timer.start();
			}
		}
		
		private static var instance:Logger;  /* 单例类实例 */
		
		/**
		 *  设置间隔时间请求一次毫秒值
		 */		
		private var delay:Number = 60000;
		private var _msg:String = "";
		
		private var prefixStr:String = "[礼物]";
		private var _timer:Timer;
		private var userID:String;
		
		
		public static function getInstance():Logger
		{
			if (!instance) 
			{
				instance = new Logger();
			}
			
			return instance;
		}
		
		
		public function formatDateTime():String  
		{  
			
			//需要as3corelib.swc如果没有可以直接使用 ：return dateToString(data,formatString);  
			var dateFormater:DateTimeFormatter=new DateTimeFormatter();  
			dateFormater.setDateTimePattern("YYYY-MM-DD HH-mm-ss");  
			return dateFormater.format(new Date());  
		}
		
		public function debug(msg:String):void
		{
			_msg += (prefixStr + "  DEBUG  " + userID + "  " + formatDateTime() +"  "+ msg + "\n");
		}
		
		public function info(msg:String):void
		{
			_msg += (prefixStr + "  INFO  " + userID + "  " + formatDateTime() +"  "+ msg + "\n");
		}
		
		public function warn(msg:String):void
		{
			_msg += (prefixStr + "  WARN  " + userID + "  " + formatDateTime() +"  "+ msg + "\n");
		}
		
		public function error(msg:String):void
		{
			_msg += (prefixStr + "  ERROR  " + userID + "  " + formatDateTime() +"  "+ msg + "\n");
		}
		
		private function timerComplete(e:TimerEvent):void
		{
			if(_msg.length >0)
			{
				runReported();
			}
		}
		
		/**
		 *停止运行时调用请求提交 
		 * 
		 */		
		public function stopRun():void
		{
			_timer.stop();
			if(_msg.length >0)
			{
				runReported();
			}
		}
		
		public function runReported():void
		{
			
		}
	}
}