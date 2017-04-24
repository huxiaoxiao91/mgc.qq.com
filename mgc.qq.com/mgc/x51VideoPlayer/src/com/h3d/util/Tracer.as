package com.h3d.util
{
	//import com.junkbyte.console.Cc;
	//import com.junkbyte.console.Cc;
	
	import flash.external.ExternalInterface;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.getTimer;
	
	public class Tracer
	{
		public static const ERROR:uint = 1;
		public static const WARNNING:uint = 2;
		public static const INFO:uint = 3;
		
		public static var logAble:Boolean = true;
		public static var callb:Function = null;
		public static var priority:int = INFO;
		
		private static var nowTime:Date = null;
		private static var formater:DateTimeFormatter = null;
		private static var lastTick:int = 0;
		public function Tracer() {
			//callb = 
		}
		
		public static function setLogFunction(param1:Function) : void {
			callb = param1;
			
			// 输出到 console.log
			// 输出到trace
			// 输出到工具
		}
		
		public static function log(msg:String): void {
			updateNowTime();
			
			if (logAble && priority >= INFO) {
				var logmsg:String = formater.format(nowTime) + msg;
				//Debug.log(logmsg);
				//ExternalInterface.call("console.log", formater.format(nowTime) + msg);
				//Cc.log(logmsg);
				trace(logmsg);
			}
		}
		
		public static function warning(msg:String):void {
			updateNowTime();
			if (logAble && priority >= WARNNING) {
				var logmsg:String = formater.format(nowTime) + msg;
				//Debug.warning(logmsg);
				//ExternalInterface.call("console.warn", formater.format(nowTime) + msg);
				//Cc.warn(logmsg);
				//trace(logmsg);
			}
		}
		
		public static function error(msg:String):void {
			updateNowTime();
			if (logAble && priority >= ERROR) {
				var logmsg:String = formater.format(nowTime) + msg;
				//Debug.error(formater.format(nowTime) + msg);
				//ExternalInterface.call("console.error", formater.format(nowTime) + msg);
				//Cc.error(logmsg);
				//trace(logmsg);
			}
		}
		
		private static function updateNowTime():void {
			if (nowTime == null) {
				nowTime = new Date();
				formater = new DateTimeFormatter("en-US");
				formater.setDateTimePattern("MMdd/HHmmss: ");
				lastTick = getTimer();
			}
			
			var nowTick:int = getTimer();
			nowTime.time += nowTick - lastTick;
			lastTick = nowTick;
		}
	}
}