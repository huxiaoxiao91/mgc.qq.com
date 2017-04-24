package com.h3d.qqx5
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getTimer;

	/*
	 *优化as-js的操作 
	*/
	public class OperaCallOptimize
	{
		private var m_interval:int;
		private var m_maxCall:int;
		private var m_maxLength:int;
		private var m_callback:int;//回调操作码
		private var m_calllist:Array;//存储回调每一次的参数
		private var m_last_time:int ;
		private var m_callcnt:int ;
		private var m_now_time:uint;
		private var m_jscallback:ExternalCallbakInterface;
		private var m_time_since_last_second:int = 0;
		private var m_timeidx:int = 0;//hss
		/*
		interval:int:间隔时间，不到间隔时间的时候不再发给js
		maxCall:int:一分钟内最多发送次数，超过次数不再发送给js
		maxLength:int:延迟发送的队列最大长度，超过这个长度的丢弃
		op_type:int:待优化的操作码
		*/
		public function OperaCallOptimize(interval:int,maxCall:int,maxLength:int,callback:int)
		{
			m_calllist = new Array();
			m_interval = interval;
			m_maxCall = maxCall;
			m_maxLength = maxLength;
			m_callback = callback;
			m_last_time = 0;
			m_now_time = 0;
			m_jscallback = new ExternalCallbakInterface();
			//如果需要实时把该对象从计时器中删除，取消hss几处的mark
			TimerManager.getInstance().PushTimeList(this);
			
		}
		
		
		public function PushOpreCall(obj:Object,isSelf:Boolean = false):void
		{
			if(isSelf == true )
			{
				m_calllist.push(obj);
				return ;
			}
			//超过最大队列长队的时候不push
			if (m_calllist.length > m_maxLength) {
				if(obj.op_type == VideoWebOperationType.VOT_OnReceiveChatMsg){
					if(obj.msg && obj.msg.res_forbid_public_chat){
						m_calllist.push(obj);
						Globals.s_logger.debug("禁言：obj.msg.res_forbid_public_chat:"+obj.msg.res_forbid_public_chat);
						return ;
					}
				}
				
				Globals.s_logger.debug("MSG ===>>> 超出消息最大队列 自动遗弃消息：" + JSON.stringify(obj));
				return ;
			}
			m_calllist.push(obj);
//			if(m_calllist.length == 1)//hss
//				m_timeidx = OperaCallOptimizeTime.getInstance().PushTimeList(this);//hss
		}
		
		public function Update( interval:int):void
		{
			if( m_calllist.length < 1)
				return ;
			var tmp_time:int = flash.utils.getTimer();
			var delta_time:int = tmp_time - m_last_time;
			m_time_since_last_second += delta_time;
			if(m_time_since_last_second > 1)
			{
				//离上一次计算超过1秒
				m_callcnt = 0;
				m_time_since_last_second = 0;
			}
			//时间间隔内 超过次数限制就不再发送
			if(delta_time< m_interval)
			{
				//时间间隔内，不发
				return;	
			}
			if(m_callcnt > m_maxCall)
			{
				//大于美妙最大数量不发
				return;
			}
			
			m_last_time = tmp_time;
			
			//请求回调函数。
			if(m_callback == 46)
			{
				m_jscallback.Apply(m_callback,m_calllist.shift(),false,true);
			}
			else
			{
				m_jscallback.Apply(m_callback,m_calllist.shift(),false);
			}
			
			++m_callcnt;
//			if(m_calllist.length == 0)//hss
//				OperaCallOptimizeTime.getInstance().ShiftTimeList(this,m_timeidx);//hss
		}
		
		public function SetTimerIndex( index:int):void
		{
			//m_timeridx = index;
		}
	}
}