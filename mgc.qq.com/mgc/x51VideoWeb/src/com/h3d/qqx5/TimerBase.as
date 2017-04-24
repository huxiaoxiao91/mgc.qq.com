package com.h3d.qqx5
{
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class TimerBase
	{
		private var m_intervaltime:int;//计时的间隔
		private var m_timeridx:int;//对于总计时器的索引
		private var m_lasttime:int;//从上次开始计时，已经经过的时间
		private var m_func:Function;
		public function TimerBase(interval:int,fun:Function)
		{
			m_intervaltime = interval;
			m_func = fun;
			m_timeridx =0 ;
		}		
		
		//m_timeridx为0的timer不会被停止。（第一个创建的timer即是0）
		public function StartTimer():void
		{
			if( m_timeridx ==0 )
				m_timeridx = TimerManager.getInstance().PushTimeList(this);
		}	
		
		public function StopTimer():void
		{
			if(m_timeridx !=0 )
			{
				TimerManager.getInstance().ShiftTimeList(this,m_timeridx);
				m_timeridx = 0;
			}
		}	
		
		public function Update(interval:int):void
		{
			m_lasttime += interval;
			if(m_intervaltime <= m_lasttime)//已经达到一个间隔的时间了
			{
				m_lasttime = 0;
				m_func();
			}
		}	
		public function SetTimerIndex( index:int):void
		{
			m_timeridx = index;
		}
	}
}