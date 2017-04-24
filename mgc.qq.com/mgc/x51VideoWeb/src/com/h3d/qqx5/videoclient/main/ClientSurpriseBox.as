package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.modules.surprise_box.event.CEventOpenSurpriseBox;
	import com.h3d.qqx5.modules.surprise_box.event.CEventQuerySurpriseBox;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.modules.surprise_box.share.SurpriseBoxStatus;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.QuerySurpriseBoxErrorCode;
	import com.h3d.qqx5.videoclient.data.SurpriseBoxRewardUI;
	import com.h3d.qqx5.videoclient.interfaces.IUISurpriseBox;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallbackInternal;

	public class ClientSurpriseBox
	{
		protected var m_client:IVideoClientInternal = null;
		protected var m_status:SurpriseBoxStatus = new SurpriseBoxStatus;
		protected var m_update_tick:Int64 = new Int64();
		
		public function ClientSurpriseBox(client:IVideoClientInternal)
		{
			m_client = client;
		}
		
		public function Update():void
		{
			
		}
		public function OnStopLive():void
		{
			
		}
		public function OnStartLive():void
		{
			
		}
		
		public function TryOpen():void
		{
			var ev:CEventOpenSurpriseBox = new  CEventOpenSurpriseBox;
			ev.room_id = Globals.SelfRoomID;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		public function QueryReward():void
		{
			if(!m_status.active)
			{
				NotifyQueryResult(QuerySurpriseBoxErrorCode.QSBEC_NoActivity, new Array);
			}
			else
			{
				var ev:CEventQuerySurpriseBox = new CEventQuerySurpriseBox;
				ev.roomid = Globals.SelfRoomID;
				m_client.SendEvent(ev,Globals.SelfRoomID);
			}
		}
		
		public function UpdateStatus(status:SurpriseBoxStatus,activity_id:int):void
		{
			m_status = status;
			var cb:IUISurpriseBox = GetCallBack();
			if(cb != null)
			{
				cb.OnUpdateSurpriseBoxStatus(activity_id,status.active,status.precent,status.left_open_times,status.cd_seconds,status.need_flower,status.total_cd_seconds,status.nest_left_open_times);
			}
		}
		
		public function NotifyOpenResult(err:int):void
		{
			var cb:IUISurpriseBox = GetCallBack();
			var rwdFouUIArr:Array = new Array();
			if(cb != null)
			{
				cb.OnOpenSurpriseBoxResult(err);
			}
		}
		
		public function NotifyQueryResult(ec:int,reward:Array):void
		{

		}
		
		public function OnEnterRoom():void
		{
			
		}
		
		public function OnLeaveRoom():void 
		{
			
		}
		protected function NotifyStatusToUI():void
		{
			
		}
		protected function GetCallBack():IUISurpriseBox
		{
			var vcb:IVideoClientLogicCallback = m_client.GetUICallback();
			if(vcb != null)
				return vcb.GetSurpriseBoxCallBack();
			else
				return null;
		}
		protected function CheckStatusForNextRound():void
		{
			
		}
	}
}