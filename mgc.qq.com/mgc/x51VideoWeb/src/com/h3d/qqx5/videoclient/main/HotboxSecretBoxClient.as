package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.comdata.VideoChannelType;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.CEventFinishEducation;
	import com.h3d.qqx5.common.event.CEventNotifyAnchorSecretCode;
	import com.h3d.qqx5.common.event.CEventNotifyLastHitPlayerReward;
	import com.h3d.qqx5.common.event.CEventNotifyPlayerSecretHeatBox;
	import com.h3d.qqx5.common.event.CEventNotifySecretHeatBoxInfo;
	import com.h3d.qqx5.common.event.CEventWhistleLastHitPlayer;
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
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
	
	public class HotboxSecretBoxClient
	{
		
		private var m_client:IVideoClientInternal;
		public function HotboxSecretBoxClient(_m_client:IVideoClientInternal)
		{
			m_client = _m_client;
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			var clsid:int = ev.CLSID();
			switch(clsid)
			{
				case HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifySecretHeatBoxInfo:
					handleNotifySecretHeatBoxInfo(ev);
					break;
				case HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyAnchorSecretCode:
					handleNotifyAnchorSecretCode(ev);
					break;
				case HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyPlayerSecretHeatBox:
					handleNotifyPlayerSecretHeatBox(ev);
					break;
				case HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyLastHitPlayerReward:
					handleNotifyLastHitPlayerReward(ev);
					break;
				case HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventWhistleLastHitPlayer:
					handleWhistleLastHitPlayer(ev);
					break;
				default:
					break;
			}
			
			return true;
		}
		//下发宝箱开启的差值,活动标题和内容
		private function handleNotifySecretHeatBoxInfo(ev:INetMessage):void
		{
			var evt:CEventNotifySecretHeatBoxInfo = ev as CEventNotifySecretHeatBoxInfo;
			Globals.s_logger.debug("handleNotifySecretHeatBoxInfo msg =  " + JSON.stringify(evt));
			m_client.GetUICallback().HandleNotifySecretHeatBoxInfo(evt.diff_value, evt.title, evt.content);
		}
		
		//下发主播设置（默认）的密令
		private function handleNotifyAnchorSecretCode(ev:INetMessage):void
		{
			var evt:CEventNotifyAnchorSecretCode = ev as CEventNotifyAnchorSecretCode;
			Globals.s_logger.debug("handleNotifyAnchorSecretCode msg =  " + JSON.stringify(evt));
			m_client.GetUICallback().handleNotifyAnchorSecretCode(evt.secret_code);
		}
		
		//通知玩家密令宝箱倒计时变化
		private function handleNotifyPlayerSecretHeatBox(ev:INetMessage):void
		{
			var evt:CEventNotifyPlayerSecretHeatBox = ev as CEventNotifyPlayerSecretHeatBox;
			Globals.s_logger.debug("handleNotifyPlayerSecretHeatBox msg =  " + JSON.stringify(evt));
			m_client.GetUICallback().handleNotifyPlayerSecretHeatBox(evt.last_seconds, evt.end_time, evt.box_id);
		}
		
		//通知补刀王玩家获得的奖励
		private function handleNotifyLastHitPlayerReward(ev:INetMessage):void
		{
			var evt:CEventNotifyLastHitPlayerReward = ev as CEventNotifyLastHitPlayerReward;
			Globals.s_logger.debug("handleNotifyLastHitPlayerReward msg =  " + JSON.stringify(evt));
			var reward_true:Array                          = new Array;
			var giftArr_true:Array                         = new Array;
			
			for each (var tmpitem:RewardBasicItem in evt.rewards)
			{
				var rewarddata:BoxRewardForUI = new BoxRewardForUI;
				rewarddata.reward_type = tmpitem.type;
				rewarddata.reward_id = tmpitem.para1;
				rewarddata.reward_cnt = tmpitem.para3;
				
				rewarddata.channel = tmpitem.item_channel;
				
				if (VideoChannelType.IsQueryReaward(rewarddata.channel)) //游戏侧道具奖励
				{
					var gift:RewardReqestWeb = new RewardReqestWeb;
					gift.id = m_client.IsSelfMale() ? tmpitem.para1 : tmpitem.para2;
					gift.amount = tmpitem.para3;
					gift.type = tmpitem.type;
					gift.channel = rewarddata.channel;
					giftArr_true.push(gift);
				}
				reward_true.push(rewarddata);
			}
			Globals.s_logger.debug("handleNotifyLastHitPlayerReward msg end =  " + JSON.stringify(evt));
			if( giftArr_true.length > 0 )
			{
				Globals.s_logger.debug("handleNotifyLastHitPlayerReward res GetRewordsInfos:"+JSON.stringify(evt));
				m_client.GetReawardCookieManager().GetRewordsInfos(giftArr_true,m_client.GetUICallback().handleNotifyLastHitPlayerReward, reward_true );
			}
			else
			{
				Globals.s_logger.debug("handleNotifyLastHitPlayerReward res handleNotifyLastHitPlayerReward:"+JSON.stringify(evt));
				m_client.GetUICallback().handleNotifyLastHitPlayerReward(reward_true, giftArr_true);
			}
			
		}
		
		//通知补刀王玩家获得的奖励
		private function handleWhistleLastHitPlayer(ev:INetMessage):void
		{
			var evt:CEventWhistleLastHitPlayer = ev as CEventWhistleLastHitPlayer;
			Globals.s_logger.debug("handleWhistleLastHitPlayer msg =  " + JSON.stringify(evt));
			
			m_client.GetUICallback().handleWhistleLastHitPlayer(evt.guard_level, evt.wealth_level, evt.vip_level, evt.zone_name, evt.nick_name, evt.text, evt.has_portrait, evt.player_pstid, evt.invisible);
		}
	
	}
}