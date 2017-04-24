package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.event.CEventOpenSurpriseBoxRes;
	import com.h3d.qqx5.modules.surprise_box.event.CEventQuerySurpriseBoxRes;
	import com.h3d.qqx5.modules.surprise_box.event.CEventUpdateSurpriseBoxStatus;
	import com.h3d.qqx5.modules.surprise_box.event.VideoSurpriseBoxEventID;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.videoclient.data.OpenSurpriseBoxErrorCode;
	import com.h3d.qqx5.videoclient.interfaces.IClientSurpriseBoxManager;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;

	public class ClientSurpriseBoxManager implements IClientSurpriseBoxManager
	{
		protected var m_client:IVideoClientInternal = null;
		protected var m_box:ClientSurpriseBox = null;
		protected var m_last_query_code:int = 0;
		protected var m_activity_id:int = 0;
		protected var m_last_query_reward:Array;
		
		public function ClientSurpriseBoxManager(vct:int, client:IVideoClientInternal)
		{
			m_client = client;
			m_box = new ClientSurpriseBox(client);
		}
		
		public function Update():void
		{
			
		}
		
		public function OnStopLive():void
		{
			
		}
		
		//查询惊喜宝箱奖励
		public function QueryReward():void
		{
			m_box.QueryReward();
		}
		
		public function OnStartLive():void
		{
			
		}
		
		public function OnEnterRoom():void
		{
			
		}
		
		public function OnLeaveRoom():void
		{
			
		}
		
		public function OpenSurpriseBox():void
		{
			m_box.TryOpen();
		}
		
		public function GetActivityID():int
		{
			return m_activity_id;
		}
		
		public function OnEventLimit(clsid:int):void
		{
			
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			var clsid:int = ev.CLSID();
			Globals.s_logger.log("ClientSurpriseBoxManager::HandleServerEvent clsid:" + clsid);
			switch(clsid)
			{
				case VideoSurpriseBoxEventID.CLSID_CEventUpdateSurpriseBoxStatus:
					HandleUpdateEvent(ev);
					break;
				case VideoSurpriseBoxEventID.CLSID_CEventOpenSurpriseBoxRes:
					HandleOpenResultEvent(ev);
					break;
//				case VideoSurpriseBoxEventID.CLSID_CEventQuerySurpriseBoxRes:
//					HandleQueryResultEvent(ev);
//					break;
			}
			
			return false;
		}
		

		private function HandleUpdateEvent(ev:INetMessage):void
		{
			var evt:CEventUpdateSurpriseBoxStatus = ev as CEventUpdateSurpriseBoxStatus;
			if(evt == null)
				return;
			
			m_box.UpdateStatus(evt.box_status,evt.activity_id);
			m_activity_id = evt.activity_id;
		}
		
		private function HandleOpenResultEvent(ev:INetMessage):void
		{
			var evt:CEventOpenSurpriseBoxRes = ev as CEventOpenSurpriseBoxRes;
			if(null != m_box)
			{
				var empty_rewards:RewardBasicItem = new RewardBasicItem;
				m_box.NotifyOpenResult(evt.error);
			}
		}
	}
}