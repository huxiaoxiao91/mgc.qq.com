package com.h3d.qqx5
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class OperaCallOptimizeTime
	{
		private var m_timer:Timer;
		private var m_CallList:Array = new Array();
		private static  var instance:OperaCallOptimizeTime = new OperaCallOptimizeTime();  
		public function OperaCallOptimizeTime()
		{
			if (instance) 
			{  
				throw new Error("Instance is alreally exist");  
			}
			//开始计时
			m_timer = new Timer(50);
			m_timer.addEventListener(TimerEvent.TIMER,Update);
			m_timer.start();
		}
				
		public static function getInstance():OperaCallOptimizeTime 
		{  
			if(instance == null)
			{  
				instance = new OperaCallOptimizeTime();  
			}  
			return instance;
		}  
		
		public function PushTimeList(obj:OperaCallOptimize):void
		{
			m_CallList.push(obj);
		}
		
		public function ShiftTimeList(obj:OperaCallOptimize):void
		{
			m_CallList.(obj);
		}
		
		public function Update(e:Event):void
		{
			for (var call:int= 0 ; call < m_CallList.length; call ++)
			{
				m_CallList[call].QuerySend();
			}
		}
	}
}