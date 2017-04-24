package com.h3d.qqx5.videoclient.vote
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.CEventCheckNickOnLogin;
	import com.h3d.qqx5.common.event.CEventEnterRoomNotifyVoteInfo;
	import com.h3d.qqx5.common.event.CEventGetVideoVoteHistory;
	import com.h3d.qqx5.common.event.CEventGetVideoVoteStartInfo;
	import com.h3d.qqx5.common.event.CEventGetVideoVoteStartInfoRes;
	import com.h3d.qqx5.common.event.CEventTakeVideoVote;
	import com.h3d.qqx5.common.event.CEventVideoVoteHistoryRes;
	import com.h3d.qqx5.common.event.CEventVideoVoteRes;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;
	import com.h3d.qqx5.common.event.eventid.VideoVoteOperation;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.tqos.TQOSVote;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteStartInfo;
	import com.h3d.qqx5.videoclient.data.VideoVoteEntryForUI;
	import com.h3d.qqx5.videoclient.data.VideoVoteErrorCode;
	import com.h3d.qqx5.videoclient.data.VideoVoteInfoForUI;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	import com.junkbyte.console.Cc;

	/**
	 * @author liuchui
	 */
	public class CVideoVoteClient
	{
		private var m_video_client:IVideoClientInternal;
		private var m_is_startvote:Boolean;
		private var m_has_voted:Boolean;		
		private var m_vote_info:VideoVoteInfo = new VideoVoteInfo;
		private var m_selects:Array = new Array;
		
		public function CVideoVoteClient(video_client:IVideoClientInternal)
		{
			m_video_client = video_client;
			m_is_startvote = false;
			m_has_voted = false;
		}
		
		// 发起投票
		public function StartVote(vote_info:VideoVoteStartInfo):void
		{
			// web不提供该功能
		}
		// 停止投票
		public function StopVote():void
		{
			// web不提供该功能
		}
		// 投票
		public function TakeVote(select:Array):void
		{
			if(select.length == 0)
				return;
			
			if (m_vote_info.vote_id.toNumber() == -1)
			{
				//Globals.s_logger.error("TakeVote, " + "No vote info when taking vote!");
				Globals.s_logger.error("TakeVote, " + "No vote info when taking vote!");
				return;
			}
			
			// 选择的索引不能重复
			for(var i:int = 0; i < select.length; i++)
			{
				for (var j:int = i+1; j < select.length; j++)
				{
					if (select[i] == select[j])
					{
						//Globals.s_logger.error("TakeVote, " +  "select index repeat");
						Globals.s_logger.error("TakeVote, " +  "select index repeat");
						var ui:IVideoClientLogicCallback = m_video_client.GetUICallback();
						ui.OnTakeVoteRes(VideoResultType.VREST_Normal, VideoVoteErrorCode.VideoVoteErr_ParamError);
						return;
					}
				}
			}
			
			var event:CEventTakeVideoVote = new CEventTakeVideoVote;
			event.vote_id = m_vote_info.vote_id;
			event.selects = select;
			SendEvent(event);
		}
		
		public function CheckNickOnLogin():void
		{
			var event:CEventCheckNickOnLogin = new CEventCheckNickOnLogin();
			SendEvent(event);
		}
		
		
		// 取得投票历史
		public function GetVoteHistory():void
		{
			var event:CEventGetVideoVoteHistory = new CEventGetVideoVoteHistory ;
			SendEvent(event);
		}
		// 取得投票内容
		public function GetVoteStartInfo():void
		{
			var event:CEventGetVideoVoteStartInfo = new CEventGetVideoVoteStartInfo;
			SendEvent(event);
		}
		
		// 房间有否有发起投票
		public function IsStartVote():Boolean
		{
			m_video_client.GetUICallback().OnIsStartVoteRes(m_is_startvote);
			return m_is_startvote;
		}
		// 自己是否投过票
		public function HasVoted():Boolean
		{
			m_video_client.GetUICallback().OnHasVotedRes(m_has_voted);
			return m_has_voted;
		}
		public function SetIsStartVote(started:Boolean):void
		{
			m_is_startvote = started;
		}
		public function SetHasVoted(voted:Boolean):void
		{
			m_has_voted = voted;
		}
		public function HandleServerEvent(event:INetMessage):Boolean
		{
			var clsid:int = event.CLSID();
			Globals.s_logger.log("CVideoVoteClient::HandleServerEvent clsid:" + clsid);
			if (clsid <= VideoVoteEvent.EventVideoVoteStart || clsid >= VideoVoteEvent.EventVideoVoteEnd)
				return false;
			
			// process event
			switch (clsid)
			{
				case VideoVoteEvent.CLSID_CEventVideoVoteHistoryRes:
					HandleCEventVideoViteHistory(event);
					break;
				case VideoVoteEvent.CLSID_CEventVideoVoteRes:
					HandleCEventVideoVoteRes(event);
					break;
				case VideoVoteEvent.CLSID_CEventGetVideoVoteStartInfoRes:
					HandleCEventGetVideoVoteStartInfoRes(event);
					break;
				case VideoVoteEvent.CLSID_CEventEnterRoomNotifyVoteInfo:
					HandleCEventEnterRoomNotifyVoteInfo(event);
					break;
			}
			
			return true;
		}
		
		private function SendEvent(event:INetMessage):void
		{
			m_video_client.SendEvent(event, Globals.SelfRoomID);
		}
		private var Pattern:RegExp = /\\/g;
		private function ToVideoVoteInfoForUI(info:VideoVoteInfo):VideoVoteInfoForUI
		{
			var t_info:VideoVoteInfoForUI = new VideoVoteInfoForUI;
			t_info.vote_id = info.vote_id.toString();
			t_info.vote_topic = info.vote_topic.replace(Pattern,"\\\\");
			t_info.anchor = info.anchor.toString();
			t_info.anchor_name = info.anchor_name.replace(Pattern,"\\\\");
			t_info.start_voting_time = info.start_voting_time;
			t_info.end_voting_time = info.end_voting_time;
			t_info.optional_max_count = info.optional_max_count;
			
			for(var i:int = 0; i < info.vote_entries.length; ++i)
			{
				var entry:VideoVoteEntryForUI = new VideoVoteEntryForUI;
				entry.content = info.vote_entries[i].content.replace(Pattern,"\\\\");
				entry.curr_count = info.vote_entries[i].curr_count;
				t_info.vote_entries.push(entry);
			}
			return t_info;
		}
		
		private function HandleCEventEnterRoomNotifyVoteInfo(ev:INetMessage ):void
		{
			var evt:CEventEnterRoomNotifyVoteInfo = ev as CEventEnterRoomNotifyVoteInfo;
			//			//m_base.GetVoteClient().SetIsStartVote(evt.vote_id.equal());
			SetIsStartVote(evt.vote_id.toString() == "-1");
			if(evt.selects.length == 0)
				SetHasVoted(false);
			else
				SetHasVoted(true);
			var tmp:VideoVoteInfoForUI = new VideoVoteInfoForUI;
			var hasVote:int = 0;//有投票
			m_video_client.GetUICallback().OnAnchorStartVote(hasVote,tmp);
			
		}
		
		private function HandleCEventVideoViteHistory(event:INetMessage):void
		{
			var ev:CEventVideoVoteHistoryRes = event as CEventVideoVoteHistoryRes;
			var vote_history:Array = new Array;
			for(var i:int = 0; i < ev.vote_infos.size(); ++i)
			{
				var s_info:VideoVoteInfo = ev.vote_infos[i] as VideoVoteInfo;
				vote_history.push(ToVideoVoteInfoForUI(s_info));
			}
			// web不提供该功能
			//m_video_client.GetUICallback().OnVoteHistory(ev.result, vote_history);
		}
		private function HandleCEventVideoVoteRes(event:INetMessage):void
		{
			var ev:CEventVideoVoteRes = event as CEventVideoVoteRes;
			var ui:IVideoClientLogicCallback = m_video_client.GetUICallback();
			if (ev.operation == VideoVoteOperation.VideoVoteOper_Start)
			{
				// web不提供该功能
				//ui->OnStartVoteRes(ev->m_result);
			}
			else if(ev.operation == VideoVoteOperation.VideoVoteOper_Take)
			{
				ui.OnTakeVoteRes(VideoResultType.VREST_Normal, ev.result);
			}
			else if(ev.operation == VideoVoteOperation.VideoVoteOper_Stop)
			{
				//web不提供该功能
				m_is_startvote = false;
				//ui->OnStopVoteRes(ev->m_result);
				ui.OnAnchorStopVote();
				
			}
			
			//tqos上报 begin
			var tqos:TQOSVote = new TQOSVote();
			tqos.nQQ = this.m_video_client.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nRoomId = Globals.SelfRoomID;
			tqos.nErrorCode = ev.operation;
			tqos.StrRoomServerIP = this.m_video_client.GetCallCenter().GetRPip();
			tqos.Response();
			//tqos上报 end
		}
		private function HandleCEventGetVideoVoteStartInfoRes(event:INetMessage):void
		{
			var ev:CEventGetVideoVoteStartInfoRes = event as CEventGetVideoVoteStartInfoRes;
			
			if (ev.result == VideoVoteErrorCode.VideoVoteErr_Success)
			{
				m_vote_info = ev.vote_info;
				m_is_startvote = true;
				
				m_selects = ev.selects;
				if (m_selects.length == 0)
					m_has_voted = false;
				else
					m_has_voted = true;
			}
			else if(ev.result == VideoVoteErrorCode.VideoVoteErr_LastStartInfo)
			{
				m_vote_info = ev.vote_info;
				m_is_startvote = false;
				m_selects = new Array;
				m_has_voted = false;
			}
			else if(ev.result == VideoVoteErrorCode.VideoVoteErr_Broadcast)
			{
				m_vote_info = ev.vote_info;
				m_is_startvote = true;
				m_selects = new Array;
				m_has_voted = false;
				
				// web不提供该功能
				if (m_video_client.GetAnchor())
				{
					if (m_video_client.GetAnchor().GetVideoAccount().pstid.equal(ev.vote_info.anchor ) )
						return;
				}
				var hasNewVote:int = 1;//有新投票
				if( m_video_client.GetIsGuest() == true)//游客,只显示红点
					hasNewVote = 0;
				
				m_video_client.GetUICallback().OnAnchorStartVote(hasNewVote, ToVideoVoteInfoForUI(m_vote_info));
			}
			else
			{
				m_has_voted = false;
				m_is_startvote = false;
			}
			
			//如果是12号返回码就不推送
			if(ev.result != VideoVoteErrorCode.VideoVoteErr_Broadcast)
				m_video_client.GetUICallback().OnGetVideoStartInfo(VideoResultType.VREST_Normal, ev.result, ToVideoVoteInfoForUI(ev.vote_info), ev.selects);
		}
	}	
}