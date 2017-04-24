package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.videoclient.interfaces.IConcertClient;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.main.CVideoClientBase;
	public class CConcertClient implements IConcertClient
	{
		public function CConcertClient(vc:IVideoClientInternal, base:CVideoClientBase)
		{
			m_base = base;
			m_client = vc;
			m_has_ticket = false;
			m_is_started = false;
		}
		
		public function SetBuyConcertTicketURL( url:String):void
		{
			m_buy_concert_ticket_url = url;
		}
		
		public function SetConcertStaticImageURL(url:String):void
		{
			m_concert_static_image_url = url;
		}
		
		public function SetHasTicket(has_ticket:Boolean):void
		{
			m_has_ticket = has_ticket;
		}
		
		public function SetIsStarted( is_started:Boolean):void
		{
			m_is_started = is_started;
		}
		
		public function  IsConcert():Boolean
		{
			if ( !m_client.IsInRoom() )
				return false;
			
			return m_base.IsConcert();
		}
		
		// 获取演唱会购票url
		public function GetBuyConcertTicketURL():String
		{
			return m_buy_concert_ticket_url;
		}
		
		// 获取演唱会无票玩家在房间内显示的图片url
		public function GetConcertStaticImageURL():String
		{
			return m_concert_static_image_url;
		}
		
		// 玩家是否有演唱会门票
		public function  HasConcertTicket():Boolean
		{
			return m_has_ticket;
		}
		
		// 演唱会当前状态，是否开启
		public function IsConcertStarted():Boolean
		{
			return m_is_started;
		}
		
		private var m_base:CVideoClientBase;
		private var m_client:IVideoClientInternal;
		
		private var  m_buy_concert_ticket_url:String;
		private var  m_concert_static_image_url:String;
		private var  m_has_ticket:Boolean;
		private var  m_is_started:Boolean;
	}
}