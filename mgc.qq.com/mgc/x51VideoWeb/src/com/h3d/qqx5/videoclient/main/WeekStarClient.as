package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.VideoChannelType;
	import com.h3d.qqx5.common.event.CEventAnchorWeekStarLevelUpNotify;
	import com.h3d.qqx5.common.event.CEventAnchorWeekStarMatchSettleNotify;
	import com.h3d.qqx5.common.event.CEventRefreshWeekStarRankRes;
	import com.h3d.qqx5.common.event.CEventWeekStarConfigRsp;
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.tqos.TQOSVote;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoVoteStartInfo;
	import com.h3d.qqx5.videoclient.data.BoxRewardForUI;
	import com.h3d.qqx5.videoclient.data.ERewardType;
	import com.h3d.qqx5.videoclient.data.VideoVoteEntryForUI;
	import com.h3d.qqx5.videoclient.data.VideoVoteErrorCode;
	import com.h3d.qqx5.videoclient.data.VideoVoteInfoForUI;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWeb;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	
	public class WeekStarClient
	{
		
		private var m_client:IVideoClientInternal;
		public function WeekStarClient(_m_client:IVideoClientInternal)
		{
			m_client = _m_client;
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			var clsid:int = ev.CLSID();
			switch(clsid)
			{
				case WeekStarEventID.CLSID_CEventRefreshWeekStarRankRes:
					handleRefreshWeekStarRankRes(ev);
					break;
				case WeekStarEventID.CLSID_CEventWeekStarConfigRsp:
					handleWeekStarConfigRsp(ev);
					break;
				case WeekStarEventID.CLSID_CEventAnchorWeekStarLevelUpNotify:
					handleAnchorWeekStarLevelUpNotify(ev);
					break;
				case WeekStarEventID.CLSID_CEventAnchorWeekStarMatchSettleNotify:
					handleAnchorWeekStarMatchSettleNotify(ev);
					break;
				default:
					break;
			}
			
			return true;
		}
		//周星积分榜回复消息
		private function handleRefreshWeekStarRankRes(ev:INetMessage):void
		{
			var evt:CEventRefreshWeekStarRankRes = ev as CEventRefreshWeekStarRankRes;
			var contribute_player:Object = new Object;
			contribute_player.anchor_id = evt.contribute_player.anchor_id.toString();
			contribute_player.have_portrait = evt.contribute_player.have_portrait;
			contribute_player.player_contribution = evt.contribute_player.player_contribution;
			contribute_player.player_nick = evt.contribute_player.player_nick;
			contribute_player.player_pstid = evt.contribute_player.player_pstid.toString();
			contribute_player.session = evt.contribute_player.session;
			var rank:Array = new Array;
			for(var i:int = 0; i<evt.rank.length; i++)
			{
				rank[i] = {};
				rank[i].anchor_id = evt.rank[i].anchor_id.toString();
				rank[i].anchor_nick = evt.rank[i].anchor_nick;
				rank[i].anchor_status = evt.rank[i].anchor_status;
				rank[i].grade_name = evt.rank[i].grade_name;
				rank[i].onboard_time = evt.rank[i].onboard_time;
				rank[i].portrait_url = evt.rank[i].portrait_url;
				rank[i].room_id = evt.rank[i].room_id;
				rank[i].session = evt.rank[i].session;
				rank[i].star_light = evt.rank[i].star_light.toString();
				rank[i].grade = evt.rank[i].grade;
				rank[i].sub_level = evt.rank[i].sub_level;
				rank[i].total_score = evt.rank[i].total_score;
			}
			var groups:Array = new Array;
			//Int64类型转化
			for(i = 0; i<evt.groups.length; i++)
			{
				groups[i] = {};
				groups[i].group_id = evt.groups[i].group_id.toString();
				groups[i].group_name = evt.groups[i].group_name;
			}
			Globals.s_logger.debug("handleRefreshWeekStarRankRes server evt =  " + JSON.stringify(evt) + "," + JSON.stringify(groups));
			m_client.GetUICallback().handleRefreshWeekStarRankRes(evt.res, rank, contribute_player, groups, evt.total_size, evt.settle_time);
		}
		//周星赛URL配置下发
		private function handleWeekStarConfigRsp(ev:INetMessage):void
		{
			var evt:CEventWeekStarConfigRsp = ev as CEventWeekStarConfigRsp;
			Globals.s_logger.debug("handleWeekStarConfigRsp server evt =  " + JSON.stringify(evt));
			m_client.GetUICallback().handleWeekStarConfigRsp(evt.player_url);
		}
		//通知主播周星等级升级
		private function handleAnchorWeekStarLevelUpNotify(ev:INetMessage):void
		{
			var evt:CEventAnchorWeekStarLevelUpNotify = ev as CEventAnchorWeekStarLevelUpNotify;
			Globals.s_logger.debug("handleAnchorWeekStarLevelUpNotify server evt =  " + JSON.stringify(evt));
			m_client.GetUICallback().handleAnchorWeekStarLevelUpNotify(evt.grade, evt.sub_level, evt.grade_name, evt.posing_url);
		}
		//通知主播周星积分结算
		private function handleAnchorWeekStarMatchSettleNotify(ev:INetMessage):void
		{
			var evt:CEventAnchorWeekStarMatchSettleNotify = ev as CEventAnchorWeekStarMatchSettleNotify;
			Globals.s_logger.debug("handleAnchorWeekStarMatchSettleNotify server evt =  " + JSON.stringify(evt));
			m_client.GetUICallback().handleAnchorWeekStarMatchSettleNotify(evt.last_week_score, evt.total_score, evt.total_rank, evt.group_name, evt.sub_rank, evt.previous_diff);
		}
	}
}