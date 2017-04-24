package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.LoginManager;
	import com.h3d.qqx5.VideoWebCode;
	import com.h3d.qqx5.VideoWebOperationType;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.AnchorImpressionData;
	import com.h3d.qqx5.common.comdata.AnchorImpressionEdit;
	import com.h3d.qqx5.common.comdata.CookieLiveTask;
	import com.h3d.qqx5.common.comdata.VideoChannelType;
	import com.h3d.qqx5.common.event.CEventConcertPlaybackRoomGetRoomList;
	import com.h3d.qqx5.common.event.CEventConfirmFirstLoginReward;
	import com.h3d.qqx5.common.event.CEventConfirmFirstLoginRewardRes;
	import com.h3d.qqx5.common.event.CEventEditAnchorImpress;
	import com.h3d.qqx5.common.event.CEventEditAnchorImpressRes;
	import com.h3d.qqx5.common.event.CEventEncryptPortraitUrl;
	import com.h3d.qqx5.common.event.CEventEncryptPortraitUrlRes;
	import com.h3d.qqx5.common.event.CEventFinishEducation;
	import com.h3d.qqx5.common.event.CEventFirstLoginRewardNotify;
	import com.h3d.qqx5.common.event.CEventFragmentManager;
	import com.h3d.qqx5.common.event.CEventGetActivityCompletedCount;
	import com.h3d.qqx5.common.event.CEventGetActivityCompletedCountRes;
	import com.h3d.qqx5.common.event.CEventGetAllTags;
	import com.h3d.qqx5.common.event.CEventGetAllTagsRes;
	import com.h3d.qqx5.common.event.CEventGetDailySigninRewardContent;
	import com.h3d.qqx5.common.event.CEventGetDailySigninRewardContentRes;
	import com.h3d.qqx5.common.event.CEventGetFriendPayCashNotice;
	import com.h3d.qqx5.common.event.CEventGetGuestInfo;
	import com.h3d.qqx5.common.event.CEventGetGuestInfoRes;
	import com.h3d.qqx5.common.event.CEventGetSigninRewardNotify;
	import com.h3d.qqx5.common.event.CEventGetSigninRewardNotifyRes;
	import com.h3d.qqx5.common.event.CEventGetVideoRoomLiveInfo;
	import com.h3d.qqx5.common.event.CEventIgnoreFreeGift;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpress;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpressForPlayer;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpressForPlayerRes;
	import com.h3d.qqx5.common.event.CEventLoadAnchorStarGiftInfo;
	import com.h3d.qqx5.common.event.CEventLoadMemberOperationInfo;
	import com.h3d.qqx5.common.event.CEventLoadMemberOperationInfoRes;
	import com.h3d.qqx5.common.event.CEventLoadPlayerInfoForHomePage;
	import com.h3d.qqx5.common.event.CEventLoadPreviewVideoTreasureBoxNewRole;
	import com.h3d.qqx5.common.event.CEventLoadRank;
	import com.h3d.qqx5.common.event.CEventLoadRecommendVideoRoom;
	import com.h3d.qqx5.common.event.CEventNotifyConcertVideoGiftUsableIDs;
	import com.h3d.qqx5.common.event.CEventNotifyDivert;
	import com.h3d.qqx5.common.event.CEventNotifyRoomActivityComplete;
	import com.h3d.qqx5.common.event.CEventPlayerDrawSecretHeatBoxReward;
	import com.h3d.qqx5.common.event.CEventQueryAnchorTaskNewRole;
	import com.h3d.qqx5.common.event.CEventQueryDreamGift;
	import com.h3d.qqx5.common.event.CEventRefreshLiveTaskInfoToClient;
	import com.h3d.qqx5.common.event.CEventRefreshVideoCharInfoToClient;
	import com.h3d.qqx5.common.event.CEventReportAnchor;
	import com.h3d.qqx5.common.event.CEventSetNoviceGuided;
	import com.h3d.qqx5.common.event.CEventSigninAccumulate;
	import com.h3d.qqx5.common.event.CEventSigninAccumulateRes;
	import com.h3d.qqx5.common.event.CEventSigninDaily;
	import com.h3d.qqx5.common.event.CEventSigninDailyRes;
	import com.h3d.qqx5.common.event.CEventStartConcertPlayback;
	import com.h3d.qqx5.common.event.CEventTakeRoomGuardSeat;
	import com.h3d.qqx5.common.event.CEventTakeVipSeat;
	import com.h3d.qqx5.common.event.CEventVideoClientSigVerify;
	import com.h3d.qqx5.common.event.CEventVideoGetGiftPoolBoxInfo;
	import com.h3d.qqx5.common.event.CEventVideoQueryBalance;
	import com.h3d.qqx5.common.event.CEventVideoQueryVideoMoney;
	import com.h3d.qqx5.common.event.CEventVideoRefreshFreeGift;
	import com.h3d.qqx5.common.event.CEventVideoRoomCanEnterRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomCheckNick;
	import com.h3d.qqx5.common.event.CEventVideoRoomCreateVideoRole;
	import com.h3d.qqx5.common.event.CEventVideoRoomCreateVideoRoleRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomInfoRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomLeaveRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomWebTipsNotify;
	import com.h3d.qqx5.common.event.CEventVideoSendGift;
	import com.h3d.qqx5.common.event.CEventVideoUserLogin;
	import com.h3d.qqx5.common.event.CEventVisitAnchorRes;
	import com.h3d.qqx5.common.event.CEventWeekStarConfigReq;
	import com.h3d.qqx5.common.event.CEventWeekStarNotifySucc;
	import com.h3d.qqx5.common.event.eventid.ConcertEventID;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.event.eventid.EVENT_ID_ZONE_RANK;
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.common.event.eventid.VideoPersonalCardEventID;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.enum.RoomProxyResult;
	import com.h3d.qqx5.enum.RoomStatus;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.enum.VideoRoomType;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoInitConnectionResponse;
	import com.h3d.qqx5.framework.callcenter.event.CallCenterMessageID;
	import com.h3d.qqx5.framework.interfaces.ICallCenter;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.events.AnchorNestEventID;
	import com.h3d.qqx5.modules.anchor_pk.event.VideoAnchorPKEventID;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventDropAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventDropAnchorTaskRes;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventNotifyAnchorTaskUnavailable;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventNotifyAudiencePublishAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventRemoveAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventTakeAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventTakeAnchorTaskRes;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxClientInfo;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxErrorCode;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxForUI;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxGrabber;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxMoneyType;
	import com.h3d.qqx5.modules.dream_box.event.CEventBroadcastAllRoomRocketGift;
	import com.h3d.qqx5.modules.dream_box.event.CEventClearDreamBox;
	import com.h3d.qqx5.modules.dream_box.event.CEventGetDreamBoxGrabRec;
	import com.h3d.qqx5.modules.dream_box.event.CEventGetDreamBoxGrabRecRes;
	import com.h3d.qqx5.modules.dream_box.event.CEventGrabDreamBox;
	import com.h3d.qqx5.modules.dream_box.event.CEventGrabDreamBoxRes;
	import com.h3d.qqx5.modules.dream_box.event.CEventNotifyDreamBoxGrabbedOut;
	import com.h3d.qqx5.modules.dream_box.event.CEventPublishDreamBox;
	import com.h3d.qqx5.modules.dream_box.event.CEventRefreshDreamBoxCount;
	import com.h3d.qqx5.modules.dream_box.event.DreamBoxEventID;
	import com.h3d.qqx5.modules.rand_nick.CEventGetRandNick;
	import com.h3d.qqx5.modules.rand_nick.CEventGetRandNickRes;
	import com.h3d.qqx5.modules.rand_nick.RandNickEventID;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	import com.h3d.qqx5.modules.video_activity.VideoActivityInfoToClient;
	import com.h3d.qqx5.modules.video_activity.event.CEventGetActivityCenterInfos;
	import com.h3d.qqx5.modules.video_activity.event.CEventGetActivityCenterInfosRes;
	import com.h3d.qqx5.modules.video_activity.event.CEventNotifyActivityCompletedCount;
	import com.h3d.qqx5.modules.video_activity.event.CEventNotifyWebActivityGuide;
	import com.h3d.qqx5.modules.video_activity.event.CEventTakeDailyWage;
	import com.h3d.qqx5.modules.video_activity.event.CEventTakeDailyWageRes;
	import com.h3d.qqx5.modules.video_activity.event.CEventTakeVideoActivityRewards;
	import com.h3d.qqx5.modules.video_activity.event.CEventTakeVideoActivityRewardsRes;
	import com.h3d.qqx5.modules.video_vip.shared.VideoVipBuyType;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventBuyVideoVip;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventModifyVideoPlayerCardSignature;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryBuyVideoVipPrice;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeWhistleLeft;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventUploadVideoPlayerCardPortrait;
	import com.h3d.qqx5.tqos.TQOSAcceptAnchorTask;
	import com.h3d.qqx5.tqos.TQOSQueryAnchorCard;
	import com.h3d.qqx5.tqos.TQOSQueryRank;
	import com.h3d.qqx5.util.AccountCookieConst;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.util.CookieLog;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.URLSuffix;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	import com.h3d.qqx5.video_service.serviceinf.RoomAnchorInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomState;
	import com.h3d.qqx5.videoclient.OlinePictureDef;
	import com.h3d.qqx5.videoclient.data.AccumulateRewards;
	import com.h3d.qqx5.videoclient.data.ActivityCenterInfosForUI;
	import com.h3d.qqx5.videoclient.data.ActivityInfoForUI;
	import com.h3d.qqx5.videoclient.data.ActivityProcess;
	import com.h3d.qqx5.videoclient.data.ActivityRewardForUI;
	import com.h3d.qqx5.videoclient.data.AnchorImpressionDataForUI;
	import com.h3d.qqx5.videoclient.data.AnchorImpressionEditForUI;
	import com.h3d.qqx5.videoclient.data.AnchorInfocard;
	import com.h3d.qqx5.videoclient.data.CDailySiginReward;
	import com.h3d.qqx5.videoclient.data.CDailySiginRewardForUI;
	import com.h3d.qqx5.videoclient.data.CMemberOperationInfo;
	import com.h3d.qqx5.videoclient.data.CReward;
	import com.h3d.qqx5.videoclient.data.CeremonyRefreshInfoForUI;
	import com.h3d.qqx5.videoclient.data.CeremonyStartInfoForUI;
	import com.h3d.qqx5.videoclient.data.ChangeCostType;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	import com.h3d.qqx5.videoclient.data.DailyActivityInfoForUI;
	import com.h3d.qqx5.videoclient.data.DailySignInRewardList;
	import com.h3d.qqx5.videoclient.data.DailySigninRewardContent;
	import com.h3d.qqx5.videoclient.data.DailySigninRewardContentForUI;
	import com.h3d.qqx5.videoclient.data.ERewardType;
	import com.h3d.qqx5.videoclient.data.EnterOption;
	import com.h3d.qqx5.videoclient.data.LiveTaskCondition;
	import com.h3d.qqx5.videoclient.data.LiveTaskInfoForUI;
	import com.h3d.qqx5.videoclient.data.RewardBox;
	import com.h3d.qqx5.videoclient.data.RoomInfoForUI;
	import com.h3d.qqx5.videoclient.data.RoomPlayerType;
	import com.h3d.qqx5.videoclient.data.SigninAccumulateResStatus;
	import com.h3d.qqx5.videoclient.data.VideoClientType;
	import com.h3d.qqx5.videoclient.data.VideoGuardPrivilegeData;
	import com.h3d.qqx5.videoclient.data.VideoRoomData;
	import com.h3d.qqx5.videoclient.data.VideoRoomPlayerDataForAnchorCardFans;
	import com.h3d.qqx5.videoclient.data.VideoWebPayParam;
	import com.h3d.qqx5.videoclient.gamereward.ReawardCookieManager;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWeb;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorNestClient;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorPKClient;
	import com.h3d.qqx5.videoclient.interfaces.IClientAnchor;
	import com.h3d.qqx5.videoclient.interfaces.IClientSurpriseBoxManager;
	import com.h3d.qqx5.videoclient.interfaces.IFansGuardConfig;
	import com.h3d.qqx5.videoclient.interfaces.ISurpriseBox;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientAdapter;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogic;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientPlayer;
	import com.h3d.qqx5.videoclient.interfaces.IVideoGuildClient;
	import com.h3d.qqx5.videoclient.xmlconfig.CAnchorImpressionConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CFansGuardConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CGiftConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoActivityRewardConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoVipConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVipSeatClientConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.IImpressionConfig;
	import com.h3d.qqx5.x51VideoWeb;
	
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	
	/**
	 * 注：
	 * 	获取角色，登录相关逻辑转移到CallCenter里面。
	 * @author gaolei
	 * 
	 */
	public class CX5VideoClient implements IVideoClientInternal, IVideoClientLogicInternal
	{		
		private var m_base:CVideoClientBase;
		private var m_ui:IVideoClientLogicCallback;
		private var m_x5Bridge:IVideoClientAdapter;
		private var m_callcenter:ICallCenter;
		private var m_video_client_player:VideoClientPlayer;
		private var m_video_ad_url:String = "http://x5.qq.com/client/carousel/index.shtml";
		private var m_room_icons:Dictionary = new Dictionary;
		private var m_vip_url:String = "";
		
		private var m_guard_Config:CFansGuardConfig = null;
		private var m_impression_config:CAnchorImpressionConfig = null;
		private var rewardConfig:CVideoActivityRewardConfig = null;
		private var m_config_file_path:String = "/config/";
		private var m_vipConfig:CVideoVipConfig = null;
		private var m_client_raffle_manager:CRaffleClientManager;
		private var m_nick:String = "ttt";
		private var m_frag_mng:CEventFragmentManager;
		private var m_erncrypt_url_cnt:int = 0;
		private var m_erncrypt_url:String = "";
		private var m_firstLoginRewardaList:Array = new Array;
		private var m_free_gift:Array = new Array;
		private var m_loginManager:LoginManager = null;
		private var m_reward_cookie_manager:ReawardCookieManager;
		private var m_isGuest:Boolean = false;
		private var m_bLoginChange:Boolean = false;
		private var m_ConnQQ:int = -1 ;
		private var m_dreambox_rate:int = 1 ;
		private var m_qgame_item_image_url:String = "";
		public function CX5VideoClient()
		{
			m_base = new CVideoClientBase(this);
			m_video_client_player = new VideoClientPlayer(this, m_base);
			m_client_raffle_manager = new CRaffleClientManager(this);
			LoadVideoClientConfig();//加载配置文件
			m_loginManager = new LoginManager(this);
			m_reward_cookie_manager = new ReawardCookieManager(this);
		}
		
		public function GetLoginManager():LoginManager
		{
			return m_loginManager;
		}
		
		public function GetReawardCookieManager():ReawardCookieManager
		{
			return m_reward_cookie_manager;
		}
		
		public function GetVipConfig():CVideoVipConfig
		{
			return m_vipConfig;
		}
		
		public function SetCallCenter(callcenter:ICallCenter):void
		{
			m_callcenter = callcenter;
		}
		
		public function GetCallCenter():ICallCenter
		{
			return m_callcenter;
		}
		
		public function Init():void
		{
			m_base.InitVideoClientBase( m_guard_Config );
		}
		public function GetImpressionConfig():IImpressionConfig
		{
			return m_impression_config;
		}
		public function GetGuardConfig():IFansGuardConfig
		{
			return m_guard_Config;
		}
		
		public function LoadVideoClientConfig():void
		{
			m_impression_config = new CAnchorImpressionConfig(Globals.SwfFolderURL + m_config_file_path+"impression.xml");
			m_guard_Config = new CFansGuardConfig(GetVideoClientAdapter(),Globals.SwfFolderURL + m_config_file_path + "video_fans_guard.xml");
			
			m_vipConfig = CVideoVipConfig.getInstance();			
			m_vipConfig.LoadVideoVipConfig(Globals.SwfFolderURL + m_config_file_path + "video_vip_config.xml");
			
			rewardConfig = CVideoActivityRewardConfig.getInsatce();
			rewardConfig.LoadActivityRewardConfig(Globals.SwfFolderURL + m_config_file_path+"video_reward.xml");		
			
			CGiftConfig.getInstance().LoadGiftConfig();
			CVipSeatClientConfig.getInstance().LoadVipSeatConfig(Globals.SwfFolderURL + m_config_file_path+"video_seat_config.xml");
		}
		
		public function LoadPlayerInfoForHomePage() : void
		{	
			//新逻辑
			var ev:CEventLoadPlayerInfoForHomePage = new CEventLoadPlayerInfoForHomePage;
			
			SendEvent(ev,Globals.SelfRoomID);
		}
		
		// 获得某等级守护的权限
		public function GetGuardConfigData(guard_level:int):VideoGuardPrivilegeData
		{
			return m_guard_Config.GetVideoGuardPrivilegeData(guard_level);
		}
		
		public function Update(itime:int):void
		{
			
		}
		
		public function  IsStartVote():Boolean
		{
			return m_base.GetVoteClient().IsStartVote();
		}
		
		public function  HasVoted():Boolean
		{
			return m_base.GetVoteClient().HasVoted();
		}
		
		public function  GetAnchor():IClientAnchor
		{
			return null;
		}
		
		public function SetVideoClientAdapter(bridge:IVideoClientAdapter):void
		{
			m_x5Bridge = bridge;
		}
		
		public function SetVideoAdUrl(url:String):void
		{
			m_video_ad_url = url;
		}
		
		public function NotifyConnected(res:int):void
		{	
			var guestcookie:Cookie = new Cookie("x51webGuest");
			var qq:uint = guestcookie.getData("guest_qq");
			Globals.s_logger.debug("NotifyConnected() res = " + res);
			if (res == 0 && GetLocalAccountID().toNumber() != 0 && GetLocalAccountID().toNumber() == qq) {
				m_isGuest = true;
			} else {
				m_isGuest = false;
			}
			var cookie:Cookie = new Cookie("x51web");
			//存下是否为游客的状态
			if (res == 0 && GetLocalAccountID().toNumber() != 0) {
				cookie.flushData(AccountCookieConst.IS_GUEST, m_isGuest);
				//("is_guest" + Globals.cookieQQ + "_" + Globals.cookieZoonID, m_isGuest);
				if (m_isGuest == true) {
					cookie.flushData(AccountCookieConst.CLEAR_GUEST, false);//(CallCenter.CLEAR_GUEST, false);
				}
			}
			
//			if (m_isGuest) {
//				cookie.flushData(AccountCookieConst.CONNECTED_TIME, 0);
//			} else {
//				cookie.flushData(AccountCookieConst.CONNECTED_TIME, Globals.connectTime);
//			}

			//登录成功且角色列表不为空，返回128
			if (res == 0 && Globals.rpArr != null) //登陆成功 并且没有角色
			{
				var arr:Array = new Array();
				m_ui.OnLoadServerListFromVersion(0, true, Globals.rpArr, arr, null);
				Globals.rpArr = null;
			} else {
				m_bLoginChange = false; //初始化
				m_ui.notifyConnected(res, m_callcenter.GetQQ(), m_callcenter.GetZoneId(), m_isGuest);
				if(m_isGuest == false){
					m_callcenter.ClearGuestCookieData();
				}
			}
			if (res == 0) {
				Globals.addindex = -1;
				Globals.s_logger.debug("NotifyConnected() Globals.channel = " + Globals.channel + " Globals.deviceType :" + Globals.deviceType);
				if (Globals.deviceType == 5)
					m_base.VideoRoomGetLiveCDN();
			}
		}
		
		public function GetInterfacesForUI():IVideoClientLogic
		{
			return this;
		}
		
		public function GetSurpriseBox():ISurpriseBox
		{
			return null;
		}
		
		public function GetVideoClientPlayer():IVideoClientPlayer
		{
			return m_video_client_player;
		}
		
		public function GetVideoGroupID():int
		{
			return Globals.VideoGroupID;	
		}
		
		public function GetRoomsIcons():Dictionary
		{
			return m_room_icons;
		}
		
		public function GetVideoRoomPicUrl():void
		{
			m_base.GetVideoRoomPicUrl();
		}
		
		public function GetVipUrl():String
		{
			return m_vip_url;
		}
		
		public function GetPicDownloadUrl():String
		{
			return m_base.GetPicDownloadUrl();
		}
		
		public function ClearRoomProxy():void
		{
			
		}
		
		public function OnConnectFailCallback():void
		{
			GetInterfacesForUI().NotifyConnected(2);
		}
		
		public function OnDisConnected():void
		{
			m_ui.OnGetConnectStatus();
		}
		public function OnConnectSuccessCallback():void
		{
			GetInterfacesForUI().NotifyConnected(0);
		}

		public function OnInitConnectFailCallback(res:int):void {
			m_ui.NoticeConnectMsg(res);
		}

		public function OnReconnectVerifyFailCallback(res:int):void {
			m_ui.NoticeConnectMsg(res);
		}

		public function OnSyncServerTimeCallback(time:int):void
		{
			this.m_video_client_player.InitServerTime(time);
		}
		
		public function AddRoomProxy(ip:String, port:int):void
		{
			
		}
		
		//登陆异常的处理
		public function LoginChangeToDo():void
		{
			m_bLoginChange= true;
			if(IsInRoom())
			{
				m_base.StopWatchLive();
			}
		}
		
		public function GetVideoRoomTicketUrl():String
		{
			return null;
		}
		
		
		public function GetVideoClientAdapter() : IVideoClientAdapter
		{
			return m_x5Bridge;
		}
		
		
		private function IsInVideoRoomEvent(clsid:int):Boolean
		{
			switch(clsid)
			{
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshLiveStatus:
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshCurrentAnchorDetail:
				case EEventIDVideoRoom.CLSID_CEventNotifySendLotsOfGifts:
				case EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcastAllRoom:
				case VideoAnchorPKEventID.CLSID_CEventAnchorPKForecast:
				case VideoAnchorPKEventID.CLSID_CEventAnchorPKMatchEndBroadcast:
					return true;
				default:
					break;
			}
			
			return false;
		}
		
		public function ReportAnchor( type:int, content:String, pic:ByteArray, anchor:Int64, anchor_name:String):Boolean
		{
			if(m_base == null)
			{
				return false;
			}
			var info:RoomAnchorInfo  = new RoomAnchorInfo;
			m_base.GetRoomAnchorInfo(info);
			var  reportev:CEventReportAnchor = new CEventReportAnchor(anchor, info.room_type, type, info.room_name, anchor_name	, content, pic);
			SendEvent(reportev,Globals.SelfRoomID);
			return true;
		}
		private function ShouldProcessEvent(clsid:int):Boolean
		{
			var room_id:int = GetRoomID();
			
			if(room_id == 0 && IsInVideoRoomEvent(clsid))
			{
				return false;
			}
			
			return true;
		}

		public function Logout(reason:String = ""):void {
			if (IsInRoom()) {
				//主动离开房间
				this.LeaveRoom();
			}
			if (GetIsGuest() == false) {
				//情掉本地缓存。
				//游客状态不需要清理cookie，这样会把正常的登录信息清除掉的。
				Globals.s_logger.localLog("ClearCookieData: logout");
				var cookie:Cookie = new Cookie("x51web");
				if (m_callcenter.GetQQ() > 0) {
					var cookieQQ:uint    = cookie.getData(AccountCookieConst.QQ);
					var cookieZoneId:int = cookie.getData(AccountCookieConst.ZONE_ID);
					if (m_callcenter.GetQQ() == cookieQQ && m_callcenter.GetZoneId() == cookieZoneId) {
						Globals.s_logger.localLog("ClearCookieData: logout cookieQQ=" + cookieQQ);
						CookieLog.addLogicClearLog(AccountCookieConst.SOURCE, "cookieQQ=" + cookieQQ + " " + reason);
						m_callcenter.ClearCookieData(0);
					}
				}
			}
			m_base.ClearRoomData();
		}
		
		public function HandleMessageTimeOut():void
		{
			m_ui.OnMessageTimeOut();
		}
		
		public function HandleServerEvent(ev:INetMessage):void
		{
			Globals.s_logger.info("HandleServerEvent:"+ ev.CLSID());
			if (Globals.isDubug) {
				Globals.s_logger.debug("CLSID:" + ev.CLSID() + " -> " + JSON.stringify(ev));
			}
			if(ev.CLSID() == 41302){
				Globals.s_logger.debug("HandleServerEvent CLSID:" + ev.CLSID() + " -> " + JSON.stringify(ev));
			}
			if(ev == null)
				return;
			
			//聊天特化消息
			if(ev.CLSID() == EEventIDVideoRoomExt.CLSID_CEventVideoToClientChatMessageForWeb || ev.CLSID() == EEventIDVideoRoomExt.CLSID_CEventVideoSendGiftResultForWeb)
			{
				this.m_base.HandleServerEvent(ev);
				return;
			}
			else if( ev.CLSID() == EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardDescRes || ev.CLSID() == EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardCountDescRes)
			{
				m_reward_cookie_manager.HandleServerEvent(ev);
				return ;
			}
			if(!ShouldProcessEvent(ev.CLSID()))
			{
				Globals.s_logger.info("skip event "+ ev.CLSID());
				return;
			}
			if ( ev.CLSID() == CallCenterMessageID.CLSID_CEventVideoInitConnectionResponse )
			{
				Globals.s_logger.info("CEventVideoInitConnectionResponse:"+ ev.CLSID());
				var evt:CEventVideoInitConnectionResponse  = ev as CEventVideoInitConnectionResponse;//static_cast< *>( ev );
				if ( evt && evt.res == RoomProxyResult.PROXY_FAIL_ROUTER_BROKEN )
				{
					Globals.s_logger.localLog("接收到服务器消息登出: logout（CEventVideoInitConnectionResponse res=" + evt.res + "）");
					Logout("CEventVideoInitConnectionResponse res=ROUTER_BROKEN");
					return ;
				}
			}
			m_video_client_player.HandleVideoServerEvent(ev);
			
			var res:Boolean = m_base.HandleServerEvent(ev);
			Globals.s_logger.debug("HandleServerEvent 41302:res = " + res);
			if(res)
			{
				return;
			}
			// TODO 其余特化的处理
			var clsid:int = ev.CLSID();
			if( !Globals.isCancelOpeLog &&( clsid != 39713 || clsid != 39894 || clsid != 39731|| clsid != 39736|| clsid != 39971) )
				Globals.s_logger.debug(" CX5VideoClient.HandleServerEvent clsid:" + clsid);
			switch(clsid)
			{			
				case VideoPersonalCardEventID.CLSID_CEventVisitAnchorRes:
					HandleCEventVisitAnchorRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshVideoCharInfoToClient:
					HandleCEventRefreshVideoCharInfoToClient(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventRefreshFollowedAnchorsIDToClient:
					HandleCEventRefreshFollowedAnchorsIDToClient(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventGetVideoPlayerInfoRes:
					HandleCEventGetVideoPlayerInfoRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoEventSpeedLimit:				
					break;
				case EEventIDVideoRoom.CLSID_CEventRoomCloseTime:
					break;
				case EEventIDVideoRoom.CLSID_CEventNotifyAllPlayerRoomIsClosing:
					break;
				case AnchorTaskEventID.CLSID_CEventNotifyAudiencePublishAnchorTask:
					res = true;
					HandleCEventNotifyAudiencePublishAnchorTask(ev);
					break;
				case AnchorTaskEventID.CLSID_CEventTakeAnchorTaskRes:
					res = true;
					HandleCEventTakeAnchorTaskRes(ev);
					break;
				case AnchorTaskEventID.CLSID_CEventDropAnchorTaskRes:
					res = true;
					HandleCEventDropAnchorTaskRes(ev);
					break;
				case AnchorTaskEventID.CLSID_CEventNotifyAnchorTaskUnavailable:
					res = true;
					HandleCEventAnchorTaskUnavailable(ev);
					break;
				case AnchorTaskEventID.CLSID_CEventRemoveAnchorTask:
					res = true;
					HandleCEventRemoveAnchorTask(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadNestListRes:
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressForPlayerRes:
					HandleCEventLoadAnchorImpressForPlayerRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNestAssistantSetFunctionRes:
					break;
				case AnchorNestEventID.CLSID_CEventNotifyNestIsFreezing:
					break;
				case EEventIDVideoRoomExt.CLSID_CEventEditAnchorImpressRes:
					HandleCEventEditAnchorImpressRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomInfoRes:
					HandleCEventVideoRoomGetRoomInfoRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshLiveNestCnt:
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomCreateVideoRoleRes:
					HandleCEventVideoRoomCreateVideoRoleRes(ev);
					break;

				case EEventIDVideoRoomExt.CLSID_CEventLoadMemberOperationInfoRes:
					HandleCEventLoadMemberOperationInfoRes(ev);
					break;
				case RaffleEventID.CLSID_CEventNotifyRaffleState:
				case RaffleEventID.CLSID_CEventLuckPlayerListIncrement:
				case RaffleEventID.CLSID_CEventVideoRaffleRes:
					res = true;
					m_client_raffle_manager.HandleSuperRoomServerEvent(ev);
					break;
				case ConcertEventID.CLSID_CEventRefreshLiveTaskInfoToClient:
					res = true;
					HandleCEventRefreshLiveTaskInfoToClient(ev);
					break;
				case ConcertEventID.CLSID_CEventNotifyDivert:
					res = true;
					HandleCEventNotifyDivert(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventEncryptPortraitUrlRes:
					res = true;
					HandleCEventEncryptPortraitUrlRes(ev);
					break;

				case EEventIDVideoRoomExt.CLSID_CEventFirstLoginRewardNotify:
					res = true;
					HandleCEventFirstLoginRewardNotify(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventConfirmFirstLoginRewardRes:
					res = true;
					HandleCEventConfirmFirstLoginRewardRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventGetSigninRewardNotifyRes:
					res = true;
					HandleCEventGetSigninRewardNotifyRes(ev);
					break;
				
				case EEventIDVideoRoomExt.CLSID_CEventGetDailySigninRewardContentRes:
					res = true;
					HandleCEventGetDailySigninRewardContentRes(ev);
					break;
				
				case EEventIDVideoRoomExt.CLSID_CEventSigninAccumulateRes:
					res = true;
					HandleCEventSigninAccumulateRes(ev);
					break;
				
				case EEventIDVideoRoomExt.CLSID_CEventSigninDailyRes:
					res = true;
					HandleCEventSigninDailyRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNotifyConcertVideoGiftUsableIDs:
					res = true;
					responseGiftIDArray(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRefreshFreeGift:
					res = true;
					HandleCEventVideoRefreshFreeGift(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventGetGuestInfoRes:
					res = true;
					HandleCEventGetGuestInfoRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomLeaveRoomRes:
					res = true;
					HandleCEventVideoRoomLeaveRoomRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventGetAllTagsRes:
					res = true;
					HandleCEventGetAllTagsRes(ev);
					break;
				case RandNickEventID.CLSID_CEventGetRandNickRes:
					res = true;
					HandleCEventGetGetRandNickRes(ev);
					break;
				case VideoActivityEventID.CLSID_CEventGetActivityCompletedCountRes:
					res = true;
					HandleCEventGetActivityCompletedCountRes(ev);
					break;
				case VideoActivityEventID.CLSID_CEventNotifyRoomActivityComplete:
					res = true;
					HandleDailyRoomActivity(ev);
					break;
				case VideoActivityEventID.CLSID_CEventTakeDailyWageRes:
					res = true;
					HandleCEventTakeDailyWageRes(ev);
					break;
				case VideoActivityEventID.CLSID_CEventGetActivityCenterInfosRes:
					res = true;
					HandleCEventGetActivityCenterInfosRes(ev);
					break;
				case VideoActivityEventID.CLSID_CEventTakeVideoActivityRewardsRes:
					HandleCEventTakeVideoActivityRewardsRes(ev);
					break;
				case VideoActivityEventID.CLSID_CEventNotifyActivityCompletedCount:					
					HandleCEventNotifyActivityCompletedCount(ev);
					break;
				case VideoActivityEventID.CLSID_CEventNotifyWebActivityGuide:					
					HandleCEventNotifyWebActivityGuide(ev);
					break;
				case DreamBoxEventID.CLSID_CEventGrabDreamBoxRes:
					res = true;
					HandleCEventGrabDreamBoxRes(ev);
					break;
				case DreamBoxEventID.CLSID_CEventGetDreamBoxGrabRecRes:
					res = true;
					HandleCEventGetDreamBoxGrabRecRes(ev);
					break;
				case DreamBoxEventID.CLSID_CEventPublishDreamBox:
					res = true;
					HandleCEventPublishDreamBox(ev);
					break;
				case DreamBoxEventID.CLSID_CEventNotifyDreamBoxGrabbedOut:
					res = true;
					HandleNotifyDreamBoxGrabbedOut(ev);
					break;
				case DreamBoxEventID.CLSID_CEventBroadcastAllRoomRocketGift:
					res = true;
					HandleCEventBroadcastAllRoomRocketGift(ev);
					break;
				case DreamBoxEventID.CLSID_CEventRefreshDreamBoxCount:
					HandleCEventRefreshDreamBoxCount(ev);
					res = true;
					break;
				case DreamBoxEventID.CLSID_CEventClearDreamBox:
					HandleCEventClearDreamBox(ev);
					res = true;
					break;
				default:
					break;
			}
		}
		
		
		
		// 免费礼物倒计时更新
		private function HandleCEventVideoRefreshFreeGift(event:INetMessage ):void
		{
			var ev:CEventVideoRefreshFreeGift = event as CEventVideoRefreshFreeGift;
			if(m_free_gift != null)
				m_free_gift = ev.free_gift;
			m_ui.RefreshConcertFreeGiftInfo(ev.free_gift);
		}
		
		//每日签到回调
		private function HandleCEventSigninDailyRes( event:INetMessage ):void
		{
			var ev:CEventSigninDailyRes = event as CEventSigninDailyRes;
			var targetrew:CDailySiginRewardForUI = new CDailySiginRewardForUI;
			var giftArr:Array = new Array;
			Globals.s_logger.debug("HandleCEventSigninDailyRes() status = " + ev.status  + "  accumulate_day =  " +  ev.content.accumulate_day + "   month = " + ev.content.month + "   is_signin_today = " + ev.content.is_signin_today + "  year = " + ev.content.year);
//			if( ev.status == SigninDailyResStatus.SDRS_Succ)
//			{	
				//签到表
				var info:DailySigninRewardContentForUI = new DailySigninRewardContentForUI;
				var gift_daily:Array                   = new Array();
	
				var rewardList:Array                   = [];
				for (var index:int = 0; index < ev.m_reward_list.length; index++)
				{
					var reward:CDailySiginReward     = ev.m_reward_list[index];
					var dsrUI:CDailySiginRewardForUI = new CDailySiginRewardForUI;
	
					dsrUI.type = reward.type;
					dsrUI.id = reward.male_data;
					dsrUI.count = reward.count;
//					dsrUI.level = reward.level;
//					dsrUI.multiply = reward.multiply;
					dsrUI.channel = reward.channel;
	
					if (reward.type == ERewardType.R_VIP && reward.male_data != 0) //如果是送贵族，送我当前身份
					{
						if (ev.mylevel > 0) //没有贵族身份就送配置的
							dsrUI.id = ev.mylevel;
					}
					rewardList.push(dsrUI);
				}
	
				ChangeRewardContent(info, ev.content, ev.mylevel, giftArr);
	
				if (ev.signin_day <= info.daily_rewards.length)
				{
					var sres:CDailySiginRewardForUI = info.daily_rewards[ev.signin_day - 1];
					//无耻的as到处都是引用！！！！！！！
					var res:CDailySiginRewardForUI  = new CDailySiginRewardForUI;
					res.channel = sres.channel;
					res.count = sres.count;
					res.id = sres.id;
					res.level = sres.level;
					res.multiply = sres.multiply;
					res.type = sres.type;
					//无耻的as到处都是引用！！！！！！！
					if (ev.mylevel >= res.level) //如果我的贵族等级大于等于配置可以领取多倍奖励
						res.count = res.count * res.multiply;
	
					if (VideoChannelType.IsQueryReaward(res.channel))
					{
						var gift_web:RewardReqestWeb = new RewardReqestWeb;
						gift_web.amount = res.count;
						gift_web.id = res.id;
						gift_web.type = res.type;
						gift_web.channel = res.channel;
						gift_daily.push(gift_web);
					}
					if (gift_daily.length > 0)
						m_reward_cookie_manager.GetRewordsInfos(gift_daily, m_ui.OnSignInDaily, ev.status, res, ev.m_is_reissue, rewardList);
					else
						m_ui.OnSignInDaily(ev.status, res, ev.m_is_reissue, rewardList, gift_daily);
//					//每日签到的奖励信息,记录在本地，目前只刷新梦幻币和贵族身份
//					ChangeRewardtoLocal( info.daily_rewards[ev.signin_day-1]);
				}
				//最后再刷新，否则会被改变
				if (giftArr.length > 0)
					m_reward_cookie_manager.GetRewordsInfos(giftArr, m_ui.OnGetSignDailyInfo, ev.status, info, ev.m_is_reissue, rewardList)
				else
					m_ui.OnGetSignDailyInfo(ev.status, info, ev.m_is_reissue, rewardList, giftArr);
				//主动请求个人信息
				LoadPlayerInfoForHomePage();//fix by 经验值等级无法实时更新
//			}
//			else
//			{
//				m_ui.OnSignInDaily(ev.status,targetrew,ev.m_is_reissue,ev.m_reward_list,gift_daily);
//			}
		}
		
		//累计签到回调
		private function HandleCEventSigninAccumulateRes( event:INetMessage ):void
		{
			var ev:CEventSigninAccumulateRes = event as CEventSigninAccumulateRes;
			var rewards:Array = new Array;	
			//累计签到回调[累计奖励不会加倍]
			if(ev.status == SigninAccumulateResStatus.SARS_Succ)
			{
				var info:DailySigninRewardContentForUI = new DailySigninRewardContentForUI;
				var giftArr:Array = new Array;
				
				ChangeRewardContent(info,ev.content,ev.mylevel,giftArr);
				
				var rewardList:Array = [];
				for(var index:int=0; index < ev.m_reward_list.length; index++)
				{
					var reward:CDailySiginReward = ev.m_reward_list[index];
					var dsrUI:CDailySiginRewardForUI = new CDailySiginRewardForUI;
					dsrUI.count = reward.count;
					dsrUI.id = reward.male_data;
					dsrUI.type = reward.type;
					if(reward.type == ERewardType.R_VIP && reward.male_data != 0 )//如果是送贵族，送我当前身份
					{
						if( ev.mylevel > 0 )//没有贵族身份就送配置的
							dsrUI.id = ev.mylevel;
					}		
					
					dsrUI.channel = reward.channel;
					rewardList.push(dsrUI);
				}
				
				for(var idx:int=0; idx< info.accumulate_rewards.length ; idx++)
				{
					var ainfo:AccumulateRewards = info.accumulate_rewards[idx];
					var rewards_ui:Array = new Array;
					var gift_daily:Array = new Array;
					for each(var crewad:CDailySiginRewardForUI in ainfo.rewards)
					{
						//as为引用 ！！！！添加替换类
						var rew_true:CDailySiginRewardForUI = new CDailySiginRewardForUI;
						rew_true.channel = crewad.channel;
						rew_true.count = crewad.count;
						rew_true.id = crewad.id;
						rew_true.level = crewad.level;
						rew_true.multiply = crewad.multiply;
						rew_true.type = crewad.type;
						//as为引用 ！！！！！ 添加替换类
						if( VideoChannelType.IsQueryReaward(rew_true.channel))
						{
							var gift_web:RewardReqestWeb = new RewardReqestWeb;
							gift_web.amount = rew_true.count;
							gift_web.id =rew_true.id ;
							gift_web.type = rew_true.type;
							gift_web.channel = rew_true.channel;
							
							gift_daily.push(gift_web);
						}
						rewards_ui.push( rew_true);
					}

					if (ev.accumulate_day == ainfo.days)
					{
						if (gift_daily.length > 0)
							m_reward_cookie_manager.GetRewordsInfos(gift_daily, m_ui.OnGetCumulativeReward, ev.status, rewards_ui, ev.m_is_reissue, rewardList);
						else
							m_ui.OnGetCumulativeReward(ev.status, rewards_ui, ev.m_is_reissue, rewardList, gift_daily);
						//主动请求个人信息
						LoadPlayerInfoForHomePage(); //fix by 经验值等级无法实时更新
						break;
					}
				}
				//最后再发出签到信息，传出去是引用！！！！！！！会被篡改！！！！
				if (giftArr.length > 0)
					m_reward_cookie_manager.GetRewordsInfos(giftArr, m_ui.OnGetSignDailyInfo, ev.status, info, ev.m_is_reissue, rewardList)
				else
					m_ui.OnGetSignDailyInfo(ev.status, info, ev.m_is_reissue, rewardList, giftArr);//签到表
				
			}
			else
			{	
				m_ui.OnGetCumulativeReward(ev.status,rewards,ev.m_is_reissue,ev.m_reward_list,rewards);
			}
		}
		
		//签到的奖励信息,记录在本地，目前只刷新梦幻币和贵族身份
		private function ChangeRewardtoLocal(reward:CDailySiginRewardForUI):void
		{
			if(reward.type == ERewardType.R_VideoMoney)//梦幻币
			{
				m_video_client_player.SetVideoMoney(m_video_client_player.GetDreamMoneyNum()+ reward.count ,null);
			}
			else if( reward.type == ERewardType.R_VIP )//贵族身份
			{
				//天数要改成秒数
				m_video_client_player.SetVipInfo(reward.id,m_video_client_player.GetVipRemainTime()+reward.count * 24* 60*60);
			}
		}
		
		//首登奖励通知
		private function HandleCEventFirstLoginRewardNotify( event:INetMessage ):void
		{
			var ev:CEventFirstLoginRewardNotify = event as CEventFirstLoginRewardNotify;
			m_firstLoginRewardaList = new Array;
			var giftArr:Array = new Array;
			for(var index:int=0; index < ev.reward_list.length; index++)
			{
				var reward:CReward = ev.reward_list[index];
				var box:CDailySiginRewardForUI = new CDailySiginRewardForUI;
				box.count = reward.count;
				box.id = reward.male_data;
				box.type = reward.type;
				if(reward.type == ERewardType.R_VIP && reward.male_data != 0 )//如果是送贵族，送我当前身份
				{
					var mylevel:int = m_video_client_player.GetVipLevel();
					if( mylevel > 0 )//没有贵族身份就送配置的
						box.id = mylevel;
				}		
				
				box.channel = reward.channel;
				
				if( VideoChannelType.IsQueryReaward( box.channel) )
				{
					var gift_web:RewardReqestWeb = new RewardReqestWeb;
					gift_web.amount = reward.count;
					gift_web.id =IsSelfMale()?reward.male_data:reward.female_data ;
					gift_web.type = reward.type;
					gift_web.channel = box.channel;
					giftArr.push(gift_web);
				}
				
				m_firstLoginRewardaList.push(box);
			}
			if(giftArr.length > 0 )
			{
				m_reward_cookie_manager.GetRewordsInfos(giftArr,m_ui.OnGetFirstLoginRewardNotify,ev.status,ev.is_taken,m_firstLoginRewardaList);
			}
			else
			{
				var tmpArr:Array = new Array;
				m_ui.OnGetFirstLoginRewardNotify(ev.status,ev.is_taken,m_firstLoginRewardaList,tmpArr);
			}
		}
		
		/**
		 * 领取首登奖励的回调
		 * 	新增了奖励礼包列表，所以做了和TakeVideoActivityRewards方法里类似的处理。
		 * @param event
		 * 
		 */		
		private function HandleCEventConfirmFirstLoginRewardRes( event:INetMessage ):void
		{
			var ev:CEventConfirmFirstLoginRewardRes = event as CEventConfirmFirstLoginRewardRes;
			
			var addMoney:int = 0;
			var giftarr:Array = new Array();
			if(ev.rewards != null){
				for(var i:int= 0; i < ev.rewards.length; i++)
				{
					var rew:CReward = new CReward;
					rew = ev.rewards[i];
					if(rew.type == ERewardType.R_VideoMoney)
						addMoney += rew.count;
					
					if (rew.type == ERewardType.R_VIP && rew.male_data != 0) //如果是送贵族，送我当前身份
					{
						//领取奖励时候 都以服务器返回的level为准
						//没有贵族身份就送配置的
						if (ev.mylevel > 0)
						{
							rew.male_data = ev.mylevel;
						}
					}
					
					if( rew.channel == VideoChannelType.VCT_X5)
					{
						var game:RewardReqestWeb = new RewardReqestWeb;
						
						game.id = IsSelfMale() ? rew.male_data : rew.female_data;
						game.amount = rew.count;
						game.type = rew.type;
						giftarr.push( game );
					}
				}
				//条件和CEventTakeVideoActivityRewardsRes中的额外属性不一致，暂不处理。
				//领取成功 ，梦幻币做加成处理
//				if(res.res == 1 && addMoney > 0)
//				{
//					m_base.AddVideoDreamMoney(addMoney);
//				}
//				if( giftarr.length > 0)//有游戏测奖励
//				{
//					m_reward_cookie_manager.GetRewordsInfos(giftarr, m_ui.OnTakeVideoActivityRewardsRes,VideoResultType.VREST_Normal,res.res,res.activity_id,res.activity_category,res.rewards);
//				}
			}
//			Globals.s_logger.debug("  ConfirmFirstLoginReward! " + JSON.stringify(ev));
			m_ui.OnGetFirstLoginReward(ev.status, (ev.rewards != null ? ev.rewards : []), giftarr, ev.is_reissue);
			
			
			if( ev.status ==   SigninAccumulateResStatus.SARS_Succ)
			{
				for(var idx:int=0; idx< m_firstLoginRewardaList.length; idx++ )
				{
					var reward:CDailySiginRewardForUI = m_firstLoginRewardaList[idx];

					if(reward.type == ERewardType.R_VIP && reward.id != 0 )//如果是送贵族，送我当前身份
					{
						var mylevel:int = ev.mylevel;//领取奖励时候 都以服务器返回的level为准
						if( mylevel > 0 )//没有贵族身份就送配置的
							reward.id = mylevel;
					}
					ChangeRewardtoLocal(reward);//首登目前不会有加倍奖励
				}
			}
			//主动请求个人信息
			LoadPlayerInfoForHomePage();//fix by 经验值等级无法实时更新
		}
		
		//签到和领取提醒
		private function HandleCEventGetSigninRewardNotifyRes( event:INetMessage ):void
		{
			var ev:CEventGetSigninRewardNotifyRes = event as CEventGetSigninRewardNotifyRes;
			
			m_ui.OnSignDaliyNotify(ev.status,ev.is_Daily,ev.is_Acc );
		}
		
		
		//签到信息表
		private function HandleCEventGetDailySigninRewardContentRes( event:INetMessage ):void
		{
			var ev:CEventGetDailySigninRewardContentRes = event as CEventGetDailySigninRewardContentRes;
			var info:DailySigninRewardContentForUI = new DailySigninRewardContentForUI;
			var giftArr:Array = new Array;
			var tmpArr:Array = new Array;
			
			ChangeRewardContent(info,ev.content,m_video_client_player.GetVipLevel(),giftArr);
			
			if( giftArr.length > 0 )
			{
				m_reward_cookie_manager.GetRewordsInfos(giftArr,m_ui.OnGetSignDailyInfo,ev.status ,info,false,[]);
			}
			else
			{
				m_ui.OnGetSignDailyInfo(ev.status ,info,false,[],tmpArr);
			}
		}
		
		//签到信息
		private function ChangeRewardContent(targetinfo:DailySigninRewardContentForUI,souceinfo:DailySigninRewardContent, mylevel:int,giftArr:Array):void
		{
			targetinfo.accumulate_day = souceinfo.accumulate_day;
			targetinfo.month = souceinfo.month;
			targetinfo.is_signin_today = souceinfo.is_signin_today;
			targetinfo.year = souceinfo.year;
			ChangeDailyRewards(targetinfo.daily_rewards,souceinfo.daily_rewards,mylevel,giftArr);
			ChangeAccumulateRewards(targetinfo.accumulate_rewards,souceinfo.accumulate_rewards,mylevel,giftArr);
		}
		
		//累计奖励
		private function ChangeAccumulateRewards(targetinfo:Array,souceinfo:Dictionary,mylevel:int,giftArr:Array):void
		{
			for( var idx:Object in souceinfo)//key是累计天数。
			{
				var rbox:RewardBox = souceinfo[idx];
				
				var ainfo:AccumulateRewards = new AccumulateRewards;
				ainfo.days = int(idx);//累计天数
				ainfo.status = rbox.status;//领取状态
				for(var index:int=0; index<rbox.rewards.length; index ++ )
				{
					var rinfo:CDailySiginReward = rbox.rewards[index];
					var targetrew:CDailySiginRewardForUI = new CDailySiginRewardForUI;
					targetrew.type = rinfo.type;
					targetrew.count = rinfo.count;
					targetrew.id = IsSelfMale()?rinfo.male_data:rinfo.female_data;//web男女奖励一致,如果是贵族 id代表送的等级
					if(rinfo.type == ERewardType.R_VIP && rinfo.male_data != 0 )//如果是送贵族，送我当前身份
					{
						if( mylevel > 0 )//没有贵族身份就送配置的
							targetrew.id = mylevel;
					}
					targetrew.channel = rinfo.channel;	
					
					if( VideoChannelType.IsQueryReaward( targetrew.channel ) )//游戏侧道具奖励
					{
						var giftTsu:RewardReqestWeb = new RewardReqestWeb;
						giftTsu.id = IsSelfMale() ? rinfo.male_data : rinfo.female_data;
						giftTsu.amount = rinfo.count;
						giftTsu.type = rinfo.type;
						giftTsu.channel = targetrew.channel;
						
						giftArr.push(giftTsu);
					}
					
					ainfo.rewards.push(targetrew);
				}	
				targetinfo.push(ainfo);
			}
			//DTK75083 奖励和配置不符——（排序后查询的顺序与返回结果的顺序会产生偏差。放到返回页面前在排序那是数据已经齐全。Dictionary的key如果不是连续的取值的时候会有随机性。）
			//targetinfo.sort(AccumulateRewardsSortByDay);
		}
		
		private function AccumulateRewardsSortByDay(argc1:AccumulateRewards,argc2:AccumulateRewards):int
		{
			var res:int = 0;
			if(argc1.days < argc2.days)
				res = -1;
			else if(argc1.days > argc2.days)
				res = 1;		
			return res;
		}
		
		//每日奖励
		private function ChangeDailyRewards(targetinfo:Array,souceinfo:Dictionary,mylevel:int,giftArr:Array):void
		{
			for( var idx:Object in souceinfo)//key是天数，每日奖励的天数与索引是一一对应  所以直接去掉key
			{
				var list:DailySignInRewardList = souceinfo[idx];
				for(var index:int=0; index<list.rewards.length; index ++ )//每日奖励目前是只会有一个,以后可能会扩展
				{
					var rinfo:CDailySiginReward = list.rewards[index];
					var targetrew:CDailySiginRewardForUI = new CDailySiginRewardForUI;
					targetrew.type = rinfo.type;
					targetrew.count = rinfo.count;
					targetrew.id =IsSelfMale()? rinfo.male_data:rinfo.female_data;//web男女奖励一致,如果是贵族 id代表送的等级
					if(rinfo.type == ERewardType.R_VIP && rinfo.male_data != 0 && rinfo.channel != VideoChannelType.VCT_X5)//如果是送贵族，送我当前身份
					{
						if( mylevel > 0 )//没有贵族身份就送配置的
							targetrew.id = mylevel;//
					}
					targetrew.level = rinfo.level;
					targetrew.multiply = rinfo.multiply;
					
					targetrew.channel = rinfo.channel;	
					
					if( VideoChannelType.IsQueryReaward( targetrew.channel ) )//游戏侧道具奖励
					{
						var giftTsu:RewardReqestWeb = new RewardReqestWeb;
						giftTsu.id = IsSelfMale() ? rinfo.male_data : rinfo.female_data;
						giftTsu.amount = rinfo.count;
						giftTsu.type = rinfo.type;
						giftTsu.channel = targetrew.channel;
						
						giftArr.push(giftTsu);
					}
					
					targetinfo.push(targetrew);
				}				
			}
		}
		
		
		//查询活动中心任务完成数量结果处理
		private function HandleCEventGetActivityCompletedCountRes( event:INetMessage ):void
		{
			var ev:CEventGetActivityCompletedCountRes = event as CEventGetActivityCompletedCountRes;
			
			m_ui.NotifyActivityCompletedCount(ev.completed_cnt,ev.has_taken_wage_today,ev.m_status);
		}
		
		
		private function HandleCEventEncryptPortraitUrlRes( event:INetMessage ):void
		{
			var ev:CEventEncryptPortraitUrlRes = event as CEventEncryptPortraitUrlRes;
			if(ev.ret !=0 && m_erncrypt_url_cnt <3 )
			{
				EncryptPortraitUrl(m_erncrypt_url,m_erncrypt_url_cnt++);
			}
			else
			{
				var url:String = GetPicDownloadUrl()+"/qdancersec/"+ev.url+"/0"
				m_ui.OnEncryptPortraitUrlRes(ev.ret, url);
			}
		}
		
		private function HandleCEventNotifyDivert( event:INetMessage ):void
		{
			var ev:CEventNotifyDivert = event as CEventNotifyDivert;
			var rooms:Array = new Array;
			var tmprooms:Array = new Array;
			m_base.FillRoomDataForUI(ev.top_quality_room, rooms);//优质
			
			m_base.FillRoomDataForUI(ev.normal_room , tmprooms);//普通
			for( var i:int = 0; i < tmprooms.length; i ++)
			{
				rooms.push(tmprooms[i]);
			}
			
			m_ui.NotifyDivertInfo( rooms, ev.top_quality_room.length);
		}
		
		private function HandleCEventRefreshLiveTaskInfoToClient( event:INetMessage ):void
		{
			var ev:CEventRefreshLiveTaskInfoToClient = event as CEventRefreshLiveTaskInfoToClient;
			
			if( !ev )
				return;
			var curtask:CookieLiveTask = new CookieLiveTask;
			var ctask: CookieLiveTask = new CookieLiveTask;
			// 读取现场任务的缓存
			var cookie:Cookie = new Cookie("x51webLiveTask");
			if( m_video_client_player != null )
			{
				var obj:Object= cookie.getData(m_video_client_player.GetVideoPersistID().toString());//没有存过
				if(obj == null )
				{
					ctask =null;
				}
				else
				{
					ctask.has_newtask = obj.has_newtask;
					ctask.tasks = obj.tasks;
				}
			}
			
			if (ctask != null )
			{		
				if( ctask.has_newtask == false )
				{
					var cnt :int =0;
					for(var i:int = 0; i < ev.info.length; i ++ )
					{
						for(var j:int = 0; j < ctask.tasks.length; j ++ )
						{
							if(ev.info[i].task_id == ctask.tasks[j])
								cnt++;
						}
					}
					//原来有的与最新有的不一致，则为有新的了。
					if (cnt != ev.info.length)
					{
						ctask.has_newtask = true;	
					}
				}
			}
			var infos:Array = new Array;
			for(var idx:int = 0; idx<ev.info.length; idx++)
			{
				var info:LiveTaskInfoForUI = new LiveTaskInfoForUI;
				info.task_id = ev.info[idx].task_id;
				info.condition =LiveTaskCondition.GetCondition(ev.info[idx].condition_id, ev.info[idx].finish_progress);
				info.desc  = ev.info[idx].desc.replace(/\\/g,"\\\\");
				info.current_progress =ev.info[idx].current_progress.toString() ;
				info.finish_progress =ev.info[idx].finish_progress.toString();
				info.status = ev.info[idx].status;
				curtask.tasks.push(info.task_id);
				infos.push( info );
			}
			
			if(m_ui != null )
			{
				if(ctask == null || ctask.has_newtask == true )//如果从来没记录过，也默认为有新任务
					m_ui.NotifyNewLiveTask(true);
			}
			// 保存新任务信息
			cookie.flushData(m_video_client_player.GetVideoPersistID().toString(),curtask);
			
			if( m_ui !=null )
			{
				m_ui.RefreshLiveTaskInfo( infos );
			}
		}
		
		private function HandleCEventNotifyActivityCompletedCount(ev:INetMessage):void
		{
			var evt:CEventNotifyActivityCompletedCount = ev as CEventNotifyActivityCompletedCount;
			
			if( evt != null && m_ui != null)
			{
				m_ui.NotifyActivityCompletedCount(evt.completed_cnt,evt.has_taken_wage_today,0);
			}
		}

		private function HandleCEventNotifyWebActivityGuide(ev:INetMessage):void {
			var evt:CEventNotifyWebActivityGuide = ev as CEventNotifyWebActivityGuide;
			if (m_ui != null) {
				//XW81897 查找玩家是否完成新任务引导
				m_ui.NotifyWebActivityGuide(m_video_client_player.IsTipsNoticed());
			}
		}

		private function HandleCEventLoadMemberOperationInfoRes(ev:INetMessage):void {
			var evt:CEventLoadMemberOperationInfoRes = ev as CEventLoadMemberOperationInfoRes;
			if (evt == null) {
//				Globals.s_logger.debug( "  41184 is null ");
			}
			var MemInfo:CMemberOperationInfo = new CMemberOperationInfo();
			if (evt.mem_player.m_player_url != "" && evt.mem_player.playerType != RoomPlayerType.RPT_admin) {
				//XW79794 去除头像随机数
				MemInfo.portrait_url = Globals.m_pic_download_url + "/qdancersec/" + evt.mem_player.m_player_url; // + "/0" + URLSuffix.CreateVersionString();
			}
			MemInfo.FillWithVideoRoomPlayerInfo(evt.mem_player);

			MemInfo.guardIcon = m_guard_Config.GetIcon(evt.mem_player.guardLevel);
			MemInfo.vipIcon = m_vipConfig.GetVipIcon(evt.mem_player.video_level);

			MemInfo.isIgnore = isInIgnoreList(evt.mem_player.playerNick, MemInfo.zone_name);
			MemInfo.banable = evt.banable;
			MemInfo.unbanable = evt.unbanalbe;
			if (MemInfo.player_name == "" && MemInfo.zone_name == "") {
				MemInfo.Online = false;
			}

			if (evt.mem_player.pstid.equal(m_video_client_player.GetVideoPersistID()) == true) {
				MemInfo.isSelf = true;
			}

//			Globals.s_logger.debug( "  41184 is evt " + evt + " ui " + m_ui);
			//返回服务器的时间
			MemInfo.server_time = GetServerTime();

			if (evt != null && m_ui != null) {
				m_ui.OnMemberOperationRes(evt.res, MemInfo);
			}
		}

		private function HandleCEventTakeVideoActivityRewardsRes(ev:INetMessage):void 
		{
			var res:CEventTakeVideoActivityRewardsRes = ev as CEventTakeVideoActivityRewardsRes;

			var addMoney:int                          = 0;
			var giftarr:Array                         = new Array();
			for (var idx:int = 0; idx < res.rewards.length; idx++)
			{
				var rew:CReward = new CReward;
				rew = res.rewards[idx];
				if (rew.type == ERewardType.R_VideoMoney)
					addMoney += rew.count;

				if (rew.type == ERewardType.R_VIP)
				{
					if (res.vip_level > 0)
					{
						rew.male_data = res.vip_level;
					}
				}

				if (VideoChannelType.IsQueryReaward(rew.channel))
				{
					var game:RewardReqestWeb = new RewardReqestWeb;
					game.id = IsSelfMale() ? rew.male_data : rew.female_data;
					game.amount = rew.count;
					game.type = rew.type;
					game.channel = rew.channel;

					giftarr.push(game);
				}
			}
			//领取成功 ，梦幻币做加成处理
			if (res.res == 1 && addMoney > 0)
			{
				m_base.AddVideoDreamMoney(addMoney);
			}
			if (giftarr.length > 0) //有游戏测奖励
			{
				m_reward_cookie_manager.GetRewordsInfos(giftarr, m_ui.OnTakeVideoActivityRewardsRes, VideoResultType.VREST_Normal, res.res, res.activity_id, res.activity_category, res.rewards, res.m_is_reissue);
			}
			else if (res != null && m_ui != null)
			{
				m_ui.OnTakeVideoActivityRewardsRes(VideoResultType.VREST_Normal, res.res, res.activity_id, res.activity_category, res.rewards, res.m_is_reissue, giftarr);
			}
		}
		
		
		private function HandleCEventGetActivityCenterInfosRes(ev:INetMessage):void
		{
			
			var res:CEventGetActivityCenterInfosRes = ev as CEventGetActivityCenterInfosRes;
			
			if( res == null)
				return;
			
			var activity_center_info:ActivityCenterInfosForUI = new ActivityCenterInfosForUI;
			var giftArr:Array = new Array;
			if(res.succ == 0)
			{
				activity_center_info.level = res.level;
				activity_center_info.exp = res.exp;
				activity_center_info.levelup_exp = res.levelup_exp;
				activity_center_info.video_money = res.video_money;
				activity_center_info.vip_level = res.vip_level;
				activity_center_info.vipIcon =CVideoVipConfig.getInstance().GetVipIcon(res.vip_level);
				activity_center_info.goldIcon = rewardConfig.GetRewardIcon(2,0);//梦幻币图标
				activity_center_info.has_taken_wage_today = res.has_taken_wage_today;
				activity_center_info.wage = res.wage;
				activity_center_info.attached_wage = res.attached_wage;
				//成长任务，放在活动任务的第一条
				var dev_activity_cnt:int = res.dev_activity.length;
				for each(var dev_info:VideoActivityInfoToClient in res.dev_activity)
				{
					var dev_activity:ActivityInfoForUI = new ActivityInfoForUI;
					dev_activity.id = dev_info.id;
					dev_activity.name = dev_info.name;
					dev_activity.desc = dev_info.desc;
					dev_activity.tip = dev_info.tip;
					dev_activity.status = dev_info.status;
					
					for each(var dev_crewad:CReward in dev_info.rewards)
					{
						var dev_rewardUI:ActivityRewardForUI = new ActivityRewardForUI;
						dev_rewardUI.giftType = dev_crewad.type;
						dev_rewardUI.giftId = dev_crewad.female_data;//web端奖励无性别之分
						dev_rewardUI.giftCount = dev_crewad.count;
						dev_rewardUI.giftName = rewardConfig.GetRewardName(dev_crewad.type,dev_crewad.female_data);
						dev_rewardUI.giftIcon = rewardConfig.GetRewardIcon(dev_crewad.type,dev_crewad.female_data);;
						dev_rewardUI.giftIntro = rewardConfig.GetRewardIntro(dev_crewad.type,dev_crewad.female_data);
						dev_rewardUI.giftTips = dev_rewardUI.giftName + ":" + dev_rewardUI.giftCount;
						dev_rewardUI.channel = dev_crewad.channel;
						
						Globals.s_logger.debug("返回页面串：dev_crewad.type = " + dev_crewad.type + "   ERewardType.R_VIP = " + ERewardType.R_VIP + "   res.vip_level = " + res.vip_level + "  dev_rewardUI.giftId = " + dev_rewardUI.giftId);
						
						if(dev_crewad.type == ERewardType.R_VIP && res.vip_level != 0)
							dev_rewardUI.giftId = res.vip_level;
						if( VideoChannelType.IsQueryReaward(dev_rewardUI.channel))
						{
							var dev_gift:RewardReqestWeb = new RewardReqestWeb;
							dev_gift.amount = dev_crewad.count;
							dev_gift.id = IsSelfMale() ? dev_crewad.male_data : dev_crewad.female_data;
							dev_gift.type = dev_crewad.type;
							dev_gift.channel = dev_rewardUI.channel;
							
							giftArr.push(dev_gift);
						}
						dev_activity.rewards.push(dev_rewardUI);
					}
					
					// 此处是因为服务器预留，防止运营配置多个完成条件，目前完成条件只会有一个
					for(var dev_k1:String in dev_info.completed_conditions)
					{
						var dev_bar:ActivityProcess = new ActivityProcess;
						dev_bar.key = dev_k1;
						dev_bar.cur_progress = dev_info.completed_conditions[dev_k1].cur_progress.toString();
						dev_bar.need_progress = dev_info.completed_conditions[dev_k1].need_progress.toString();
						dev_activity.progress.push(dev_bar);
					}
					activity_center_info.activity_info.push(dev_activity);	
				}
				//活动任务
				for each(var info:VideoActivityInfoToClient in res.activity_infos)
				{
					var tmp:ActivityInfoForUI = new ActivityInfoForUI;
					
					tmp.id = info.id;
					tmp.name = info.name;
					tmp.desc = info.desc;
					tmp.begin_time = info.begin_time;
					tmp.end_time = info.end_time;
					tmp.status = info.status;
					
					for each(var crewad:CReward in info.rewards)
					{
						var rewardUI:ActivityRewardForUI = new ActivityRewardForUI;
						rewardUI.giftType = crewad.type;
						rewardUI.giftId = crewad.female_data;//web端奖励无性别之分
						rewardUI.giftCount = crewad.count;
						rewardUI.giftName = rewardConfig.GetRewardName(crewad.type,crewad.female_data);
						rewardUI.giftIcon = rewardConfig.GetRewardIcon(crewad.type,crewad.female_data);;
						rewardUI.giftIntro = rewardConfig.GetRewardIntro(crewad.type,crewad.female_data);
						rewardUI.giftTips = rewardUI.giftName + ":" + rewardUI.giftCount;
						rewardUI.channel = crewad.channel;
						if( VideoChannelType.IsQueryReaward(rewardUI.channel ))
						{
							var gift:RewardReqestWeb = new RewardReqestWeb;
							gift.amount = crewad.count;
							gift.id = IsSelfMale() ? crewad.male_data : crewad.female_data;
							gift.type = crewad.type;
							gift.channel = crewad.channel;
							
							giftArr.push(gift);
						}
						tmp.rewards.push(rewardUI);
					}
					
					// 此处是因为服务器预留，防止运营配置多个完成条件，目前完成条件只会有一个
					for(var k1:String in info.completed_conditions)
					{
						var bar:ActivityProcess = new ActivityProcess;
						bar.key = k1;
						bar.cur_progress = info.completed_conditions[k1].cur_progress.toString();
						bar.need_progress = info.completed_conditions[k1].need_progress.toString();
						tmp.progress.push(bar);
					}
					activity_center_info.activity_info.push(tmp);					
				}
				
				
				for each(var dailyInfo:VideoActivityInfoToClient in res.daily_activity_infos)
				{
					var daily:DailyActivityInfoForUI = new DailyActivityInfoForUI;
					daily.id = dailyInfo.id;
					daily.name = dailyInfo.name;
					daily.desc = dailyInfo.desc;
					
					for each(var crewad_daily:CReward in dailyInfo.rewards)
					{
						var rewardUI_daily:ActivityRewardForUI = new ActivityRewardForUI;
						rewardUI_daily.giftType = crewad_daily.type;
						rewardUI_daily.giftId = crewad_daily.female_data;//web端奖励无性别之分
						rewardUI_daily.giftCount = crewad_daily.count;
						rewardUI_daily.giftName = rewardConfig.GetRewardName(crewad_daily.type,crewad_daily.female_data);
						rewardUI_daily.giftIcon = rewardConfig.GetRewardIcon(crewad_daily.type,crewad_daily.female_data);;
						rewardUI_daily.giftIntro = rewardConfig.GetRewardIntro(crewad_daily.type,crewad_daily.female_data);
						rewardUI_daily.giftTips = rewardUI_daily.giftName + ":" + rewardUI_daily.giftCount;
						
						rewardUI_daily.channel = crewad_daily.channel;
						if(VideoChannelType.IsQueryReaward(rewardUI_daily.channel ))
						{
							var gift_daily:RewardReqestWeb = new RewardReqestWeb;
							gift_daily.amount = crewad_daily.count;
							gift_daily.id = IsSelfMale() ? crewad_daily.male_data : crewad_daily.female_data;
							gift_daily.type = crewad_daily.type;
							gift_daily.channel = crewad_daily.channel;
							
							giftArr.push(gift_daily);
						}
						
						daily.rewards.push(rewardUI_daily);
					}	
					daily.status = dailyInfo.status;
					// 此处是因为服务器预留，防止运营配置多个完成条件，目前完成条件只会有一个
					for(var k:String in dailyInfo.completed_conditions)
					{
						var bar1:ActivityProcess = new ActivityProcess;
						bar1.key = k;
						bar1.need_progress = dailyInfo.completed_conditions[k].need_progress.toString();
						bar1.cur_progress = dailyInfo.completed_conditions[k].cur_progress.toString();
						daily.progress.push(bar1);						
					}
					activity_center_info.daily_activity_info.push(daily);
				}
				
				// web引流任务
				for each(var webinfo:VideoActivityInfoToClient in res.activity_infos_web)
				{
					var webinfoUI:ActivityInfoForUI = new ActivityInfoForUI;
					webinfoUI.id = webinfo.id;
					webinfoUI.name = webinfo.name;
					webinfoUI.desc = webinfo.desc;
					webinfoUI.begin_time = webinfo.begin_time;
					webinfoUI.end_time = webinfo.end_time;
					webinfoUI.status = webinfo.status;
					for each(var webRewad:CReward in webinfo.rewards)
					{
						var webRewardUI:ActivityRewardForUI = new ActivityRewardForUI;
						webRewardUI.giftType = webRewad.type;
						webRewardUI.giftId = webRewad.female_data;//web端奖励无性别之分
						webRewardUI.giftCount = webRewad.count;
						webRewardUI.giftName = rewardConfig.GetRewardName(webRewad.type,webRewad.female_data);
						webRewardUI.giftIcon = rewardConfig.GetRewardIcon(webRewad.type,webRewad.female_data);;
						webRewardUI.giftIntro = rewardConfig.GetRewardIntro(webRewad.type,webRewad.female_data);
						webRewardUI.giftTips = webRewardUI.giftName + ":" + webRewardUI.giftCount;
						
						webRewardUI.channel = webRewad.channel;
						if( VideoChannelType.IsQueryReaward( webRewardUI.channel ))
						{
							var gift_web:RewardReqestWeb = new RewardReqestWeb;
							gift_web.amount = webRewad.count;
							gift_web.id = IsSelfMale() ? webRewad.male_data : webRewad.female_data;
							gift_web.type = webRewad.type;
							gift_web.channel = webRewardUI.channel;
							
							giftArr.push(gift_web);
						}
						
						webinfoUI.rewards.push(webRewardUI);
					}
					// 此处是因为服务器预留，防止运营配置多个完成条件，目前完成条件只会有一个
					for(var webkey:String in webinfo.completed_conditions)
					{
						var webbar:ActivityProcess = new ActivityProcess;
						webbar.key = webkey;
						webbar.cur_progress = webinfo.completed_conditions[webkey].cur_progress.toString();
						webbar.need_progress = webinfo.completed_conditions[webkey].need_progress.toString();
						webinfoUI.progress.push(webbar);
					}
					activity_center_info.activity_info_web.push(webinfoUI);	
				}

			}
			
			if( m_ui != null )
			{
				if( giftArr.length > 0 )
				{
					m_reward_cookie_manager.GetRewordsInfos(giftArr,m_ui.OnGetAcitivityCenterInfosRes, VideoResultType.VREST_Normal, res.succ, activity_center_info ,dev_activity_cnt);
				}
				else
					{
						var tmpArr:Array = new Array;
						m_ui.OnGetAcitivityCenterInfosRes( VideoResultType.VREST_Normal, res.succ, activity_center_info ,dev_activity_cnt,tmpArr);
					}
			}
		}
		
		private function HandleCEventTakeDailyWageRes(ev:INetMessage):void
		{
			var evt:CEventTakeDailyWageRes = ev as CEventTakeDailyWageRes;
			
			if(evt.res == 1)
			{
				m_base.AddVideoDreamMoney(evt.wage+evt.attached_wage);
			}
			if( evt != null && m_ui != null)
			{
				m_ui.OnTakeDailyWageRes( VideoResultType.VREST_Normal, evt.res, evt.wage, evt.attached_wage );
			}
		}
		
		private function ConvertLogic2UIVideoRoomStatus(logic_status:int):int
		{
			if (logic_status == VideoRoomState.VRS_OPEN || logic_status == VideoRoomState.VRS_NONE)
				return RoomStatus.VRS_Wait;
			else if (logic_status == VideoRoomState.VRS_LIVE)
				return RoomStatus.VRS_Playing;
			else 
				return RoomStatus.VRS_Closed;
		}
		
		private function HandleCEventEditAnchorImpressRes(ev:INetMessage):void
		{
			var evt:CEventEditAnchorImpressRes = ev as CEventEditAnchorImpressRes;
			if(evt == null)
				return;
			
			m_ui.OnEditAnchorImpressionForPlayer(evt.result);
		}
		
		private function HandleCEventVideoRoomCreateVideoRoleRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomCreateVideoRoleRes = ev as CEventVideoRoomCreateVideoRoleRes;
			if(evt == null)
				return;
			
			if( evt.res == 0)
			{
				this.m_loginManager.start();
				m_callcenter.SetCharactor(true);
				GetVideoClientPlayer().SyncVideoClientPlayerInfo();
			}
			m_ui.OnCreateRole(VideoWebOperationType.VOT_CreateRole,evt.res,evt.recommend_nick);
		}
		
		public function ConnectRoomProxy(qq:Int64, verify:String, zoneid:int, needCache:Boolean, channel:int, appid:int, skey:String):void {
//			Globals.s_logger.debug("-2:qq:" + qq.toNumber() + "--m_ConnQQ:" + m_ConnQQ);
			//128的请求和-2的请求是必须是同一个qq，不同就弹异常
			//首页的0和游客的0除外
			//if(m_ConnQQ >0 && m_ConnQQ != qq.toNumber())
			if (m_callcenter.GetQQ() > 0 && m_callcenter.GetQQ() != qq.toNumber()) {
				if (Globals.isLogoutState) {
					return;
				}
				Globals.isLogoutState = true;
				LoginChangeToDo();
				Globals.s_logger.localLog("ChangeLogin: -2请求的QQ和服务器建立连接时的QQ号不一致。 "
					+ "(callcenter qq:" + m_callcenter.GetQQ() + " connect qq:" + qq.toString() + ")");
				var op:Object = {"op_type": VideoWebOperationType.Change_Login, "res": VideoWebCode.CHANGE_LOGIN_ACCOUNT_CHANGE,
						"msg": "-2请求的QQ和服务器建立连接时的QQ号不一致。"};
				if (x51VideoWeb.isOldFrame) {
					ExternalInterface.call("MGC_Comm.ChangeLogin", op);
					Globals.s_logger.debug("ConnectRoomProxy()    MGC_Comm.ChangeLogin");
				} else {
					ExternalInterface.call("mgc.network.recvMsg", op);
					Globals.s_logger.debug("ConnectRoomProxy()    mgc.network.recvMsg   ChangeLogin");
				}

				return;
			}

			Globals.channel = channel;

			//炫舞2客户端上不检测登录异常。
			if (Globals.channel == VideoChannelType.VCT_X52 && Globals.deviceType == ClientDeviceType.CDT_X52) {

			} else {
				var cookie:Cookie    = new Cookie("x51web");
				var lastqq:uint      = cookie.getData(AccountCookieConst.QQ);
				//("qq" + Globals.cookieQQ + "_" + Globals.cookieZoonID); //登陆态里的qq
				var lastzoneid:int   = cookie.getData(AccountCookieConst.ZONE_ID);
				//("room_proxy_zoneid" + Globals.cookieQQ + "_" + Globals.cookieZoonID); //登陆态里的大区

				var is_guest:Boolean = cookie.getData(AccountCookieConst.IS_GUEST); //("is_guest");

				if (lastqq != 0 && lastzoneid != zoneid && is_guest == false) //当前想要登录的大区 需要和登录态里的大区保持一致
				{
					Globals.s_logger.debug("ConnectRoomProxy()  " + "lastqq:" + lastqq + ",lastzoneid:" + lastzoneid);

					if (Globals.isLogoutState) {
						return;
					}
					Globals.isLogoutState = true;

					LoginChangeToDo();

					var log_msg:String = "-2请求的zoneid（" + zoneid + "）和连接服务器cookie中zoneid（" + lastzoneid + "）不一致。";
					Globals.s_logger.localLog("ChangeLogin: " + log_msg);

					var op_zone:Object = {"op_type": VideoWebOperationType.Change_Login, "res": VideoWebCode.CHANGE_LOGIN_ACCOUNT_CHANGE,
							"msg": log_msg};
					if (x51VideoWeb.isOldFrame) {
						ExternalInterface.call("MGC_Comm.ChangeLogin", op_zone);
					} else {
						ExternalInterface.call("mgc.network.recvMsg", op_zone);
					}
					return;
				}
			}

//			if(channel == 1)
//			{
//				zoneid = 10888;
//			}
			m_callcenter.Init((uint)(qq.toNumber()), verify, zoneid, appid, skey);
			m_callcenter.DoConnect();
			return;
		}

		public function GetRoomDataForUI(data:VideoRoomData):void 
		{
			m_base.GetRoomDataForUI(data);
		}

		private function HandleCEventVideoRoomGetRoomInfoRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomGetRoomInfoRes = ev as CEventVideoRoomGetRoomInfoRes;
			if(evt == null)
				return;
			var info:RoomInfoForUI = new RoomInfoForUI;
			
			info.room_id = evt.room_id;
			info.room_name = evt.room_name;
			info.room_state = ConvertLogic2UIVideoRoomStatus(evt.room_state);
			info.anchor_name = evt.anchor_name;
			info.audience_cnt = evt.audience_cnt;
			info.result = evt.result;
			var data:VideoRoomData = new VideoRoomData;
			GetRoomDataForUI(data);
			
			if (info.room_state == RoomStatus.VRS_Playing)
			{
				var pic_download_url1:String = m_base.GetPicDownloadUrl();
				info.room_logo_url = OlinePictureDef.GetVideoRoomSnapShotUrl(pic_download_url1,GetVideoGroupID(), info.room_id);
			}
			else
			{
				var client:IAnchorNestClient = GetAnchorNestClient();
				var is_in_nest_room:Boolean = false;
				if (client != null)
				{
					is_in_nest_room = client.IsAnchorNestRoom();
				}
				if (is_in_nest_room)
				{
					var pic_download_url2:String = m_base.GetPicDownloadUrl();
					info.room_logo_url = OlinePictureDef.GetVideoRoomPictureDownloadUrl(pic_download_url2, GetVideoGroupID(), info.room_id, 0);
				}
				else
				{
					if (!IsInRoom())
					{
						var pic_download_urltmp:String = m_base.GetPicDownloadUrl();
						info.room_logo_url = OlinePictureDef.GetVideoRoomPictureDownloadUrl(pic_download_urltmp, GetVideoGroupID(), info.room_id, 0);
					}
					else
					{
						info.room_logo_url = "";
						var room_pics:Array = data.roomPics;
						
						for (var i:int = 0; i < room_pics.length;i++)
						{
							var str:String = room_pics[i]; 
							if( str != null && str.length != 0 )
							{
								info.room_logo_url = str;
								break;
							}
						}
					}
				}
			}
			if (m_ui != null)
				m_ui.OnLoadRoomInfo(info);
		}
		private function HandleCEventLoadAnchorImpressForPlayerRes(ev:INetMessage):void
		{
			var evt:CEventLoadAnchorImpressForPlayerRes = ev as CEventLoadAnchorImpressForPlayerRes;
			if(evt == null)
				return;
			
			var data:Array = new Array;
			GetAnchorImpressionForUI3(data,evt.impressiondata);
			m_ui.OnLoadAnchorImpressionForPlayer(VideoResultType.VREST_Normal, data,evt.anchor_id.toNumber(),evt.m_status);
			
		}
		
		private function GetAnchorImpressionForUI3(data:Array,impression_flag:Int64):void
		{
			for (var i:int = 0; i < 64 ; i++)
			{
				if (impression_flag.isBitSet(i))
				{
					data.push(i);
				}
			}
		}
		
		private function HandleCEventRefreshVideoCharInfoToClient(ev:INetMessage):void
		{
			var evt:CEventRefreshVideoCharInfoToClient = ev as CEventRefreshVideoCharInfoToClient;
			m_video_client_player.SetCharInfo(evt.info);
		}
		
		private function HandleCEventRefreshFollowedAnchorsIDToClient(ev:INetMessage):void
		{
			//var evt:CEventRefreshFollowedAnchorsIDToClient = ev as CEventRefreshFollowedAnchorsIDToClient;
			//m_video_client_player.SetFollowingAnchorIDs(evt.ids);
		}
		
		private function HandleCEventGetVideoPlayerInfoRes(ev:INetMessage):void
		{
			//Tracer.warning("HandleCEventGetVideoPlayerInfoRes skipped!because no use in web");
//			Globals.s_logger.warn("HandleCEventGetVideoPlayerInfoRes skipped!because no use in web");
			//var evt:CEventGetVideoPlayerInfoRes = ev as CEventGetVideoPlayerInfoRes;
			//if(evt.succ)
			//{
			//m_video_client_player.SetFollowingAnchorIDs(evt.followed_anchors);
			//}
			
			
			//m_video_client_player.SetVideoCharInfo(true, evt.succ, evt.char_info);
			
			//			if ( Globals.isConnect  == true)//登陆时候的刷新，回调登陆成功的接口
			//			{
			//				if(evt.succ)
			//				{	
			//					m_ui.notifyConnected(0,Globals.RoomProxyZoneID,Globals.RoomProxyIp,Globals.RoomProxyPort);
			//					Globals.isConnect = false;
			//				}
			//				else
			//					m_ui.notifyConnected(1,Globals.RoomProxyZoneID,Globals.RoomProxyIp,Globals.RoomProxyPort);
			//			}
			
		}
		private function AnchorFansSortByAffnity(argc1:VideoRoomPlayerDataForAnchorCardFans,argc2:VideoRoomPlayerDataForAnchorCardFans):int
		{
			var res:int = 0;
			var aff1:Number = Number(argc1.affinity);
			var aff2:Number = Number(argc2.affinity);
			
			if(aff1 > aff2)
				res = -1;
			else if(aff1 < aff2)
				res = 1;			
			return res;
		}
		
		private var mypPattern:RegExp = /\\/g;
		
		private function HandleCEventVisitAnchorRes(ev:INetMessage):void
		{
			var pEvent:CEventVisitAnchorRes = ev as CEventVisitAnchorRes;
			if(pEvent == null)
			{
				return;
			}
			//tqos上报 begin
			var tqos:TQOSQueryAnchorCard = new TQOSQueryAnchorCard();
			tqos.nQQ = m_callcenter.GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nAnchorQQ = pEvent.card.pstid.toNumber();
			tqos.nErrorCode = pEvent.res;
			tqos.Response();
			//tqos上报 end
			var card:AnchorInfocard = new AnchorInfocard;
			if(m_ui != null)
			{
				Globals.s_logger.debug("HandleCEventVisitAnchorRes server ifsuccess pEvent=  " + JSON.stringify(pEvent) + "," + (pEvent.player_id.toString()));
				if(pEvent.res == CEventVisitAnchorRes.VAR_Succ)
				{				
					var data:Array = new Array ;
					GetAnchorImpressionForUI(data, pEvent.impressions);
					
					card.basicData.m_impression_data.m_impressions = data;
					
					card.basicData.m_impression_data.m_total_count = pEvent.impressions.total_count;
					card.basicData.m_impression_data.m_player_count = pEvent.impressions.player_count;
					
					m_base.AnchorCardToAnchorInfocard(pEvent.card,card);
					
					//刷新本地数据---只有当前房间的主播id等于加载的主播信息时 才刷新本地的
					// xw81665 同时刷新一下主播关注数（粉丝）
					if( pEvent.card.pstid.equal( m_base.GetAnchorQQ()))
					{
						m_base.UpdateLiveDetailImpression(pEvent.impressions, pEvent.card.followed);
					}
					
					card.guardIcon = m_guard_Config.GetIcon(card.current_guard_level);
					
					var url :String = m_guard_Config.GetGuardRuleURL();
					var isFollow:Boolean = 	m_video_client_player.IsFollowingAnchor(Int64.fromJsonNode(card.basicData.anchorID));
					
					//对主播的粉丝按亲密度从高到低排序
					card.fans.sort(AnchorFansSortByAffnity);
					
					card.basicData.name = card.basicData.name.replace(mypPattern,"\\\\");
					card.basicData.intro = card.basicData.intro.replace(mypPattern,"\\\\");
					card.basicData.from = card.basicData.from.replace(mypPattern,"\\\\");
					
					Globals.s_logger.debug("OnLoadAnchorInfocard server tojson =  " + JSON.stringify(card));
					m_ui.OnLoadAnchorInfocard(VideoResultType.VREST_Normal, true,card,url,isFollow);
				}
				else
				{
					var rurl :String = m_guard_Config.GetGuardRuleURL();
					Globals.s_logger.debug("OnLoadAnchorInfocard server tojson =  " + JSON.stringify(card));
					m_ui.OnLoadAnchorInfocard(VideoResultType.VREST_Normal, false,card,rurl,false);					
				}
			}			
		}
		private function HandleCEventNotifyAudiencePublishAnchorTask(ev:INetMessage):void
		{
			var pEvent:CEventNotifyAudiencePublishAnchorTask = ev as CEventNotifyAudiencePublishAnchorTask;
			if(pEvent == null)
				return;
			Globals.needShowAnchorTask = pEvent.is_show;
			if(m_ui != null)
				m_ui.AudienceOnPublishAnchorTask(pEvent.is_show, pEvent.need_show_special);
		}
		private function HandleCEventTakeAnchorTaskRes(ev:INetMessage):void
		{
			var pEvent:CEventTakeAnchorTaskRes = ev as CEventTakeAnchorTaskRes;
			if(pEvent == null)
				return;
			if(m_ui != null)
				m_ui.OnTakeAnchorTaskRes(pEvent.res);
			
			//tqos上报 begin
			var tqos:TQOSAcceptAnchorTask = new TQOSAcceptAnchorTask();
			tqos.nQQ = m_callcenter.GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nRoomId = Globals.SelfRoomID;
			tqos.nErrorCode = pEvent.res;
			tqos.Response();
			//tqos上报 end
			
		}
		private function HandleCEventDropAnchorTaskRes(ev:INetMessage):void
		{
			var pEvent:CEventDropAnchorTaskRes = ev as CEventDropAnchorTaskRes;
			if (pEvent == null)
				return;
			if(m_ui != null)
				m_ui.OnDropAnchorTaskRes(pEvent.res);
		}
		private function HandleCEventAnchorTaskUnavailable(ev:INetMessage):void
		{
			var pEvent:CEventNotifyAnchorTaskUnavailable = ev as CEventNotifyAnchorTaskUnavailable;
			if(pEvent == null)
				return;
			if(m_ui != null)
				m_ui.OnAnchorStopLive();
		}
		
		private function HandleCEventRemoveAnchorTask(ev:INetMessage):void
		{
			var pEvent:CEventRemoveAnchorTask = ev as CEventRemoveAnchorTask;
			if(pEvent == null)
				return;
			if(m_ui != null)
				m_ui.OnRemoveAnchorTask();
		}
		
		private function GetAnchorImpressionForUI(data:Array, server_data:AnchorImpressionDataServer):void
		{
			var impression_list:Array = server_data.impressions;
			for each(var da:AnchorImpressionData in impression_list)
			{
				var tmp:AnchorImpressionDataForUI = new AnchorImpressionDataForUI;
				tmp.m_impression_id = da.impression_id;
				tmp.m_count = da.count;
				tmp.m_impression_name = m_impression_config.GetImpressionName(da.impression_id);
				data.push(tmp);
			}
		}
		
		public function GetUICallback():IVideoClientLogicCallback
		{
			return m_ui;
		}		
		
		public function SendEvent(ev:INetMessage, roomid:int,deviceType:int = 0):void
		{
			if(ev.CLSID() == EVENT_ID_ZONE_RANK.CLSID_CEventLoadRank)
			{
				//排行榜qos上报 begin
				var tqosRank:TQOSQueryRank = new TQOSQueryRank();
				tqosRank.nQQ = m_callcenter.GetQQ();
				tqosRank.nDeviceType = ClientDeviceType.CDT_WEB;
				tqosRank.nRoomId = Globals.SelfRoomID;
				tqosRank.StrRoomServerIP = m_callcenter.GetRPip();
				tqosRank.Response();
				//tqos上报 end
			}
			Globals.s_logger.info("SendEvent CLSID:"+ev.CLSID());
			m_callcenter.sendMessageToRoomProxy(ev, roomid);
		}
		
		public function GetLocalAccountID():Int64
		{
			return Int64.fromNumber(m_callcenter.GetQQ());
		}
		
		public function GetLocalAccountType():int
		{
			return 0;
		}
		
		public function GetSelfPersistID():Int64
		{
			return m_video_client_player.GetVideoPersistID();
		}
		
		public function IsSelfMale():Boolean
		{
			return m_video_client_player.IsMale();
		}
		
		public function GetType():int
		{
			return VideoClientType.VCT_X5Client;
		}
		
		public function GetConfigPath():String
		{
			return null;
		}
		
		public function GetLogicInternal():IVideoClientLogicInternal
		{
			return this;
		}
		
		public function GetVideoClientBase():CVideoClientBase
		{
			return m_base;
		}
		
		public function GetRoomID():int
		{
			return Globals.SelfRoomID;
		}
		
		public function GetIsGuest():Boolean
		{
			return m_isGuest;
		}
		
		
		public function IsInRoom():Boolean
		{
			return Globals.SelfRoomID != 0;
		}
		
		public function SetRoomIcons(icons:Dictionary):void
		{
			m_room_icons = icons;
		}
		
		public function SetVipUrl(url:String):void
		{
			m_vip_url = url;
		}
		
		public function SetLogicCallBack(cb:IVideoClientLogicCallback):void
		{
			m_ui = cb as IVideoClientLogicCallback;
		}
		
		
		public function  HandleCEventRoomIsClosing(  evt :INetMessage ):void
		{
			m_ui.OnRoomIsClosing();
		}
		
		
		public function LoadRoomList(type:int, category:int , beginIndex:int , requestNum:int,module_type:int,tag:int = 0,position:int = 0,source:int=0):void
		{
			m_base.LoadRoomList(type, category, beginIndex, requestNum,tag,position,module_type,source);
		}
		
		public function GetServerTime():int
		{
			return m_video_client_player.GetVideoServerTime()/ 1000;
		}
		
		public function GetVideoAdUrl():String
		{
			return m_video_ad_url;
		}
		
		//=================================
		// 进入房间，异步
		public function EnterRoom(roomID:int,data:ByteArray,options:EnterOption,source:int, tag:int, module_type:int, page_capacity:int, room_list_pos:int):Boolean
		{	
			Globals.s_logger.debug("EnterRoom page to server videoclient =  " + source + "," + module_type + "," + page_capacity + "," + room_list_pos);
			
			m_base.EnterRoom(roomID, data, options, source, tag, module_type, page_capacity, room_list_pos);
			return true;
		}
		
		// 退出房间，异步
		public function LeaveRoom():Boolean
		{
			m_base.LeaveRoom();
			return true;
		}
		
		// 获得主播名片信息，异步
		public function  GetAnchorCardInfo(anchorID:Int64):Boolean
		{			
			m_base.GetAnchorCardInfo(anchorID );
			return true;
		}
		// 获取房间内玩家列表, param: pageIndex页序号，异步
		public function LoadPlayerList(pageIndex:int ):Boolean
		{
			m_base.LoadPlayerList(pageIndex,VideoClientType.VCT_X5Client);
			return true;
		}

		/**
		 * 创建新角色
		 * @param nick
		 * @param gender
		 * @param nick_pool
		 * @param nick_record_id
		 * @param is_auto_create
		 * 
		 * QGame快速注册接口增加is_auto_create参数，true表示是自动创建，false表示手动创建
		 * 
		 */
		public function CreateRole(nick:String, gender:int, nick_pool:int, nick_record_id:int, is_auto_create:Boolean):void {
			var ev:CEventVideoRoomCreateVideoRole = new CEventVideoRoomCreateVideoRole;
			ev.nick = nick;
			m_nick = nick;
			ev.gender = gender;
			ev.rand_nick_pool = nick_pool;
			ev.nick_record_id = nick_record_id;
			ev.m_is_auto_create = is_auto_create;
			Globals.s_logger.debug("is_auto_create" + is_auto_create);
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		// 获取宝箱数据，异步
		public function GetTreasureBoxData(roomID:int ):Boolean
		{
			var evt:CEventVideoGetGiftPoolBoxInfo = new CEventVideoGetGiftPoolBoxInfo;
			evt.room_id = roomID;
			SendEvent(evt,Globals.SelfRoomID);
			return true;
		}
		// 房间内亲密度排行榜，异步
		public function LoadVideoRoomAffinityRank(timedimension:int = 0):Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoAffinityRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			ev.rank_timedimension = timedimension;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		
		
		// 主播星耀值排行榜，异步
		public function LoadVideoRoomAnchorStarlightRank(timedimension:int = 0):Boolean
		{		
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoStarlightRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			ev.rank_timedimension = timedimension;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		
		//主播人气值排行榜，异步
		public function LoadVideoRoomAnchorPopularityRank():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoPopularityRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		//玩家贡献榜，异步
		public function LoadActivityPlayerRank():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "CommonActivityPlayerRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		//主播PK榜，异步
		public function LoadAnchorPKRank():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoAnchorPKRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		
		// 送礼，异步
		public function SendGift(gift_id:int , gift_cnt:int,anchor_id:Int64,star_gift:Boolean ):Boolean
		{
			// UI端会检查玩家身上的代币数量，客户端逻辑就不检查了
			var giftev:CEventVideoSendGift = new CEventVideoSendGift;
			giftev.gift_count = gift_cnt;
			giftev.gift_id = gift_id;
			if( anchor_id.isZero() )
				giftev.anchor_qq = m_base.GetAnchorQQ();
			else
				giftev.anchor_qq = anchor_id;
			giftev.star_gift = star_gift;
			SendEvent(giftev,Globals.SelfRoomID);
			return true;
		}
		// 搜索在线列表，异步
		public function SearchOnlinePlayer( key_words:String):void
		{
			m_base.SearchOnlinePlayer(key_words);
		}
		// 投票，参数为玩家选择的选项索引列表，索引从0开始，异步
		public function TakeVote(select:Array) :void
		{
			m_base.GetVoteClient().TakeVote(select);
		}
		//连接视频版本服务器获取大区角色信息
		public function ConnectVideoVersion(qq:uint,verify:String,m_appid:uint,m_skey:String):void
		{
			//连接版本服务器时候 记录一下当前的qq，防止连roomserver时候 账号不一致
			m_ConnQQ = qq;
//			Globals.sVersionCallCenter.ConnectVersion(qq,verify,m_appid,m_skey);
		}
		
		// 请求投票信息，异步
		public function GetVoteStartInfo():void
		{
			m_base.GetVoteClient().GetVoteStartInfo();
		}
		//获得推荐房间列表,prob概率[0-100],recommend_count推荐房间最大数量，异步
		public function  LoadRecommendVideoRoom(type:int ,prob: int ,recommend_count:int ):void
		{
			// 连接完成
			var ev:CEventLoadRecommendVideoRoom = new CEventLoadRecommendVideoRoom;
			ev.type = type;
			SendEvent(ev,Globals.SelfRoomID);
		}
		public function GetPlayerGuardLevel():int
		{
			return m_base.GetPlayerGuardLevel();
		}
		//发送聊天信息ChatChannel	
		public function  SendChatMsg( msg:String, channelID:int, recver_id:Int64, recver_name:String, recver_zoneName:String) :Boolean
		{
			//			var len:int = msg.length;
			//			const MaxMessageLength:int = 86;
			//			var max_length :int = MaxMessageLength;
			//			
			//			var guard_chat_length :int= m_guardConfig.GetSWordNum(GetPlayerGuardLevel());
			//			if(guard_chat_length > 0)
			//				max_length = guard_chat_length+1;
			//			
			//			if (channelID == ChatChannel.VIDEOCHNL_Whistle || channelID == ChatChannel.VIDEOCHNL_SUPERSTARHORN)
			//			{
			//				max_length = 100+1;
			//			}
			//			if(len >= max_length) //这儿是由普通用户发的，不能超过MaxMessageLength=86
			//			{
			//				return false;
			//			}
			//小窝助手不受禁言 限速等影响
			m_base.SendChatMsg( msg, channelID, recver_id, recver_name, recver_zoneName, !GetAnchorNestClient().IsNestAssistant());
			return true;
		}
		
		//梦工厂VIP贵族 begin
		//获取VIP价格信息
		public function GetVipPrice():Boolean
		{
			var req_ev:CEventQueryBuyVideoVipPrice = new CEventQueryBuyVideoVipPrice;
			SendEvent(req_ev,Globals.SelfRoomID);
			return true;
		}
		//获取免费飞屏数量
		public function  GetFreeWhistleCount():int
		{
			var req_ev:CEventQueryFreeWhistleLeft = new CEventQueryFreeWhistleLeft ;
			SendEvent(req_ev,Globals.SelfRoomID);
			return 0;
			// 不再从本地取，直接查询服务器
			//return m_base.GetFreeWhistleLeft();
		}
		//获取免费超新星数量
		public function GetFreeSuperStarHornLeft():int
		{
			return m_base.GetFreeSuperStarHornLeft();
		}
		public function SetVipFreeWhistleLeft( left:int  ):void
		{
			m_base.SetVipFreeWhistleLeft(left);
		}
				
		public function SetVipFreeSuperStarHornLeft(left:int ):void
		{
			m_base.SetVipFreeSuperStarHornLeft(left);
		}

		//开通VIP
		public function StartVip(vip_level:int, duration:int, cost_type:int, anchor_id:Int64):Boolean {
			var request_ev:CEventBuyVideoVip = new CEventBuyVideoVip;
			request_ev.vip_level = vip_level;
			request_ev.buy_type = VideoVipBuyType.VVBT_Start;
			request_ev.duration = duration;
			request_ev.anchor_id = anchor_id;
			//兼容服务器和页面
			cost_type = ChangeCostType.ChangeJSCostType(cost_type);
			request_ev.cost_type = cost_type;
			SendEvent(request_ev, Globals.SelfRoomID);
			return true;
		}

		//续费VIP
		public function RenewalVip(vip_level:int, duration:int, cost_type:int, anchor_id:Int64):Boolean {
			var request_ev:CEventBuyVideoVip = new CEventBuyVideoVip;
			request_ev.vip_level = vip_level;
			request_ev.buy_type = VideoVipBuyType.VVBT_Renewal;
			request_ev.duration = duration;
			request_ev.anchor_id = anchor_id;
			//兼容服务器和页面
			cost_type = ChangeCostType.ChangeJSCostType(cost_type);
			request_ev.cost_type = cost_type;
			SendEvent(request_ev, Globals.SelfRoomID);
			return true;
		}
		//获取梦工厂名片信息
		public function GetPlayerVideoCardInfoById(player_id:Int64, source:int ):Boolean
		{
			return m_base.GetPlayerVideoCardInfoById(player_id, source);
		}
		//上传梦工厂名片头像
		public function UploadVideoCardPortait(content:ByteArray):Boolean
		{
			var req_ev:CEventUploadVideoPlayerCardPortrait  = new CEventUploadVideoPlayerCardPortrait ;
			req_ev.pic_content.buffer().writeBytes(content);
			
			SendEvent(req_ev,Globals.SelfRoomID);
			return true;
		}
		//修改梦工厂名片个性签名
		public function ModifyVideoCardSignature(sig:String):Boolean
		{
			var req_ev:CEventModifyVideoPlayerCardSignature = new CEventModifyVideoPlayerCardSignature ;
			req_ev.signature = sig;
			SendEvent(req_ev,Globals.SelfRoomID);
			return true;
		}
		//领取VIP每日福利
		public function TakeVipDailyReward():Boolean
		{
			m_base.TakeVipDailyReward();
			return true;
		}
		//在自己的梦工厂名片上取消主播关注
		public function CancelFollowAnchorFromVideoCard(anchor_id:String):Boolean
		{
			return false;
		}
		//守护禁言或者解除禁言沿用ForbidTalk接口
		//查询VIP等级
		public function GetVideoVipLevel():int
		{
			return m_base.GetVideoVipLevel();
		}
		//查询VIP剩余日期
		public function GetVideoVipExpire():int
		{
			return m_base.GetVideoVipExpire();
		}
		
		public function GetPrivateInfoList():void
		{
			GetUICallback().OnGetPrivateInfoList(m_base.GetRoomPrivateChatList());
		}

		public function LoadMemberOperationInfo(member_id:Int64, name:String, zoneName:String):Boolean {
			// 成员操作列表
			var ev:CEventLoadMemberOperationInfo = new CEventLoadMemberOperationInfo;
			ev.name = name;
			ev.zoneName = zoneName;
			ev.member_id = member_id;
			SendEvent(ev, Globals.SelfRoomID);
			return false;
		}
		
		public function QueryVideoMoney():Boolean
		{
			var ev:CEventVideoQueryVideoMoney = new CEventVideoQueryVideoMoney;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}	
		
		public function QueryBalance(save_num:int): Boolean
		{
			var ev:CEventVideoQueryBalance = new CEventVideoQueryBalance ;
			var param:VideoWebPayParam = new  VideoWebPayParam;
			param.open_id = this.GetLocalAccountID().toString();
			var bridge:IVideoClientAdapter   = GetVideoClientAdapter();
			if ( bridge )
			{
				param = bridge.GetVideoWebPayParam();
				ev.open_id = param.open_id;
				ev.open_key = param.open_key;
				ev.pay_token = param.pay_token;
				ev.pf = param.pf;
				ev.pf_key = param.pf_key;
			}
			
			ev.save_num = save_num;
			ev.device_type = ClientDeviceType.CDT_WEB;
			SendEvent(ev, Globals.SelfRoomID);
			return false;
		}
		public function EncryptPortraitUrl(url:String,cnt:int ): Boolean
		{
			var evt:CEventEncryptPortraitUrl = new CEventEncryptPortraitUrl;
			evt.url = url;
			SendEvent(evt, Globals.SelfRoomID);
			m_erncrypt_url_cnt = cnt;
			m_erncrypt_url = url;
			return false;
		}
		
		
		//今天是否领取过VIP福利
		public function HaveTakenVipDailyRewardToday():Boolean
		{
			return m_base.HaveTakenVipWeeklyRewardToday();
		}
		public function ForbidTalk(ban:Boolean, perpetual:Boolean, pstid:Int64):Boolean
		{	
			m_base.ForbidTalk(ban,perpetual,pstid);
			return true;
		}
		public function IsChatBanned(zone_name:String, player_name:String ):Boolean
		{
			return m_base.IsChatBanned(zone_name,player_name);
		}
		public function IsPerpetualChatBan(zone_name:String, player_name:String ):Boolean
		{
			return m_base.IsPerpetualChatBan(zone_name,player_name);
		}
		//梦工厂VIP贵族 end
		public function GetLivingNetworkStatus():int
		{
			return 0;
		}
		
		//全民选秀 begin
		//设置或取消评委，judge_type为TSJT_Invalid表示取消
		public function SetTalentShowJudge(player_name:String,zone_name:String, judge_type:int):void
		{
			
		}
		
		
		//加载星主播积分排行榜
		public function LoadStarAnchorScoreRank():void
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoStarAnchorRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		
		//加载舞团联盟争霸排行榜
		public function LoadGuildChampionRank():void
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoGuildChampionRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		//全民选秀 end
		// (video guild)加载主播积分榜
		public function LoadAnchorScoreRank(timedimension:int):Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoAnchorScoreRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.rank_timedimension = timedimension;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		
		// (video guild)加载后援团排行榜
		public function LoadVideoGuildRank():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoGuildRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;			
		}
		
		//请求周星榜请求
		public function VideoStarGiftRankWeb():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoStarGiftRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;			
		}
		//请求冠军榜请求
		public function VideoStarGiftChampionRankWeb():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoStarGiftChampionRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;			
		}
		
		
		//加载优胜主播榜
		public function LoadAnchorPKWinnerRank():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name ="VideoAnchorPKWinnerRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		//加载英豪榜
		public function LoadAnchorPKRichManRank():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name ="VideoAnchorPKRichmanRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		
		//查询是否具有评委身份，同步接口
		public function GetPlayerJudgeType(player_name:String, zone_name:String):int
		{
			return 0;
		}
		//打分
		public function ScoreTalentShow(scores:Array):void
		{
			
		}
		//加载当前分数
		public function LoadTalentShowScore():void
		{
			
		}
		//开始比赛
		public function StartTalentShow() :void
		{}
		//停止比赛
		public function StopTalentShow():void
		{
			
		}
		//获取房间的活动比赛状态 //找不到对应的回调函数？？？？？？？？？
		public function GetTalentShowStatus(activity_type:int):int
		{
			return 0;		
		}
		//当前是否在全民选秀活动期间（和玩家所处房间无关）////找不到对应的回调函数？？？？？？？？？
		public function InTalentShowActivity( activity_type:int):Boolean
		{
			return true;
		}
		
		
		//点赞
		public function DianZan():void
		{
			m_base.GetTalentShow().DianZan();
		}
		//获取舞团争霸介绍url///找不到对应的回调函数
		public function GetGuildChampionIntroUrl():String
		{
			return null;
		}
		public function GetCRedEnvelopeClient():CRedEnvelopeClient
		{
			return m_base.GetCRedEnvelopeClient();
		}
		
		public function GetVideoGuildClient():IVideoGuildClient
		{
			return m_base.GetVideoGuildClient();
		}
		
		public function GetNestClient():IAnchorNestClient
		{
			return m_base.GetNestClient();
		}
		
		public function GetSurpriseBoxMng():IClientSurpriseBoxManager
		{
			return m_base.GetSurpriseBoxMng();
		}
		
		public function GenerateAnchorPortraitUrl(anchor_id:Int64):String
		{
			return null;
		}
		
		public function LoadAttachedPlayerInfoCard(anchor_id:Int64):void
		{
			
		}
		
		public function GetAnchorPKClient():IAnchorPKClient
		{
			return null;
		}
		
		// 获取VIP贵宾席
		public function LoadVipSeats(anchorID:Int64):Boolean
		{
			return false;
		}
		
		
		
		//获取梦工厂门票购买url		
		//获取梦工厂门票特效
		public function GetVideoRoomTicketEffect():String
		{
			return null;
		}
		// 玩家用：选择或更换支持的主播
		public function ChooseSupportAnchor(anchor:Int64):void
		{
			
		}
		// 获得活动信息（包括各个主播的信息、玩家自己支持的主播和玩家自己对各个主播的支持度，其他数据不要使用，可能为脏数据）
		public function GetCeremonyStartInfo():CeremonyStartInfoForUI
		{
			return null;
		}
		// 获得活动信息（包括各个主播的支持度和粉丝排行）
		public function GetCeremonyInfo():CeremonyRefreshInfoForUI
		{
			return null;
		}
		// 获得活动状态（枚举VideoCeremonyState）
		public function GetCeremonyState():int
		{
			return 0;
		}
		// 获得支持的主播是否在线
		public function IsAnchorOnline(anchor_id:Int64):Boolean
		{
			return false;
		}
		//领取主播任务
		public function TakeAnchorTask():void
		{
			var event:CEventTakeAnchorTask = new CEventTakeAnchorTask;
			SendEvent(event,Globals.SelfRoomID);
		} 
		//放弃主播任务
		public function DropAnchorTask():void
		{
			var event:CEventDropAnchorTask = new CEventDropAnchorTask;
			SendEvent(event,Globals.SelfRoomID);
		}
		
		// 玩家vip榜，异步
		public function LoadVideoVIPRank(begin_index:int , end_index:int ):Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoVIPRank"
			ev.title.data.operator_id = GetSelfPersistID();
			ev.begin_index = begin_index;
			ev.end_index = end_index;
			ev.source = 1;
			SendEvent(ev,Globals.SelfRoomID);
			return true;
		}
		
		//获取热度加成信息，VIP等级和人数，加成点数
		public function GetGiftPoolAdditionInfo():void
		{
			return m_base.GetGiftPoolAdditionInfo();
		}
		
		// 抢红包
		public function GrabRedEnvelope(red_id:String):void
		{}
		// 查看红包
		public function LoadRedEnvelopeInfo(red_id:Int64):void
		{}
		// 记录屏蔽列表
		public function AddChatIngoreList(playerId:Int64):void
		{}
		public function RemoveChatIngoreList(player_id:Int64):void
		{}
		
		
		// 永久全房间禁言
		public function ForbidTalkForAllRoom(playerId:Int64, ban:Boolean):Boolean
		{
			return true ; 
		}
		public function GetAnchorNestClient():IAnchorNestClient
		{
			return m_base.GetAnchorNestClient();
		}
		public function LoadNestAssistantList():void
		{
			
		}
		
		//主播获取印象信息
		public function LoadAnchorImpressionForAnchor(anchor_id:Int64):void
		{
			var ev:CEventLoadAnchorImpress = new CEventLoadAnchorImpress;
			ev.anchor_id = anchor_id;
			SendEvent(ev,Globals.SelfRoomID);
		}
		//玩家获取主播印象信息
		public function LoadAnchorImpressionForPlayer(anchor_id:Int64):void
		{
			var ev:CEventLoadAnchorImpressForPlayer = new CEventLoadAnchorImpressForPlayer;
			ev.anchor_id = anchor_id;
			SendEvent(ev,Globals.SelfRoomID);
		}
		//编辑主播印象
		public function EditAnchorImpression(anchor_id:Int64,data:Array):void
		{
			var ev:CEventEditAnchorImpress = new CEventEditAnchorImpress;
			ev.anchor_id = anchor_id;
			var server_data:Array = ev.edit_info;
			var size:int = data.length;
			
			for each(var itr:AnchorImpressionEditForUI in data)
			{
				if(itr.m_impression_id >= 64)
					continue;
				
				var temp:AnchorImpressionEdit = new AnchorImpressionEdit;
				temp.impression_id = itr.m_impression_id;
				temp.op_type = itr.m_op_type;
				server_data.push(temp);				
			}
			
			if(server_data.length == 0)
			{
				return;
			}
			
			SendEvent(ev,Globals.SelfRoomID);
		} 
		
		
		// 主播双周星耀值排行榜，异步
		public function LoadVideoRoomAnchorTwoweekStarlightRank():Boolean
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			if (m_base.GetRoomType() == VideoRoomType.VRT_AUDIO)
			{
				ev.title.rank_name = "AudioTwoweekStarlightRank";
			}
			else
			{
				ev.title.rank_name = "VideoTwoweekStarlightRank";
			}
			ev.trans_id = Int64.fromNumber(0);
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev,Globals.SelfRoomID);
			return true;
		}
		
		//查询某个小窝任务奖励
		public function QueryNestTaskReward(index:int):void
		{
			
		}
		//加载小窝列表
		public function LoadNestList():void
		{
			
		}
		// 加载某个房间信息
		public function LoadRoomInfo(roomID:int ):void
		{
			var ev:CEventVideoRoomGetRoomInfo = new CEventVideoRoomGetRoomInfo;
			ev.room_id = roomID;
			SendEvent(ev,Globals.SelfRoomID);
		}
		public function AssistantSetFunction(player_id:Int64, forbid_public_chat:Boolean, open_chat_cd:Boolean, chat_cd_time:int, cooldown_cd:int, room_id:int):void
		{
			
		}
		public function GetPublicChatCoolDownTimeOnEnter():int
		{
			return 0;
		}
		public function GetChatParameter(forbidden_public_chat:Boolean, open_chat_cd:Boolean,chat_cd_time:int):void
		{
			
		}
		public function KickPlayer(playerName:String,playerZoneName:String):Boolean
		{
			return m_base.KickPlayer(playerName, playerZoneName);
		}
		
		public function FillAnchorPortraitUrl(anchor_data:ClientAnchorData):void
		{
			m_base.FillAnchorPortraitUrl(anchor_data);
		}
		
		public function FillAnchorImageUrl(anchor_data:ClientAnchorData):void
		{
			m_base.FillAnchorImageUrl(anchor_data);
		}
		
		public function FillVideoRoomPicUrl(room_data:VideoRoomData):void
		{
			m_base.FillVideoRoomPicUrl(room_data);
		}
		
		public function FillVideoRoomLogoUrl(room_data:VideoRoomData):void
		{
			m_base.FillVideoRoomLogoUrl(room_data);
		}
		public function LoadSuperFans(fanstype:int,anchorID:Int64):Boolean
		{
			m_base.LoadSuperFans(fanstype);
			return true;
		}
		
		public function CheckNick( nick:String):void
		{	
			var ev:CEventVideoRoomCheckNick = new 	CEventVideoRoomCheckNick ;
			ev.nick = nick;
			SendEvent(ev,Globals.SelfRoomID);
		}
		//预览宝箱
		public function LoadPreviewTreasureBoxDataNewRole(box_id:int,activity_id:int = 0):void
		{
			var ev:CEventLoadPreviewVideoTreasureBoxNewRole = new CEventLoadPreviewVideoTreasureBoxNewRole;
			ev.box_id = box_id;
			ev.activity_id = activity_id;
			ev.device_type = ClientDeviceType.CDT_WEB;
			SendEvent(ev,Globals.SelfRoomID);
		}
		//查询主播任务
		public function QueryClientAnchorTaskNewRole():void
		{
			var ev:CEventQueryAnchorTaskNewRole = new CEventQueryAnchorTaskNewRole;
			SendEvent(ev,Globals.SelfRoomID);
		}
		
		//屏蔽
		public function isInIgnoreList( strNickName:String, strZoneName:String):Boolean
		{
			return m_base.isInIgnoreList(strNickName,strZoneName);
		}
		public function IgnorePlayer( player_id:Int64,strNickName:String, strZoneName:String, bAdd:Boolean):void
		{
			m_base.IgnorePlayer(player_id,strNickName, strZoneName,bAdd);
		}
		// 玩家财富排行榜
		public function LoadVideoRichRank(begin_index:int, end_index:int,timedimension:int = 0):void
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoRichRank";
			ev.title.data.operator_id =  GetSelfPersistID();
			ev.begin_index = begin_index;
			ev.end_index = end_index;
			ev.rank_timedimension = timedimension;
			ev.source = 1;
			SendEvent(ev,Globals.SelfRoomID);
		}
		// 加载视频等级排行榜，异步
		public function LoadVideoLevelRank(begin_index:int, end_index:int):void
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoLevelRank";
			ev.title.data.operator_id = GetSelfPersistID();
			ev.begin_index = begin_index;
			ev.end_index = end_index;
			ev.source = 1;
			SendEvent(ev,Globals.SelfRoomID);
		}
		// 获取活动中心信息
		public function GetActivityCenterInfos():void
		{
			var ev:CEventGetActivityCenterInfos = new CEventGetActivityCenterInfos;
			SendEvent(ev,Globals.SelfRoomID);
		}
		// 领取活动中心奖励
		public function TakeVideoActivityRewards(activity_id:int, activity_category:int):void
		{
			var ev:CEventTakeVideoActivityRewards = new CEventTakeVideoActivityRewards;
			ev.activity_id = activity_id;
			ev.activity_category = activity_category;
			SendEvent(ev,Globals.SelfRoomID);
		}
		
		// 领取每日工资
		public function TakeDailyWage():void
		{
			var ev:CEventTakeDailyWage = new CEventTakeDailyWage;	
			SendEvent(ev,Globals.SelfRoomID);
		}
		
		//频闭私聊，除了主播和管理员以外
		public function ForbidPrivateChat(forbid:int):void
		{
			var cookie:Cookie = new Cookie("x51web");
			Globals.isForbidPrivateChat =( forbid == 0 ? true:false);
			cookie.flushData("isForbidPrivateChat",Globals.isForbidPrivateChat);
		}
		
		public function   QueryRaffle():void
		{
			m_client_raffle_manager.QueryRaffle();
		}
		public function  GetConcertCurLeftTime():void
		{
			m_client_raffle_manager.GetConcertCurLeftTime();
		}
		public function   DoRaffle():void
		{
			m_client_raffle_manager.DoRaffle();
		}
		public function GetBuyTicketAndPicURL():void
		{
			m_base.GetBuyTicketAndPicURL();
		}
		
		public function  SetDefaultDefinition( definition :int):void
		{
			m_base.SetDefaultDefinition(definition);
		}
		
		public function  GetRoomStatus( ):void
		{
			m_base.GetRoomStatus();
		}
		
		public function  GetCurrentAvailableDefinition( ):Array
		{
			return m_base.GetCurrentAvailableDefinition();
		}
		
		public function  GetCurrentDefinition():int
		{
			return m_base.GetCurrentDefinition();
		}
		
		public function ChooseDefinition( definition:int ):Boolean
		{
			return m_base.ChooseDefinition(definition);
		}
		
		
		//		public function DispatchEvent(event:INetMessage):Boolean
		//		{
		//			trace(("x5video_client"), ("DispatchEvent "));		
		//			var ev:INetMessage = m_frag_mng.SpliceEvent(event);
		//			if( ev )
		//			{
		//				event = ev;
		//				return true;
		//			}
		//			
		//			switch(event.CLSID())
		//			{
		//				case MessageID.CLSID_CEventRoomProxyWrapEvent:
		//				{
		//					trace( ("x5video_client"), ("CLSID_CEventRoomProxyWrapEvent") );
		//					var real_evt:CEventRoomProxyWrapEvent = event as CEventRoomProxyWrapEvent;
		//					
		//					
		//					// 序列化
		//					var clsid:int = real_evt.payload.getInt();
		//					var attached_event :INetMessage = m_callcenter.CreateMessage(clsid);					
		//					ProtoBufSerializer.FromStream(attached_event,real_evt.payload);
		//					
		//					if(!attached_event)
		//						return false;
		//					
		//					m_callcenter.onDispatchEvent(attached_event, real_evt.serialID);
		//					HandleServerEvent(attached_event);
		//				}
		//					break;
		//				default:
		//					HandleServerEvent(event);
		//					break;
		//			}
		//			return true;
		//		}
		
		//查询是否可以进入某房间
		public function CanEnterRoom(roomid:int):void
		{
			var ev:CEventVideoRoomCanEnterRoom = new CEventVideoRoomCanEnterRoom;
			ev.room_id = roomid;
			SendEvent(ev,Globals.SelfRoomID);		
		}
		//设置已经进行过新手引导了
		public function SetNoviceGuided():void
		{
			var ev:CEventSetNoviceGuided = new CEventSetNoviceGuided;
			SendEvent(ev,Globals.SelfRoomID);		
		}
		
		//请求梦幻币礼物数量
		public function QueryDreamGift():void
		{
			var ev:CEventQueryDreamGift = new CEventQueryDreamGift;
			SendEvent(ev,Globals.SelfRoomID);
		}
		
		//查询活动中心完成数量
		public function GetActivityCompleteCount():void 
		{
			var ev:CEventGetActivityCompletedCount = new CEventGetActivityCompletedCount;
			SendEvent(ev,Globals.SelfRoomID);
		}
		
		//查询当前进入房间是不是演唱会房间
		public function QueryIsConcertRoom():Boolean
		{
			return m_base.IsConcert();
		}
		
		//获取好友给自己充值的信息
		public function GetFriendPayCashInfo():void
		{
			var event:CEventGetFriendPayCashNotice = new CEventGetFriendPayCashNotice();
			SendEvent(event, Globals.SelfRoomID);
			//TODO 配一个假数据
//			var ev:CEventNotifyFriendPayCash = new CEventNotifyFriendPayCash();
//			ev.info = [];
//			for (var i:int = 0; i < 2; i ++){
//				var presenter:FriendPayInfo = new FriendPayInfo();
//				presenter.presenter_qq = new Int64();
//				presenter.presenter_qq.low = 10000 + i;
//				presenter.presenter_nick = "test_" + i;
//				presenter.amount = new Int64();
//				presenter.amount.low = 1000*i;
//				ev.info.push(presenter);
//			}
//			HandleServerEvent(ev);
		}
		
		public function GetPortraitUrl():void
		{
			m_ui.OnGetPortraitUrl( m_video_client_player.GetPhotoUrl() );
		}
		
		public function GetGiftEffectCnt():void
		{
			m_base.GetGiftEffectCnt();
		}
		
		//首登签到begin
		public function GetFirstLoginRewardNotify(real_login:Boolean ):void//玩家领取首次登陆奖励
		{
			var evt:CEventVideoUserLogin = new CEventVideoUserLogin;
			evt.real_login = real_login;
			SendEvent(evt,Globals.SelfRoomID);
		}
		public function GetFirstLoginReward():void//领取首登奖励
		{
			var evt:CEventConfirmFirstLoginReward = new CEventConfirmFirstLoginReward;
			SendEvent(evt,Globals.SelfRoomID);
		}
		public function SignDaliyNotify():void//每日签到提醒
		{
			var evt:CEventGetSigninRewardNotify = new CEventGetSigninRewardNotify;
			SendEvent(evt,Globals.SelfRoomID);
		}
		public function GetSignDailyInfo():void//获取每日签到信息
		{
			var evt:CEventGetDailySigninRewardContent = new CEventGetDailySigninRewardContent;
			SendEvent(evt,Globals.SelfRoomID);
		}
		public function SignInDaily():void//领取签到奖励
		{
			var evt:CEventSigninDaily = new CEventSigninDaily;
			SendEvent(evt,Globals.SelfRoomID);
		}
		public function GetCumulativeReward(accday:int):void//领取累计奖励
		{
			var evt:CEventSigninAccumulate = new CEventSigninAccumulate;
			evt.day = accday;
			SendEvent(evt,Globals.SelfRoomID);
		}
		//首登签到end
		
		/**
		 * 房间日常任务完成消息提示
		 * @param event
		 * 
		 */		
		public function HandleDailyRoomActivity(event:INetMessage):void
		{
			var ev:CEventNotifyRoomActivityComplete = event as CEventNotifyRoomActivityComplete;
			// _X1
			var giftArr:Array = new Array;
			for( var index:int =0 ; index < ev.activity.rewards.length; index ++ )
			{
				var res:CReward = ev.activity.rewards[index];
				if( VideoChannelType.IsQueryReaward( res.channel ))
				{
					var gift_web:RewardReqestWeb = new RewardReqestWeb;
					gift_web.amount = res.count;
					gift_web.id = IsSelfMale()?res.male_data:res.female_data;
					gift_web.type = res.type;
					gift_web.channel = res.channel;
					
					giftArr.push(gift_web);
				}
			}
			
			if( giftArr.length > 0 )
			{
				m_reward_cookie_manager.GetRewordsInfos(giftArr,m_ui.OnDailyRoomActivity,ev.activity,ev.activity_category);
			}
			else
			{
				m_ui.OnDailyRoomActivity(ev.activity,ev.activity_category,giftArr);
			}
		}
		
		
		/**
		 * 房间日常任务完成消息提示
		 * @param event
		 * 
		 */		
		public function responseGiftIDArray(event:INetMessage):void
		{
			var ev:CEventNotifyConcertVideoGiftUsableIDs = event as CEventNotifyConcertVideoGiftUsableIDs;
			
			m_ui.OnGiftIDArray(ev.gift_ids);
			if(m_free_gift != null )
			{
				m_ui.RefreshConcertFreeGiftInfo(m_free_gift);
				m_free_gift = null;
		}
		}
		
		public function GetGuestInfo():void
		{
			var evt:CEventGetGuestInfo = new CEventGetGuestInfo;
			SendEvent(evt,Globals.SelfRoomID);
		}
		
		public	function GetAllTags(is_home:Boolean):void
		{
			var evt:CEventGetAllTags = new CEventGetAllTags;
			evt.homepage = is_home;
			SendEvent(evt,Globals.SelfRoomID);
		}
		
		public	function GetRandNick(last_nick_pool:int,gender:int):void
		{
			var evt:CEventGetRandNick = new CEventGetRandNick;
			evt.last_nick_pool = last_nick_pool;
			evt.gender = gender;
			SendEvent(evt,Globals.SelfRoomID);
		}
		
		public function QueryGuestCookie():void
		{
			var cookie:Cookie = new Cookie("x51webGuest");
			var encrypt_identity:String = cookie.getData("identity");
			var qq:int = cookie.getData("guest_qq");
			
			var hasCookie:Boolean = false;
			if( qq !=0 && encrypt_identity.length >0)
				hasCookie = true;
			m_ui.OnQueryGuestCookie(hasCookie,qq,encrypt_identity);
		}
		
		public function QueryIsGuest():void
		{
			m_ui.OnQueryIsGuest(m_isGuest);
		}
		
		public function HandleCEventGetGuestInfoRes(event:INetMessage):void
		{
			var ev:CEventGetGuestInfoRes = event as CEventGetGuestInfoRes;
			var cookie:Cookie = new Cookie("x51webGuest");
			if(ev.status == 0)
			{
				cookie.flushData("identity",ev.encrypt_identity);
				cookie.flushData("guest_qq",ev.id);
				Globals.isReconnection = true;
				ConnectVideoVersion(ev.id,ev.encrypt_identity,Globals.appid,Globals.skey);
			}
			m_ui.OnGetGuestInfo(ev.status, ev.id, ev.encrypt_identity);
		}
		
		public function HandleCEventGetAllTagsRes(event:INetMessage):void
		{
			var ev:CEventGetAllTagsRes = event as CEventGetAllTagsRes;
			m_ui.OnGetAllTags(ev.status,ev.tags);
		}
		
		public function HandleCEventGetGetRandNickRes(event:INetMessage):void
		{
			var ev:CEventGetRandNickRes = event as CEventGetRandNickRes;
			m_ui.OnGetRandNick(ev.nick,ev.nick_pool,ev.nick_record_id);
		}
		
		//火箭礼物
		public function HandleCEventGrabDreamBoxRes(event:INetMessage):void
		{
			var ev:CEventGrabDreamBoxRes = event as CEventGrabDreamBoxRes;
			
			m_ui.OnGrabDreamBox(ev.res,ev.box_id.toString(),ev.money_type,ev.money_count);
			
			//梦幻币加成到本地
			if( ev.res == DreamBoxErrorCode.DBEC_Success && ev.money_type == DreamBoxMoneyType.DBMT_VideoMoney)
			{
				m_video_client_player.SetVideoMoney(m_video_client_player.GetDreamMoneyNum() + ev.money_count,null);
			}
		}
		public function HandleCEventGetDreamBoxGrabRecRes(event:INetMessage):void
		{
			var ev:CEventGetDreamBoxGrabRecRes = event as CEventGetDreamBoxGrabRecRes;
			
			//页数
			var tolcnt:int = ev.total_size / 10;
			if( ev.total_size % 10 ) 
				tolcnt += 1;
			
			var player_name:String = ev.publisher_nick.replace(/\\/g,"\\\\");
			var vecs:Array = new Array();
			for(var i:String  in ev.rec )
			{
				var grabber:DreamBoxGrabber =  new DreamBoxGrabber;
				grabber.player_name =  ev.rec[i].player_name.replace(/\\/g,"\\\\");
				grabber.money = ev.rec[i].money;
				grabber.money_type = ev.rec[i].money_type;
				grabber.player_zone = ev.rec[i].player_zone;
				vecs.push(grabber);
			}
			m_dreambox_rate = ev.video_money_rate;
			m_ui.OnQueryDreamBoxRec(ev.res,ev.box_id.toString(),tolcnt,player_name,ev.total_money,ev.grab_count,ev.video_money_rate,vecs);
		}
		public function HandleCEventPublishDreamBox(event:INetMessage):void
		{
			var ev:CEventPublishDreamBox = event as CEventPublishDreamBox;
			var info:DreamBoxForUI = new DreamBoxForUI;
			DreamBoxClientInfoToUI(ev.box ,info);
			m_ui.PublishDreamBox(ev.box_count,info);
		}
		public function HandleNotifyDreamBoxGrabbedOut(event:INetMessage):void
		{
			var ev:CEventNotifyDreamBoxGrabbedOut = event as CEventNotifyDreamBoxGrabbedOut;
			m_ui.NotifyDreamBoxGrabbedOut();
		}
		public function HandleCEventBroadcastAllRoomRocketGift(event:INetMessage):void
		{
			var ev:CEventBroadcastAllRoomRocketGift = event as CEventBroadcastAllRoomRocketGift;
			var player_name:String = ev.player_name.replace(/\\/g,"\\\\");
			var anchor_name:String = ev.anchor_name.replace(/\\/g,"\\\\");
			m_ui.ShowRocketGiftWhistle(player_name,anchor_name,ev.player_zone,ev.wealth_level,ev.guard_level,ev.vip_level,ev.rocket_cnt,ev.room_id,ev.is_nest,ev.player_id, ev.invisible);
		}
		
		public function HandleCEventRefreshDreamBoxCount(event:INetMessage):void
		{
			var ev:CEventRefreshDreamBoxCount = event as CEventRefreshDreamBoxCount;
			m_ui.RefreshDreamBoxCnt(ev.box_count);
		}
		
		public function HandleCEventClearDreamBox(event:INetMessage):void
		{
			var ev:CEventClearDreamBox = event as CEventClearDreamBox;
			m_ui.NotifyClearDreamBox();
		}
		public function HandleCEventVideoRoomLeaveRoomRes(event :INetMessage):void
		{
			var ev:CEventVideoRoomLeaveRoomRes = event as CEventVideoRoomLeaveRoomRes;
			if( m_bLoginChange ==  false )
			m_ui.NotifyLeaveRoomRes(ev.status);
		}
		
		public function DreamBoxClientInfoToUI(sinfo:DreamBoxClientInfo,tinfo:DreamBoxForUI):void
		{
			tinfo.box_id = sinfo.box_id.toString();
			tinfo.has_grabbed = sinfo.has_grabbed;
			tinfo.total_money = sinfo.total_money;
			var server_time:int = GetServerTime();
			tinfo.count_down = 	sinfo.count_down + sinfo.generate_time - server_time ;//倒计时剩余的秒数
			//Cc.error("count_down:",sinfo.count_down,"  generate_time:",sinfo.generate_time,"  server_time:",server_time);
			if(tinfo.count_down > sinfo.count_down)
			{
				tinfo.count_down = sinfo.count_down;
			}
			
			if( tinfo.count_down < 0 )
				tinfo.count_down = -1;
		}
		
		//屏蔽免费礼物(免费花花和梦幻币礼物)
		public function ForbiFreeGift(forbid:Boolean):void
		{
			Globals.forbidFreeGift = forbid;
		}
		
		//新增高级守护  房间id，座位id，所有者id号，耗费炫逗数量
		public function TakeRoomGuardSeat(seatIndex:int,owner:Int64,cost:int):void//抢座
		{
			var evt:CEventTakeRoomGuardSeat = new CEventTakeRoomGuardSeat;
			evt.m_room_id = Globals.SelfRoomID;
			evt.m_seat_index = seatIndex;
			evt.m_owner = owner;
			evt.m_cost = cost;
			SendEvent(evt,Globals.SelfRoomID);
		}
		//加载主播等级榜
		public function RefreshAnchorLevelRank():void
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoAnchorLevelRank";
			ev.trans_id.setZero();
			ev.begin_index = 0;
			ev.end_index = 0;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		public function LoadAnchorStarGiftInfo(m_anchor_id:Int64):void
		{
			var ev:CEventLoadAnchorStarGiftInfo = new CEventLoadAnchorStarGiftInfo;
			ev.m_anchor_id = m_anchor_id;
			
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		
		public function TakeVipSeat(cost:int, seat_index:int  ):void
		{
			var ev:CEventTakeVipSeat = new CEventTakeVipSeat;
			ev.cost = cost;
			ev.seat_index = seat_index;
			
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		public function GetSeatPriceResetNotice():void
		{
			m_base.GetSeatPriceResetNotice();
		}
		
		public function GetStarGiftInfo():void
		{
			m_base.GetStarGiftInfo();
		}
		
		//抢梦幻宝箱
		public function GrabDreamBox(box_id:Int64):void
		{
			var ev:CEventGrabDreamBox = new CEventGrabDreamBox;
			ev.box_id = box_id;			
			SendEvent(ev, Globals.SelfRoomID);
		}
		//查抢梦幻宝箱记录
		public function QueryDreamBoxRec(box_id:Int64,index:int):void
		{
			var ev:CEventGetDreamBoxGrabRec = new CEventGetDreamBoxGrabRec;
			ev.box_id = box_id;
			var begin_index:int = (index-1)*10;//一页10名
			var end_index:int = index*10 -1;
			ev.begin_index = begin_index;
			ev.end_index = end_index;
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		//获取vid
		public function GetVideoRoomLiveInfo(roomID:int):void
		{
			Globals.SelfRoomID = roomID;
			Globals.iframeRoomID = roomID;
			
			Globals.isReady = true;
		}
		
		public function RequestGetVideoRoomLiveInfo():void
		{
			Globals.s_logger.debug("RequestGetVideoRoomLiveInfo() : Globals.video_buname = " + Globals.video_buname);
			if(Globals.video_buname.length > 0 )
			{
				var ev:CEventGetVideoRoomLiveInfo = new CEventGetVideoRoomLiveInfo;
				ev.room_id = Globals.iframeRoomID;
				SendEvent(ev, Globals.SelfRoomID);
			}
		}

		public function RequestIgnoreFreeGift(ignore:Boolean):void
		{
			Globals.s_logger.debug("RequestIgnoreFreeGift(" + ignore + ")");
			var ev:CEventIgnoreFreeGift = new CEventIgnoreFreeGift();
			//ev.room_id = Globals.iframeRoomID;
			ev.is_ignore = ignore;
			SendEvent(ev, Globals.SelfRoomID);
		}
		
		public function SetQgame_item_image_url(url:String):void
		{
			m_qgame_item_image_url = url;
		}
		
		public function GetQgame_item_image_url():String
		{
			return m_qgame_item_image_url;
		}
		
		public function GetCheckNickOnLogin():void
		{
			m_base.GetVoteClient().CheckNickOnLogin();
		}
		
		/**
		 * 续期，暂时不使用，不走roomproxy
		 * @param appid
		 * @param key
		 * 
		 */		
		public function VideoClientSigVerify(appid:int,key:String):void
		{
			var ev:CEventVideoClientSigVerify = new CEventVideoClientSigVerify;
			ev.appid = appid;
			ev.key = key;
			SendEvent(ev, Globals.SelfRoomID);
		}

		//============幸运抽奖 start============
		public function OpenLuckyDrawWindow(begin_time:int=-1, config_refresh_time:int=-1):void {
			m_base.OpenLuckyDrawWindow(begin_time, config_refresh_time);
		}
		
		public function CloseLuckyDrawWindow():void{
			m_base.CloseLuckyDrawWindow();
		}

		public function LuckyDraw(is_free:Boolean, is_continuous:Boolean, begin_time:int=-1, refreshTime:int = -1):void {
			m_base.LuckyDraw(is_free, is_continuous, begin_time, refreshTime);
		}
		//============幸运抽奖 end============
		
		//============新皮肤 start============
		public function GetPunchInInfo():void{
			m_base.GetPunchInInfo();
		}
		public function PunchIn(punch_in_id:int, today_index:int, day_index:int, retrieve:Boolean, retrieve_price:int):void{
			m_base.PunchIn(punch_in_id, today_index, day_index, retrieve, retrieve_price);
		}
		
		// 魅力排行榜
		public function LoadVideoRoomCharmRank(begin_index:int, end_index:int, timedimension:int = 0):void {
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoRoomCharmRank";
			ev.title.data.operator_id = GetSelfPersistID();
			ev.begin_index = begin_index;
			ev.end_index = end_index;
			ev.rank_timedimension = timedimension;
			ev.source = 1;
			SendEvent(ev, Globals.SelfRoomID);
		}
		/**
		 * 询问皮肤礼物对应关系
		 * 
		 */		
		public function QuerySkinGift():void{
			m_base.QuerySkinGift();
		}

		public function ADClick(ad_type:int, ad_site:int):void {
			m_base.ADClick(ad_type, ad_site);
		}

		//============新皮肤 end============

		public function sendMissionGuideOver():void {
			var event:CEventVideoRoomWebTipsNotify = new CEventVideoRoomWebTipsNotify();
			SendEvent(event, Globals.SelfRoomID);
			//XW81897 更新本地缓存
			m_video_client_player.SetTipsNotice(true);
		}
		//当客户端完成教学任务时，发送对应的教学任务的flag,给服务器。		
		public function handleFinishEducation(flag:int):void
		{
			var evt:CEventFinishEducation = new CEventFinishEducation;
			evt.flag = flag;
			Globals.s_logger.debug("handleFinishEducation flag = " + JSON.stringify(evt.flag));
			SendEvent(evt,Globals.SelfRoomID);
		}
		//玩家点击密令按钮领取奖励		
		public function sendPlayerDrawSecretHeatBoxReward(is_forbid_talk:Boolean):void
		{
			var evt:CEventPlayerDrawSecretHeatBoxReward = new CEventPlayerDrawSecretHeatBoxReward;
			evt.is_forbid_talk = is_forbid_talk;
			Globals.s_logger.debug("sendPlayerDrawSecretHeatBoxReward is_forbid_talk = " + JSON.stringify(evt.is_forbid_talk));
			SendEvent(evt,Globals.SelfRoomID);
		}
		// 获取演唱会回放房间列表事件		
		public function concertPlaybackRoomGetRoomList(from:int, req_count:int):void
		{
			var evt:CEventConcertPlaybackRoomGetRoomList = new CEventConcertPlaybackRoomGetRoomList;
			evt.from = from;
			evt.req_count = req_count;
			Globals.s_logger.debug("concertPlaybackRoomGetRoomList 41417 = " + JSON.stringify(evt));
			SendEvent(evt,Globals.SelfRoomID);
		}
		// 开始观看演唱会回放事件	
		public function startConcertPlayback(concert_id:int):void
		{
			var evt:CEventStartConcertPlayback = new CEventStartConcertPlayback;
			evt.concert_id = concert_id;
			Globals.s_logger.debug("startConcertPlayback 41419 = " + JSON.stringify(evt));
			SendEvent(evt,Globals.SelfRoomID);
		}
		public function getWeekStarNotifySucc(flag:int):void{
			var evt:CEventWeekStarNotifySucc = new CEventWeekStarNotifySucc;
			evt.flag = flag;
			SendEvent(evt,Globals.SelfRoomID);
		}
		//周星赛URL配置请求
		public function WeekStarConfigReq():void
		{
			var evt:CEventWeekStarConfigReq = new CEventWeekStarConfigReq;
			SendEvent(evt,Globals.SelfRoomID);
		}
		//获取周星积分榜数据
		public function GetWeekStarRankList(sub_rank_name:String, begin_index:int, end_index:int):void
		{
			var ev:CEventLoadRank = new CEventLoadRank;
			ev.title.rank_name = "VideoWeekStarRank";
			ev.title.sub_rank_name = sub_rank_name;
			ev.begin_index = begin_index;
			ev.end_index = end_index;
			ev.source = 1;
			Globals.s_logger.debug("GetWeekStarRankList 22001 = " + JSON.stringify(ev));
			SendEvent(ev, Globals.SelfRoomID);
		}
	}
}