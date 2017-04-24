package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.common.event.CEventDianZan;
	import com.h3d.qqx5.common.event.CEventDianZanResult;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.videoclient.data.VideoClientType;
	import com.h3d.qqx5.videoclient.data.VideoRoomActivityType;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.junkbyte.console.Cc;
	
	import flash.utils.Dictionary;

	public class ClientTalentShow
	{
		private var m_client:IVideoClientInternal;
		public function ClientTalentShow(vc:IVideoClientInternal, vct:int)
		{
			m_client = vc;
		}
		
		public function StartTalentShow():void
		{
			
		}
		public function StopTalentShow():void
		{
			
		}
		public function LoadTalentShowScore():void
		{
			
		}
		public function ScoreTalentShow(scores:Array):void
		{
			
		}
		public function HandleServerEvent(ev:INetMessage):void
		{
				var clsid:int = ev.CLSID();
				Globals.s_logger.log("ClientTalenShow::HandleServerEvent clsid:" + clsid);
				switch(clsid)
				{
					case EEventIDVideoRoom.CLSID_CEventStartTalentShowMatch:
						HandleCEventStartTalentShowMatch(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventStopTalentShowMatch:
						HandleCEventStopTalentShowMatch(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventAssignTalentJudgeRes:
						HandleCEventAssignTalentJudgeRes(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventBroadcastAssignTalentJudgeMsg:
						HandleCEventBroadcastAssignTalentJudgeMsg(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventTalentShowStateChangeNotify:
						HandleCEventTalentShowStateChangeNotify(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventLoadTalentShowScoreRes:
						HandleCEventLoadTalentShowScoreRes(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventScoreTalentShowBroadcast:
						HandleCEventScoreTalentShowBroadcast(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventSyncTalentShowJudge:
						HandleCEventSyncTalentShowJudge(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventGetJudgeTypes:
						HandleCEventGetJudgeTypes(ev);
						break;
					case EEventIDVideoRoom.CLSID_CEventDianZanResult:
						HandleCEventDianZanResult(ev);
						break;
					default:
						break;
				}

		}
		public function GetTalentShowState( activity_type:int = 0 ):int
		{
			return 0;
		}
		public function SetTalentShowState(tss:int ):void
		{
			
		}
		public function SetActivityType(at:int):void
		{
			
		}
		public function SetJudgeType(type:int ):void
		{
			
		}
		public function SetCurrentTalentShowActivityID(talentshow_id:int ):void
		{
			
		}
		public function GetCurrentTalentShowActivityID():int
		{
			return 0;
		}
		public function GetTalentShowIntroUrl() :String
		{
			return null;
		}
		public function AddJudgeType(zone_and_nick:Dictionary, type:int ):void
		{
			
		}
		public function DelJudgeType(zone_and_nick:Dictionary):void
		{
			
		}
		//typedef std::map<std::pair<std::string, std::string>, int> TalentShowJudgeTypes;
		//public function SetJudgeTypes(judge_types:TalentShowJudgeTypes):void
		public function SetJudgeTypes(judge_types:Dictionary):void
		{
			
		}
		public function GetJudgeType(zone_name:String,player_name:String):int
		{
			return 0;
		}
		public function ClearJudgeTypes():void
		{
			
		}		
		//舞团争霸
		public function DianZan():void
		{
			var ev:CEventDianZan = new CEventDianZan ;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
//		public function GetGuildChampionIntroUrl():String;
//		{
//			return null;
//		}
		
		public function LoadGuildChampionRank():void
		{
			//在cx5videoclient里实现了
		}
		public function GetActivityType():int
		{
			return 0;
		}
		public function LoadTalentShowConfig(config_file_name:String):void
		{
			
		}
		private function HandleCEventStartTalentShowMatch(ev:INetMessage):void
		{
			
		}
		private function HandleCEventStopTalentShowMatch(ev:INetMessage):void
		{
		}
		private function HandleCEventAssignTalentJudgeRes(ev:INetMessage):void
		{
			
		}
		private function HandleCEventBroadcastAssignTalentJudgeMsg(ev:INetMessage):void
		{
			
		}
		private function HandleCEventTalentShowStateChangeNotify(ev:INetMessage):void
		{
			
		}
		private function HandleCEventLoadTalentShowScoreRes(ev:INetMessage):void
		{
			
		}
		private function HandleCEventScoreTalentShowBroadcast(ev:INetMessage):void
		{
			
		}
		private function HandleCEventSyncTalentShowJudge(ev:INetMessage):void
		{
			
		}
		private function HandleCEventGetJudgeTypes(ev:INetMessage):void
		{
			
		}
		private function HandleCEventDianZanResult(ev:INetMessage):void
		{
			var  evt:CEventDianZanResult = ev as CEventDianZanResult;
			m_client.GetUICallback().OnDianZanResult(VideoResultType.VREST_Normal, evt.result,evt.anchor_name);
		}

	}
}