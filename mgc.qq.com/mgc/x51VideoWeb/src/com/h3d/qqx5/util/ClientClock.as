package com.h3d.qqx5.util
{
	import flash.utils.getTimer;

	/**
	 * @author liuchui
	 */
	public class ClientClock
	{
		private var server_time_begin:Number = 0;
		private var local_tick_begin:int = 0;
		
		public function ClientClock()
		{
			server_time_begin = 0;
			local_tick_begin = 0;
		}		
		
		public function InitClock(server_time:int) : void
		{
			server_time_begin = server_time * 1000.0;
			local_tick_begin = getTimer();
		}
		
		public function GetTickCount():Number
		{
			return server_time_begin + (getTimer() - local_tick_begin);
		}
		
		public function GetTime() : Date
		{
			var d:Date = new Date;
			d.setTime(GetTickCount());
			return d;
		}
	}	
}