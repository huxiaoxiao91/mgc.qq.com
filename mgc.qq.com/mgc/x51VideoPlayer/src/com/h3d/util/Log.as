package com.h3d.util
{
	import com.junkbyte.console.Cc;

	public class Log
	{
		
		static public var LOG:String = "";
		
		static private var curNum:int = 0;
		static private var maxNum:int = 100;
		
		public function Log()
		{
			
		}
		
		static public function error(s:String):void
		{
			//LOG += getTimeString() + "  Error:  " + s + "\n";
		}
		
		static public function warn(s:String):void
		{
			//LOG += getTimeString() + "  Warn:  " + s + "\n";
		}
		
		static public function info(s:String):void
		{
			//LOG += getTimeString() + "  Info:  " + s + "\n";
		}
		
		static public function log(s:String):void
		{
			//LOG += getTimeString() + "  Log:  " + s + "\n";
		}
		
		static public function debug(s:String):void
		{
			//LOG += getTimeString() + "  debug:" + s + "\n";
		}
		
		static public function getTimeString():String
		{
			var date:Date = new Date();
			
			var ret:String = "";
			
			ret += ((date.hours < 10) ? "0" : "") + date.hours.toString() + ":";  
			ret += ((date.minutes < 10) ? "0" : "") + date.minutes.toString() + ":";
			ret += ((date.seconds < 10) ? "0" : "") + date.seconds.toString();
			
			return ret;
		}
		
		static public function getTimeString2():String
		{
			var date:Date = new Date();
			
			var ret:String = "";
			
			ret += ((date.hours < 10) ? "0" : "") + date.hours.toString() + "_";  
			ret += ((date.minutes < 10) ? "0" : "") + date.minutes.toString() + "_";
			ret += ((date.seconds < 10) ? "0" : "") + date.seconds.toString();
			
			return ret;
		}
		
		
		static public function showLog(...parameters):void
		{
			//return;
			
			if(parameters[0] == "视频数据" || parameters[0] == "音频数据")
			{
				if(curNum > maxNum) return;
				curNum++;
			}
			
			Cc.warn(new Date().time.toString(),"  ",parameters);
		}
		
		/**
		 * 
		 * @param msgNum 消息号
		 * @param msg 日志
		 * 
		 */		
		public static function formatLogMsg(msgNum:int, msg:String):void {
			var date:Date = new Date();
			LOG += "Info" + "\t" + getDateStr(date) + "\t" + date.time + "\t" + msgNum + "\t" + msg + "\n";
		}
		
		private static function getDateStr(date:Date = null):String {
			if (date == null) {
				date = new Date();
			}
			var ret:String = "";
			ret += date.fullYear.toString() + "-"
			ret += (date.month + 1).toString() + "-";
			ret += date.date.toString() + " "
			ret += ((date.hours < 10) ? "0" : "") + date.hours.toString() + ":";
			ret += ((date.minutes < 10) ? "0" : "") + date.minutes.toString() + ":";
			ret += ((date.seconds < 10) ? "0" : "") + date.seconds.toString() + ".";
			ret += (date.milliseconds < 10 ? "00" : (date.milliseconds < 100 ? "0" : "")) + date.milliseconds;
			return ret;
		}
		
	}
}