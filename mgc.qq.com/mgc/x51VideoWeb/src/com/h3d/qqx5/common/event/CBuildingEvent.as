package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.MessageDispacher;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.ProtoBufSerializer;
	import com.h3d.qqx5.common.SingletonMgr;
	import flash.utils.ByteArray;
	import flash.utils.getTimer;

	public class CBuildingEvent
	{
		public function CBuildingEvent(clsid:int,frag_count:int)
		{
			m_clsid = clsid;
			m_wait_frag_count = frag_count;
			m_check_sum = (frag_count>0?frag_count*(frag_count-1)/2:0);
			m_buf.buffer().clear();
		}
		
		public function PutFrag(index:int, n:uint):ByteArray
		{
			var p:ByteArray= new ByteArray;
			m_buf.buffer().writeBytes(p,index*CEventFragmentManager.FRAGMENTSIZE,n);
			m_update_time = getTimer();
			m_wait_frag_count--;
			m_check_sum -= index;
			return p;
		}
		public function FinishBuild():Boolean
		{
			return m_wait_frag_count==0 && m_check_sum==0;
		}
		public function IsTimeOut():Boolean
		{
			return (getTimer()-m_update_time) > CEventFragmentManager.TIMEOUT_MS;
		}
		public function CreateOriginalEvent():INetMessage
		{
			if (FinishBuild() )
			{
				var ev:INetMessage = new INetMessage;
				
				ev = SingletonMgr.Instance().GetMsgFactory().CreateMessage(m_clsid);
				if(ev)
				{
					ProtoBufSerializer.FromStream(ev,m_buf);
					return ev;
				}
				else
				{
					trace("CreateOriginalEvent got NULL event.clsid:",m_clsid);
				}
			}
			return null;
		}
		
		private var m_clsid:int;
		private var m_wait_frag_count:int;
		private var m_check_sum:int;
		private var m_update_time:Number;
		private var m_buf:NetBuffer = new NetBuffer;
	}
}