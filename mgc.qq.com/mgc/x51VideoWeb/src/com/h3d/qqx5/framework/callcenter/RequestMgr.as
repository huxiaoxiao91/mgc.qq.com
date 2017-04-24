package com.h3d.qqx5.framework.callcenter
{
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.MessageDispacher;
	
	import flash.utils.Dictionary;
	import flash.utils.getTimer;

	/**
	 * @author Administrator
	 */
	public class RequestMgr
	{
		private var m_requests:Array = new Array;
		private var m_need_wait_response_eventids:Dictionary = new Dictionary;
		private var m_serialID:int = 0;
		private var _dispacth:MessageDispacher;
		private const _request_timeout_tick:int = 15000;
		
		public function RequestMgr(dispatch:MessageDispacher)
		{
			_dispacth = dispatch;
		}
		
		public function addNeedResponseEventID(reqId:int, ressponseID:int):void
		{
			m_need_wait_response_eventids[reqId] = ressponseID;
		}
		
		public function ProcessRequest(msg : INetMessage) : int
		{
			var serialid:int = (++m_serialID);
			if(serialid < 0)
			{
				serialid = 1;
				m_serialID = 1;
			}
			if(IsEventNeedWait(msg))
			{
				AddRequest(msg, serialid);
			}
			
			return serialid;
		}
		
		public function UpdateRequestMgr() : void
		{
			var curr_tick:int = flash.utils.getTimer();
			for(var i : int = 0; i < m_requests.length;)
			{
				var info:RequestInfo = m_requests[i] as RequestInfo;
				if(curr_tick - info.start_tick > _request_timeout_tick)
				{
					_dispacth.dispatch2(VideoResultType.VREST_TimeOut, info.response_clsid, null);
					m_requests.splice(i, 1);
				}			
				else
				{
					++i;
				}
			}
		}
		
		public function ProcessResponse(msg:INetMessage, serialID:int) : void
		{
			for(var i : int = 0; i < m_requests.length; ++i)
			{
				var info:RequestInfo = m_requests[i] as RequestInfo;
				if(info.serialid == serialID &&
					info.response_clsid == msg.CLSID())
				{
					m_requests.splice(i, 1);
					return;
				}
			}
		}
		
		public function OnLinkClosed() : void
		{
			for(var i : int = 0; i < m_requests.length; ++i)
			{
				var info:RequestInfo = m_requests[i] as RequestInfo;
				_dispacth.dispatch2(VideoResultType.VREST_ConnectionClosed, info.response_clsid, null);
			}
			
			m_requests.splice(0, m_requests.length);
		}
		
		private function IsEventNeedWait(msg:INetMessage) : Boolean
		{
			var clsid:int = msg.CLSID();
			if(m_need_wait_response_eventids[clsid] == null)
			{
				return false;
			}
			else
			{
				return true;
			}
		}
		
		private function  AddRequest(msg:INetMessage, serialID:int):void
		{
			var info:RequestInfo = new RequestInfo;
			info.serialid = serialID;
			info.request_clsid = msg.CLSID();
			info.response_clsid = m_need_wait_response_eventids[info.request_clsid];
			info.start_tick = flash.utils.getTimer();
			
			m_requests.push(info);
		}
	}	
}