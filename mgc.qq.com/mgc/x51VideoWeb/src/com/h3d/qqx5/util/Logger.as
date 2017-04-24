package com.h3d.qqx5.util
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.common.Globals;
	import com.junkbyte.console.Cc;
	
	import flash.display.Sprite;
	import flash.external.ExternalInterface;

	public class Logger
	{
		/**
		 * 本地日志
		 */
		public static var LOCAL_LOG:String = "";

		//日志的级别
		public static const DebugLevel:int = 0; //测试用
		public static const LogLevel:int   = 1; //
		public static const InfoLevel:int  = 2;
		public static const WarnLevel:int  = 3; //
		public static const ErrorLevel:int = 4; //
		public static const TQOSLevel:int  = 5; //

		private var needUpLevel:int        = InfoLevel; //上报的最低级别，再低不予上报
		private var needShowLevel:int      = DebugLevel; //输出的最低日志级别，低于不予输出
		private var uploadstr:String       = "|"; //整合上传的字符串
		private var uplevel:int            = 0; //上报等级
		private var upmaxlen:int           = 2 * 1000; //2k的大小			

		private var uploadTQosStr:String   = "";
		private var timer:TimerBase        = new TimerBase(1000 * 60 * 5, UpLoadLogByTime); //五分钟 

		public function Logger(stage:Sprite, key:String = "`", needlevel:int = InfoLevel) {
			Cc.config.maxLines = 5000;//(Globals.isDubug == false && Globals.ipType == Globals.IP_OUTER) ? 500 : 5000;
//			Cc.config.maxLines = 50;
			Cc.startOnStage(stage, key);
			needUpLevel = needlevel;
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("UpLoadLog", UpLoadLogByTime);
			}
			timer.StartTimer();
		}

		public function SetNeedUpLevel(needlevel:int):void {
			needUpLevel = needlevel;
		}

		public function SetNeedShowLevel(showlevel:int):void {
			needShowLevel = showlevel;
		}

		public function info(msg:String):void
		{
			var str:String = new Date().toTimeString() + "    "  + new Date().time + "   "  +"--" + msg;
			if(InfoLevel >= needShowLevel )
				Cc.info("Info --" + str);
//			UpLoadLogToServer(str,InfoLevel);
//			trace(str);
		}
		
		public function debug(msg:String):void
		{
			var str:String = new Date().toTimeString() + "    "  + new Date().time + "   "  +"--" + msg;
			if(DebugLevel >= needShowLevel )
				Cc.debug("Debug--" + str);
//			UpLoadLogToServer(str,DebugLevel);
//			trace(str);
		}
		
		public function error(msg:String):void
		{
			var str:String = new Date().toTimeString() + "    "  + new Date().time + "   "  +"--" + msg;
			if(ErrorLevel >= needShowLevel )
				Cc.error("Error--" + str);
//			UpLoadLogToServer(str,ErrorLevel);
//			trace(str);
		}
		
		public function warn(msg:String):void
		{
			var str:String = new Date().toTimeString() + "    "  + new Date().time + "   "  +"--" + msg;
			if(WarnLevel >= needShowLevel )
				Cc.warn("Warn --" + str);
//			UpLoadLogToServer(str,WarnLevel);
//			trace(str);
		}
		
		public function tqos(msg:String):void
		{
			var str:String = new Date().toTimeString() + "    "  + new Date().time + "   "  +"--" + msg;

			UpLoadTQOSToServer(str,TQOSLevel);
		}

		public function test(msg:String):void {
			trace(msg);
		}
		
		public function log(msg:String):void
		{
			return;
			var str:String = new Date().toTimeString() + "    "  + new Date().time + "   "  +"--" + msg;
			if(LogLevel >= needShowLevel )
				Cc.log("Log  --" + str);
			UpLoadLogToServer(str,LogLevel);
		}

		public function localLog(msg:String):void {
			debug(msg);
			var str:String = new Date().toTimeString() + "    " + new Date().time + "   " + "--" + msg;
			if (LOCAL_LOG != "") {
				LOCAL_LOG += "\n" + str;
			} else {
				LOCAL_LOG += str;
			}
		}

		private function GetUpLevelStr(logLevel:int):String
		{
			var uplevelstr:String = "";
			
			if(logLevel == DebugLevel)
				uplevelstr = "Debug";
			else if(logLevel == LogLevel)
				uplevelstr = "Log";
			else if(logLevel == InfoLevel)
				uplevelstr = "Info";
			else if(logLevel == WarnLevel)
				uplevelstr = "Warn";
			else if(logLevel == ErrorLevel)
				uplevelstr = "Error";
			else if(logLevel == TQOSLevel)
				uplevelstr = "TQOS";
			return uplevelstr;			
		}
		
		private function UpLoadLogByTime():void
		{
			if(uploadTQosStr.length < 1)
				return ;
			if (ExternalInterface.available) {
				var argc1:Object = {"e_c": 5 + "|" + uploadTQosStr, "c_t": 100};
				ExternalInterface.call("EAS.SendClick", argc1);
			}
			uploadTQosStr = "";				
		}
		
		private function UpLoadTQOSToServer(upstr:String,logLevel:int):void
		{
			//上报tqos
			
			if(upstr.length > upmaxlen)//超过2k之后的直接扔掉
			{
				upstr = upstr.substr(0,upmaxlen);
			}
			
			if(uploadTQosStr.length + upstr.length >= upmaxlen)//如果加上最新的一条log大于2k就上报之前的，该调向下积累
			{
				if (ExternalInterface.available) {
					var argc1:Object = {"e_c": logLevel + "|" + uploadTQosStr, "c_t": 100};
					ExternalInterface.call("EAS.SendClick", argc1);
					uploadTQosStr = upstr;
				}
			}
			else
			{
				if(uploadTQosStr == "")
					uploadTQosStr = upstr;
				else
					uploadTQosStr = uploadTQosStr + "..." + upstr;				
			}
			return;
		}
		
		//upstr上传的信息字符串，loglevel上传的日志等级
		private function UpLoadLogToServer(upstr:String,logLevel:int):void
		{				
			if(logLevel < needUpLevel)//低予最低的上报日志等级不予上报
				return;
			
			if(upstr.length > upmaxlen)//超过2k之后的直接扔掉
			{
				upstr = upstr.substr(0,upmaxlen);
			}
						
			if(logLevel == ErrorLevel)//是error立刻上报
			{
				if (ExternalInterface.available) {
					var argc:Object = {"e_c": logLevel + "|" + upstr, "c_t": 100};
					ExternalInterface.call("EAS.SendClick", argc);
				}
				return;
			}
						
			if(uploadstr.length + upstr.length >= upmaxlen)//如果加上最新的一条log大于2k就上报之前的，该调向下积累
			{
				if (ExternalInterface.available) {
					var argc1:Object = {"e_c": logLevel + "|" + uploadstr, "c_t": 100};
					ExternalInterface.call("EAS.SendClick", argc1);
				}
				uplevel = logLevel;
				uploadstr = "|" + upstr;				
			}
			else
			{
				if(logLevel > uplevel)
					uplevel = logLevel;
				if(uploadstr == "|")
					uploadstr = upstr;
				else
					uploadstr = uploadstr + "..." + upstr;				
			}
		}
	}
}