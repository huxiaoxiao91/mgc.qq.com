package com.h3d.qqx5
{
	import avmplus.FLASH10_FLAGS;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	//总计时器
	public class TimerManager
	{
		private const INTERVAL:int = 25;//计时器的频率，单位毫秒
		private var m_timer:Timer;
		private var m_timerCnt:int;
		private var m_CallList:Array = new Array();
		private var m_lasttime:int;
		private static  var instance:TimerManager = new TimerManager();  
		function TimerManager()
		{
			if (instance) 
			{  
				throw new Error("Instance is alreally exist");  
			}
			//开始计时
			m_timer = new Timer(INTERVAL);
			m_timer.addEventListener(TimerEvent.TIMER,Update);
			m_timer.start();
			m_lasttime = flash.utils.getTimer();
			m_timerCnt = 0;
		}
				
		public static function getInstance():TimerManager 
		{  
			if(instance == null)
			{  
				instance = new TimerManager();  
			}  
			return instance;
		}  
		
		public function PushTimeList(obj:Object):int
		{
			m_CallList.push(obj);
			return m_timerCnt++;
		}
		
		public function ShiftTimeList(obj:Object,idx:int):void
		{
			m_CallList.splice(idx,1);
			for( var index:int= idx ; index < m_CallList.length; index++)
			{
				m_CallList[index].SetTimerIndex(index);
			}
			--m_timerCnt;
		}
		
		public function Update(e:Event):void
		{
			//用自己统计的间隔时间
			var deltatime:int = flash.utils.getTimer() - m_lasttime;
			for (var call:int= 0 ; call < m_CallList.length; call ++)
			{
				m_CallList[call].Update(deltatime);
			}
			m_lasttime = flash.utils.getTimer() ;
		}
	}
}