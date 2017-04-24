package com.h3d.util
{
	import com.junkbyte.console.Cc;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.globalization.DateTimeFormatter;
	import flash.utils.Timer;

	//x51VideoWeb保持一致 add by hss
	public class TQosLogger
	{
		
		private var timer:Timer = new Timer(1000*60*5);//五分钟 

		public static const  TQOSLevel:int = 5;
		
		private var uploadTQosStr:String = "";//整合上传的字符串
		private var upmaxlen:int = 2*1000;//2k的大小		
		
		public function TQosLogger()
		{
			ExternalInterface.addCallback("UpLoadLog",UpLoadLogByTimeFromWeb);
			timer.addEventListener(TimerEvent.TIMER,UpLoadLogByTime);
			timer.start();
		}
		
		private function UpLoadLogByTimeFromWeb():void
		{
			UpLoadLogByTime(null);
		}
		
		private function UpLoadLogByTime(e:Event):void
		{
			if(uploadTQosStr.length < 1)
				return ;
			var argc1:Object = {"e_c":"TQOS|" + uploadTQosStr,"c_t":100};
			ExternalInterface.call("EAS.SendClick",argc1);
			uploadTQosStr = "";				
		}
		
		public function tqos(msg:String):void
		{
			var str:String = getTimeString()+"--" + msg;
			UpLoadTQOSToServer(str,TQOSLevel);
		}
		
		public function getTimeString():String
		{
			var date:Date = new Date();
			
			var ret:String = "";
			
			ret += ((date.hours < 10) ? "0" : "") + date.hours.toString() + ":";  
			ret += ((date.minutes < 10) ? "0" : "") + date.minutes.toString() + ":";
			ret += ((date.seconds < 10) ? "0" : "") + date.seconds.toString();
			
			return ret;
		}
		
		private function UpLoadTQOSToServer(upstr:String,logLevel:int):void
		{
			//上报tqos
			
			if(upstr.length > upmaxlen)//超过2k之后的直接扔掉
			{
				upstr = upstr.substr(0,upmaxlen);
			}
			
			if(uploadTQosStr.length + upstr.length >= upmaxlen)//如果加上最新的一条log大于2k就上报之前的，该调向下积累
//			if(true)
			{
				var argc1:Object = {"e_c":"TQOS|"+ uploadTQosStr,"c_t":100};
				ExternalInterface.call("EAS.SendClick",argc1);
				uploadTQosStr = upstr;				
			}
			else
			{
				uploadTQosStr = uploadTQosStr + "..." + upstr;				
			}
			return;
		}
	}
}