package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.AnchorCard;
	import com.h3d.qqx5.common.comdata.AnchorCardVideoGuildInfo;
	import com.h3d.qqx5.common.comdata.AnchorFollower;
	import com.h3d.qqx5.common.comdata.AnchorImpressionData;
	import com.h3d.qqx5.common.comdata.VideoAnchorLevelRank;
	import com.h3d.qqx5.common.comdata.VideoRoomSuperGuard;
	import com.h3d.qqx5.common.comdata.VipSeatInfo;
	import com.h3d.qqx5.common.event.CEventAllVipSeatsOccupiedBroadcastAllRoom;
	import com.h3d.qqx5.common.event.CEventCheckNickOnLoginRes;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpressRes;
	import com.h3d.qqx5.common.event.CEventLoadAnchorStarGiftInfoRes;
	import com.h3d.qqx5.common.event.CEventLoadRecommendVideoRoomRes;
	import com.h3d.qqx5.common.event.CEventLoadStarGiftChampionRankRes;
	import com.h3d.qqx5.common.event.CEventLoadStarGiftRankRes;
	import com.h3d.qqx5.common.event.CEventLoadVideoLevelRankRes;
	import com.h3d.qqx5.common.event.CEventNotifyAllUserAdmin;
	import com.h3d.qqx5.common.event.CEventNotifyLostVipSeat;
	import com.h3d.qqx5.common.event.CEventNotifySecretHeatBoxInfo;
	import com.h3d.qqx5.common.event.CEventNotifyUserAdminSystemInfo;
	import com.h3d.qqx5.common.event.CEventNotifyVipTakeSeatProtectTime;
	import com.h3d.qqx5.common.event.CEventRefreshAffinityRank;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorLevelRank;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorScoreRank;
	import com.h3d.qqx5.common.event.CEventRefreshGuildChampionRank;
	import com.h3d.qqx5.common.event.CEventRefreshPopularityRank;
	import com.h3d.qqx5.common.event.CEventRefreshStarAnchorRank;
	import com.h3d.qqx5.common.event.CEventRefreshStarGiftInfo;
	import com.h3d.qqx5.common.event.CEventRefreshStarlightRank;
	import com.h3d.qqx5.common.event.CEventRefreshTwoweekStarlightRank;
	import com.h3d.qqx5.common.event.CEventRefreshVideoGuildRank;
	import com.h3d.qqx5.common.event.CEventRefreshVideoRichRank;
	import com.h3d.qqx5.common.event.CEventRefreshVideoVIPRank;
	import com.h3d.qqx5.common.event.CEventRefreshVipSeats;
	import com.h3d.qqx5.common.event.CEventStarGiftChampionNotify;
	import com.h3d.qqx5.common.event.CEventTakeVipSeatRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomBanNotice;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoomBroadcast;
	import com.h3d.qqx5.common.event.CEventVideoRoomGuardLevelChange;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadPlayerList;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadPlayerListRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadSuperGuardResult;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshGuardLevel;
	import com.h3d.qqx5.common.event.CEventVideoRoomShareConfig;
	import com.h3d.qqx5.common.event.CEventVideoRoomVipSeatsInfo;
	import com.h3d.qqx5.common.event.CEventVisitAnchor;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.common.event.eventid.MobileUserAdminId;
	import com.h3d.qqx5.common.event.eventid.PlaybackEventID;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.common.uidata.ClientAnchorCardVideoGuildInfo;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.enum.PlayerSex;
	import com.h3d.qqx5.enum.TakeSeatResult;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.enum.VideoRoomType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.client.AnchorNestClient;
	import com.h3d.qqx5.modules.anchor_nest.events.AnchorNestEventID;
	import com.h3d.qqx5.modules.anchor_pk.event.VideoAnchorPKEventID;
	import com.h3d.qqx5.modules.nest_task.event.AnchorNestTaskEventID;
	import com.h3d.qqx5.modules.red_envelope.share.VideoRedEnvelopeEventId;
	import com.h3d.qqx5.modules.surprise_box.event.VideoSurpriseBoxEventID;
	import com.h3d.qqx5.modules.video_activity.VideoRichRank;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.modules.video_guild.client.VideoGuildClient;
	import com.h3d.qqx5.modules.video_guild.share.event.VideoGuildEventID;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventGetVideoPlayerCardInfo;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventTakeVideoVipDailyRewards;
	import com.h3d.qqx5.modules.video_vip.shared.event.VideoVipEventID;
	import com.h3d.qqx5.tqos.TQOSHomePageLoadTime;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.PersistIDUtil;
	import com.h3d.qqx5.util.URLSuffix;
	import com.h3d.qqx5.video_rank_server.shared.AnchorWeekStarMatchInfo;
	import com.h3d.qqx5.video_rank_server.shared.VideoAffinityRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorScoreRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoGuildChampionRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoGuildRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoPopularityRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarAnchorRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftAnchorRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftAnchorRankForUI;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftPlayerRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftPlayerRankForUI;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarGiftRankContainer;
	import com.h3d.qqx5.video_rank_server.shared.VideoStarlightRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoTwoweekStarlightRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoVIPRank;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	import com.h3d.qqx5.video_service.serviceinf.RoomAnchorInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;
	import com.h3d.qqx5.videoclient.OlinePictureDef;
	import com.h3d.qqx5.videoclient.data.AnchorAffinityRankData;
	import com.h3d.qqx5.videoclient.data.AnchorImpressionDataForUI;
	import com.h3d.qqx5.videoclient.data.AnchorInfocard;
	import com.h3d.qqx5.videoclient.data.AnchorNestSkinInfoUI;
	import com.h3d.qqx5.videoclient.data.AnchorStarlightRankData;
	import com.h3d.qqx5.videoclient.data.ChatBanResNameData;
	import com.h3d.qqx5.videoclient.data.ChatChannel;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	import com.h3d.qqx5.videoclient.data.ClientGuildChampionRankData;
	import com.h3d.qqx5.videoclient.data.ClientStarAnchorRankData;
	import com.h3d.qqx5.videoclient.data.EnterOption;
	import com.h3d.qqx5.videoclient.data.GuardLevelEnum;
	import com.h3d.qqx5.videoclient.data.IconString;
	import com.h3d.qqx5.videoclient.data.RecommendVideoRoomInfo;
	import com.h3d.qqx5.videoclient.data.RichRankData;
	import com.h3d.qqx5.videoclient.data.RoomPlayerType;
	import com.h3d.qqx5.videoclient.data.RoomVipSeatCnt;
	import com.h3d.qqx5.videoclient.data.SelfVideoRoomInfo;
	import com.h3d.qqx5.videoclient.data.SuperType;
	import com.h3d.qqx5.videoclient.data.VideAnchorLevelRankUiData;
	import com.h3d.qqx5.videoclient.data.VideoAnchorScoreRankForUI;
	import com.h3d.qqx5.videoclient.data.VideoClientType;
	import com.h3d.qqx5.videoclient.data.VideoGuardConditionType;
	import com.h3d.qqx5.videoclient.data.VideoGuardPrivilegeData;
	import com.h3d.qqx5.videoclient.data.VideoGuildInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildRankForUI;
	import com.h3d.qqx5.videoclient.data.VideoLevelRankDataForUI;
	import com.h3d.qqx5.videoclient.data.VideoRoomAffinity;
	import com.h3d.qqx5.videoclient.data.VideoRoomData;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import com.h3d.qqx5.videoclient.data.VideoRoomPlayerData;
	import com.h3d.qqx5.videoclient.data.VideoRoomPlayerDataForAnchorCardFans;
	import com.h3d.qqx5.videoclient.data.VideoRoomSuperFansCnt;
	import com.h3d.qqx5.videoclient.data.VideoVIPRankData;
	import com.h3d.qqx5.videoclient.data.VipLevelEnum;
	import com.h3d.qqx5.videoclient.data.VipNameEnum;
	import com.h3d.qqx5.videoclient.data.VipSeatInfoForUI;
	import com.h3d.qqx5.videoclient.data.WebColor;
	import com.h3d.qqx5.videoclient.data.WeekStarInfoUI;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorNestClient;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorPKClient;
	import com.h3d.qqx5.videoclient.interfaces.IClientSurpriseBoxManager;
	import com.h3d.qqx5.videoclient.interfaces.IClientVideoVipManager;
	import com.h3d.qqx5.videoclient.interfaces.IConcertClient;
	import com.h3d.qqx5.videoclient.interfaces.IFansGuardConfig;
	import com.h3d.qqx5.videoclient.interfaces.ITXVideoEngineEventExt;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoGuildClient;
	import com.h3d.qqx5.videoclient.main.HotboxSecretBoxClient;
	import com.h3d.qqx5.videoclient.main.PlaybackClient;
	import com.h3d.qqx5.videoclient.main.WeekStarClient;
	import com.h3d.qqx5.videoclient.vote.CVideoVoteClient;
	import com.h3d.qqx5.videoclient.xmlconfig.CFansGuardConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CGiftConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoVipConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVipSeatClientConfig;
	
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	
	
	public class CVideoClientBase implements ITXVideoEngineEventExt
	{
		private var m_client:IVideoClientInternal;
		private var m_room:CVideoRoomClient;
		private var m_client_type:int;		
		private var m_cdn_buname:String = "";
		private var m_pic_download_url:String;
		private var m_video_guild:VideoGuildClient;
		private var m_anchor_pk:IAnchorPKClient;
		private var m_surprise_box_mng:IClientSurpriseBoxManager;
		private var m_super_fans:Array = new Array();		
		private var m_super_guards:Dictionary = new Dictionary();		
		private var m_chat_banned:Array = new Array();	
		private var m_perpetual_chat_banned:Array = new Array();	;//first 大区名；second 玩家名 永久禁言
		private var m_talent_show:ClientTalentShow;		
		private var m_video_ceremony_client:CVideoCeremonyClient;		
		private var m_anchor_nest:IAnchorNestClient;		
		private var m_videosrv_shutdown_left_minutes:int;		
		private var m_next_notify_shutdown:int;		
		private var m_selfInfo:SelfVideoRoomInfo = new SelfVideoRoomInfo;	
		private var m_video_vote_client:CVideoVoteClient;
		private var m_current_vid:int = 0;
		private var m_cdn_vec:Array = new Array;
		private var m_guard_cfg:CFansGuardConfig = null;
		private var m_video_vip_mgr:IClientVideoVipManager;
		private var m_hotbox_secret_box:HotboxSecretBoxClient;
		
		private var m_vipConfig:CVideoVipConfig = null;
		private var guardConfig:IFansGuardConfig = null;
		private var m_concert_client:IConcertClient = null;
		private var m_current_invited_anchor_vid:int = 0;
		private var m_red_envelope_client:CRedEnvelopeClient = null;
		private var m_seat_protect_time:Dictionary ;
		private var m_star_gift_info:Array = new Array;
		private var m_star_gift_champion:Dictionary = new Dictionary;
		private var m_playback:PlaybackClient;
		private var m_weekstar:WeekStarClient;
		
		public function CVideoClientBase(client:IVideoClientInternal)
		{
			m_client = client;
			m_client_type = VideoClientType.VCT_X5Client;
			m_room = new CVideoRoomClient(m_client, this);			
			m_anchor_pk = new AnchorPKClient(client,this);
			m_surprise_box_mng = new ClientSurpriseBoxManager(0, client)			
			m_video_guild = new VideoGuildClient(client,this);
			m_video_vote_client = new CVideoVoteClient(m_client);
			m_talent_show = new ClientTalentShow(m_client, m_client_type);
			m_video_ceremony_client = new CVideoCeremonyClient;
			m_anchor_nest = new AnchorNestClient(m_client, this);
			m_video_vip_mgr = new CClientVideoVipManager(0, client, m_room);
			m_concert_client = new CConcertClient(m_client, this);
			m_red_envelope_client = new CRedEnvelopeClient(client,this);
			m_seat_protect_time = new Dictionary();
			m_hotbox_secret_box = new HotboxSecretBoxClient(m_client);
			m_playback= new PlaybackClient(m_client);
			m_weekstar= new WeekStarClient(m_client);
		}
		
		public function GetSurpriseBoxMng():IClientSurpriseBoxManager
		{
			return m_surprise_box_mng;
		}
		
		public function GetRoomType():int
		{
			return m_room.GetRoomType();
		}
		
		
		public function  ClearRoomData():void
		{
			m_room.ClearRoomData();
		}
				
		public function GetSeatPriceResetNotice():void
		{
			m_room.GetSeatPriceResetNotice();
		}
		
		public function GetBuyTicketAndPicURL():void
		{
			m_client.GetUICallback().OnGetBuyTicketAndPicURL(m_concert_client.GetBuyConcertTicketURL(),m_concert_client.GetConcertStaticImageURL() );
		}
		
		public function GetRoomPrivateChatList():Array
		{
			return m_room.GetPrivateChatList();
		}
		
		public function GetGiftPoolAdditionInfo():void
		{
			return  m_room.GetGiftPoolAdditionInfo();
		}
		
		public function IsConcert():Boolean
		{
			return m_room.IsConcert();
		}
		
		public function IsChatBanned( zone_name:String, player_name:String ):Boolean
		{
			for each(var a:ChatBanResNameData in m_chat_banned)
			{
				if( a.target_nickName == player_name && a.target_zoneName == zone_name)
				{
					return true;
				}
			}
			return false;
		}
		
		public function IsPerpetualChatBan( zone_name:String, player_name:String ):Boolean
		{
			for each(var a:ChatBanResNameData in m_perpetual_chat_banned)
			{
				if( a.target_nickName == player_name && a.target_zoneName == zone_name)
				{
					return true;
				}
			}
			return false;
		}
		
		public function  GetTalentShow():ClientTalentShow
		{
			return m_talent_show;
		}
		
		public function InitVideoClientBase(cfg:CFansGuardConfig):void
		{
			m_guard_cfg = cfg;
		}
		
		public function GetGiftEffectCnt():void
		{
			m_room.GetGiftEffectCnt();
		}
		public function GetAnchorNestClient():IAnchorNestClient
		{
			trace(m_anchor_nest);
			return m_anchor_nest;
		}
		
		public function GetCeremonyClient() :CVideoCeremonyClient
		{
			return m_video_ceremony_client; 
		}
		
		public function  GetFreeWhistleLeft():int
		{
			return m_room.GetFreeWhistleLeft();
		}
		public function  GetRoomDataForUI(data:VideoRoomData):void
		{
			m_room.GetRoomDataForUI(data);
			FillVideoRoomPicUrl(data);
			FillVideoRoomLogoUrl(data);
		}
		public function   GetFreeSuperStarHornLeft():int
		{
			return m_room.GetFreeSuperStarHornLeft();
		}
		
		public function AddVideoDreamMoney(money:int):void
		{
			m_room.AddVideoDreamMoney(money);
		}
		
		public function SetVipFreeWhistleLeft( left :int):void
		{
			m_room.SetVipFreeWhistleLeft(left);
		}
		
		public function SetVipFreeSuperStarHornLeft( left :int):void
		{
			m_room.SetVipFreeSuperStarHornLeft(left);
		}
		
		public function  HaveTakenVipWeeklyRewardToday() :Boolean
		{
			return m_room.HaveTakenVipWeeklyRewardToday();
		}
		
		public function ForbidTalkForAllRoom(playerId:Int64, ban:Boolean):Boolean
		{
			return m_room.ForbidTalkForAllRoom(playerId, ban);
		}
		
		public function  ForbidTalk( ban:Boolean, perpetual:Boolean ,pstid:Int64):Boolean
		{
			return m_room.ForbidTalk(ban, perpetual,pstid);
		}
		
		public function  GetVideoVipLevel():int
		{
			return m_room.GetVipLevel();
		}
		
		public function  SetVideoVipInfo(level:int,expire:int):void
		{
			return m_room.SetVipInfo(level,expire);
		}
		
		public function  GetVideoVipExpire():int
		{
			return m_room.GetVipExpire();
		}
		
		private function GetCurrentAnchorDataForUI(  data:ClientAnchorData ):void
		{
			m_room.GetCurrentAnchorDataForUI(data);
			FillAnchorPortraitUrl(data);
			FillAnchorImageUrl(data);
		}
		
		public function GetRoomAnchorInfo( info:RoomAnchorInfo ):void
		{
			if(m_room != null)
			{
				m_room.GetRoomAnchorInfo(info);
			}
		}
		
		public function TakeVipDailyReward():void
		{
			var ev:CEventTakeVideoVipDailyRewards = new CEventTakeVideoVipDailyRewards ;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		
		// 获得主播名片信息，异步
		public function  GetAnchorCardInfo(anchorID:Int64):Boolean
		{			
			var visit_event:CEventVisitAnchor = new CEventVisitAnchor;
			visit_event.anchor_id = anchorID;
			Globals.s_logger.debug("GetAnchorCardInfo page to server =  " + JSON.stringify(visit_event));
			m_client.SendEvent(visit_event,Globals.SelfRoomID);		
			return true;
		}

		public function SuperGuardMapToVec( guard_map:Dictionary,guard_vec:Array ):void
		{
			for(var it:Object in guard_map)
			{
				var guard:VideoRoomSuperGuard = guard_map[it];
				var to_ui:VideoRoomAffinity = VideoRoomSuperGuard2VideoRoomAffinity(guard);
				guard_vec.push(to_ui);
			}
			guard_vec.sort(VideoRoomTotalAffinityCmp);
		}
		
		public function VideoRoomAffinityCmp(player1:VideoRoomAffinity,player2:VideoRoomAffinity):int
		{
			var affinity1:Number = Number(player1.affinity);
			var affinity2:Number =  Number(player2.affinity);
			if ( affinity1 > affinity2)
				return -1;
			else if(affinity1 < affinity2)
				return 1;
			else
				return 0;
		};
		
		
		public function VideoRoomTotalAffinityCmp(player1:VideoRoomAffinity,player2:VideoRoomAffinity):int
		{
			var totalaff1:Number = Number(player1.total_affinity);
			var totalaff2:Number =  Number(player2.total_affinity);
			if ( totalaff1 > totalaff2)
				return -1;
			else 
				return 1;
		};
		private var Pattern:RegExp = /\\/g;
		public function VideoRoomSuperGuard2VideoRoomAffinity(guard:VideoRoomSuperGuard):VideoRoomAffinity
		{
			var  data : VideoRoomAffinity = new VideoRoomAffinity;
			data.male = (guard.player_sex == PlayerSex.SEX_Male);
			data.playerID = guard.player_id.toString();
			data.total_affinity = guard.total_affinity.toString();
			data.anchorID = guard.anchor_id.toString();
			data.zoneName = guard.player_zone;
			data.wealth = guard.wealth.toString();
			data.playerName = guard.player_name.replace(Pattern,"\\\\");
			data.baned = false;
			data.perpentralBaned = false;
			data.guardlevel = guard.guard_level;
			data.jacket = 0;
			data.affinity = "0";
			data.viplevel = guard.vip_level;
			data.m_pk_richman_order = guard.pk_richman_order;
			data.guardIcon = guardConfig.GetIcon(guard.guard_level);
			data.vipIcon = m_vipConfig.GetVipIcon(guard.vip_level);
			data.nickColor = m_vipConfig.GetVipNickColor(guard.vip_level);
			
			return data;
		}
		
		public function LoadSuperFans( fanstype:int ):void
		{
			if(fanstype == SuperType.SuperFansRank)
			{
				m_super_fans.sort(VideoRoomAffinityCmp);
				m_client.GetUICallback().OnLoadSuperFans(SuperType.SuperFansRank,0,m_super_fans);
				return;
			}
			else if(fanstype == SuperType.SuperGuardRank)
			{
				var super_guards_ui:Array = new Array() ;
				SuperGuardMapToVec(m_super_guards,super_guards_ui);
				m_client.GetUICallback().OnLoadSuperFans(SuperType.SuperGuardRank,0,super_guards_ui);
				return;
			}
		}
		// 转播其他主播的视频
		public function StartVideoShare(vid:int, cdns:Array):void
		{
			var cdn_urls:Array = new Array;
			Globals.s_logger.debug("BroadcastLive: start watch live, vid: " +  vid + ", cdn_size: "+ cdns.length);
			if(vid == 0 || cdns == null || cdns.length <= 0)
				return;
			for(var i:int = 0; i < cdns.length; ++i)
			{
				var urlstr:String = cdns[i] as String;
				urlstr += vid;
				urlstr += ".flv?buname=";
				urlstr += m_cdn_buname;
				urlstr += "&vkey=";
				urlstr += Globals.vkey;
				urlstr += "&sdtfrom=v221";
				
				Globals.s_logger.log("cdn url:" + urlstr);
				cdn_urls.push(urlstr);
			}
			
			// 通知页面开始直播
			m_client.GetUICallback().OnStartVideoLive(cdn_urls,0,IsConcert());
		}
		
		public function StopVideoShare():void
		{
			StartWatchLive(0);
		}
		public function ClearDataWhenStopWatchLive(isChangeDefinition:Boolean = false):void
		{
			if( !(m_anchor_nest && m_anchor_nest.IsAnchorNestRoom()) && !isChangeDefinition)
			{
				//清理非小窝房间的。
				//m_anchor_nest.ToAnchorNestRoom()方法没有人调用，所以房间一直为非小窝房间。
				if (m_room != null && m_room.isNest())
				{

				}
				else
				{
					var affinityRank:Array = new Array();
					// 清空超级粉丝榜
					m_client.GetUICallback().OnLoadSuperFans(SuperType.SuperFansRank, 1, affinityRank);
					// 清空常驻守护榜
					m_client.GetUICallback().OnLoadSuperFans(SuperType.SuperGuardRank, 1, affinityRank);

					//清理本地数据
					m_super_fans = new Array;
					for (var it:Object in m_super_guards)
						delete m_super_guards[it];
					ClearSelfInfo();
				}
			}
		}
		
		public function StopWatchLive():void
		{
			// 通知页面停止直播
			m_client.GetUICallback().OnStopVideoLive();
		}
		public function StopWatchInvitedAnchorLive():void
		{
			// 通知页面停止直播
			m_client.GetUICallback().OnStopWatchInvitedAnchorLive();
		}
		
		public function StartWatchLive(res:int):Boolean 
		{
			var cdn_urls:Array = new Array;
			Globals.s_logger.debug("videoroom: start watch live, vid: " +  m_current_vid + ", cdn_size: "+ m_cdn_vec.length);
			if(m_current_vid == 0)
			{
				m_client.GetUICallback().OnStartVideoLive(cdn_urls,1,IsConcert());
				return false;
			}
			for(var i:int = 0; i < m_cdn_vec.length; ++i)
			{
				var urlstr:String = m_cdn_vec[i] as String;
				urlstr += m_current_vid;
				urlstr += ".flv?buname=";
				urlstr += m_cdn_buname;
				urlstr += "&vkey=";
				urlstr += Globals.vkey;
				urlstr += "&sdtfrom=v221";
				
				Globals.s_logger.log("cdn url:" + urlstr);
				cdn_urls.push(urlstr);
			}
			
			// 通知页面开始直播
			//如果演唱会已经开启并且没有门票，不播放视频
			if( IsConcert() && ( m_concert_client.IsConcertStarted() &&m_concert_client.HasConcertTicket()  == false))
				return false;
			m_client.GetUICallback().OnStartVideoLive(cdn_urls,res,IsConcert());
			return true;
		}
		
		public function StartWatchInvitedAnchorLive():void 
		{
			var cdn_urls:Array = new Array;
			Globals.s_logger.debug("videoroom: StartWatchInvitedAnchorLive, vid: " +  m_current_invited_anchor_vid + ", cdn_size: "+ m_cdn_vec.length);
			if(m_current_invited_anchor_vid == 0)
			{
				m_client.GetUICallback().OnStarSplitScreenLive(cdn_urls,IsConcert());
				return ;
			}
			for(var i:int = 0; i < m_cdn_vec.length; ++i)
			{
				var urlstr:String = m_cdn_vec[i] as String;
				urlstr += m_current_invited_anchor_vid;
				urlstr += ".flv?buname=";
				urlstr += m_cdn_buname;
				urlstr += "&vkey=";
				urlstr += Globals.vkey;
				urlstr += "&sdtfrom=v221";
				
				Globals.s_logger.log("cdn url:" + urlstr);
				cdn_urls.push(urlstr);
			}
			
			// 通知页面开始直播
			//如果演唱会没有分屏功能
			if( IsConcert())
				return ;
			m_client.GetUICallback().OnStarSplitScreenLive(cdn_urls,IsConcert());
			return ;
		}
		
		
		public function SetCDNAddress(cdns:Array):void
		{
			m_cdn_vec = cdns;
		}
		
		public function GetAnchorPKClient():IAnchorPKClient
		{
			return m_anchor_pk;
		}
		
		public function FillRoomDataForUI(logic_rooms:Array, rooms:Array):void
		{
			m_room.FillRoomDataForUI(logic_rooms,rooms);
		}
		public function FillRoomPageDataForUI(logic_rooms:Array, rooms:Array):void
		{
			m_room.FillRoomPageDataForUI(logic_rooms,rooms);
		}
		private function  VideoRoomPlayerInfo2VideoRoomAffinity(info:VideoRoomPlayerInfo, anchor:String):VideoRoomAffinity
		{
			var data : VideoRoomAffinity = new VideoRoomAffinity ;
			data.male = (info.sex == PlayerSex.SEX_Male);
			data.playerID = info.pstid.toString();
			data.total_affinity = info.total_affinity.toString();
			data.anchorID = "0";
			data.anchorName = anchor.replace(Pattern,"\\\\");
			data.playerZoneID = info.uid.zoneid;
			data.zoneName = info.zoneName;
			data.wealth = info.wealth.toString();
			data.playerName = info.playerNick.replace(Pattern,"\\\\");
			data.baned = info.IsChatBan();
			data.perpentralBaned = info.IsPerpetualChatBan();
			data.guardlevel = info.guardLevel;
			data.jacket = 0;
			data.affinity = info.affinity.toString();
			data.viplevel = info.video_vip_level;
			data.credits_level = info.credits_level;
			data.m_pk_richman_order = info.pk_richman_order;
			data.video_level = info.video_level;
			data.guardIcon = guardConfig.GetIcon(info.guardLevel);
			data.vipIcon = m_vipConfig.GetVipIcon(info.video_vip_level);
			data.vipName = m_vipConfig.GetVipName(info.video_vip_level);
			data.nickColor = m_vipConfig.GetVipNickColor(info.video_vip_level);
			data.wealth_level = info.wealth_level;
			
			return data;
		}
			
		public function VideoRoomPlayerInfo2VideoRoomPlayerData( info:VideoRoomPlayerInfo, data:VideoRoomPlayerData):void
		{			
			data.male = (info.sex==PlayerSex.SEX_Male);
			data.name = info.playerNick.replace(Pattern,"\\\\");
			//begin目前服务器发的数据没有zoneid，为了页面方便暂时加个判断
			data.zoneID = Globals.zoonId;
			//end
			data.playerID =info.pstid.toString();
			data.zoneName = info.zoneName;
			data.wealth = info.wealth.toString();
			data.purpleLevel = info.purplediamond_level;
			data.talkForbidden = info.IsNormalChatBan();
			data.videoLevel = info.video_level;
			data.playerQQ = info.uid.account.toString();
			data.wealth_level = info.wealth_level;
			data.anchor_level = info.anchor_level;
			
			if(data.talkForbidden)
			{
				data.tempBannedIcon = IconString.tempBannedIcon;
			}
			
			data.portrait_info = info.portrait_info;
			data.playerType = info.playerType;
			
			if(data.playerType == RoomPlayerType.RPT_anchor)
			{
				data.playerIcon = IconString.anchorIcon;
				if(m_room.GetAnchorQQ().toString() == data.playerQQ && !m_room.GetIsNestRoolStopLive())
				{
					data.isOnLive = true;
				}
			}
			else if(data.playerType == RoomPlayerType.RPT_admin)
			{
				data.playerIcon = IconString.adminIcon;		
			}
			
			data.purpleNF = info.nfpurplediamond_user ? true : false;
			data.online = info.online;
			data.perpetualTalkForbidden = info.IsPerpetualChatBan();
			if(data.perpetualTalkForbidden)
			{
				data.perpetualTalkForbiddenIcon = IconString.foreverBannedIcon;
			}
			
			data.guardLevel = info.guardLevel;
			data.viplevel = info.video_vip_level;
			data.credits_level = info.credits_level;
			data.judgeType = info.judge_type;
			data.talentshowRank = info.talent_show_rank;
			data.starAnchor = (info.star_anchor != 0);
			if(data.starAnchor)
			{
				data.starAnchorIcon = IconString.starAnchorIcon;
			}
			
			data.anchorTitle = info.annual2014_title;
			data.invisible = info.invisible;
			data.forbidTalkAllRoom = info.IsChatBanAllRoom();
			
			
			data.nest_assistant = info.assistant;
			data.guardIcon = guardConfig.GetIcon(info.guardLevel);
			data.vipIcon = m_vipConfig.GetVipIcon(info.video_vip_level);
			data.nickColor = m_vipConfig.GetVipNickColor(info.video_vip_level);			
		}
		
		public function ToVideoGuildInfoForUI(info:VideoGuildInfo):VideoGuildInfoForUI
		{
			var t_info:VideoGuildInfoForUI = new VideoGuildInfoForUI;
			t_info.anchor_cont_score = info.anchor_cont_score;
			t_info.anchor_give_score = info.anchor_give_score;
			t_info.anchor_name = info.anchor_name;
			t_info.anchor_pstid = info.anchor_pstid.toString();
			t_info.chief_name = info.chief_name;
			t_info.chief_pstid = info.chief_pstid.toString();
			t_info.chief_qq = info.chief_qq.toString();
			t_info.chief_zname = info.chief_zname;
			t_info.create_time = info.create_time;
			t_info.demised_chief_pstid = info.demised_chief_pstid.toString();
			t_info.fans_board_time_limit = info.fans_board_time_limit;
			t_info.fans_board_type = info.fans_board_type;
			t_info.forbid_join_apply= info.forbid_join_apply;
			t_info.last_cont_rank = info.last_cont_rank;
			t_info.last_month_cont = info.last_month_cont;
			t_info.last_score_rank = info.last_score_rank;
			t_info.last_send_ticket_time = info.last_send_ticket_time;
			t_info.level = info.level;
			t_info.member_count = info.member_count;
			t_info.member_limit = info.member_limit;
			t_info.system_score = info.system_score;
			t_info.system_score_clear_time = info.system_score_clear_time;
			t_info.today_ticket_acc = info.today_ticket_acc;
			t_info.total_score = info.total_score.toString();
			t_info.vg_demise_time = info.vg_demise_time;
			t_info.vg_desc = info.vg_desc;
			t_info.vg_dismiss = info.vg_dismiss;
			t_info.vg_name = info.vg_name;
			t_info.vg_notice = info.vg_notice;
			t_info.vg_score = info.vg_score;
			t_info.vg_wealth = info.vg_wealth;
			t_info.vgid = info.vgid.toString();
			t_info.m_pk_anchor_winner_order = info.pk_anchor_winner_order;
			t_info.fans_board_name = info.fans_board_name;
			t_info.ban_custom_fans_board_time = info.ban_custom_fans_board_time;
			t_info.customed_fans_board_name = info.custom_fans_board_name;
			t_info.chief_wealth_level = info.chief_wealth_level;
			
			return t_info;
		}
		public function GetPlayerVideoCardInfoById(player_id:Int64, source:int):Boolean
		{
			var req_ev:CEventGetVideoPlayerCardInfo = new CEventGetVideoPlayerCardInfo ;
			req_ev.target_id = player_id;
			req_ev.source = source;
			Globals.s_logger.debug("GetPlayerVideoCardInfoById req_ev.source = " + req_ev.source);
			m_client.SendEvent(req_ev,Globals.SelfRoomID);
			return true;
		}
		
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			var res:Boolean = true;
			var clsid:int = ev.CLSID();
			if(guardConfig == null)			
				guardConfig =  m_client.GetGuardConfig();
			if(m_vipConfig == null)
				m_vipConfig = CVideoVipConfig.getInstance();
			
			//聊天特化消息
			if(ev.CLSID() == EEventIDVideoRoomExt.CLSID_CEventVideoToClientChatMessageForWeb)
			{
				this.m_room.HandleVideoToClientChatMsgForWeb(ev);
				return res;
			}
			if(ev.CLSID() == EEventIDVideoRoomExt.CLSID_CEventVideoSendGiftResultForWeb)
			{
				m_room.HandleVideoSendGiftResultForWeb(ev);
				return res;
			}		
			
			switch(clsid)
			{
				case EEventIDVideoRoom.CLSID_CEventVideoRoomLoadPlayerListRes:
					HandleVideoLoadRoomPlayerlistRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomVipSeatsInfo:
					HandleVideoRoomVipSeatPlayerInfo(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomShareConfig:
					HandleCEventShareConfig(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshAffinityRank:
					HandleCEventRefreshAffinityRank(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshPopularityRank:
					HandleCEventRefreshPopularityRank(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshStarlightRank:
					HandleCEventRefreshStarlightRank(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshTwoweekStarlightRank:				
					HandleCEventRefreshTwoweekStarlightRank(ev)
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshVideoVIPRank:
					HandleCEventRefreshVideoVIPRank(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventNofityDeputyAnchorChange:
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomLoadSuperGuardResult:
					HandleCEventVideoRoomLoadSuperGuardResult(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomAssignSuperGuardRes:
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRecedeSuperGuardRes:
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomGuardLevelChange:
					HandleCEventVideoRoomGuardLevelChange(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshGuardLevel:
					HandleCEventVideoRoomRefreshGuardLevel(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcast:
					HandleCEventVideoRoomEnterRoomBroadcast(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventLoadRecommendVideoRoomRes:
					HandleCEventLoadRecommendVideoRoomRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventSyncChatBannedPlayers:
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshStarAnchorRank:
					HandleCEventRefreshStarAnchorRank(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshGuildChampionRank:
					HandleCEventRefreshGuildChampionRank(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshAnchorScoreRank:
					HandleCEventRefreshAnchorScoreRank(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshVideoGuildRank:
					HandleCEventRefreshVideoGuildRank(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressRes:
					HandleCEventLoadAnchorImpressRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventStartTalentShowMatch:
				case EEventIDVideoRoom.CLSID_CEventStopTalentShowMatch:
				case EEventIDVideoRoom.CLSID_CEventAssignTalentJudgeRes:
				case EEventIDVideoRoom.CLSID_CEventBroadcastAssignTalentJudgeMsg:
				case EEventIDVideoRoom.CLSID_CEventTalentShowStateChangeNotify:
				case EEventIDVideoRoom.CLSID_CEventLoadTalentShowScoreRes:
				case EEventIDVideoRoom.CLSID_CEventScoreTalentShowBroadcast:
				case EEventIDVideoRoom.CLSID_CEventSyncTalentShowJudge:
				case EEventIDVideoRoom.CLSID_CEventGetJudgeTypes:
				case EEventIDVideoRoom.CLSID_CEventDianZanResult:
					m_talent_show.HandleServerEvent(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoShutDown:
					break;
				case EEventIDVideoRoom.CLSID_CEventDiceResult:
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadVideoLevelRankRes:
					HandleCEventLoadVideoLevelRankRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshVideoRichRank:
					HandleCEventRefreshVideoRichRank(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshAnchorLevelRank:
					HandleCEventRefreshAnchorLevelRank(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadStarGiftRankRes:
					HandleCEventLoadStarGiftRankRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadStarGiftChampionRankRes:
					HandleCEventLoadStarGiftChampionRankRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventStarGiftChampionNotify:
					HandleCEventStarGiftChampionNotify(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadAnchorStarGiftInfoRes:
					HandleCEventLoadAnchorStarGiftInfoRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshStarGiftInfo:
					HandleCEventRefreshStarGiftInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNotifyLostVipSeat:
					HandleCEventNotifyLostVipSeat(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventTakeVipSeatRes:
					HandleCEventTakeVipSeatRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshVipSeats:
					HandleCEventRefreshVipSeats(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNotifyVipTakeSeatProtectTime:
					HandleCEventNotifyVipTakeSeatProtectTime(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventAllVipSeatsOccupiedBroadcastAllRoom:
					HandleCEventAllVipSeatsOccupiedBroadcastAllRoom(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventCheckNickOnLoginRes:
					HandleCheckNickOnLoginRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomBanNotice:
					HandleCEventVideoRoomBanNotice(ev);
					break;
				case MobileUserAdminId.CLSID_CEventNotifyAllUserAdmin:
					HandleAllUserAdminList(ev);
					break;
				case MobileUserAdminId.CLSID_CEventNotifyUserAdminSystemInfo:
					HandleUserAdminSystemInfo(ev);
					break;
				default:
					res = false;
					break;
			}
			
			if (clsid > VideoVoteEvent.EventVideoVoteStart && clsid < VideoVoteEvent.EventVideoVoteEnd)
			{
				return m_video_vote_client.HandleServerEvent(ev);
			}
			else if((VideoSurpriseBoxEventID.CLSID_VideoSurpriseBoxEventIDStart <= clsid) && (clsid <= VideoSurpriseBoxEventID.CLSID_VideoSurpriseBoxEventIDEnd))
			{
				return m_surprise_box_mng.HandleServerEvent(ev);
			}
			else if(VideoVipEventID.EventVideoVipStart < clsid && clsid < VideoVipEventID.EventVideoVipEnd)
			{
				return m_video_vip_mgr.HandleServerEvent(ev);
			}
			else if(VideoGuildEventID.VideoGuildEventIDStart < clsid && clsid < VideoGuildEventID.VideoGuildEventIDEnd)
			{
				return m_video_guild.HandleServerEvent(ev);
			}
			else if(VideoAnchorPKEventID.VideoAnchorPKEventIDStart < clsid && clsid < VideoAnchorPKEventID.VideoAnchorPKEventIDEnd)
			{
				return m_anchor_pk.HandleServerEvent(ev);
			}
			else if(VideoCeremonyEventId.EventVideoCeremonyStart < clsid && clsid < VideoCeremonyEventId.EventVideoCeremonyEnd)
			{
				//return m_video_ceremony_client->HandleServerEvent(ev);
			}
			else if(VideoRedEnvelopeEventId.EventRedEnvelopeStart < clsid && clsid < VideoRedEnvelopeEventId.EventRedEnvelopeEnd)
			{
				return m_red_envelope_client.HandleServerEvent(ev);
			}
			else if(AnchorNestEventID.VideoAnchorNestEventIDStart < clsid && clsid < AnchorNestEventID.VideoAnchorNestEventIDEnd && clsid != AnchorNestEventID.CLSID_CEventNotifyNestIsFreezing)
			{
				return m_anchor_nest.HandleServerEvent(ev);
			}
			else if(clsid >= AnchorNestTaskEventID.CLSID_NestTaskEventStart && clsid <= AnchorNestTaskEventID.CLSID_NestTaskEventEnd)
			{
				return m_anchor_nest.HandleServerEvent(ev);
			}
			else if(clsid >= AnchorPKEventID.CLSID_CEventRefreshRocketBuff && clsid <= AnchorPKEventID.CLSID_CEventRefreshPlayerContributePKRank)
			{
				return m_anchor_nest.HandleServerEvent(ev);
			}
			else if(clsid >= CommonActivityEventID.CLSID_CEventCommonActivityInfoBegin && clsid <= CommonActivityEventID.CLSID_CEventCommonActivityPlayerRank)
			{
				return m_anchor_nest.HandleServerEvent(ev);
			}
			else if(clsid >= HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifySecretHeatBoxInfo && clsid <= HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyPlayerSecretHeatBox)
			{
				return m_hotbox_secret_box.HandleServerEvent(ev);
			}
			else if(clsid >= PlaybackEventID.CLSID_CEventConcertPlaybackRoomGetRoomList && clsid <= PlaybackEventID.CLSID_CEventStartConcertPlaybackRes)
			{
				return m_playback.HandleServerEvent(ev);
			} 
			else if(clsid >= WeekStarEventID.CLSID_CEventRefreshWeekStarRankRes && clsid <= WeekStarEventID.CLSID_CEventAnchorWeekStarMatchSettleNotify)
			{
				return m_weekstar.HandleServerEvent(ev);
			} 

			if(!res)
				res = m_room.HandleServerEvent(ev);
			return res;			
		}
		
		private function SetGiftData(obj_rank:Object):void
		{
			var giftdata:Object = CGiftConfig.getInstance().GetGiftData(obj_rank.gift_id);
			if( giftdata != null )
			{
				obj_rank.gift_name = giftdata.name;
				obj_rank.gift_price = giftdata.price;
				obj_rank.gift_icon = giftdata.icon;
			}
			else
			{
				obj_rank.gift_name = "";
				obj_rank.gift_price = "";
				obj_rank.gift_icon = "";
			}
		}
		/**
		 * 加载周星榜
		 * @param ev
		 * 
		 */		
		private function HandleCEventLoadStarGiftRankRes(ev:INetMessage):void
		{
			var evt:CEventLoadStarGiftRankRes = ev as CEventLoadStarGiftRankRes;
			// to ui
			var rank_ui:Array = new Array;
			for( var i:int =0; i < evt.gift_rank.length ; i ++)
			{
				//to ui
				var obj_rank:Object = new Object;
				var rank:VideoStarGiftRankContainer = evt.gift_rank[i];
				obj_rank.gift_id = rank.gift_id;
				//设置礼物信息
				SetGiftData(obj_rank);
				var anchor_rank:Array = new Array;
				for(var j:int=0; j< rank.anchor_rank_vec.length; j ++)
				{
					var anchor_ui:VideoStarGiftAnchorRankForUI = new VideoStarGiftAnchorRankForUI;
					ToVideoStarGiftAnchorRankUI(rank.anchor_rank_vec[j] , anchor_ui,j);
					anchor_rank.push( anchor_ui);
				}
				obj_rank.anchor_rank = anchor_rank;
				//player
				var player_rank:Array = new Array;
				for(var k:int=0; k< rank.player_rank_vec.length; k ++)
				{
					var palyer_ui:VideoStarGiftPlayerRankForUI = new VideoStarGiftPlayerRankForUI;
					ToVideoStarGiftpalyerRankUI(rank.player_rank_vec[k] , palyer_ui,k);
					player_rank.push(palyer_ui);
				}
				obj_rank.player_rank = player_rank;
				rank_ui.push(obj_rank);
			}
			var next_time :String =GetNextSession(evt.next_session, evt.next_star_gifts.length > 0 ) ;//下期榜单时间
			//to ui 
			// to ui
			var next_star_gifts:Array = new Array;
			for(var w:int=0; w< evt.next_star_gifts.length; w ++)
			{
				var obj_gift:Object = new Object;
				obj_gift.gift_id = evt.next_star_gifts[w];
				SetGiftData(obj_gift);//设置礼物名字和图标等信息
				
				next_star_gifts.push( obj_gift );
			}
			m_client.GetUICallback().LoadStarGiftRankRes(rank_ui, next_star_gifts, next_time );
		}
		
		private function GetNextSession(next_session:int,hasGift:Boolean):String
		{
			var next_time:String = new String( "");
			if( hasGift && next_session >0)
			{
				var date1:Date = new Date( );
				date1.time = next_session * 7 *24 * 3600 * 1000 - 3 * 24 * 3600*1000;
				var month1:int =  date1.month+1;
				next_time =month1.toString() +"."+ date1.date.toString() +  " - " ;
				// 加6天
				var date2:Date = new Date( );
				date2.time = date1.time + 6*24*3600*1000;
				var month2:int =  date2.month+1;
				next_time +=month2.toString() +"."+ date2.date.toString()  ;
			}
			return next_time;
		}
		
		private function ToVideoStarGiftAnchorRankUI(source:VideoStarGiftAnchorRank , target:VideoStarGiftAnchorRankForUI,order:int):void
		{
			target.anchor_id = source.anchor_id.toString();
			target.anchor_nick_str = source.anchor_nick_str.replace(/\\/g,"\\\\");
			target.anchor_level= source.anchor_level;
			if(source.last_order == 0)//表示第一次进入榜单
			{
				target.order_change = 101 - (order +1);
			}
			else
			target.order_change = source.last_order - (order+1);
			target.score= source.score;
			target.portrait_url = source.portrait_url;
			
			target.portrait_url  = Globals.m_pic_download_url + "/qdancersec/" +  source.portrait_url + "/0" + URLSuffix.CreateVersionString();
			target.room_id = source.room_id;
			target.anchor_status = source.anchor_status;
		}

		private function ToVideoStarGiftpalyerRankUI(source:VideoStarGiftPlayerRank , target:VideoStarGiftPlayerRankForUI,order:int):void
		{
			target.player_id = source.player_id.toString();
			target.player_nick_str = source.player_nick_str.replace(/\\/g,"\\\\");
			target.zone_str = source.zone_str;
			target.sex = source.sex;
			target.have_portrait = source.have_portrait;
			target.wealth_level = source.wealth_level;
			if(source.last_order == 0)//表示第一次进入榜单
			{
				target.order_change = 101 - (order +1);
			}
			else
				target.order_change = source.last_order - (order+1);
			target.score = source.score;
			if( target.have_portrait != 0)
				target.portrait_url  = Globals.m_pic_download_url + "/qdancersec/" +  source.portrait_url + "/0" + URLSuffix.CreateVersionString();
			else
				target.portrait_url  = "";
		}
		
		/**
		 * 冠军榜返回
		 * @param ev
		 * 
		 */	
		private function HandleCEventLoadStarGiftChampionRankRes(ev:INetMessage):void
		{
			var evt:CEventLoadStarGiftChampionRankRes = ev as CEventLoadStarGiftChampionRankRes;
			if( evt == null )
				return ;
			var rank_ui:Array = new Array;
			var rank_player:Array = new Array;
			for(var j:int=0; j< evt.m_anchor_rank.length&& j < evt.m_player_rank.length; j ++)
			{
				var obj_rank:Object = new Object;
				obj_rank.gift_id =  evt.m_anchor_rank[j].gift_id;
				SetGiftData(obj_rank);//设置礼物名字和图标等信息			
			
				
				//ToVideoStarGiftAnchorRankUI(evt.m_anchor_rank[j] , anchor_ui);
				obj_rank.anchor_id = evt.m_anchor_rank[j] .anchor_id.toString();
				obj_rank.anchor_nick_str = evt.m_anchor_rank[j] .anchor_nick_str.replace(/\\/g,"\\\\");
				obj_rank.anchor_level= evt.m_anchor_rank[j] .anchor_level;
				obj_rank.last_order= evt.m_anchor_rank[j] .last_order;
				obj_rank.score= evt.m_anchor_rank[j] .score;
				obj_rank.portrait_url = evt.m_anchor_rank[j] .portrait_url;
				
				obj_rank.portrait_url  = Globals.m_pic_download_url + "/qdancersec/" +  evt.m_anchor_rank[j] .portrait_url + "/0" + URLSuffix.CreateVersionString();
				obj_rank.room_id = evt.m_anchor_rank[j] .room_id;
				obj_rank.anchor_status = evt.m_anchor_rank[j] .anchor_status;
				
				Globals.s_logger.debug("冠军主播榜："+ JSON.stringify(evt.m_player_contribution));
				//添加贡献王信息
				for( var i:int=0; j<evt.m_player_contribution.length; i++){
					if(evt.m_player_contribution[i].anchor_id == obj_rank.anchor_id && evt.m_player_contribution[i].gift_id == obj_rank.gift_id){
						obj_rank.player_id = evt.m_player_contribution[i].player_id;
						obj_rank.player_nick_str = evt.m_player_contribution[i].player_nick_str;
						obj_rank.wealth_level = evt.m_player_contribution[i].wealth_level;
						obj_rank.gift_contribution = evt.m_player_contribution[i].gift_contribution;
						break;
					}
				}
				
				rank_ui.push( obj_rank);
				
				var obj_player:Object = new Object;
				obj_player.gift_id  = obj_rank.gift_id;
				SetGiftData(obj_player);
				//var palyer_ui:VideoStarGiftPlayerRankForUI = new VideoStarGiftPlayerRankForUI;
				//ToVideoStarGiftpalyerRankUI(evt.m_player_rank[j] , palyer_ui);
				obj_player.player_id = evt.m_player_rank[j].player_id.toString();
				obj_player.player_nick_str = evt.m_player_rank[j].player_nick_str.replace(/\\/g,"\\\\");
				obj_player.zone_str = evt.m_player_rank[j].zone_str;
				obj_player.sex = evt.m_player_rank[j].sex;
				obj_player.have_portrait = evt.m_player_rank[j].have_portrait;
				obj_player.wealth_level = evt.m_player_rank[j].wealth_level;
				obj_player.last_order = evt.m_player_rank[j].last_order;
				obj_player.score = evt.m_player_rank[j] .score;
				if( obj_player.have_portrait != 0)
					obj_player.portrait_url  = Globals.m_pic_download_url + "/qdancersec/" +  evt.m_player_rank[j].portrait_url + "/0" + URLSuffix.CreateVersionString();
				else
					obj_player.portrait_url  = "";
				
				rank_player.push(obj_player);
			}
			m_client.GetUICallback().LoadStarGiftChampionRankRes(rank_ui,rank_player,evt.none_config);
		}
		
		private function HandleCEventStarGiftChampionNotify(ev:INetMessage):void
		{
			var evt:CEventStarGiftChampionNotify = ev as CEventStarGiftChampionNotify;
			// to ui
			var star_gift_info:Array = new Array;
			for(var j:int=0; j< evt.gift_ids.length; j ++)
			{
				var obj_gift:Object = new Object;
				obj_gift.gift_id = evt.gift_ids[j];
				SetGiftData(obj_gift);//设置礼物名字和图标等信息
				
				star_gift_info.push( obj_gift );
			}
			m_client.GetUICallback().StarGiftChampionNotify(star_gift_info,evt.anchor_id);
		}
		
		private function HandleCEventRefreshStarGiftInfo(ev:INetMessage):void
		{
			var evt:CEventRefreshStarGiftInfo = ev as CEventRefreshStarGiftInfo;
			
			// to ui
			m_star_gift_info = new Array;
			
			for(var j:int=0; j< evt.cur_star_gifts.length; j ++)
			{
				var obj_gift:Object = new Object;
				obj_gift.gift_id = evt.cur_star_gifts[j];
				SetGiftData(obj_gift);//设置礼物名字和图标等信息
				
				m_star_gift_info.push( obj_gift );
			}
			m_star_gift_champion = evt.star_gift_champion;
			m_client.GetUICallback().RefreshStarGiftInfo(m_star_gift_info,m_star_gift_champion);
		}
		
		private function HandleCEventLoadAnchorStarGiftInfoRes(ev:INetMessage):void
		{
			var evt:CEventLoadAnchorStarGiftInfoRes = ev as CEventLoadAnchorStarGiftInfoRes;
			// to ui
			var star_gift_info:Array = new Array;
			for(var j:int=0; j< evt.star_gift_info.length; j ++)
			{
				var obj_gift:Object = new Object;
				obj_gift.gift_id = evt.star_gift_info[j].gift_id;
				SetGiftData(obj_gift);//设置礼物名字和图标等信息
				//设置下拉列表等
				obj_gift.drop_list = CGiftConfig.getInstance().GetGiftDropListData( obj_gift.gift_id );
				obj_gift.gift_cnt = evt.star_gift_info[j].gift_cnt;
				obj_gift.rank = evt.star_gift_info[j].rank;
				obj_gift.last_anchor_rank = evt.star_gift_info[j].last_anchor_rank;
				obj_gift.gift_count_diff = evt.star_gift_info[j].gift_count_diff;
				
				star_gift_info.push( obj_gift );
			}
			//添加周星赛结果信息
			var match_info:AnchorWeekStarMatchInfo = new AnchorWeekStarMatchInfo();
			
			match_info.status = evt.match_info.status;
			match_info.total_score = evt.match_info.total_score;
			match_info.total_rank = evt.match_info.total_rank;
			match_info.sub_rank = evt.match_info.sub_rank;
			match_info.group_name = evt.match_info.group_name;
			match_info.grade = evt.match_info.grade;
			match_info.sub_level = evt.match_info.sub_level;
			match_info.week_star_medals = evt.match_info.week_star_medals;
			
			Globals.s_logger.debug("match_info:"+JSON.stringify(evt));
			var sex:int = 0;
			var url:String = "";
			if( evt.m_anchor_id.equal(  m_room.GetAnchorQQ() ) )
			{
				sex = m_room.GetAnchorGender();
				url =  m_room.GetAnchorUrl();
			}
			
			m_client.GetUICallback().LoadAnchorStarGiftInfoRes(evt.m_anchor_id,star_gift_info,match_info,sex,url);
		}
		
		// 通知被抢座
		private function HandleCEventNotifyLostVipSeat(ev:INetMessage):void
		{
			var evt:CEventNotifyLostVipSeat = ev as CEventNotifyLostVipSeat;
			if( !evt )
				return;
			m_client.GetUICallback().NotifyLostVipSeat(evt.seat_index,evt.cost,evt.player_nick.replace(/\\/g,"\\\\"),evt.player_zone);
		}
		
		private function HandleCEventTakeVipSeatRes(ev:INetMessage):void
		{
			var evt:CEventTakeVipSeatRes = ev as CEventTakeVipSeatRes;
			if( !evt )
				return;

			var info:VipSeatInfoForUI = new VipSeatInfoForUI;
			ToVipSeatInfoForUI(evt.seat_info, info);
			
			var free_times:int = -1;
			if( evt.pstid.equal( m_client.GetSelfPersistID()  )) 
				 free_times =  evt.free_times;

			m_client.GetUICallback().TakeVipSeatRes(evt.res, evt.seat_index, evt.balance, evt.cost ,evt.pstid, info, free_times, evt.charm);
			
			
			if( evt.pstid.equal( m_client.GetSelfPersistID() )  )//是我自己抢的
			{
				if( evt.res == TakeSeatResult.TSR_Success )//成功的话 发系统消息
				{
					var msg_sys : VideoRoomMsgData = new VideoRoomMsgData;
					
					msg_sys.channel = ChatChannel.VIDEOCHNL_System;//系统消息
					msg_sys.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
					msg_sys.systemType = 0;
					var protect_time:int = info.protect_time /60;
					var defend:String ="";
					
					if (info.vip_level ==4)
						defend = "亲王";
					else if (info.vip_level == 5)
						defend = "皇帝";
					if(evt.cost > 0 )//花钱
					{
						if( m_room.IsLive() || m_room.isNest() )//开播或者是小窝
						{
							if (info.vip_level > 3) //亲王级以上身份
								msg_sys.msg = "$t$恭喜您成功抢到了座位！ 您的财富值+" + evt.cost
									+ "，主播的星耀值+" + evt.cost
									+ (evt.charm > 0 ? "，房间魅力值+" + evt.charm : "")
									+ "，你们之间的亲密度+" + evt.cost + "。"
									+ defend + "将拥有" + protect_time + "分钟座位保护时间!$z";
							else //将军及以下身份
								msg_sys.msg = "$t$恭喜您成功抢到了座位！ 您的财富值+" + evt.cost
									+ "，主播的星耀值+" + evt.cost
									+ (evt.charm > 0 ? "，房间魅力值+" + evt.charm : "")
									+ "，你们之间的亲密度+" + evt.cost + "。$z";
						}
						else
						{
							if( info.vip_level > 3)//亲王级以上身份
								msg_sys.msg = "$t$恭喜您成功抢到了座位！ 您的财富值+"+  evt.cost +"。" + defend+"将拥有"+ protect_time +"分钟座位保护时间!$z";
							else//将军及以下身份
								msg_sys.msg = "$t$恭喜您成功抢到了座位！ 您的财富值+"+ evt.cost+"。$z";
						}
					}
					else//免费
					{
						if (info.vip_level > 3) //亲王级以上身份							
							msg_sys.msg = "$t$恭喜您成功抢到了嘉宾席座位！"
								+ (evt.charm > 0 ? "房间魅力值+" + evt.charm + "," : "")
								+ defend + "将拥有" + protect_time + "分钟座位保护时间！$z";
						else //将军及以下身份
							msg_sys.msg = "$t$恭喜您成功抢到了嘉宾席座位！"
								+ (evt.charm > 0 ? "房间魅力值+" + evt.charm : "") + "$z";
					}
					m_client.GetUICallback().OnReceiveChatMsg(msg_sys);
				}
				
				if( evt.seat_info.cost_seat == true )//不是免费抢的才设置
					m_client.GetVideoClientPlayer().SetVideoMoney(-1,Int64.fromNumber(evt.balance));//抢座成功设置余额

			}

			Globals.s_logger.debug("CEventTakeVipSeatRes pstid" + evt.pstid.toString() + "local id:" +m_client.GetSelfPersistID().toString() +" balance " +evt.balance  );
			if( evt.res == TakeSeatResult.TSR_Success )//抢座成功发飞屏
			{
				//发飞屏;
				var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
				
				msg_data.channel = ChatChannel.VIDEOCHNL_Whistle;//飞屏
				msg_data.viplevel = evt.seat_info.vip_level;
				msg_data.sender_defend = evt.seat_info.guard_level;
				msg_data.senderZoneName = evt.seat_info.zone;
				msg_data.senderName = evt.seat_info.nick.replace(/\\/g,"\\\\");
				msg_data.wealth_level = evt.seat_info.wealth_level;
				msg_data.isSelf = evt.pstid.equal( m_client.GetSelfPersistID() ) == true ? 3: 4;//区分是谁发的飞屏
				msg_data.isTakeVip = true;
				//XW78334 抢座显示两个名字
				msg_data.msg = "$t$" +"抢到座位说:\"" + CVipSeatClientConfig.getInstance().GetVipSeatMsg(evt.seat_info.take_time)+"\"$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
		}
		
		private function HandleCEventRefreshVipSeats(ev:INetMessage):void
		{
			var evt:CEventRefreshVipSeats = ev as CEventRefreshVipSeats;
			if( !evt )
				return;
			
			var infos:Array = new Array;
			for( var i:int =0; i < evt.seat_list.length; i ++)
			{
				var info:VipSeatInfoForUI = new VipSeatInfoForUI;
				ToVipSeatInfoForUI(evt.seat_list[i],info);
				infos.push(info);
			}
			m_client.GetUICallback().RefreshVipSeats(infos );
		}
		public function ToVipSeatInfoForUI(sinfo:VipSeatInfo, tinfo:VipSeatInfoForUI ):void
		{
			tinfo.gender = sinfo.gender;
			tinfo.has_portrait = sinfo.has_portrait;
			if (tinfo.has_portrait) {
				//XW79794 去除头像随机数
				tinfo.pic_url = Globals.m_pic_download_url + "/qdancersec/" + sinfo.pic_url;// + "/0" + URLSuffix.CreateVersionString();
			} else {
				tinfo.pic_url = "";
			}
			tinfo.level = sinfo.level;
			tinfo.nick = sinfo.nick.replace(/\\/g,"\\\\");
			tinfo.player_id = sinfo.player_id.toString();
			tinfo.take_cost = sinfo.take_cost;
			tinfo.taken_cnt = sinfo.taken_cnt;
			tinfo.video_room_wealth = sinfo.video_room_wealth.toString();
			tinfo.vip_level = sinfo.vip_level;
			tinfo.guard_level =sinfo.guard_level;
			tinfo.cost_seat = sinfo.cost_seat;
			//从本地获取保护时间
			var prot:int = m_seat_protect_time[tinfo.vip_level]; 
			tinfo.protect_time = prot;//
			tinfo.begin_time = sinfo.take_time;
			tinfo.wealth_level = sinfo.wealth_level;
			tinfo.zone = sinfo.zone;
		}
		private function HandleCEventNotifyVipTakeSeatProtectTime(ev:INetMessage):void
		{
			var evt:CEventNotifyVipTakeSeatProtectTime = ev as CEventNotifyVipTakeSeatProtectTime;
			if( !evt )
				return;
			m_seat_protect_time = evt.seat_protect_time;//服务器发过来的是秒。。
			m_client.GetUICallback().NotifyVipTakeSeatProtectTime(evt.seat_protect_time);
		}
		
		private function HandleCEventAllVipSeatsOccupiedBroadcastAllRoom(ev:INetMessage):void
		{
			var evt:CEventAllVipSeatsOccupiedBroadcastAllRoom = ev as CEventAllVipSeatsOccupiedBroadcastAllRoom;
			if( !evt )
				return;
			//发走马灯
			var msg:String = "【"+evt.room_id.toString() +"-"+evt.room_name +"】"+"座无虚席，太火爆了!你还不赶紧去看看！！！";
			m_client.GetUICallback().NotifyVipTakeSeatFull(msg);
		}
		
		//刷新主播等级榜
		private function HandleCEventRefreshAnchorLevelRank(ev:INetMessage):void
		{
			var evt:CEventRefreshAnchorLevelRank = ev as CEventRefreshAnchorLevelRank;
			if(evt == null)
			{
				return;
			}
			var anchorLevelRankUi:Array = new Array();
			for each(var anchor:VideoAnchorLevelRank in evt.rank_vec)
			{
				var uidata:VideAnchorLevelRankUiData = new VideAnchorLevelRankUiData();
				uidata.anchor_gender = anchor.anchor_gender;
				uidata.anchor_id = anchor.anchor_id.toString();
				uidata.anchor_nick = anchor.anchor_nick_str.replace(/\\/g,"\\\\");
				uidata.anchor_status = anchor.anchor_status;
				
				if(anchor.anchor_url != "")
				{
					uidata.anchor_url = Globals.m_pic_download_url + "/qdancersec/" + anchor.anchor_url + "/0" + URLSuffix.CreateVersionString();
				}
				
				uidata.exp = anchor.exp;
				uidata.level = anchor.level;
				uidata.room_id = anchor.room_id;
				uidata.starlight = anchor.starlight.toString();
				
				anchorLevelRankUi.push(uidata);
			}
			
			m_client.GetUICallback().OnRefreshAnchorLevelRank(anchorLevelRankUi);
		}
		
		//守护等级改变
		private function HandleCEventVideoRoomGuardLevelChange(ev:INetMessage):void
		{
			var evt:CEventVideoRoomGuardLevelChange = ev as CEventVideoRoomGuardLevelChange;
			var isSelfGuardLevelChange:Boolean = false;
			
			if(evt.player_id.equal(m_client.GetVideoClientPlayer().GetVideoPersistID()))
			{
				isSelfGuardLevelChange = true;
			}
			
			m_client.GetUICallback().OnGuardLevelChangeNotify(evt.player_name.replace(/\\/g,"\\\\"),evt.player_zone,evt.anchor_name.replace(/\\/g,"\\\\"),evt.old_guard_level,evt.new_guard_level,evt.vip_level,isSelfGuardLevelChange);
			
			if(evt.condition_type == VideoGuardConditionType.VGCT_Affinity 
				|| evt.condition_type == VideoGuardConditionType.VGCT_Follower 
				|| evt.condition_type == VideoGuardConditionType.VGCT_ManualAssign)
			{
				var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
				msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
				msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
				msg_data.systemType = 0;//默认消息类型
				msg_data.msg = "$t$恭喜你~由于您对主播"
					+evt.anchor_name.replace(/\\/g,"\\\\")
					+ "完成了条件，亲密度达到" 
					+ m_guard_cfg.GetRequireAffinity(evt.new_guard_level)
					+"成为Ta的"
					+m_guard_cfg.GetGuardNameByLevel(evt.new_guard_level)
					+ "$z";
				
				if(isSelfGuardLevelChange)
				{
					m_client.GetUICallback().OnReceiveChatMsg(msg_data);
					m_client.GetUICallback().OnVideoRoomRefreshGuardLevel(evt.new_guard_level);
				}
			}		
		}
		
		private function HandleCEventRefreshVideoRichRank(ev:INetMessage):void
		{
			var evt:CEventRefreshVideoRichRank = ev as CEventRefreshVideoRichRank;
			var rank:Array = new Array;

			for (var i:int = 0; i < evt.rank.length; ++i)
			{
				var richrank:VideoRichRank = evt.rank[i] as VideoRichRank;
				var data:RichRankData = new RichRankData;
				data.m_player_id = richrank.player_id.toString();
				data.m_player_nick = richrank.player_nick_str.replace(Pattern,"\\\\");
				data.m_video_wealth = richrank.video_wealth.toString();
				data.m_player_zone = richrank.player_zone_str;
				data.m_wealth_level = richrank.wealth_level;
				data.m_video_wealth_total = richrank.video_wealth_total.toString();
 					
				if(richrank.last_order == 0)//表示第一次进入榜单
				{
					data.m_order_change = 1001 - (Globals.richRankRequestBeginIndex + i+1);
				}
				else
				{
					data.m_order_change = richrank.last_order - (Globals.richRankRequestBeginIndex + i+1);
				}
				rank.push(data);
			}
			
			var my_rank:int = -1;
			if (m_client.GetType() == VideoClientType.VCT_X5Client)
			{
				for each(var tmp:int in evt.id_to_rank_index)//里面只有一个值
					my_rank = tmp;
			}
			m_client.GetUICallback().OnLoadVideoRichRank(VideoResultType.VREST_Normal, rank, evt.total_size, my_rank,evt.rank_timedimension);
		}

		private function HandleCEventLoadVideoLevelRankRes(ev:INetMessage):void
		{
			var evt:CEventLoadVideoLevelRankRes = ev as CEventLoadVideoLevelRankRes;
			var rankUI:Array = new Array;
			for (var key:int = 0; key < evt.rank.length; key++)
			{
				var data:VideoLevelRankDataForUI = new VideoLevelRankDataForUI;
				
				data.m_pstid = evt.rank[key].pstid.toString();
				data.m_nick = evt.rank[key].nick_str.replace(Pattern,"\\\\");
				data.m_sex = evt.rank[key].sex;
				data.m_zone = evt.rank[key].zone_str;
				data.m_portrait_url = "";
				data.m_level = evt.rank[key].level;
				rankUI.push(data);
			}
			
			var my_rank:int = -1;
			if (m_client.GetType() == VideoClientType.VCT_X5Client)
			{
				my_rank = evt.my_rank;
			}
			m_client.GetUICallback().OnLoadVideoLevelRank(VideoResultType.VREST_Normal, rankUI, evt.total_size, my_rank);
		}
		
		private function HandleCEventLoadAnchorImpressRes(ev:INetMessage):void
		{
			var evt:CEventLoadAnchorImpressRes = ev as CEventLoadAnchorImpressRes;
			if(evt == null)
			{
				return;
			}
			
			var data:Array = new Array;
			var server_data:Array = evt.impressiondata.impressions;
			var size:int = server_data.length;
			for each(var itr:AnchorImpressionData in server_data)
			{
				var temp:	AnchorImpressionDataForUI = new AnchorImpressionDataForUI;
				temp.m_count = itr.count;
				temp.m_impression_id = itr.impression_id;
				data.push(temp);
			}

			//刷新本地数据---只有当前房间的主播id等于加载的主播信息时 才刷新本地的
			if( evt.player_id.equal( GetAnchorQQ()))
			{
				m_room.UpdateLiveDetailImpression(evt.impressiondata);
			}
			m_client.GetUICallback().OnLoadAnchorImpressionForAnchor(VideoResultType.VREST_Normal, data, evt.impressiondata.total_count, evt.impressiondata.player_count);
		}
		
		private function HandleCEventVideoRoomRefreshGuardLevel(ev:INetMessage):void
		{
			var evt:CEventVideoRoomRefreshGuardLevel = ev as CEventVideoRoomRefreshGuardLevel;
			m_selfInfo.m_guardlevel_with_cur_anchor = evt.guard_level;
			m_client.GetUICallback().OnVideoRoomRefreshGuardLevel(evt.guard_level);
		}

		/**
		 * 贵族进房广播消息。
		 * 注：xw81899新增绑定主播判断。
		 * @param ev
		 *
		 */
		private function HandleCEventVideoRoomEnterRoomBroadcast(ev:INetMessage):void {
			var evt:CEventVideoRoomEnterRoomBroadcast = ev as CEventVideoRoomEnterRoomBroadcast;
			if (evt == null) {
				return;
			}

			//守护提示不受xw81899影响
			//守护等级大于400显示守护提示即特效
			var isGuardMsg:Boolean  = evt.guard_level_new >= 400;

			var roomAnchorId:Number = m_room.GetAnchorQQ().toNumber();
			//未开播的小窝房间拿不到主播id，需要使用basic里面的信息。
			if (roomAnchorId == 0 && m_room.isNest()) {
				roomAnchorId = m_room.getBasicInfoAnchorQQ();
			}
			var isAttachedAnchor:Boolean = evt.attached_anchor_id.toNumber() > 0 && evt.attached_anchor_id.toNumber() == roomAnchorId;

			//xw84201 进房信息参考QA_20160712
			var needShowMsg:Boolean      = false;
			// 守护天尊及以上 
			if (isGuardMsg) {
				needShowMsg = true;
			}
			// 贵族等级大于将军 按照原有逻辑显示，不受限制
			else if (evt.vip_level > VipLevelEnum.jiangjun_viplevel) {
				needShowMsg = true;
			}
//			// 近卫以上身份且绑定了主播
//			else if (isAttachedAnchor && evt.vip_level > VipLevelEnum.jinwei_viplevel) {
//				needShowMsg = true;
//			}
			// 将军及以下贵族
			else {
				// 天使守护 以上 并显示对应的vip信息
				if (evt.guard_level_new >= 100) {
					needShowMsg = true;
				} else {
					// 绑定主播的vip等级大于近卫的显示进房信息。
					if (isAttachedAnchor) {
						if (evt.vip_level > VipLevelEnum.jinwei_viplevel) {
							needShowMsg = true;
						}
					}
				}
			}

			if (needShowMsg) {
				var msg_data:VideoRoomMsgData = new VideoRoomMsgData;
				msg_data.channel = ChatChannel.VIDEOCHNL_System; //系统消息
				msg_data.TextColor = WebColor.systemInfoTextColor; //系统消息颜色
				msg_data.systemType = 2; //vip或者守护进入本房间的通知
				msg_data.senderPlayerID = evt.pstid.toString();//
				msg_data.viplevel = evt.vip_level;
				msg_data.sender_defend = evt.guard_level_new;
				msg_data.senderName = evt.player_name;
				msg_data.senderZoneName = evt.player_zone;
				msg_data.vipCardPattern = GetVipNameByVipLevel(evt.vip_level);
				msg_data.wealth_level = evt.wealth_level;
				msg_data.is_vip_with_anchor = isAttachedAnchor;
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				Globals.s_logger.debug("pstid ="+evt.pstid.toString());
			}

			var needShowAni:Boolean = false;
			if (isGuardMsg) {
				needShowAni = true;
			}
			// 贵族等级大于将军 按照原有逻辑显示，不受限制
			else if (evt.vip_level > VipLevelEnum.jiangjun_viplevel) {
				needShowAni = true;
			}
			// 将军身份进入绑定主播房间
			else if (evt.vip_level == VipLevelEnum.jiangjun_viplevel && isAttachedAnchor) {
				needShowAni = true;
			}
			if (needShowAni) {
				var isSelf:Boolean = (evt.player_name == m_client.GetVideoClientPlayer().GetVideoNick());
				m_client.GetUICallback().NotifyVipEnterRoom(evt.player_name.replace(/\\/g, "\\\\"),
					evt.player_zone, evt.vip_level, evt.sex_male, evt.invisible, isSelf, evt.guard_level_new, evt.wealth_level);
			}
		}
		
		private function GetVipNameByVipLevel(viplevel:int):String
		{
			var name:String = "";
			switch(viplevel)
			{
				case VipLevelEnum.jinwei_viplevel:
					name = VipNameEnum.jinwei_vipName;
					break;
				case VipLevelEnum.qishi_viplevel:
					name = VipNameEnum.qishi_vipName;
					break;
				case VipLevelEnum.jiangjun_viplevel:
					name = VipNameEnum.jiangjun_vipName;
					break;
				case VipLevelEnum.qinwang_viplevel:
					name = VipNameEnum.qinwang_vipName;
					break;
				case VipLevelEnum.huangdi_viplevel:
					name = VipNameEnum.huangdi_vipName;
					break;
			}			
			return name;
		}
		
		private function HandleCEventShareConfig(ev:INetMessage):void
		{
			var evt:CEventVideoRoomShareConfig = ev as CEventVideoRoomShareConfig;
			if(evt == null)
			{
				return;
			}
			
			Globals.s_logger.debug("HandleCEventShareConfig() : evt.video_bunam = " + evt.video_buname);
			m_cdn_buname = evt.video_buname;
			Globals.video_buname = m_cdn_buname;
			m_pic_download_url = evt.pic_download_url;
			Globals.m_pic_download_url = m_pic_download_url;
			
			m_client.SetVideoAdUrl(evt.video_add_url);
			
			Globals.VideoGroupID = evt.video_zone_id;
			
			m_client.SetRoomIcons(evt.video_room_icon);
			
			m_client.SetVipUrl(evt.vip_url);
			
			m_client.SetQgame_item_image_url(evt.m_qgame_item_image_url);
			
			if(m_concert_client)
			{
				var concert_client :CConcertClient= m_concert_client as CConcertClient;
				if(concert_client != null)
				{
					concert_client.SetBuyConcertTicketURL(evt.buy_concert_ticket_url);
				}
			}
		}
		//守护
		private function HandleCEventVideoRoomLoadSuperGuardResult(evt:INetMessage):void
		{
			var ev:CEventVideoRoomLoadSuperGuardResult = evt as CEventVideoRoomLoadSuperGuardResult;
			
			m_super_guards = ev.super_guards_new;
			//刷常驻榜
			var super_guards_ui :Array = new Array();
			SuperGuardMapToVec(m_super_guards,super_guards_ui);
			m_client.GetUICallback().OnLoadSuperFans(SuperType.SuperGuardRank,0,super_guards_ui);
		}
		
		private var vipFansData:Dictionary = new Dictionary();
		// 贵宾席回调
		private function HandleVideoRoomVipSeatPlayerInfo(ev:INetMessage):void
		{
			var evt:CEventVideoRoomVipSeatsInfo = ev as CEventVideoRoomVipSeatsInfo;
			var logic_data_size : int = evt.vipseat_player_infos_new.length;
			var vipseat_data:Array = new Array();
			
			var vipseat_size : int = RoomVipSeatCnt.videoroom_vipseat_count ;
			var superfans_size : int= VideoRoomSuperFansCnt.videoroom_superfans_count ;
			var isFind:Boolean = false;
			if(evt.is_fans == false)
			{	
				if(vipseat_size > logic_data_size)
				{
					vipseat_size = logic_data_size;
				}
			}
			else
			{
				vipseat_data = new Array;
				
				if(superfans_size > logic_data_size)
				{
					superfans_size = logic_data_size;
				}
			}
			
			var data:ClientAnchorData = new ClientAnchorData;
			GetCurrentAnchorDataForUI( data );
		
			m_super_fans = new Array;
			
			for(var i:int = 0; i < evt.vipseat_player_infos_new.length ; ++i)
			{
				var play_info:VideoRoomPlayerInfo = evt.vipseat_player_infos_new[i] as VideoRoomPlayerInfo;
				var vip_seat :VideoRoomAffinity = VideoRoomPlayerInfo2VideoRoomAffinity(play_info, data.name);
				isFind = false;
				for (var playerid:String in vipFansData)
				{
					if(playerid == vip_seat.playerID)
					{
						vip_seat.portraitUrl = vipFansData[playerid];
						isFind = true;
						break;
					}
				}
				
				if(!isFind)
				{
					if( play_info.portrait_info != 0 && play_info.m_player_url != "")
					{
						vip_seat.portraitUrl = Globals.m_pic_download_url + "/qdancersec/" + play_info.m_player_url + "/0" + URLSuffix.CreateVersionString();
					}
					vipFansData[vip_seat.playerID] = vip_seat.portraitUrl;
				}
				
				if(i < vipseat_size && evt.is_fans == false)
				{
					vipseat_data.push(vip_seat);
				}
				else if(i < superfans_size && evt.is_fans)
				{
					m_super_fans.push(vip_seat);
				}
			}
			if(evt.is_fans == false)
			{
				m_client.GetUICallback().OnLoadVipSeats(0, vipseat_data);
			}
			else
			{
				m_super_fans.sort(VideoRoomAffinityCmp);
				m_client.GetUICallback().OnLoadSuperFans(SuperType.SuperFansRank,0,m_super_fans);
			}
		}

		/**
		 * 刷新超级粉丝
		 * @param superFans
		 *
		 */
		public function RefreshSuperFans(superFans:Array):void {
			var anchorData:ClientAnchorData = new ClientAnchorData;
			GetCurrentAnchorDataForUI(anchorData);

			var superfans_size:int = VideoRoomSuperFansCnt.videoroom_superfans_count;
			if (superfans_size > superFans.length) {
				superfans_size = superFans.length;
			}

			m_super_fans = new Array();
			var isFind:Boolean = false;
			for (var i:int = 0; i < superFans.length; ++i) {
				var play_info:VideoRoomPlayerInfo = superFans[i] as VideoRoomPlayerInfo;
				var vip_seat:VideoRoomAffinity    = VideoRoomPlayerInfo2VideoRoomAffinity(play_info, anchorData.name);
				isFind = false;
				for (var playerid:String in vipFansData) {
					if (playerid == vip_seat.playerID) {
						vip_seat.portraitUrl = vipFansData[playerid];
						isFind = true;
						break;
					}
				}

				if (!isFind) {
					if (play_info.portrait_info != 0 && play_info.m_player_url != "") {
						vip_seat.portraitUrl = Globals.m_pic_download_url + "/qdancersec/" + play_info.m_player_url + "/0" + URLSuffix.CreateVersionString();
					}
					vipFansData[vip_seat.playerID] = vip_seat.portraitUrl;
				}
				if (i < superfans_size) {
					m_super_fans.push(vip_seat);
				}
			}

			m_super_fans.sort(VideoRoomAffinityCmp);
			m_client.GetUICallback().OnLoadSuperFans(SuperType.SuperFansRank, 0, m_super_fans);
		}

		public function VideoRoomGetLiveCDN():void {
			m_room.VideoRoomGetLiveCDN();
		}
		
		private function HandleCEventRefreshStarlightRank(ev:INetMessage):void
		{
			var evt:CEventRefreshStarlightRank = ev as CEventRefreshStarlightRank;
			var rank:AnchorStarlightRankData = new AnchorStarlightRankData;
			
			for(var i:int = 0;i<evt.rank.length;i++)
			{				
				var tmp:VideoStarlightRank = evt.rank[i] as VideoStarlightRank;
				var data:ClientAnchorData = new ClientAnchorData;
				data.name = tmp.anchor_nick_str.replace(Pattern,"\\\\");
				data.starlight = tmp.score.toString();
				data.anchorQQ = tmp.anchor_id.toString();
				data.anchorID = tmp.anchor_id.toString();
				data.status = tmp.anchor_status;
				data.room_id = tmp.room_id;
				data.anchor_gender = tmp.anchor_gender;
				data.is_nest = tmp.is_nest;
				data.anchor_level = tmp.anchor_level;
				if(tmp.m_anchor_url != "")
				{
					data.photoUrl =Globals.m_pic_download_url + "/qdancersec/" + tmp.m_anchor_url + "/0" + URLSuffix.CreateVersionString();	
				}
				FillAnchorImageUrl(data);
				if(tmp.last_order == 0)//表示首次入榜
				{
					data.order_change = 13 - (i+1);
				}
				else
				{
					data.order_change = tmp.last_order - (i+1);
				}
				rank.anchorRank.push(data);
			}
			//tqos上报 begin
			var tqos:TQOSHomePageLoadTime = new TQOSHomePageLoadTime();
			tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nLoadSuccTime = flash.utils.getTimer() - TQOSHomePageLoadTime.nBeginTime;
			tqos.Response();
			//tqos上报 end
			
			m_client.GetUICallback().OnLoadAnchorStarlightRank(0, rank,evt.rank_timedimension);			
		}
		
		public function HandleCEventRefreshPopularityRank(ev:INetMessage):void
		{
			var evt:CEventRefreshPopularityRank = ev as CEventRefreshPopularityRank;
			var rank:AnchorStarlightRankData = new AnchorStarlightRankData;
			
			for each(var tmp:VideoPopularityRank in evt.rank)
			{
				var data:ClientAnchorData = new ClientAnchorData;
				data.name = tmp.anchor_nick_str;
				data.starlight = tmp.score.toString();
				data.anchorQQ = tmp.anchor_id.toString();
				data.anchorID = tmp.anchor_id.toString();
				FillAnchorPortraitUrl(data);
			
				FillAnchorImageUrl(data);
				rank.anchorRank.push(data);
			}
			m_client.GetUICallback().OnLoadAnchorPopularityRank(VideoResultType.VREST_Normal, 0, rank);		
		}
		
		public function HandleCEventRefreshStarAnchorRank(ev:INetMessage):void
		{
			var evt:CEventRefreshStarAnchorRank = ev as CEventRefreshStarAnchorRank;
			var ranklist:Array = new Array;
			for each(var tmp:VideoStarAnchorRank in evt.rank)
			{
				var rankinfo:ClientStarAnchorRankData = new ClientStarAnchorRankData;
				rankinfo.m_anchor_id = tmp.anchor_id.toString();
				rankinfo.m_score = tmp.score.toString();
				rankinfo.m_anchor_nick = tmp.anchor_nick_str;
				rankinfo.m_talent_show_scores = tmp.talent_show_scores;
				rankinfo.m_talent_show_starlight = tmp.talent_show_starlight;
				rankinfo.m_talent_show_vote = tmp.talent_show_vote;
				ranklist.push(rankinfo);
			}
			m_client.GetUICallback().OnLoadStarAnchorScoreRank(VideoResultType.VREST_Normal, 0, ranklist, "");
		}
		
		public function VideoVIPRank2VideoVIPRankData(rank:VideoVIPRank):VideoVIPRankData
		{
			var data:VideoVIPRankData  = new VideoVIPRankData;
			data.m_player_id = rank.player_id.toString();
			data.m_player_nick = rank.player_nick_str.replace(Pattern,"\\\\");
			data.m_vip_level = rank.vip_level;
			data.m_vip_icon = m_vipConfig.GetVipIcon(rank.vip_level);
			data.m_video_wealth = rank.video_wealth.toString();
			data.m_player_zone = rank.player_zone_str;
			return data;
		}
		
		public function HandleCEventRefreshVideoVIPRank( evt:INetMessage ):void
		{
			var ev:CEventRefreshVideoVIPRank = evt as CEventRefreshVideoVIPRank;
			
			var rank:Array = new Array;
			for(var i:uint = 0; i < ev.rank.length;++i)
			{
				var data:VideoVIPRankData  = VideoVIPRank2VideoVIPRankData(ev.rank[i]);
				rank.push(data);
			}
			var my_rank :int= -1;
			if (m_client.GetType() == VideoClientType.VCT_X5Client)
			{
				for each (var tmp:int in ev.id_to_rank_index)
					my_rank = tmp;
			}
			m_client.GetUICallback().OnLoadVideoVIPRank(VideoResultType.VREST_Normal, rank, ev.total_size, my_rank);
		}

		public function HandleCEventRefreshTwoweekStarlightRank(evt:INetMessage):void
		{
			var ev:CEventRefreshTwoweekStarlightRank = evt as CEventRefreshTwoweekStarlightRank;
			var rank:AnchorStarlightRankData = new AnchorStarlightRankData ;
			for each(var itr:VideoTwoweekStarlightRank in ev.rank)
			{
				var data:ClientAnchorData = new ClientAnchorData;
				data.name = itr.anchor_nick_str.replace(Pattern,"\\\\");
				data.starlight = itr.score.toString();
				data.anchorID = itr.anchor_id.toString();
				data.anchorQQ = itr.anchor_id.toString();
				data.status = itr.anchor_status;
				data.room_id = itr.room_id;
				data.anchor_gender = itr.anchor_gender;
				data.is_nest = itr.is_nest;
				if(itr.m_anchor_url != "")
					data.photoUrl = Globals.m_pic_download_url + "/qdancersec/" + itr.m_anchor_url + "/0" + URLSuffix.CreateVersionString();
				FillAnchorImageUrl(data);
				rank.anchorRank.push(data);
			}
			m_client.GetUICallback().OnLoadAnchorTwoweekStarlightRank(VideoResultType.VREST_Normal, 0, rank);
		}
		
		public function HandleCEventRefreshAnchorScoreRank(ev:INetMessage):void 
		{
			var evt: CEventRefreshAnchorScoreRank = ev as  CEventRefreshAnchorScoreRank;
			var ui_data:Array = ToVideoAnchorScoreTankForUI(evt.rank);
			m_client.GetUICallback().OnLoadAnchorScoreRank(VideoResultType.VREST_Normal, ui_data,evt.rank_timedimension);
		}
		
		public function HandleCEventRefreshGuildChampionRank(ev:INetMessage):void
		{	
			var evt:CEventRefreshGuildChampionRank = ev as CEventRefreshGuildChampionRank;
			var ranklist:Array = new Array;
			for each(var tmp:VideoGuildChampionRank in evt.rank)
			{
				var rankinfo:ClientGuildChampionRankData = new ClientGuildChampionRankData;
				rankinfo.m_anchor_id = tmp.anchor_id.toString();
				rankinfo.m_score = tmp.score.toString();
				rankinfo.m_anchor_nick = tmp.anchor_nick_str;
				rankinfo.m_zone_id = tmp.zone_id;
				rankinfo.m_gc_starlight = tmp.gc_starlight;
				rankinfo.m_guild_vote = tmp.guild_vote;
				rankinfo.m_zone_honor = tmp.zone_honor.toString();
				rankinfo.m_score = tmp.score.toString();
				rankinfo.m_zone_name = tmp.zone_name;
				rankinfo.m_guild_name = tmp.guild_name;
				
				ranklist.push(rankinfo);
			}
			m_client.GetUICallback().OnLoadGuildChampionRank(VideoResultType.VREST_Normal, 0, ranklist);	
		}
		
		public function HandleCEventRefreshVideoGuildRank(ev:INetMessage):void
		{
			var evt:CEventRefreshVideoGuildRank = ev as CEventRefreshVideoGuildRank;
			var ui_data:Array = ToVideoGuildRankForUIVec(evt.rank);
			m_client.GetUICallback().OnLoadVideoGuildRank(VideoResultType.VREST_Normal, ui_data);
		}
		
		//在线列表
		public function HandleVideoLoadRoomPlayerlistRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomLoadPlayerListRes = ev as CEventVideoRoomLoadPlayerListRes;
			var data:Array = new Array();
			for(var i:int = 0; i < evt.playerInfos.length; ++i)
			{
				var info:VideoRoomPlayerInfo = evt.playerInfos[i] as VideoRoomPlayerInfo;
				var player_data:VideoRoomPlayerData  = new VideoRoomPlayerData;
				VideoRoomPlayerInfo2VideoRoomPlayerData(info, player_data);
				data.push(player_data);
			}
			Globals.s_logger.debug("HandleVideoLoadRoomPlayerlistRes evt.playerInfos = " + JSON.stringify(evt.playerInfos));
			Globals.s_logger.debug("HandleVideoLoadRoomPlayerlistRes data = " + JSON.stringify(data));
			//在线列表排序
			//自己永远在第一位
			//然后是当前直播主播
			//然后是房间管理员，按昵称排序
			//然后是其他玩家
			// modify by hss 最后是游客
//			data = SortPlayerList(data);
			m_client.GetUICallback().OnLoadPlayerList(VideoResultType.VREST_Normal, m_room.GetRoomID(), data, evt.total_page_cnt,m_client.GetSelfPersistID());
		}
		
		private function HandleCEventVideoRoomBanNotice(ev:INetMessage):void
		{
			var evt:CEventVideoRoomBanNotice = ev as CEventVideoRoomBanNotice;
			var m_room_id:int = evt.m_room_id;
			var m_banned:Boolean = evt.m_banned;
			Globals.room_banned = evt.m_banned;
			Globals.room_ban_notice = true;
			
			m_client.GetUICallback().PushRoomBanNotice(m_room_id,m_banned);
			if(m_banned){
				var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
				msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
				msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
				msg_data.systemType = 0;
				msg_data.res_forbid_public_chat = true;
				msg_data.msg = "$t$对不起，当前房间关闭了公众聊天$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
			}
		}
		
		private function SortPlayerList(playerdata:Array):Array
		{
			if(playerdata.length <= 0)
			{
				return null;
			}
			
			var playerSelf:VideoRoomPlayerData = playerdata[0];
			var anchor:Array = new Array;
			var admin:Array = new Array;
			var otherPlayer:Array = new Array;
			var guests:Array = new Array;
			
			var i:int = 1;//在线列表第一位是自己，所以不参与for循环的排序
			for(; i < playerdata.length;i++ )	// modify by hss 最后是游客,
			{
				switch(playerdata[i].playerType)
				{
					case RoomPlayerType.RPT_anchor:
					{
						anchor.push(playerdata[i]);
						break;
					}
					case RoomPlayerType.RPT_admin:
					{
						admin.push(playerdata[i]);
						break;
					}
					case RoomPlayerType.RPT_audience:
					{
						otherPlayer.push(playerdata[i]);
						break;
					}
					case RoomPlayerType.RPT_guest:
					{
						guests.push(playerdata[i]);
						break;
					}
					default:
					{
						break;
					}
				}
			}
			anchor.sort(sortAnchor);
			admin.sort(sortAdmin);
			otherPlayer.sort(sortOtherPlayer);
			guests.sort(sortGuests);
			var listdata:Array = new Array;
			listdata.push(playerSelf);
			for(i = 0; i < anchor.length;i++ )
			{
				listdata.push(anchor[i]);
			}
			for(i = 0; i < admin.length;i++ )
			{
				listdata.push(admin[i]);
			}
			for(i = 0; i < otherPlayer.length;i++ )
			{
				listdata.push(otherPlayer[i]);
			}
			
			for(i = 0; i < guests.length;i++ )
			{
				listdata.push(guests[i]);
			}
					
			return listdata;
		}
		
		private function sortGuests(player1:VideoRoomPlayerData,player2:VideoRoomPlayerData):int
		{
			if(player1.playerQQ > player2.playerQQ)
				return 1;
			else
				return -1;
		}
		
		
		private function sortAnchor(player1:VideoRoomPlayerData,player2:VideoRoomPlayerData):int
		{
			if(player1.isOnLive)
				return -1;
			else if(player2.isOnLive)
				return 1;
			else if(player1.name < player2.name)
				return -1;
			else
				return 1;
		
		}
		private function sortAdmin(player1:VideoRoomPlayerData,player2:VideoRoomPlayerData):int
		{
			if(player1.name < player2.name)
				return 1;
			else
				return -1;
		}
		
		private function sortOtherPlayer(player1:VideoRoomPlayerData,player2:VideoRoomPlayerData):int
		{
			//按守护等级排序
			if(player1.guardLevel > player2.guardLevel)
				return -1;
			else if (player1.guardLevel < player2.guardLevel)
				return 1;
			
			//守护等级相同的按贵族等级排序
			if(player1.viplevel > player2.viplevel)
				return -1;
			else if (player1.viplevel < player2.viplevel)
				return 1;
			
			//再相同按财富值排序
			if(Number(player1.wealth) > Number(player2.wealth))
				return -1;
			else if(Number(player1.wealth) < Number(player2.wealth))
				return 1;
			
			//再相同按昵称排序
			if(player1.name < player2.name)
				return 1;
			else
				return -1;
		}
		public function HandleCEventRefreshAffinityRank(ev:INetMessage):void
		{
			var evt:CEventRefreshAffinityRank = ev as CEventRefreshAffinityRank;
			var rank:Array = new Array;

			for (var i:int =0; i<evt.rank.length;i++)
			{
				var data:VideoAffinityRank = evt.rank[i] as VideoAffinityRank;
				var uidata:AnchorAffinityRankData = new AnchorAffinityRankData();
				
				uidata.m_anchor_id = data.anchor_id.toString();
				uidata.m_player_id = data.player_id.toString();
				uidata.m_anchor_nick = data.anchor_nick_str.replace(Pattern,"\\\\");
				uidata.m_player_nick = data.nick_str.replace(Pattern,"\\\\");
				uidata.m_score = data.score.toString();
				uidata.m_player_zonename = data.zone_str;
				uidata.m_has_portrait = data.player_portrait != 0;
				uidata.anchor_status = data.anchor_status;
				uidata.room_id = rank.room_id;
				uidata.palyerGender = data.player_gender;
				uidata.anchorGender = data.anchor_gender;
				uidata.anchor_level = data.anchor_level;
				
				if(rank.m_player_url != "")
				{
					uidata.playerPhotoUrl = Globals.m_pic_download_url + "/qdancersec/" +  data.m_player_url + "/0" + URLSuffix.CreateVersionString();
				}
				if(rank.m_anchor_url != "")
				{
					uidata.anchorPhotoUrl =Globals.m_pic_download_url + "/qdancersec/" + data.m_anchor_url + "/0" + URLSuffix.CreateVersionString();		
				}

				if(data.last_order == 0)//表示首次入榜
				{
					uidata.order_change = 13 - (i+1);
				}
				else
				{
					uidata.order_change = data.last_order - (i+1) ;
				}
				rank.push(uidata);
			}
			m_client.GetUICallback().OnLoadAnchorAffinityRank(VideoResultType.VREST_Normal, rank,evt.rank_timedimension);
			
		}
		private function VideoAffinityRank2AnchorAffinityRankData(rank:VideoAffinityRank):AnchorAffinityRankData
		{
			var data:AnchorAffinityRankData = new AnchorAffinityRankData;
			data.m_anchor_id = rank.anchor_id.toString();
			data.m_player_id = rank.player_id.toString();
			data.m_anchor_nick = rank.anchor_nick_str.replace(Pattern,"\\\\");
			data.m_player_nick = rank.nick_str.replace(Pattern,"\\\\");
			data.m_score = rank.score.toString();
			data.m_player_zonename = rank.zone_str;
			data.m_has_portrait = rank.player_portrait != 0;
			data.anchor_status = rank.anchor_status;
			data.room_id = rank.room_id;
			if(rank.m_player_url != "")
				data.playerPhotoUrl = Globals.m_pic_download_url + "/qdancersec/" +  rank.m_player_url + "/0" + URLSuffix.CreateVersionString();
			if(rank.m_anchor_url != "")
				data.anchorPhotoUrl =Globals.m_pic_download_url + "/qdancersec/" + rank.m_anchor_url + "/0" + URLSuffix.CreateVersionString();				
			data.palyerGender = rank.player_gender;
			data.anchorGender = rank.anchor_gender;
			return data;
		}

		public function HandleCEventLoadRecommendVideoRoomRes(ev:INetMessage):void
		{
			var event:CEventLoadRecommendVideoRoomRes = ev as CEventLoadRecommendVideoRoomRes;
			
			var room_infos:Array = new Array;
			for (var i:int = 0; i < event.hot_room_infos.length; i++)
			{
				var room_info: RecommendVideoRoomInfo  = new RecommendVideoRoomInfo;
				room_info.room_name = event.hot_room_infos[i].room_name;
				room_info.anchor_name = event.hot_room_infos[i].anchor_name;
				room_info.room_pic_url =event.hot_room_infos[i].room_pic_url;
				room_info.room_id =event.hot_room_infos[i].room_id;

				room_infos.push(room_info);
			}
			
			m_client.GetUICallback().OnLoadRecommendVideoRoomResult(event.type,VideoResultType.VREST_Normal, room_infos);
			
			
		}
		public function AddChatBanPlayer(zone_and_nick:ChatBanResNameData ):void
		{
			m_chat_banned.push(zone_and_nick);
		}
		public function AddPerpetualChatBanPlayer(zone_and_nick:ChatBanResNameData ):void
		{
			m_perpetual_chat_banned.push(zone_and_nick);
		}
		public function DelChatBanPlayer(zone_and_nick:ChatBanResNameData ):void
		{
			var delindex:int = 0;
			//m_chat_banned.erase(zone_and_nick);
			for each(var tmp:ChatBanResNameData in m_chat_banned)
			{
				if(tmp.target_nickName == zone_and_nick.target_nickName && tmp.target_zoneName == zone_and_nick.target_zoneName)
				{
					delindex = m_chat_banned.indexOf(tmp);
					m_chat_banned.splice(delindex,1);
				}
			}
			
			//m_perpetual_chat_banned.erase(zone_and_nick);
			for each(var tmp2:ChatBanResNameData in m_perpetual_chat_banned)
			{
				if(tmp2.target_nickName == zone_and_nick.target_nickName && tmp2.target_zoneName == zone_and_nick.target_zoneName)
				{
					delindex = m_perpetual_chat_banned.indexOf(tmp);
					m_perpetual_chat_banned.splice(delindex,1);
				}
			}
			
		}
		public function ClearSelfInfo():void		
		{			
			m_selfInfo.Clear();
		}				
		private function ToVideoAnchorScoreTankForUI(rank:Array):Array		
		{			
			var uirank:Array = new Array;
			for(var i:int = 0;i<rank.length;i++)
			{				
				var t:VideoAnchorScoreRank = rank[i] as VideoAnchorScoreRank;
				var info:VideoAnchorScoreRankForUI = new VideoAnchorScoreRankForUI;
				info.m_anchor_id = t.anchor_id.toString();
				info.m_anchor_name = t.anchor_name.replace(Pattern,"\\\\");
				info.m_score = t.score.toString();
				info.m_anchor_status = t.anchor_status;
				info.m_room_id = t.room_id;
				info.m_anchor_gender = t.anchor_gender;
				info.m_is_nest = t.is_nest;
				info.m_anchor_level = t.anchor_level;
				if(t.m_anchor_url != "")
				{
					info.m_anchor_portrait_url = Globals.m_pic_download_url + "/qdancersec/" + t.m_anchor_url + "/0"+ URLSuffix.CreateVersionString();
				}
				if(t.last_order == 0)//表示第一次进入榜
				{
					info.m_order_change = 1001 - (i+1);//
				}
				else
				{
					info.m_order_change =t.last_order - (i+1);
				}
				uirank.push(info);
			}			
			return uirank;		
		}				
		private function ToVideoGuildRankForUIVec(rank:Array):Array		
		{			
			var vgrank:Array = new Array;			
			for(var i:int = 0;i<rank.length;i++)			
			{				
				var vgk:VideoGuildRank = rank[i] as VideoGuildRank;
				var vgui:VideoGuildRankForUI = new VideoGuildRankForUI;	
				vgui.m_guild_id = vgk.guild_id.toString();
				vgui.m_active_score = vgk.active_score;
				vgui.m_guild_chairman = vgk.guild_chairman.replace(/\\g/,"\\\\");
				vgui.m_guild_name = vgk.guild_name.replace(/\\g/,"\\\\");
				vgui.m_anchor_id = vgk.anchor_id.toString();
				vgui.m_anchor_portrait_url = Globals.m_pic_download_url + "/qdancersec/" + vgk.anchor_url + "/0" + URLSuffix.CreateVersionString();	
				vgui.m_player_url = Globals.m_pic_download_url + "/qdancersec/" +  vgk.player_url + "/0" + URLSuffix.CreateVersionString();
				vgui.m_anchor_name = vgk.anchor_name.replace(/\\g/,"\\\\");
				vgrank.push(vgui);
			}
			return vgrank;
		}
		public function LoadRoomList(type:int , category:int , beginIndex:int , requestNum:int,tag:int,position:int,module_type:int,source:int):Boolean
		{
			return m_room.LoadRoomList(type, category, beginIndex, requestNum,tag,position,module_type,source);
		}
		
		public function LoadPlayerList(page:int , clientType:int ):void
		{
			var evt:CEventVideoRoomLoadPlayerList = new CEventVideoRoomLoadPlayerList;
			evt.is_x5client = (clientType == VideoClientType.VCT_X5Client);
			evt.page_index = page;
			m_client.SendEvent(evt,Globals.SelfRoomID);
		}
		public  function StopDeputy():void		
		{
			
			
		}
		public function GetAnchorQQ():Int64
		{
			if(m_room != null)
			{
				return m_room.GetAnchorQQ();
			}
			return Int64.fromNumber(0);
		}
		public function EnterRoom(roomID:int,data:ByteArray,options:EnterOption,source:int, tag:int, module_type:int, page_capacity:int, room_list_pos:int):void
		{
			Globals.s_logger.debug("EnterRoom page to server base =  " + source + "," + tag + "," + module_type + "," + page_capacity + "," + room_list_pos);
			m_room.EnterRoom(roomID, data, options, source, tag, module_type, page_capacity, room_list_pos);
		}
		public function GetSurpriseBoxManager():IClientSurpriseBoxManager		
		{			
			return m_surprise_box_mng;		
		}			
		
		public function GetConcertClient():IConcertClient
		{
			return m_concert_client;
		}
		
		//注意使用数据的初始化情况		
		public function LeaveRoom():void		
		{			
			m_room.LeaveRoom();
			m_super_fans = new Array;
			m_super_guards = new Dictionary;
//			for(var it:Object in m_super_guards)
//				delete m_super_guards[it];
			m_chat_banned.splice(0);
			m_talent_show.ClearJudgeTypes();
			m_anchor_pk.ClearAvatarCathe();
			m_video_ceremony_client.onLeaveRoom();
			if(m_anchor_nest != null)
			{
				m_anchor_nest.OnLeaveRoom();
			}			
			m_videosrv_shutdown_left_minutes = 0;
			m_next_notify_shutdown = 0;		
		}
		
		// SearchOnlinePlayer
		public function SearchOnlinePlayer(key_words:String):void
		{
			if(m_room)
			{
				m_room.SearchOnlinePlayer(key_words);
			}
		}

		//XW81665 增加刷新粉丝数量
		public function UpdateLiveDetailImpression(impressions:AnchorImpressionDataServer, followedCount:int = -1):void {
			m_room.UpdateLiveDetailImpression(impressions, followedCount);
		}
		
		public function AnchorCardToAnchorInfocard(in_data:AnchorCard,out_data:AnchorInfocard):void
		{
			//添加周星赛数据 start
			out_data.weekstarMatchInfo.status = in_data.week_star_match_info.status;
			out_data.weekstarMatchInfo.total_score = in_data.week_star_match_info.total_score;
			out_data.weekstarMatchInfo.total_rank = in_data.week_star_match_info.total_rank;
			out_data.weekstarMatchInfo.sub_rank = in_data.week_star_match_info.sub_rank;
			out_data.weekstarMatchInfo.group_name = in_data.week_star_match_info.group_name;
			out_data.weekstarMatchInfo.grade = in_data.week_star_match_info.grade;
			out_data.weekstarMatchInfo.sub_level = in_data.week_star_match_info.sub_level;
			out_data.weekstarMatchInfo.week_star_medals = in_data.week_star_match_info.week_star_medals;
			//end
			out_data.basicData.anchorID = in_data.pstid.toString();
			out_data.basicData.anchorQQ = in_data.pstid.toString();
			out_data.basicData.gameID = in_data.attached_player_pstid.toString();
			out_data.basicData.male = in_data.sex == PlayerSex.SEX_Male;
			out_data.basicData.popularity = in_data.popularity.toString();
			out_data.basicData.starlight = in_data.starlight.toString();
			out_data.basicData.intro = in_data.intro;
			out_data.basicData.name = in_data.nick;
			out_data.basicData.from = in_data.place;
			out_data.basicData.followedAudiences = in_data.followed;
			out_data.guard_count = in_data.guard_count;
			out_data.total_guard_cnt = 0;
			out_data.basicData.talent_show_rank = in_data.talent_show_rank;
			out_data.basicData.star_anchor = in_data.star_anchor;
			out_data.basicData.anchor_score = in_data.anchor_score;
			out_data.basicData.m_pk_anchor_winner_order = in_data.pk_anchor_winner_order;
			out_data.annual2014_title = in_data.annual2014_title;
			out_data.nest_id = in_data.nest_id;
			out_data.vg_cnt = in_data.vg_count;
			out_data.basicData.anchor_level = in_data.anchor_level;
			out_data.basicData.anchor_exp = in_data.anchor_exp;
			out_data.basicData.anchor_levelup_exp = in_data.anchor_levelup_exp;
			out_data.basicData.is_bottleneck = in_data.is_bottleneck;
			out_data.basicData.bottleneck_count = in_data.bottleneck_count;
			out_data.basicData.bottleneck_need_count = in_data.bottleneck_need_count;
			out_data.basicData.bottleneck_gift_id = in_data.bottleneck_gift_id;

		//	for( var itr:Object in in_data.anchor_badge_vec )
			{
				out_data.anchor_badge_vec = in_data.anchor_badge_vec;
			}
			for(var key:Object in in_data.guard_count)
			{
				out_data.total_guard_cnt += in_data.guard_count[key];
			}

			out_data.current_guard_level = in_data.affinity_statistics.guard_level;
			out_data.current_guard_name =  m_guard_cfg.GetGuardName(out_data.current_guard_level);
			var guardLeverByTotalAffnity:int = m_guard_cfg.GetGuardLevel(in_data.affinity_statistics.total);//根据总亲密度算守护等级，用以判断是否是降级了
			
			if(guardLeverByTotalAffnity > out_data.current_guard_level)//表示降级
			{
				if(guardLeverByTotalAffnity > GuardLevelEnum.tianZHunGuard && out_data.current_guard_level < GuardLevelEnum.tianZHunGuard)
				{
					out_data.next_guard_level = GuardLevelEnum.tianZHunGuard;
				}
				else
				{
					out_data.next_guard_level = guardLeverByTotalAffnity;
				}
				
				out_data.next_guard_name = m_guard_cfg.GetGuardName(out_data.next_guard_level);	
			}
			else
			{
				out_data.next_guard_level = m_guard_cfg.GetNextGuardLevel(out_data.current_guard_level);//数据待修改
				out_data.next_guard_name = m_guard_cfg.GetGuardName(out_data.next_guard_level);	
			}
			
			var guard_data:VideoGuardPrivilegeData = m_guard_cfg.GetVideoGuardPrivilegeData(out_data.next_guard_level);
			if(guard_data != null)
			{
				out_data.affinity_need = guard_data.requireAffinity - in_data.affinity_statistics.total;
				if(out_data.affinity_need <= 0)
				{
					out_data.affinity_need = 0;
				}
			}			
			//当玩家是超凡守护的时候，下一守护为0，单实现需要根据超凡的月亲密度来计算			
			if(out_data.current_guard_level == GuardLevelEnum.caoFanGuard)
			{
				out_data.needMonthAffinity = m_guard_cfg.getRequireMonthlyAffinity(out_data.current_guard_level) - in_data.affinity_statistics.this_month;
			}
			else
			{
				out_data.needMonthAffinity = m_guard_cfg.getRequireMonthlyAffinity(out_data.next_guard_level) - in_data.affinity_statistics.this_month;
			}
			for(var i:int = 0; i < in_data.followers.length; ++i)
			{
				var follower:AnchorFollower = in_data.followers[i] as AnchorFollower;
				var data:VideoRoomPlayerDataForAnchorCardFans = new VideoRoomPlayerDataForAnchorCardFans;
				data.name = follower.nick;
				data.zoneName = follower.player_zone;
				data.guardLevel = follower.guardLevel;
				data.viplevel = follower.viplevel;
				data.vipIcon = m_vipConfig.GetVipIcon(follower.viplevel);
				data.guardIcon = guardConfig.GetIcon(follower.guardLevel);
				data.nickColor = m_vipConfig.GetVipNickColor(follower.viplevel);
				data.affinity = follower.affinity.toString();
				data.psid = follower.player_psid.toString();
				data.hasPortrait = follower.has_portrait;
				out_data.fans.push(data);
			}
			
//			for (var it:* in in_data.card_video_guilds)
//			{
//				var itinfo:AnchorCardVideoGuildInfo = in_data.card_video_guilds[it];
			for each (var itinfo:AnchorCardVideoGuildInfo in in_data.card_video_guilds) {
				var cdata:ClientAnchorCardVideoGuildInfo = new ClientAnchorCardVideoGuildInfo;
				cdata.vgid = itinfo.vgid.toString();
				cdata.vg_name = itinfo.vg_name;
				cdata.vg_score = itinfo.vg_score.toString();
				out_data.guild_list.push(cdata);
			}
			if(in_data.m_anchor_url != "")
			{
				//XW79794 去除头像随机数
				out_data.basicData.photoUrl =Globals.m_pic_download_url + "/qdancersec/" +  in_data.m_anchor_url;// + "/0" + URLSuffix.CreateVersionString();
			}
			
			out_data.basicData.imageUrl = OlinePictureDef.GetVideoAnchorImageDownloadUrl(m_pic_download_url,Globals.VideoGroupID,in_data.pstid.toNumber());

			if (in_data.nest_skin_info != null) {
				out_data.nest_skin_info = new AnchorNestSkinInfoUI();
				out_data.nest_skin_info.room_skin_level = in_data.nest_skin_info.room_skin_level;
				out_data.nest_skin_info.current_charm = in_data.nest_skin_info.current_charm;
				out_data.nest_skin_info.current_need_charm = in_data.nest_skin_info.current_need_charm;
				out_data.nest_skin_info.skin_subject_name = in_data.nest_skin_info.skin_subject_name;
				out_data.nest_skin_info.room_total_charm = in_data.nest_skin_info.room_total_charm;
				out_data.nest_skin_info.charm_rank_order = in_data.nest_skin_info.charm_rank_order;
				out_data.nest_skin_info.current_punchin_count = in_data.nest_skin_info.current_punchin_count;
				out_data.nest_skin_info.total_punchin_count = in_data.nest_skin_info.total_punchin_count;
				out_data.nest_skin_info.current_takeseat_count = in_data.nest_skin_info.current_takeseat_count;
				out_data.nest_skin_info.total_takeseat_count = in_data.nest_skin_info.total_takeseat_count;
				out_data.nest_skin_info.room_skin_id = in_data.nest_skin_info.room_skin_id;
				out_data.nest_skin_info.skin_task_info = m_room.parseRoomSkinTaskInfoList(in_data.nest_skin_info.skin_task_info);
			} else {
				in_data.nest_skin_info = null;
			}
		}

		public function SetCurrentVid(vid:int):void
		{
			m_current_vid = vid;
		}
		
		public function FillVideoRoomLogoUrl(room_data:VideoRoomData):void
		{
			if(room_data.type == VideoRoomType.VRT_VIDEO)
			{
				room_data.roomLogoUrl = OlinePictureDef.GetVideoRoomSnapShotUrl(m_pic_download_url, Globals.VideoGroupID, room_data.roomID) + URLSuffix.CreateVersionString();
			}
			else
			{
				room_data.roomLogoUrl = OlinePictureDef.GetVideoAnchorImageDownloadUrl(m_pic_download_url, Globals.VideoGroupID, Int64.parseInt64(room_data.anchorID).toNumber());
			}
		}
		
		public function FillVideoRoomPicUrl(room_data:VideoRoomData):void
		{
			const VideoRoomMaxPicCount:int = 5;
			var max_pic_count:int = VideoRoomMaxPicCount;
			//if (m_anchor_nest && m_anchor_nest->IsAnchorNestRoom())
			//{
			//		max_pic_count = m_anchor_nest->GetMaxPicCount();
			//}
			//room_data.roomPics.resize(max_pic_count);
			for(var i:int = 0;i<max_pic_count;i++)
			{
				var has_pic:Boolean = ((room_data.picInfo & (1 << i)) != 0);
				if(has_pic)
				{
					var str:String = OlinePictureDef.GetVideoRoomPictureDownloadUrl(m_pic_download_url, Globals.VideoGroupID,room_data.roomID,i) ;
					room_data.roomPics.push(str);
				}
			}
		}
		
		public function GetVideoRoomPicUrl():void
		{
			m_room.GetVideoRoomPicUrl();
		}

		
		public function GetPlayerGuardLevel():int
		{
			return m_selfInfo.m_guardlevel_with_cur_anchor;
		}
		
		public function SetPlayerGuardLevel(guardlevel:int):void
		{
			m_selfInfo.m_guardlevel_with_cur_anchor = guardlevel;
		}
		
		public function SendChatMsg( msg_content:String, channelID:int, recver_id:Int64, recver_name:String, recver_zoneName:String, is_audience:Boolean):void
		{
			var guard_chat_cd : Boolean= true;
			m_room.SendChatMsg(msg_content, channelID, recver_id, recver_name, recver_zoneName, is_audience,guard_chat_cd);
		}
		
		public function GetVideoPlayerCardPortraitUrl(pstid:Int64):String
		{
			return OlinePictureDef.GetVideoPlayerCardPortraitUrl(m_pic_download_url, PersistIDUtil.get_zone_id(pstid), PersistIDUtil.get_account_id(pstid));
		}
		
		public function FillAnchorPortraitUrl(anchor_data:ClientAnchorData):void
		{
			anchor_data.photoUrl = OlinePictureDef.GetVideoAnchorPortraitDownloadUrl(m_pic_download_url, Globals.VideoGroupID, Number(anchor_data.anchorQQ));
		}
		
		public function FillAnchorImageUrl(anchor_data:ClientAnchorData):void
		{
			anchor_data.imageUrl = OlinePictureDef.GetVideoAnchorImageDownloadUrl(m_pic_download_url, Globals.VideoGroupID, Number(anchor_data.anchorQQ));	
		}
		
		public function GetPicDownloadUrl():String
		{
			return m_pic_download_url;
		}
		
		public function GetClientType():int
		{
			return m_client_type;
		}
			
		public function GetVideoGuildClient():IVideoGuildClient
		{
			return m_video_guild;
		}
		
		public function GetNestClient():IAnchorNestClient
		{
			return m_anchor_nest;
		}
		
		// 视频投票
		public function GetVoteClient():CVideoVoteClient
		{
			return m_video_vote_client;
		}
		
		public function OnPlay(nPlayType:int, cResult:int, nWidth:int, nHeight:int):void
		{
			
		}
		
		public function GetCRedEnvelopeClient():CRedEnvelopeClient
		{
			return m_red_envelope_client;
		}
		
		public function OnStop(nPlayType:int):void
		{
			
		}
		
		public function OnCommunicationClose(nErrCodeint:int):void
		{
			
		}
		
		public function OnCommunicationConnected():void
		{
			
		}
		
		public function KickPlayer(playerName:String, playerZoneName:String):Boolean
		{
			return m_room.KickPlayer(playerName, playerZoneName);
		}
		
		
		//屏蔽
		public function isInIgnoreList( strNickName:String, strZoneName:String):Boolean
		{
			return m_room.isInIgnoreList(strNickName,strZoneName);
		}
		
		public function IgnorePlayer( player_id:Int64,strNickName:String, strZoneName:String, bAdd:Boolean):void
		{
			m_room.IgnorePlayer(player_id,strNickName, strZoneName,bAdd);
		}
		
		public function  GetRoomStatus( ):void
		{
			m_room.GetRoomStatus();
		}
		
		public function  SetDefaultDefinition( definition :int):void
		{
			m_room.SetDefaultDefinition(definition);
		}
		
		public function  GetCurrentAvailableDefinition(  ):Array
		{
			return m_room.GetCurrentAvailableDefinition();
		}
		
		public function  GetCurrentDefinition():int
		{
			return m_room.GetCurrentDefinition();
		}
		
		public function  ChooseDefinition( definition:int ):Boolean
		{
			return m_room.ChooseDefinition(definition);
		}
		
		public function  SetCurrentInvitedAnchorVid(vid:int):void
		{
			m_current_invited_anchor_vid = vid;
		}
		
		public function GetStarGiftInfo():void
		{
			m_client.GetUICallback().RefreshStarGiftInfo( m_star_gift_info,m_star_gift_champion);
		}

		//============幸运抽奖 start============
		public function OpenLuckyDrawWindow(begin_time:int=-1, config_refresh_time:int=-1):void {
			m_room.OpenLuckyDrawWindow(begin_time, config_refresh_time);
		}

		public function CloseLuckyDrawWindow():void {
			m_room.CloseLuckyDrawWindow();
		}

		public function LuckyDraw(is_free:Boolean, is_continuous:Boolean, begin_time:int=-1, refreshTime:int = -1):void {
			m_room.LuckyDraw(is_free, is_continuous, begin_time, refreshTime);
		}
		//============幸运抽奖 end============

		//============幸运抽奖 start============
		public function GetPunchInInfo():void {
			m_room.GetPunchInInfo();
		}
		public function PunchIn(punch_in_id:int, today_index:int, day_index:int, retrieve:Boolean, retrieve_price:int):void{
			m_room.PunchIn(punch_in_id, today_index, day_index, retrieve, retrieve_price);
		}
		public function QuerySkinGift():void{
			m_room.QuerySkinGift();
		}
		//============幸运抽奖 end============
		
		public function HandleCheckNickOnLoginRes(ev:INetMessage):void
		{
			var evt:CEventCheckNickOnLoginRes = ev as CEventCheckNickOnLoginRes;
			
			m_client.GetUICallback().OnCheckNickOnLoginRes(evt.m_status,evt.m_nick);
		}
		
		public function ADClick(ad_type:int, ad_site:int):void {
			m_room.ADClick(ad_type, ad_site);
		}
		
		//============移动管理员的pstid信息    start============
		public function HandleAllUserAdminList(ev:INetMessage):void{
			var evt:CEventNotifyAllUserAdmin = ev as CEventNotifyAllUserAdmin;
			Globals.s_logger.debug("HandleAllUserAdminList m_user_admins = " + evt + ", admins = " + evt.m_user_admins);//
			m_client.GetUICallback().PushAllUserAdminList(evt.m_user_admins);
		}
		//============移动管理员的pstid信息     end============
		
		//============通知被任命/解除移动管理员的弹框消息    start============
		public function HandleUserAdminSystemInfo(ev:INetMessage):void{
			var evt:CEventNotifyUserAdminSystemInfo = ev as CEventNotifyUserAdminSystemInfo;
			var tojson:VideoRoomMsgData = new VideoRoomMsgData;
			tojson.senderName = evt.m_nick;
			tojson.senderZoneName = evt.m_zone_name;
			tojson.channel = 3;
			tojson.systemType = 0;
			tojson.TextColor = "#b841c6";
			if(evt.m_status){
				tojson.msg = "$t$"+evt.m_nick+"被主播任命为本房间移动端管理员$z";
			} else{
				tojson.msg = "$t$"+evt.m_nick+"被主播解除本房间移动端管理员职位$z";
			}
			Globals.s_logger.debug("HandleUserAdminSystemInfo msg =  " + tojson.msg);
			m_client.GetUICallback().OnReceiveChatMsg(tojson);
		}
		//============通知被任命/解除移动管理员的弹框消息     end============
	}
}