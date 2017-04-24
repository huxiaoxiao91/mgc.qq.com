package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.comdata.VideoChannelType;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.CEventConcertPlaybackRoomGetRoomListRes;
	import com.h3d.qqx5.common.event.CEventStartConcertPlaybackRes;
	import com.h3d.qqx5.common.event.eventid.PlaybackEventID;
	import com.h3d.qqx5.videoclient.data.ERewardType;
	import com.h3d.qqx5.videoclient.data.BoxRewardForUI;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.tqos.TQOSVote;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWeb;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteStartInfo;
	import com.h3d.qqx5.videoclient.data.VideoVoteEntryForUI;
	import com.h3d.qqx5.videoclient.data.VideoVoteErrorCode;
	import com.h3d.qqx5.videoclient.data.VideoVoteInfoForUI;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	
	public class PlaybackClient
	{
		
		private var m_client:IVideoClientInternal;
		public function PlaybackClient(_m_client:IVideoClientInternal)
		{
			m_client = _m_client;
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			var clsid:int = ev.CLSID();
			switch(clsid)
			{
				case PlaybackEventID.CLSID_CEventConcertPlaybackRoomGetRoomListRes:
					handleConcertPlaybackRoomGetRoomListRes(ev);
					break;
				case PlaybackEventID.CLSID_CEventStartConcertPlaybackRes:
					handleStartConcertPlaybackRes(ev);
					break;
				default:
					break;
			}
			
			return true;
		}
		
		
		//获取演唱会回放房间列表结果事件
		private function handleConcertPlaybackRoomGetRoomListRes(ev:INetMessage):void
		{
			var evt:CEventConcertPlaybackRoomGetRoomListRes = ev as CEventConcertPlaybackRoomGetRoomListRes;
			Globals.s_logger.debug("handleConcertPlaybackRoomGetRoomListRes 41418 =  " + JSON.stringify(evt));
			
			m_client.GetUICallback().handleConcertPlaybackRoomGetRoomListRes(evt.total_cnt, evt.rooms);
		}
		//开始观看演唱会回放结果事件
		private function handleStartConcertPlaybackRes(ev:INetMessage):void
		{
			var evt:CEventStartConcertPlaybackRes = ev as CEventStartConcertPlaybackRes;
			Globals.s_logger.debug("handleStartConcertPlaybackRes 41420 =  " + JSON.stringify(evt));
			
			m_client.GetUICallback().handleStartConcertPlaybackRes(evt.error_code, evt.concert_id, evt.video_url);
		}
	
	}
}