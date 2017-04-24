package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.AnchorImpressionData;
	import com.h3d.qqx5.common.comdata.DiceGiftExtInfo;
	import com.h3d.qqx5.common.comdata.EvtVidoeBoxStatusData;
	import com.h3d.qqx5.common.comdata.LuckyDrawNotice;
	import com.h3d.qqx5.common.comdata.VideoBoxItem;
	import com.h3d.qqx5.common.comdata.VideoChannelType;
	import com.h3d.qqx5.common.comdata.VideoGuardSeatInfo;
	import com.h3d.qqx5.common.comdata.VideoToClientChatMessage;
	import com.h3d.qqx5.common.comdata.VideoToServerChatMessage;
	import com.h3d.qqx5.common.comdata.VipSeatInfo;
	import com.h3d.qqx5.common.event.CEventAnchorGrowthConfig;
	import com.h3d.qqx5.common.event.CEventAnchorTaskRewardNotifyNewRoleWeb;
	import com.h3d.qqx5.common.event.CEventBatchVideoTreasureBoxRewardNewRoleWeb;
	import com.h3d.qqx5.common.event.CEventConcertStatusChange;
	import com.h3d.qqx5.common.event.CEventGetVideoRoomLiveInfoRes;
	import com.h3d.qqx5.common.event.CEventIgnoreFreeGiftRes;
	import com.h3d.qqx5.common.event.CEventLoadNestListRes;
	import com.h3d.qqx5.common.event.CEventLoadPreviewVideoTreasureBoxNewRoleRes;
	import com.h3d.qqx5.common.event.CEventNotifyFriendPayCash;
	import com.h3d.qqx5.common.event.CEventNotifyIsNoviceGuided;
	import com.h3d.qqx5.common.event.CEventNotifySendLotsOfGifts;
	import com.h3d.qqx5.common.event.CEventNotifySplitScreenInfoChange;
	import com.h3d.qqx5.common.event.CEventQueryAnchorTaskNewRoleResWeb;
	import com.h3d.qqx5.common.event.CEventQueryDreamGiftRes;
	import com.h3d.qqx5.common.event.CEventRefreshRoomGuardSeats;
	import com.h3d.qqx5.common.event.CEventRefreshVideoGiftConfig;
	import com.h3d.qqx5.common.event.CEventRefreshVipInfoToClient;
	import com.h3d.qqx5.common.event.CEventRoomGuardSeatLostNotify;
	import com.h3d.qqx5.common.event.CEventSwitchWhistleBroadcast;
	import com.h3d.qqx5.common.event.CEventSyncPlayerDreamGiftAnchorExp;
	import com.h3d.qqx5.common.event.CEventTakeRoomGuardSeatRes;
	import com.h3d.qqx5.common.event.CEventVideoChatBanForAllRoom;
	import com.h3d.qqx5.common.event.CEventVideoChatBanForAllRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoChatResult;
	import com.h3d.qqx5.common.event.CEventVideoGetGiftPoolBoxInfoRes;
	import com.h3d.qqx5.common.event.CEventVideoGiftPoolHeightChange;
	import com.h3d.qqx5.common.event.CEventVideoOpenGiftPoolBoxRes;
	import com.h3d.qqx5.common.event.CEventVideoQueryBalanceRes;
	import com.h3d.qqx5.common.event.CEventVideoQueryVideoMoneyRes;
	import com.h3d.qqx5.common.event.CEventVideoRankChangeBroadcastAllPlayer;
	import com.h3d.qqx5.common.event.CEventVideoRefreshFlower;
	import com.h3d.qqx5.common.event.CEventVideoRoomBasicInfos;
	import com.h3d.qqx5.common.event.CEventVideoRoomBeKicked;
	import com.h3d.qqx5.common.event.CEventVideoRoomCanEnterRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomChatBan;
	import com.h3d.qqx5.common.event.CEventVideoRoomChatBanRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomCheckNickRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomCloseLuckyDrawWindow;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoomBroadcastAllRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetLiveCDN;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetLiveCDNRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomList;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomListRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomKickPlayer;
	import com.h3d.qqx5.common.event.CEventVideoRoomKickPlayerRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomLeaveRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDraw;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDrawActivityInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDrawNotice;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDrawRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomNotifyAttachRoomInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomNotifyLiveStart;
	import com.h3d.qqx5.common.event.CEventVideoRoomNotifyLiveStop;
	import com.h3d.qqx5.common.event.CEventVideoRoomOpenLuckyDrawWindow;
	import com.h3d.qqx5.common.event.CEventVideoRoomOpenLuckyDrawWindowRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomPlayerCount;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshCurrentAnchorDetail;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshLiveStatus;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshRoomAttribute;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshRoomPicInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomSyncLuckyDrawInfo;
	import com.h3d.qqx5.common.event.CEventVideoSearchOnlinePlayer;
	import com.h3d.qqx5.common.event.CEventVideoSearchOnlinePlayerRes;
	import com.h3d.qqx5.common.event.CEventVideoSendGiftResult;
	import com.h3d.qqx5.common.event.CEventVideoToClientChatMessage;
	import com.h3d.qqx5.common.event.CEventVideoToServerChatMessage;
	import com.h3d.qqx5.common.event.CEventVideoTreasureBoxRewardNewRoleWeb;
	import com.h3d.qqx5.common.event.ad.CEventVideoAD;
	import com.h3d.qqx5.common.event.ad.CEventVideoRoomAdClick;
	import com.h3d.qqx5.common.event.ad.VideoAD;
	import com.h3d.qqx5.common.event.eventid.ConcertEventID;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.event.eventid.EventNewGrowthID;
	import com.h3d.qqx5.common.event.eventid.NewGrowthEventID;
	import com.h3d.qqx5.common.event.eventid.SplitScreenEventID;
	import com.h3d.qqx5.common.event.roomskin.CEventGetPunchInInfo;
	import com.h3d.qqx5.common.event.roomskin.CEventGetPunchInInfoRes;
	import com.h3d.qqx5.common.event.roomskin.CEventNewRoomSkinBroadcastAllPlayer;
	import com.h3d.qqx5.common.event.roomskin.CEventNotifyPunchIn;
	import com.h3d.qqx5.common.event.roomskin.CEventPunchIn;
	import com.h3d.qqx5.common.event.roomskin.CEventPunchInRes;
	import com.h3d.qqx5.common.event.roomskin.CEventQuerySkinGift;
	import com.h3d.qqx5.common.event.roomskin.CEventQuerySkinGiftRes;
	import com.h3d.qqx5.common.event.roomskin.CEventRefreshRoomCharmRank;
	import com.h3d.qqx5.common.event.roomskin.CEventRoomDailyTaskRewards;
	import com.h3d.qqx5.common.event.roomskin.CEventRoomSkinDailyTaskInfo;
	import com.h3d.qqx5.common.event.roomskin.CEventRoomSkinLevelUpNotify;
	import com.h3d.qqx5.common.event.roomskin.CEventRoomSkinLevelUpTaskInfo;
	import com.h3d.qqx5.common.event.roomskin.CEventUnlockRoomSkinTaskInfo;
	import com.h3d.qqx5.common.event.roomskin.CEventVideoRoomCharmBroadcastAllRoom;
	import com.h3d.qqx5.common.event.roomskin.PunchInInfoRewardList;
	import com.h3d.qqx5.common.event.roomskin.RoomSkinTaskInfo;
	import com.h3d.qqx5.common.event.roomskin.VideoRoomCharmRank;
	import com.h3d.qqx5.common.specialevent.CEventVideoSendGiftResultForWeb;
	import com.h3d.qqx5.common.specialevent.CEventVideoToClientChatMessageForWeb;
	import com.h3d.qqx5.common.uidata.PrivateChatInfo;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.enum.RoomStatus;
	import com.h3d.qqx5.enum.TakeSeatResult;
	import com.h3d.qqx5.enum.VideoChatChannel;
	import com.h3d.qqx5.enum.VideoDefinitionID;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.enum.VideoRoomErrorCode;
	import com.h3d.qqx5.enum.VideoRoomType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializer;
	import com.h3d.qqx5.modules.anchor_nest.share.NestInfoForUI;
	import com.h3d.qqx5.modules.anchor_nest.share.NestInfoLogicData;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	import com.h3d.qqx5.modules.red_envelope.share.RedEnvelopeGrabberInfo;
	import com.h3d.qqx5.modules.red_envelope.share.RedEnvelopeInfo;
	import com.h3d.qqx5.modules.surprise_box.share.RewardBasicItem;
	import com.h3d.qqx5.modules.video_chat.event.VideoChatEventID;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeWhistleLeft;
	import com.h3d.qqx5.tqos.TQOSCDNHttpRequest;
	import com.h3d.qqx5.tqos.TQOSChatPublic;
	import com.h3d.qqx5.tqos.TQOSEnterRoom;
	import com.h3d.qqx5.tqos.TQOSHomePageLoadTime;
	import com.h3d.qqx5.tqos.TQOSSendGift;
	import com.h3d.qqx5.tqos.TQOSSendWhistle;
	import com.h3d.qqx5.util.AccountCookieConst;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.LuckyDrawConfig;
	import com.h3d.qqx5.util.PersistIDUtil;
	import com.h3d.qqx5.util.TimeUtil;
	import com.h3d.qqx5.util.URLSuffix;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	import com.h3d.qqx5.video_service.serviceinf.EnterVideoRoomInitInfo;
	import com.h3d.qqx5.video_service.serviceinf.LiveCDNInfo;
	import com.h3d.qqx5.video_service.serviceinf.RoomAnchorInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomLiveStatus;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomLiveStatusDetail;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPageSyncInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomState;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomSyncInfo;
	import com.h3d.qqx5.videoclient.OlinePictureDef;
	import com.h3d.qqx5.videoclient.data.AccumulateRewards;
	import com.h3d.qqx5.videoclient.data.AnchorImpressionDataForUI;
	import com.h3d.qqx5.videoclient.data.AnchorPKActivityStatus;
	import com.h3d.qqx5.videoclient.data.AnchorTaskInfoUI;
	import com.h3d.qqx5.videoclient.data.BoxRewardDataForUI;
	import com.h3d.qqx5.videoclient.data.BoxRewardForUI;
	import com.h3d.qqx5.videoclient.data.CHNL_TYPE;
	import com.h3d.qqx5.videoclient.data.CReward;
	import com.h3d.qqx5.videoclient.data.ChatBanResNameData;
	import com.h3d.qqx5.videoclient.data.ChatChannel;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	import com.h3d.qqx5.videoclient.data.DreamGiftForUI;
	import com.h3d.qqx5.videoclient.data.ERewardType;
	import com.h3d.qqx5.videoclient.data.EnterOption;
	import com.h3d.qqx5.videoclient.data.FriendPayInfo;
	import com.h3d.qqx5.videoclient.data.FriendPayInfoForUi;
	import com.h3d.qqx5.videoclient.data.GiftData;
	import com.h3d.qqx5.videoclient.data.GuardLevelEnum;
	import com.h3d.qqx5.videoclient.data.IconString;
	import com.h3d.qqx5.videoclient.data.LoadTreasureBoxDataRes;
	import com.h3d.qqx5.videoclient.data.LotType;
	import com.h3d.qqx5.videoclient.data.RewardDataForUI;
	import com.h3d.qqx5.videoclient.data.RoomPlayerType;
	import com.h3d.qqx5.videoclient.data.SendVideoGiftResult;
	import com.h3d.qqx5.videoclient.data.SendVideoGiftResultInfo;
	import com.h3d.qqx5.videoclient.data.SplitScreenInfo;
	import com.h3d.qqx5.videoclient.data.SplitScreenStatus;
	import com.h3d.qqx5.videoclient.data.UIEnterVideoRoomInfo;
	import com.h3d.qqx5.videoclient.data.UIVideoRedEnvelope;
	import com.h3d.qqx5.videoclient.data.UIVideoRedEnvelopeGrabberInfo;
	import com.h3d.qqx5.videoclient.data.VideoBoxErrorCode;
	import com.h3d.qqx5.videoclient.data.VideoChatErrorCode;
	import com.h3d.qqx5.videoclient.data.VideoChatErrorInfo;
	import com.h3d.qqx5.videoclient.data.VideoGiftBoxType;
	import com.h3d.qqx5.videoclient.data.VideoGuardSeatInfoUI;
	import com.h3d.qqx5.videoclient.data.VideoRoomData;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import com.h3d.qqx5.videoclient.data.VideoRoomPlayerData;
	import com.h3d.qqx5.videoclient.data.VideoRoomScreenScrollInfo;
	import com.h3d.qqx5.videoclient.data.VideoRoomTreasureBoxData;
	import com.h3d.qqx5.videoclient.data.VideoRoomTreasureBoxStatus;
	import com.h3d.qqx5.videoclient.data.VideoVoteInfoForUI;
	import com.h3d.qqx5.videoclient.data.VipAddtionInfo;
	import com.h3d.qqx5.videoclient.data.VipLevelCount;
	import com.h3d.qqx5.videoclient.data.VipLevelEnum;
	import com.h3d.qqx5.videoclient.data.VipSeatInfoForUI;
	import com.h3d.qqx5.videoclient.data.WebColor;
	import com.h3d.qqx5.videoclient.gamereward.RewardReqestWeb;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorPKClient;
	import com.h3d.qqx5.videoclient.interfaces.IClientAnchor;
	import com.h3d.qqx5.videoclient.interfaces.IFansGuardConfig;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientAdapter;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoGuildClient;
	import com.h3d.qqx5.videoclient.interfaces.IVideoRoomClient;
	import com.h3d.qqx5.videoclient.xmlconfig.CGiftConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoActivityRewardConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoVipConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.CVipSeatClientConfig;
	import com.h3d.qqx5.videoclient.xmlconfig.IImpressionConfig;
	
	import flash.external.ExternalInterface;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getTimer;
	
	public class CVideoRoomClient  implements IVideoRoomClient
	{
		private var m_client:IVideoClientInternal = null;
		private var m_base:CVideoClientBase = null;
		
		private var m_attached_room_id:int = 0;
		private var m_attached_anchor:String = "";
		private var m_attached_room_name:String = "";
		
		private var m_live_detail:VideoRoomLiveStatusDetail = new VideoRoomLiveStatusDetail;
		private var m_deputy_anchor_name:String;
		private var m_deputy_anchor_id:Int64 = new Int64;
		private var m_deputy_anchor_zone_name:String;//std::string m_deputy_anchor_name;
		private var m_start_watch_waiting_cdn:Boolean = false;
		private var m_stop_live_waiting_notify:Boolean = false;
		private var m_vecTreasureBox:Array = new Array;
		private var m_continually_board_vgid:Int64 = new Int64;	//当前持续显示粉丝牌 所属后援团ID
		private var m_flags:int = 0;
		private var m_room_id:int = 0;
		private var m_room_name:String = "";
		private var m_status:int = 0;
		private var m_subject:int = 0;
		private var m_audience_count:int = 0;
		private var m_cur_giftpool_height:int = 0;
		private var m_max_giftpool_height:int = 0;
		private var m_roomPicInfo:int = 0;
		private var m_forbid_public_chat:Boolean = false;
		private var m_open_chat_cd_check:Boolean = true;
		private var m_chat_cd_time:int = 0; // 单位ms
		private var m_player_capacity:int = 0;
		private var m_free_whistle_left:int = 0;
		private var m_free_super_star_horn_left:int;
		private var m_type:int = 0; //房间类型
		private var m_public_chat_cd_on_enter:int = 0;
		private var m_low_video_uploadspeed:int = 0;
		private var m_normal_video_uploadspeed:int = 0;
		private var m_cdn_info:LiveCDNInfo = new LiveCDNInfo;
		private var m_watching:Boolean = false;
		private var m_vip_level:int ;  //vip等级
		private var m_vip_expire:int ;  //vip过期时间
		private var m_take_vip_weekly_reward_time:int;
		private var m_room_pics:Array = new Array;
		private var m_last_chat_time : uint;
		private var m_IgnoreList :Array = new Array;	// 屏蔽玩家列表
		
		private var guardConfig:IFansGuardConfig = null;
		private var vipConfig:CVideoVipConfig = null;
		
		private var m_concert:Boolean = false;
		private var m_default_definition:int = 0;
		private var m_current_definition:int;
		private var m_current_vid:int;
		private var m_is_special_room:Boolean = false;
		private var m_is_nest_room:Boolean = false;
		
		private var chatlength:int = 86;//玩家可输入的聊天字数长度默认86
		
		private var m_arrGiftMsgCache:Array = new Array();
		private var m_nGiftMsgCacheCap:int = 200;
		private var m_arrGiftMsgTimer:TimerBase = new TimerBase(500,updateTimer);
		
		private var m_watching_invited_anchor:Boolean = false;
		private var m_start_watch_invited_anchor_waiting_cdn:Boolean = false;
		
		//本地最近私聊列表
		private var m_arrPrivateChatInfoList:Array = new Array();
		//特殊表情
		private static var guard_expression:Array = new Array;
		private static var privil_expression1_t:Array = new Array;
		private static var privil_expression2_s:Array = new Array;
		
		private var m_gift_data:Dictionary = new Dictionary();
		private var m_beKickedRoom:Boolean = false;//记录是否退出房间，为了游客被踢出房间后，页面请求171的时候 直接返回
		private var m_server_chat_cd_time:int = 0; // 服务器根据在线人数动态调整的聊天cd时间
		private var m_seat_price_reset_notice:int = 0;
		
		private var diceGiftId:int = 46;
		
		public function CVideoRoomClient(client:IVideoClientInternal, base:CVideoClientBase)
		{
			m_client = client;
			m_base = base;
			
			for (var i:int = 76 ; i < 86;i++)
			{
				var expressino:String = "$ig" + i + "$18$18$";
				guard_expression.push(expressino);
			}
			//特权表情1
			for (var idx:int = 7 ; idx < 17;idx++)
			{
				var str:String ="";
				if(idx < 10)
					str = "0"+idx.toString();
				else 
					str = idx.toString();
				var expres:String = "$ih" + str + "$18$18$";
				privil_expression1_t.push(expres);
				
//				Globals.s_logger.debug("特权表情1数组   = " + str + "    idx =  " + idx);
			}
			//特权表情2
			for (var index:int = 17 ; index < 27;index++)
			{
				var exp:String = "$ih" + index + "$18$18$";
				privil_expression2_s.push(exp);
			}
			m_arrGiftMsgTimer.StartTimer();
		}
		
		public function IsConcert():Boolean
		{
			return m_concert;
		}
		
		public function GetAnchorGender():int
		{
			return m_live_detail.sex;
		}
		
		public function GetAnchorUrl():String
		{
			return currentAnchorPhotoUrl;
		}
		
		public function GetGiftPoolAdditionInfo():void
		{
			var info :VipAddtionInfo= new VipAddtionInfo;
			info.m_vip_cnt_info = m_vip_cnt_info;
			info.m_vip_addition = m_vip_addition;
			
			m_client.GetUICallback().OnGetVipAdditionRes( info );
		}
		
		public function AddVideoDreamMoney(money:int):void
		{
			m_client.GetVideoClientPlayer().SetVideoMoney(m_client.GetVideoClientPlayer().GetDreamMoneyNum()+money ,null);
		}
		
		public function GetFreeWhistleLeft():int
		{
			return m_free_whistle_left;
		}
		
		public function GetFreeSuperStarHornLeft() :int
		{
			return m_free_super_star_horn_left;
		}
		
		public function updateTimer():void
		{
			sendGiftMsgBatchToUI();
		}
		
		public function GetSeatPriceResetNotice():void
		{
			if( m_seat_price_reset_notice > 0  )
			{
				var server_time :int = m_client.GetLogicInternal().GetServerTime() ;
				//据零点还有多少分钟
				var date:Date = new Date();
				date.time  = server_time * 1000;//毫秒
				var date_next :Date = new Date(date.fullYear,date.month,date.date+1 );
				var minutes:int = (date_next.time - date.time ) /1000 /60 ;//到零点还有多少分钟
				if( minutes < m_seat_price_reset_notice)//间隔小于间隔 开始通知
				{
					m_client.GetUICallback().OnSeatPriceResetNotice( true);
					return ;
				}
				
			}
			m_client.GetUICallback().OnSeatPriceResetNotice(false);
		}
		private function sendGiftMsgBatchToUI():void
		{
			if(this.m_arrGiftMsgCache.length > 0)
			{
				m_client.GetUICallback().OnGiftMsgBatch(this.m_arrGiftMsgCache);
				this.m_arrGiftMsgCache.splice(0);
			}
		}
		
		
		public function  SetVipFreeWhistleLeft(left:int ):void
		{
			m_free_whistle_left = left;
		}
		
		public function  SetVipFreeSuperStarHornLeft(left:int ):void
		{
			m_free_super_star_horn_left = left;
		}
		// 可以发频红包的最低vip等级（亲王）
		private static const VideoRedEnvelope_VipMinLevel:int = 4;
		public function IgnorePlayer( player_id:Int64,strNickName:String, strZoneName:String, bAdd:Boolean):void
		{	
			var strNameWithZone:String = "["+strNickName+"]["+strZoneName+"]";
			//var strNameWithZone:String = "["+player_id+"]";
			
			if (bAdd)
			{
				m_IgnoreList.push(strNameWithZone);
				m_client.GetUICallback().OnIgnorePlayerRes(bAdd, true);
			// 亲王(4)等级以上才可以发红包，所以4级以上才记录屏蔽列表到服务器
				if(m_client.GetVideoClientPlayer().GetVipLevel() >= VideoRedEnvelope_VipMinLevel)
				{
					m_base.GetCRedEnvelopeClient().changeChatIngoreList(player_id,0);
				}
			}
			else
			{
				if(m_client.GetVideoClientPlayer().GetVipLevel() >= VideoRedEnvelope_VipMinLevel)
				{
					m_base.GetCRedEnvelopeClient().changeChatIngoreList(player_id,1);
				}
				
				for( var i:int = 0; i < m_IgnoreList.length ; ++i )
				{
					if(m_IgnoreList[i] == strNameWithZone )
					{
						m_IgnoreList.splice(i,1);
						m_client.GetUICallback().OnIgnorePlayerRes(bAdd, true);
						return ;
					}
				}
				m_client.GetUICallback().OnIgnorePlayerRes(bAdd ,false);
			}
		}
		
		public function isInIgnoreList(strNickName:String, strZoneName:String):Boolean
		{
			var strNameWithZone:String = "["+strNickName+"]["+strZoneName+"]";
			
			for( var i:int = 0; i < m_IgnoreList.length ; ++i )
			{
				if(m_IgnoreList[i] == strNameWithZone )
				{
					return true;
				}
			}
			return false;
		}
		
		public function ForbidTalk( ban:Boolean, perpetual:Boolean, pstid:Int64 ):Boolean
		{
			var evt:CEventVideoRoomChatBan = new CEventVideoRoomChatBan ;
//			evt.target_nickName = playerName;
//			evt.target_zoneName = playerZoneName;
			evt.ban = ban;
			evt.perpetual = perpetual;
			evt.target_player_id = pstid;
			m_client.SendEvent(evt,Globals.SelfRoomID);
			return true;
		}
		
		// 永久全房间禁言
		public function ForbidTalkForAllRoom(playerId:Int64, ban:Boolean):Boolean
		{
			var evt:CEventVideoChatBanForAllRoom = new CEventVideoChatBanForAllRoom ;
//			evt.target_nickName = playerName;
//			evt.target_zoneName = playerZoneName;
			evt.ban = ban;
			evt.target_player_id = playerId;
			
			m_client.SendEvent(evt,Globals.SelfRoomID);
			return true;
		}
		
		public function LoadRoomList(type:int,category:int,beginIndex:int,requestNum:int,tag:int,position:int,module_type:int,source:int):Boolean
		{
			var evt:CEventVideoRoomGetRoomList = new CEventVideoRoomGetRoomList;
			evt.count = requestNum;
			evt.from = beginIndex;
			evt.subject = category;
			evt.room_type = type;
			evt.tag = tag;
			evt.position = position;
			evt.module_type = module_type;
			evt.source = source;
			
			Globals.s_logger.debug("evt.module_type:"+evt.module_type+"----module_type:"+module_type);
			Globals.s_logger.debug("requestNum:"+evt.count+"-----tag:"+tag);
			m_client.SendEvent(evt, Globals.SelfRoomID);
			return true;
		}
		
		public function EnterRoom(roomID:int,data:ByteArray,options:EnterOption,source:int, tag:int, module_type:int, page_capacity:int, room_list_pos:int):void
		{
			var evt:CEventVideoRoomEnterRoom = new CEventVideoRoomEnterRoom;
			evt.room_id = roomID;
			if(m_client.GetIsGuest())
			{
				evt.nick ="游客"+ this.m_client.GetCallCenter().GetQQ();
			}
			else
			{
				evt.nick = this.m_client.GetVideoClientPlayer().GetVideoNick();
				evt.gender = this.m_client.GetVideoClientPlayer().Gender();
				evt.level = this.m_client.GetVideoClientPlayer().GetVideoLevel();
			}
			Globals.tmpRoomID = roomID;
			Globals.isReady = false;
			
			var viplevel:int = this.m_client.GetVideoClientPlayer().GetVipLevel();
			if(viplevel >= VipLevelEnum.jiangjun_viplevel)
			{
				evt.crowd_into = true;
			}
			else
			{
				evt.crowd_into = options.crowd_into;
			}
			
			evt.invisible = options.invisible;
			evt.source = source;
			evt.tag = tag;
			evt.module_type = module_type;
			evt.page_capacity = page_capacity;
			evt.room_list_pos = room_list_pos;
			Globals.s_logger.debug("EnterRoom page to server =  " + JSON.stringify(evt));
			m_client.SendEvent(evt, Globals.tmpRoomID);
			
			LoadCDNInfo();
		}
		
		public function ClearDeputyInfo():void
		{
			m_deputy_anchor_name = null;
			m_deputy_anchor_zone_name = null;
			m_deputy_anchor_id.setZero();	
		}
		
		public function IsCurrentAnchor():Boolean
		{
			if (m_live_detail.anchor_pstid.isZero())
			{
				return false;
			}
			var anchor:IClientAnchor = m_client.GetAnchor();
			if (anchor && anchor.GetVideoAccount().pstid.equal(m_live_detail.anchor_pstid))
			{
				return true;
			}
			return false;
		}
		public function ClearRoomWhenLeave():void
		{
			if(m_watching)
			{
				StopWatchLive();
			}
			
			if (m_watching_invited_anchor)
			{
				StopWatchInvitedAnchorLive();
			}
			
			m_live_detail = new VideoRoomLiveStatusDetail();
			m_current_definition = VideoDefinitionID.VDID_FLUENT;
			m_current_vid = 0;
			m_base.SetCurrentVid(0);
			m_base.SetCurrentInvitedAnchorVid(0);
			m_room_id = 0;
			m_start_watch_waiting_cdn = false;
			m_start_watch_invited_anchor_waiting_cdn = false;
			m_stop_live_waiting_notify = false;
			
			m_cur_giftpool_height = 0;
			m_max_giftpool_height = 0;
			m_vecTreasureBox = new Array;
			
			m_continually_board_vgid.setZero();
		}
		
		public function LeaveRoom():void
		{			
			ClearRoomWhenLeave();
			var event:CEventVideoRoomLeaveRoom = new CEventVideoRoomLeaveRoom;
			m_client.SendEvent(event,Globals.SelfRoomID);
			m_base.GetSurpriseBoxManager().OnLeaveRoom();
			Globals.SelfRoomID = 0;
			
			if(Globals.timer != null)
			{
				Globals.timer.StopTimer();//离开房间，停止刷新在线玩家列表
			}
		}

		/**
		 * 房间外离开房间（xw79531）。
		 * @return
		 *
		 */
		public function LeaveRoomOnOutSide(roomID:int):void {
			// TODO 房间外发送离开房间请求
			// CallCenter发送请求里面需要支持指定roomID（不判断是否在房间内）发送请求。
			var event:CEventVideoRoomLeaveRoom = new CEventVideoRoomLeaveRoom();
			//m_client.SendEvent(event, roomID);
		}
		
		public function IsSelfDeputy():Boolean
		{
			return m_client.GetSelfPersistID().equal(m_deputy_anchor_id);
		}
		
		public function HasDeputy():Boolean
		{			
			return (m_deputy_anchor_name != "");
		}
		
		public function GetAnchorQQ():Int64
		{
			return (m_live_detail.anchor_pstid);
		}

		private var basicAnchorID:Number = 0;
		/**
		 * 基础信息中的主播id，如果m_live_detail找不到主播id的时候，且在小窝房间时，该值有效。
		 * @return
		 *
		 */
		public function getBasicInfoAnchorQQ():Number {
			return basicAnchorID;
		}
		
		public function GetGiftEffectCnt():void
		{
			m_client.GetUICallback().OnRefreshGiftEffectCnt(m_gift_data);	
		}
		
		public function SearchOnlinePlayer(key_words:String):void
		{
			if( key_words ==null || (key_words.length == 0))
			{
				return;
			}		
			var evt:CEventVideoSearchOnlinePlayer = new CEventVideoSearchOnlinePlayer;
			evt.key_words = key_words;
			m_client.SendEvent(evt,Globals.SelfRoomID);
		}
		
		public function GetRoomAnchorInfo( info:RoomAnchorInfo ):void
		{
			if(m_status == VideoRoomState.VRS_LIVE)
			{
				info.anchor_qq = m_live_detail.anchor_pstid.toNumber();
				info.anchor_name = m_live_detail.name;
				info.room_name = m_room_name;
				info.room_type = m_subject;
			}
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			Globals.s_logger.debug("CVideoRoomClient.HandleServerEvent start:");
			if(guardConfig == null)
			{
				Globals.s_logger.debug("CVideoRoomClient.HandleServerEvent start guardConfig = null");
				guardConfig = m_client.GetGuardConfig();
			}
			if(vipConfig == null)
			{
				Globals.s_logger.debug("CVideoRoomClient.HandleServerEvent start vipConfig = null");
				vipConfig = CVideoVipConfig.getInstance();
			}
			
			var success:Boolean = true;
			var clsid:int = ev.CLSID();
			Globals.s_logger.debug("CVideoRoomClient.HandleServerEvent clsid:" + clsid);
			switch(clsid)
			{
				case EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomListRes:
					HandleCEventVideoRoomGetRoomListRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomRes:
					HandleCEventVideoRoomEnterRoomRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomGetLiveCDNRes:
					HandleCEventVideoRoomGetLiveCDNRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomBeKicked:
					HandleCEventVideoRoomBeKicked(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomNotifyLiveStart:
					HandleCEventVideoRoomNotifyLiveStart(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomNotifyLiveStop:
					HandleCEventVideoRoomNotifyLiveStop(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshLiveStatus:
					HandleCEventVideoRoomRefreshLiveStatus(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomPlayerCount:
					HandleVideoRoomPlayerCount(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomChatBan:
					HandleVideoRoomChatBan(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomKickPlayerRes:
					HandleCEventVideoRoomKickPlayerRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomChatBanRes:
					HandleCEventVideoRoomChatBanRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoGetGiftPoolBoxInfoRes:
					HandleCEventVideoGetGiftPoolBoxInfoRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoOpenGiftPoolBoxRes:
					HandleCEventVideoOpenGiftPoolBoxRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoGiftPoolHeightChange:
					HandleCEventVideoGiftPoolHeightChange(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRefreshFlower:
					HandleCEventVideoRefreshFlower(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventNotifySendLotsOfGifts:
					HandleCEventNotifySendLotsOfGifts(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshRoomPicInfo:
					HandleCEventVideoRoomRefreshRoomPicInfo(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshCurrentAnchorDetail:
					HandleCEventVideoRoomRefreshCurrentAnchorDetail(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoSendGiftResult:
					HandleVideoSendGiftResult(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoSendGiftResultForWeb:
					HandleVideoSendGiftResultForWeb(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshRoomAttribute:
					HandleCEventVideoRoomRefreshRoomAttribute(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoToClientChatMessage:
					HandleVideoToClientChatMsg(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoToClientChatMessageForWeb:
					HandleVideoToClientChatMsgForWeb(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoSearchOnlinePlayerRes:
					HandleCEventVideoSearchOnlinePlayerRes(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoChatResult:
					HandleCEventVideoChatResult(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcastAllRoom:
					HandleCEventVideoRoomEnterRoomBroadcastAllRoom(ev);
					break;
				case EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfoCardRes:
					break;
				case VideoChatEventID.CLSID_CEventSetVideoPublicChatCoolDownOnEnterRes:
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoChatBanForAllRoomRes:
					HandleCEventVideoChatBanForAllRoomRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomNotifyAttachRoomInfo:
					HandleCEventVideoRoomNotifyAttachRoomInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoQueryBalanceRes:
					HandleCEventVideoQueryBalance(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoQueryVideoMoneyRes:
					HandleCEventVideoQueryVideoMoneyRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomCheckNickRes:
					HandleCEventVideoRoomCheckNickRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadPreviewVideoTreasureBoxNewRoleRes:
					HandleCEventLoadPreviewVideoTreasureBoxNewRoleRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoTreasureBoxRewardNewRoleWeb:
					HandleCEventVideoTreasureBoxRewardNewRoleWeb(ev);
					break;							
				case AnchorTaskEventID.CLSID_CEventQueryAnchorTaskNewRoleResWeb:
					HandleCEventQueryAnchorTaskNewRoleRes(ev);
					break;
				case AnchorTaskEventID.CLSID_CEventAnchorTaskRewardNotifyNewRoleWeb:
					HandleCEventAnchorTaskRewardNotifyNewRole(ev);
					break;		
				case ConcertEventID.CLSID_CEventSwitchWhistleBroadcast:
					HandleCEventSwitchWhistleBroadcast(ev);
					break;
				case ConcertEventID.CLSID_CEventConcertStatusChange:
					HandleCEventConcertStatusChange(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomCanEnterRoomRes:
					HandleCEventVideoRoomCanEnterRoomRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNotifyIsNoviceGuided:
					HandleCEventNotifyIsNoviceGuided(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventQueryDreamGiftRes:
					HandleCEventQueryDreamGiftRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNotifyFriendPayCash:
					HandleCEventNotifyFriendPayCash(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshVideoGiftConfig:
					HandleCEventRefreshVideoGiftConfig(ev);
					break;
				case SplitScreenEventID.CLSID_CEventNotifySplitScreenInfoChange:
					HandleCEventNotifySplitScreenInfoChange(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadNestListRes:
					HandleCEventLoadNestListRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventTakeRoomGuardSeatRes:
					HandleCEventTakeRoomGuardSeatRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRoomGuardSeatLostNotify:
					HandleCEventRoomGuardSeatLostNotifys(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshRoomGuardSeats:
					HandleCEventRefreshRoomGuardSeats(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRankChangeBroadcastAllPlayer:
					HandleCEventVideoRankChangeBroadcastAllPlayer(ev);
					break;
				case NewGrowthEventID.CLSID_CEventSyncPlayerDreamGiftAnchorExp:
					HandleCEventSyncPlayerDreamGiftAnchorExp(ev);
					break;
				case EventNewGrowthID.CLSID_CEventAnchorGrowthConfig:
					HandleCEventAnchorGrowthConfig(ev);
				case EEventIDVideoRoomExt.CLSID_CEventGetVideoRoomLiveInfoRes:
					HandleCEventGetVideoRoomLiveInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventBatchVideoTreasureBoxRewardNewRoleWeb:
					Globals.s_logger.log(" HandleCEventBatchVideoTreasureBoxRewardNewRoleWeb clsid:" + clsid);
					//HandleCEventBatchVideoTreasureBoxRewardNewRoleWeb(ev);
					var ev1:CEventVideoTreasureBoxRewardNewRoleWeb = new CEventVideoTreasureBoxRewardNewRoleWeb();
					var evt:CEventBatchVideoTreasureBoxRewardNewRoleWeb = ev as CEventBatchVideoTreasureBoxRewardNewRoleWeb;
					ev1.res = evt.res;
					ev1.rewards = evt.rewards;
					ev1.buff_percent = evt.buff_percent;
					ev1.anchor_level = evt.anchor_level;
					ev1.online = false; 
					ev1.m_is_reissue = evt.m_is_reissue;
					ev1.vip_level = evt.vip_level;
					ev1.box_id = -1;
					ev1.last_hit_player_name = evt.last_hit_player_names.join("&&").toString();
					if(evt.last_hit_player_ids.length > 0){
//						for(var i:int=0,n:int=evt.last_hit_player_ids.length; i<n; i++){
//							ev1.last_hit_player_id = evt.last_hit_player_ids[i];
//							ev1.last_hit_player_invisible = evt.last_hit_player_invisibles[i];
//							Globals.s_logger.log("HandleCEventBatchVideoTreasureBoxRewardNewRoleWeb evt1:" + JSON.stringify(ev1));
							HandleCEventVideoTreasureBoxRewardNewRoleWeb(ev1, evt.last_hit_player_ids, evt.last_hit_player_invisibles);
//						}	
					} else{
						Globals.s_logger.debug(" HandleCEventBatchVideoTreasureBoxRewardNewRoleWeb evt1:" + JSON.stringify(ev1));
						HandleCEventVideoTreasureBoxRewardNewRoleWeb(ev1);
					}
					break;
				case EEventIDVideoRoomExt.CLSID_CEventIgnoreFreeGiftRes:
					HandleCEventIgnoreFreeGiftRes(ev);
					break;
				
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawActivityInfo:
					HandleCEventVideoRoomLuckyDrawActivityInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomOpenLuckyDrawWindowRes:
					HandleCEventVideoRoomOpenLuckyDrawWindowRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawRes:
					HandleCEventVideoRoomLuckyDrawRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawNotice:
					HandleCEventVideoRoomLuckyDrawNotice(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomSyncLuckyDrawInfo:
					HandleCEventVideoRoomSyncLuckyDrawInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshVipInfoToClient:
					HandleCEventRefreshVipInfoToClient(ev);
					break;

				case EEventIDVideoRoomExt.CLSID_CEventGetPunchInInfoRes:
					HandleCEventGetPunchInInfoRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventPunchInRes:
					HandleCEventPunchInRes(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNotifyPunchIn:
					HandleCEventNotifyPunchInRes(ev);
					break;

				case EEventIDVideoRoomExt.CLSID_CEventUnlockRoomSkinTaskInfo:
					HandleCEventUnlockRoomSkinTaskInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventNewRoomSkinBroadcastAllPlayer:
					HandleCEventNewRoomSkinBroadcastAllPlayer(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRoomSkinLevelUpTaskInfo:
					HandleCEventRoomSkinLevelUpTaskInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRoomSkinDailyTaskInfo:
					HandleCEventRoomSkinDailyTaskInfo(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRoomSkinLevelUpNotify:
					HandleCEventRoomSkinLevelUpNotify(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRoomDailyTaskRewards:
					HandleCEventRoomDailyTaskRewards(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomCharmBroadcastAllRoom:
					HandleCEventVideoRoomCharmBroadcastAllRoom(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventRefreshRoomCharmRank:
					HandleCEventRefreshRoomCharmRank(ev);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventQuerySkinGiftRes:
					HandleCEventQuerySkinGiftRes(ev);
					break;

				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomBasicInfos:
					HandleCEventVideoRoomBasicInfos(ev)
					break;

				case EEventIDVideoRoomExt.CLSID_CEventVideoAD:
					HandleCEventVideoAD(ev)
					break;

				default:
					success = false;
					break;
			}
			return success;
		}

		private function HandleCEventBatchVideoTreasureBoxRewardNewRoleWeb(event:INetMessage):void {
			var evt:CEventBatchVideoTreasureBoxRewardNewRoleWeb = event as CEventBatchVideoTreasureBoxRewardNewRoleWeb;
//			Globals.s_logger.log(" HandleCEventBatchVideoTreasureBoxRewardNewRoleWeb evt:" + JSON.stringify(evt));
			m_client.GetUICallback().BatchVideoTreasureBoxRewardNewRoleWeb(evt.res,evt.rewards,evt.buff_percent,evt.m_is_reissue,evt.last_hit_player_names);
		}

		//刷新主播等级相关配置
		
		private var LevelInfoArr:Array = null;
		private var BottleneckInfoDic:Dictionary = null;
		
		private function HandleCEventAnchorGrowthConfig(event:INetMessage):void
		{
			var evt:CEventAnchorGrowthConfig = event as CEventAnchorGrowthConfig;
			if(evt == null)
			{
				return;
			}
			
			LevelInfoArr = evt.level_info;
			BottleneckInfoDic = evt.bottleneck_info;
		}
		
		//刷新我对当前主播贡献的经验值已经当日上限
		private function HandleCEventSyncPlayerDreamGiftAnchorExp(event:INetMessage):void
		{
			var evt:CEventSyncPlayerDreamGiftAnchorExp = event as CEventSyncPlayerDreamGiftAnchorExp;
			if(evt == null)
			{
				return;
			}
			m_client.GetUICallback().RefreshPlayerDreamGiftAnchorExp(evt.total_anchor_exp,evt.max_anchor_exp);
		}
		
		
		//星耀榜,周星榜变化时的走马灯消息。
		private function HandleCEventVideoRankChangeBroadcastAllPlayer(event:INetMessage):void
		{
			var evt:CEventVideoRankChangeBroadcastAllPlayer = event as CEventVideoRankChangeBroadcastAllPlayer;
			if(evt == null)
			{
				return;
			}
			Globals.s_logger.debug( "星耀榜上升 "+JSON.stringify(evt)+"   ###  video_rank_type" + evt.video_rank_type);
			Globals.s_logger.debug( "CEventVideoRankChangeBroadcastAllPlayer  gift_id"+evt.gift_id + "level "+evt.level);
			//SRT_UnKnown,  // 非法预留
			//SRT_StarLight,	// 星耀榜
			//SRT_StarGift,	// 周星榜
			var obj:Object = CGiftConfig.getInstance().GetGiftData(evt.gift_id);
			var gift_name:String = "";
			if( obj != null )
			{
				Globals.s_logger.debug( "CEventVideoRankChangeBroadcastAllPlayer  gift_name"+obj.name );
				gift_name = obj.name;
			}
			m_client.GetUICallback().OnVideoRankChangeBroadcastAllPlayer(evt.m_player_name.replace(/\\/g,"\\\\"),evt.m_timedimension,evt.m_enScrollType,evt.m_rank_move,evt.video_rank_type,
				gift_name,evt.level,evt.gift_id,evt.stargift_player_nick);
		}
		
		//抢座
		private function HandleCEventTakeRoomGuardSeatRes(event:INetMessage):void
		{
			var evt:CEventTakeRoomGuardSeatRes = event as CEventTakeRoomGuardSeatRes;
			if(evt == null)
			{
				return;
			}
			//是不是自己都要飞特效
			var seatInfoUI:VideoGuardSeatInfoUI = new VideoGuardSeatInfoUI();
			ToVideoGuardSeatInfoForUI(evt.seat_info, seatInfoUI);
			m_client.GetUICallback().OnTakeRoomGuardSeat(evt.m_room_id,evt.m_seat_index,evt.m_res,seatInfoUI,evt.cost,evt.player_id.toString(),evt.charm);
			
			if(evt.m_res == 0 && evt.player_id.equal( m_client.GetSelfPersistID()  ) ) 
			{
				// 添加系统提示
				var msg_sys : VideoRoomMsgData = new VideoRoomMsgData;
				
				msg_sys.channel = ChatChannel.VIDEOCHNL_System;//系统消息
				msg_sys.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
				msg_sys.systemType = 0;
				msg_sys.msg = "$t$恭喜您成功抢到了座位！ 您的财富值+" + evt.cost + "，主播的星耀值+" + evt.cost
					+ (evt.charm > 0 ? "，房间魅力值+" + evt.charm : "") + "，你们之间的亲密度+" + evt.cost + "。$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_sys);
				m_client.GetVideoClientPlayer().SetVideoMoney(-1,Int64.fromNumber(evt.m_diamond_balance));//抢座成功设置余额
			}
			if( evt.m_res == TakeSeatResult.TSR_Success )//抢座成功 发飞屏
			{
				//发飞屏;
				var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
				
				msg_data.channel = ChatChannel.VIDEOCHNL_Whistle;//飞屏
				msg_data.viplevel = evt.seat_info.m_vip_level;
				msg_data.sender_defend = evt.seat_info.m_guard_level;
				msg_data.senderZoneName = evt.seat_info.m_zone;
				msg_data.senderName = evt.seat_info.m_nick.replace(/\\/g,"\\\\");
				msg_data.wealth_level = evt.seat_info.m_wealth_level;
				msg_data.isSelf = evt.player_id.equal( m_client.GetSelfPersistID() ) == true ? 3: 4;//区分是谁发的飞屏
				msg_data.isTakeVip = true;
				//XW78530 守护宝座抢座飞屏显示两次玩家名
				msg_data.msg = "$t$" +"抢到座位说:\"" + CVipSeatClientConfig.getInstance().GetVipSeatMsg(evt.seat_info.m_taking_time)+"\"$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
		}
		
		//座位被抢的通知
		private function HandleCEventRoomGuardSeatLostNotifys(event:INetMessage):void
		{
			var evt:CEventRoomGuardSeatLostNotify = event as CEventRoomGuardSeatLostNotify;
			if(evt == null)
			{
				return;
			}
			m_client.GetUICallback().OnRoomGuardSeatLostNotify(evt.m_room_id,evt.m_seat_index,evt.m_nick.replace(/\\/g,"\\\\"),evt.m_zone,evt.m_cost,evt.m_player_id.toString(),evt.m_last_cost);
		}
		
		
		private function HandleCEventVideoRoomRefreshRoomPicInfo(event:INetMessage):void
		{
			var evt:CEventVideoRoomRefreshRoomPicInfo = event as CEventVideoRoomRefreshRoomPicInfo;
			m_roomPicInfo = evt.new_room_picInfo;
			GetVideoRoomPicUrl();//刷新给页面
		}
		
		//刷新守护宝座
		private function HandleCEventRefreshRoomGuardSeats(event:INetMessage):void
		{
			var evt:CEventRefreshRoomGuardSeats = event as CEventRefreshRoomGuardSeats;
			if(evt == null)
			{
				return;
			}
			
			var seatInfoUIArray:Array = new Array;
			
			for each(var seatinfo:VideoGuardSeatInfo in evt.m_seats)
			{
				var seatInfoUI:VideoGuardSeatInfoUI = new VideoGuardSeatInfoUI();
				ToVideoGuardSeatInfoForUI(seatinfo, seatInfoUI);
				seatInfoUIArray.push(seatInfoUI);
			}
			
			m_client.GetUICallback().OnRefreshRoomGuardSeats(evt.m_room_id,seatInfoUIArray);
		}
		
		private function ToVideoGuardSeatInfoForUI( seatinfo:VideoGuardSeatInfo ,seatInfoUI:VideoGuardSeatInfoUI ):void
		{
			seatInfoUI.m_seat_id = seatinfo.m_seat_id;
			seatInfoUI.m_player_id = seatinfo.m_player_id.toString();
			seatInfoUI.m_nick = seatinfo.m_nick.replace(Pattern,"\\\\");
			seatInfoUI.m_zone = seatinfo.m_zone;
			seatInfoUI.m_has_portrait = seatinfo.m_has_portrait;
			if(seatinfo.m_has_portrait)
			{
				//XW79794 去除头像随机数
				seatInfoUI.m_pic_url = Globals.m_pic_download_url + "/qdancersec/" +  seatinfo.m_pic_url;// + "/0" + URLSuffix.CreateVersionString();
			}
			seatInfoUI.m_gender = seatinfo.m_gender;
			seatInfoUI.m_level = seatinfo.m_level;
			seatInfoUI.m_vip_level = seatinfo.m_vip_level;
			seatInfoUI.m_guard_level = seatinfo.m_guard_level;
			seatInfoUI.m_affinity = seatinfo.m_affinity;
			seatInfoUI.m_wealth = seatinfo.m_wealth;
			seatInfoUI.m_in_room = seatinfo.m_in_room;
			seatInfoUI.m_taken_times = seatinfo.m_taken_times;
			seatInfoUI.m_take_cost = seatinfo.m_take_cost;
			seatInfoUI.m_taking_id = seatinfo.m_taking_id.toString();
			seatInfoUI.m_wealth_level = seatinfo.m_wealth_level;
		}
		//分屏状态改变
		private function HandleCEventNotifySplitScreenInfoChange(event:INetMessage):void
		{
			var evt:CEventNotifySplitScreenInfoChange = event as CEventNotifySplitScreenInfoChange;
			if(evt == null)
			{
				return;
			}
			
			var old_split_screen_info:SplitScreenInfo = new SplitScreenInfo();
			GetSplitScreenInfo(old_split_screen_info);
			m_live_detail.split_screen_info = evt.info;
			UpdateSplitScreenLiveStatus(old_split_screen_info, evt.info);
		}
		
		//免费礼物包括 免费花  安可，召唤 和梦幻币礼物
		private function isForbidFreeGift(giftdata:GiftData):Boolean
		{
			if(!Globals.forbidFreeGift)//没有频闭返回false
			{
				return false;
			}
			
			if((giftdata.giftItemID == 1 
				|| giftdata.giftItemID == 30 || giftdata.giftItemID == 31 || giftdata.giftItemID == 32 || giftdata.giftItemID == 35 || giftdata.giftItemID == 36)
				&& giftdata.senderName != m_client.GetVideoClientPlayer().GetVideoNick())
			{
				return true;
			}
			
			return false;
		}
		
		private function isDreamGift(giftid:int):Boolean
		{
			if(giftid == 30 || giftid == 31 || giftid == 32)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		/**
		 * 暂时未使用，使用的非ForWeb的（CEventVideoSendGiftResult）
		 * @param ev
		 * 
		 */		
		public function HandleVideoSendGiftResultForWeb(ev:INetMessage):void
		{
			var result_ev:CEventVideoSendGiftResultForWeb = ev as CEventVideoSendGiftResultForWeb;
			if(result_ev == null)
			{
				return;
			}
			//tqos上报 begin
			var tqos:TQOSSendGift = new TQOSSendGift();
			tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nRoomId = Globals.SelfRoomID;
			tqos.nErrorCode = result_ev.result;
			tqos.StrRoomServerIP = this.m_client.GetCallCenter().GetRPip();
			tqos.Response();
			//tqos上报 end
			
			var uicb:IVideoClientLogicCallback = this.m_client.GetUICallback();
			if(uicb == null)
			{
				return;
			}
			
			if(result_ev.result == SendVideoGiftResult.SVGR_Succ)
			{
				var data:GiftData = new GiftData();
				
				data.giftItemID = result_ev.m_gift_id;
				data.count = result_ev.m_gift_count;
				data.senderName = result_ev.m_sender_name;
				data.anchorName = result_ev.m_anchor_name.replace(Pattern,"\\\\");
				data.zoneName = result_ev.m_zone_name;
				data.giftName = result_ev.m_gift_name;
				data.vip_level = result_ev.m_vip_level;
				data.vipIcon = vipConfig.GetVipIcon(data.vip_level);
				data.guardIcon = guardConfig.GetIcon(result_ev.m_guard_level);
				data.sender_channelid = PersistIDUtil.get_channel_id(result_ev.m_sender_id);
				data.senderPlayerID = result_ev.m_sender_id.toString();
				data.anchorID = result_ev.m_anchor_qq.toString();
				data.support_degree_add = result_ev.m_support_degree_add;
				data.invisible = result_ev.m_invisible;
				data.senderName =data.senderName.replace(Pattern,"\\\\");
				data.continuous_send_gift_times = result_ev.m_continuous_send_gift_times;
				data.anchor_exp = result_ev.anchor_exp;
				data.wealth_level = result_ev.wealth_level;
				data.source = result_ev.source;
				
				if(data.giftItemID == diceGiftId)
				{
					result_ev.m_gift_ext_info.resetPosition();
					result_ev.m_gift_ext_info.getInt();
					data.m_level = result_ev.m_gift_ext_info.buffer().readByte();
					data.m_dice_val_1 = result_ev.m_gift_ext_info.buffer().readByte();
					data.m_dice_val_2 = result_ev.m_gift_ext_info.buffer().readByte();
					data.m_dice_val_3 = result_ev.m_gift_ext_info.buffer().readByte();
				}
				
				
				if(this.m_arrGiftMsgCache.length + 1 > this.m_nGiftMsgCacheCap)
				{
					sendGiftMsgBatchToUI();
				}
				else 
				{
					m_arrGiftMsgCache.push(data);
				}
				var self:Boolean = false;
				
				if(result_ev.m_sender_name == m_client.GetVideoClientPlayer().GetVideoNick())
				{
					self = true;
				}
				
				if(!isForbidFreeGift(data) || self)
				{
					uicb.OnReceiveGift(data,self);
				}
			}
			
			if(result_ev.m_sender_id.equal(m_client.GetSelfPersistID()))
			{
				// 只有自己送礼才处理这个回调
				var info:SendVideoGiftResultInfo = new SendVideoGiftResultInfo;
				info.result = result_ev.result;
				info.result_ext = result_ev.m_res_ext;
				info.reason_ext = result_ev.m_reason_ext;
				
				uicb.OnSendGiftRes(VideoResultType.VREST_Normal, info, result_ev.m_sender_id,result_ev.m_diamond_balance,result_ev.m_video_money,result_ev.m_gift_id,result_ev.m_gift_count);
				
				{
					if( result_ev.m_diamond_balance != -1)
					{
						m_client.GetVideoClientPlayer().SetVideoMoney(result_ev.m_video_money,Int64.fromNumber(result_ev.m_diamond_balance) );
					}
					else
					{
						m_client.GetVideoClientPlayer().SetVideoMoney(result_ev.m_video_money, null );
					}
				}
				
				if(result_ev.result == SendVideoGiftResult.SVGR_Succ && result_ev.m_diamond_balance != -1)
				{
					var adapter:IVideoClientAdapter = m_client.GetVideoClientAdapter();
					if(adapter != null)
					{
						adapter.RefreshMobilePlayerDiamondBalance(result_ev.m_diamond_balance);
					}
				}				
			}
			
			//判断下目标主播是否在线
			if(result_ev.m_anchor_qq.isZero())
			{
				return;
			}
			//UI端刷新StarLight和Popular
			var apc:IAnchorPKClient = m_base.GetAnchorPKClient();
			if(apc != null)
			{
				//刷新anchorPK中的主播信息
				apc.RefreshMatchAnchorStarLightAndPopular(result_ev.m_anchor_qq, Int64.fromNumber(result_ev.m_anchor_starlight), Int64.fromNumber(result_ev.m_anchor_popularity));
			}
			if (m_live_detail.anchor_pstid.equal(result_ev.m_anchor_qq))
			{
				m_live_detail.popularity = result_ev.m_anchor_popularity;
				m_live_detail.startlight = result_ev.m_anchor_starlight;
				m_live_detail.followed = result_ev.m_anchor_followed;
				uicb.RefreshAnchorStarLightAndPopular(Int64.fromNumber(result_ev.m_anchor_starlight), Int64.fromNumber(result_ev.m_anchor_popularity));
			}
		}

		/**
		 * 聊天特化处理
		 * CEventVideoToClientChatMessageForWeb这个消息适用于发送广播类消息，发送给多人的，如公聊和后援团聊天，非发送者账号会收到这个消息。
		 * 其他情况都走的CEventVideoToClientChatMessage消息。
		 * @param evt
		 * 
		 */
		public function HandleVideoToClientChatMsgForWeb(evt:INetMessage):void
		{
			var  ev:CEventVideoToClientChatMessageForWeb = evt as CEventVideoToClientChatMessageForWeb;
			var msg: VideoToClientChatMessage = ev.GetMessage();
			var msg_data:VideoRoomMsgData = new VideoRoomMsgData;
			
			//如果收到中级守护一下的守护等级的人发来的消息里面有守护专属表情，直接丢掉
			if(msg.guard_level_new < 20 && isContainGuardExpression(msg.message))
			{
				return;
			}
			
			//如果屏蔽了所有私聊，直接丢弃私聊信息
			if(msg.type == CHNL_TYPE.CHNL_VIDEOROOM_PRIVATE &&msg.sender_type == RoomPlayerType.RPT_audience && m_client.GetVideoClientPlayer().GetVideoNick() == msg.recver_name )// 是私聊并且是发给我的
			{
				var cookie:Cookie = new Cookie("x51web");
				var forbidprivate:Boolean = cookie.getData("isForbidPrivateChat");
				if( forbidprivate )
					return;
			}
			//屏蔽了该玩家 不屏蔽飞屏
			if(msg.type != CHNL_TYPE.CHNL_VIDEOROOM_WHISTLE && isInIgnoreList(msg.sender_name,msg.sender_zoneName))
			{
				return;
			}
			//msg_data.guardIcon = guardConfig.GetIcon(msg.guard_level_new);
			//msg_data.vipIcon = vipConfig.GetVipIcon(msg.vip_level);
			
			msg_data.msg = ReplaceChatMsg(msg.message);
			msg_data.receiverName = msg.recver_name;//.replace(Pattern,"\\\\")
			msg_data.receiverZoneName = msg.recver_zoneName;
			msg_data.senderName = msg.sender_name;//.replace(Pattern,"\\\\")
			msg_data.senderZoneName = msg.sender_zoneName;
			msg_data.senderPlayerID = msg.sender_ID.toString();
			msg_data.senderPlayerZoneID = 0;
			msg_data.m_senderPlayerType = msg.sender_type;
			msg_data.wealth_level = msg.wealth_level;
			msg_data.add_anchor_exp = msg.add_anchor_exp;
			
			if(msg_data.m_senderPlayerType == RoomPlayerType.RPT_anchor)
			{
				msg_data.senderIcon = IconString.anchorIcon;
				if(msg_data.senderPlayerID == GetAnchorQQ().toString())
				{
					msg_data.isOnLive = true;
				}
			}
			else if(msg_data.m_senderPlayerType == RoomPlayerType.RPT_admin)
			{
				msg_data.senderIcon = IconString.adminIcon;
			}
			
			msg_data.viplevel = msg.vip_level;
			msg_data.sender_defend = msg.guard_level_new;
			
			msg_data.isSelf = 0;
			switch(msg.type)
			{
				case CHNL_TYPE.CHNL_VIDEOROOM_PUBLIC://公聊
				{
					msg_data.channel = ChatChannel.VIDEOCHNL_Public;					
					msg_data.TextColor = WebColor.publicChatCommonTextColor;//公聊字体是一个颜色
					
					switch( msg_data.sender_defend )//根据守护等级确定昵称颜色
					{
						case GuardLevelEnum.noneGuardLevel:
							msg_data.NickColor = WebColor.primaryGuardNickColor;//无守护和初中级守护
							break;
						case GuardLevelEnum.highGuard:
							msg_data.NickColor = WebColor.highGuardNickColor;//高级
							break;
						case GuardLevelEnum.angelGuard:
							msg_data.NickColor = WebColor.angelGuardNickColor;//天使
							break;
						case GuardLevelEnum.soalGuard:
							msg_data.NickColor = WebColor.soalGuardNickColor;//灵魂
							break;
						case GuardLevelEnum.unNormalGuard:
							msg_data.NickColor = WebColor.unNormalGuardNickColor;//非凡
							break;
						case GuardLevelEnum.extremeGuard:
							msg_data.NickColor = WebColor.extremeGuardNickColor;//至尊
							break;
						case GuardLevelEnum.tianZHunGuard:
							msg_data.NickColor = WebColor.tianZhunGuardNickColor;//天尊
							break;
						case GuardLevelEnum.caoFanGuard:
							msg_data.NickColor = WebColor.caoFanGuardNickColor;//超凡
							break;
					}
					
					switch( msg_data.m_senderPlayerType )//主播和管理员的昵称颜色
					{
						case RoomPlayerType.RPT_admin:
							msg_data.NickColor = WebColor.adminNickColor;
							break;
						case RoomPlayerType.RPT_anchor:
							msg_data.NickColor = WebColor.anchorNickColor;
							break;
					}
					
					var is_self :Boolean  = false;
					if(msg.sender_type == RoomPlayerType.RPT_audience)
					{
						is_self = (msg.sender_name == m_client.GetVideoClientPlayer().GetVideoNick());
					}
					if(is_self)
					{
						m_last_chat_time = getTimer();
						firstSendChatMsg = false;
					}
				}
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_PRIVATE://私聊
					msg_data.channel = ChatChannel.VIDEOCHNL_Private;
					msg_data.TextColor=WebColor.privateChatTextColor;//私聊字体颜色
					msg_data.NickColor = WebColor.privateChatNickColor;//私聊昵称颜色
					
					var chatinfo:PrivateChatInfo = new PrivateChatInfo();
					if( this.m_client.GetVideoClientPlayer().GetVideoNick() == msg_data.receiverName )// 是私聊并且是发给我的
					{
						msg_data.isSelf = 1;
						chatinfo.name = msg_data.senderName;
						chatinfo.zonename = msg_data.senderZoneName;
						chatinfo.receiverPlayerType = msg_data.m_senderPlayerType;
					}						
					else if( this.m_client.GetVideoClientPlayer().GetVideoNick() == msg_data.senderName)
					{	
						msg_data.isSelf = 2;
						chatinfo.name = msg_data.receiverName;
						chatinfo.zonename = msg_data.receiverZoneName;
						chatinfo.receiverPlayerType = msg_data.receiverPlayerType;
					}
					insertChatInfo(chatinfo);
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_WHISTLE:
					msg_data.channel = ChatChannel.VIDEOCHNL_Whistle;
					msg_data.vipCardPattern = CVideoVipConfig.getInstance().GetCardPattern(msg.vip_level);
				//	msg_data.vipIcon = CVideoVipConfig.getInstance().GetVipIcon(msg.vip_level);
				//	msg_data.guardIcon = m_client.GetGuardConfig().GetIcon(msg.vip_level);
					//是自己的免费飞屏，则更新个数
					if (m_client.GetVideoClientPlayer())
					{
						var self_zid:String = m_client.GetVideoClientPlayer().GetVideoPersistID().toString();
						if ( msg_data.senderPlayerID == self_zid
							&& m_free_whistle_left > 0 )
						{
							--m_free_whistle_left;
						}
						if ( msg_data.senderPlayerID == self_zid)
						{//飞屏tqos上报 begin
							var tqos:TQOSSendWhistle = new TQOSSendWhistle();
							tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
							tqos.nDeviceType = ClientDeviceType.CDT_WEB;
							tqos.nRoomId = Globals.SelfRoomID;
							tqos.StrRoomServerIP = this.m_client.GetCallCenter().GetRPip();
							tqos.Response();
							//tqos上报 end
						}
					}
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_GUILD:
					msg_data.channel = ChatChannel.VIDEOCHNL_Guild;
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_SUPERSTARHORN:
					msg_data.channel = ChatChannel.VIDEOCHNL_SUPERSTARHORN;
					//是自己的免费超新星，则更新个数
					if ( m_client && m_client.GetVideoClientPlayer() )
					{
						var self_zid2:String = m_client.GetVideoClientPlayer().GetVideoPersistID().toString();
						if ( msg_data.senderPlayerID == self_zid2 && m_free_super_star_horn_left > 0)
						{
							--m_free_super_star_horn_left;
						}
					}
					break;
				case CHNL_TYPE.CHNL_GAMENOTIFY:  
					msg_data.channel = ChatChannel.VIDEOCHNL_System;
					msg_data.TextColor = "#FFFF00";
					break;
				case CHNL_TYPE.	CHNL_SYSNOTIFY:
					msg_data.channel = ChatChannel.VIDEOCHNL_System;
					msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
					break;
				default:
					return;
			}
			
			msg_data.m_is_purple = false;//(msg.m_is_purple ? true : false);
			
			if(m_client && m_client.GetUICallback())
			{
				Globals.s_logger.debug("OnReceiveChatMsg msg_data = " + JSON.stringify(msg_data));
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
			}
		}
		
		
		
		private function HandleCEventNotifyFriendPayCash(event:INetMessage):void
		{
			var ev:CEventNotifyFriendPayCash = event as CEventNotifyFriendPayCash;
			if(ev == null)
			{
				return;
			}

			if(m_client.GetUICallback() != null)
			{
				var frientpaylist:Array = new Array;
				for each(var info:FriendPayInfo in ev.info)
				{
					var uiInfo:FriendPayInfoForUi = new FriendPayInfoForUi;
					uiInfo.qq = info.presenter_qq.toString();
					uiInfo.nick = info.presenter_nick;
					uiInfo.amount = info.amount.toNumber();
					frientpaylist.push(uiInfo);
				}			
				m_client.GetUICallback().OnGetFriendPayCashInfo(frientpaylist);
			}
		}

		private  function HandleCEventRefreshVideoGiftConfig(event:INetMessage):void
		{
			var ev:CEventRefreshVideoGiftConfig = event as CEventRefreshVideoGiftConfig;
			if(ev == null)
			{
				return ;
			}
			
			m_gift_data = ev.gift_data;
			
			if(m_client.GetUICallback() != null)
			{
				m_client.GetUICallback().OnRefreshGiftEffectCnt(m_gift_data);	
			}
		}
		//查询梦幻币礼物
		private function HandleCEventQueryDreamGiftRes(event:INetMessage):void
		{
			var ev:CEventQueryDreamGiftRes = event as CEventQueryDreamGiftRes;
			Globals.s_logger.debug("HandleCEventQueryDreamGiftRes"+JSON.stringify(ev));
			if(ev == null)
			{
				return;
			}
			
			var videoGift:Array = new Array;
			
			for (var id:String in ev.video_gifts)
			{
				var gift:DreamGiftForUI = new DreamGiftForUI;
				gift.giftId = int(id);
				gift.giftCount = ev.video_gifts[id];
				videoGift.push(gift);
			}
			
			Globals.s_logger.debug("HandleCEventQueryDreamGiftRes videoGift"+JSON.stringify(videoGift));
			if (m_client.GetVideoClientPlayer() != null) {
				var skin_gifts:Dictionary = m_client.GetVideoClientPlayer().getSkinGiftList();
				for (var sgId:String in skin_gifts) {
					var find:Boolean = false;
					for each(var dui:DreamGiftForUI in videoGift){
						if(dui.giftId == int(sgId)){
							find = true;
							break;
						}
					}
					if(find == false){
						var skin_gift:DreamGiftForUI = new DreamGiftForUI();
						skin_gift.giftId = int(sgId);
						skin_gift.giftCount = skin_gifts[sgId];
						videoGift.push(skin_gift);
					}
				}
			}
			
			m_client.GetUICallback().OnQueryDreamGift(videoGift, false);			
		}
		
		//是否需要进行新手教学
		private function HandleCEventNotifyIsNoviceGuided(event:INetMessage):void
		{
			var ev:CEventNotifyIsNoviceGuided = event as CEventNotifyIsNoviceGuided;
			if(ev == null)
			{
				return ;
			}
			
			if(m_client.GetUICallback() != null)
			{
				m_client.GetUICallback().OnIsNoviceGuided(ev.guided);
			}
			
		}

		//可否进入房间处理
		private function HandleCEventVideoRoomCanEnterRoomRes(event:INetMessage):void {
			var ev:CEventVideoRoomCanEnterRoomRes = event as CEventVideoRoomCanEnterRoomRes;
			if (ev == null) {
				return;
			}

			if (m_client.GetUICallback() != null) {
				m_client.GetUICallback().OnCanEnterRoom(ev.room_id, ev.result,
					ev.video_room_type, ev.ticket_room, ev.is_living, ev.is_super_room, 
					ev.is_nest_room, ev.is_special_room, ev.room_skin_id, ev.room_skin_level, ev.is_pk);
			}
		}

		private function HandleCEventSwitchWhistleBroadcast(event:INetMessage):void
		{
			var ev:CEventSwitchWhistleBroadcast = event as CEventSwitchWhistleBroadcast;
			if(ev == null)
			{
				return;
			}
			
			var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			if(ev.is_open)
			{
				msg_data.msg = "$t$管理员开启了当前房间的飞屏功能$z";
			}
			else
			{
				msg_data.msg = "$t$管理员关闭了当前房间的飞屏功能$z";
			}
			m_client.GetUICallback().OnReceiveChatMsg(msg_data);	
			
//			if(m_client.GetUICallback() != null)
//			{
//				m_client.GetUICallback().OnSwitchWhistleBroadcast(VideoResultType.VREST_Normal, ev.is_open);
//			}
		}
		
		//刷新演唱会房间状态
		private function HandleCEventConcertStatusChange( event:INetMessage):void
		{
			var ev:CEventConcertStatusChange = event as CEventConcertStatusChange;
			if(ev == null)
			{
				return ;
			}
			
			var is_change:Boolean = false;
			if(m_base.GetConcertClient())
			{
				var concert_client:CConcertClient = m_base.GetConcertClient() as CConcertClient;
				if(concert_client != null)
				{
					if(concert_client.IsConcertStarted() != ev.is_open)
					{
						is_change = true;
						concert_client.SetIsStarted(ev.is_open);
					}
				}
			}
			
			if(is_change)
			{
				//如果演唱会已经开启并且没有门票，停止直播，通知礼物区置灰
				if(ev.is_open&& concert_client.HasConcertTicket() == false)
				{
					m_base.StopWatchLive();
					RefreshRoomStatus();
				}
				m_client.GetUICallback().OnConcertStatusChange(concert_client.HasConcertTicket(), ev.is_open);
			}
		}

		private function HandleCEventQueryAnchorTaskNewRoleRes(event:INetMessage):void
		{
			var evt:CEventQueryAnchorTaskNewRoleResWeb = event as CEventQueryAnchorTaskNewRoleResWeb;
			if (evt != null)
			{
				var task:AnchorTaskInfoUI = new AnchorTaskInfoUI;
				var giftArr:Array         = new Array;
				//处理服务器可以反复接主播任务的问题。 by zhangqing
				if (!Globals.needShowAnchorTask)
				{
					task.stat = 0;
					m_client.GetUICallback().OnQueryClientAnchorTaskResNewRole(0, task, evt.adv_guard_ratio, evt.buff_percent, giftArr);
					return;
				}
				var rewardConfig:CVideoActivityRewardConfig = CVideoActivityRewardConfig.getInsatce();
				task.description = evt.description.split("\n", evt.description.length);
				task.stat = evt.stat;

				for each (var female:CReward in evt.rewards)
				{
					var femalerwd:RewardDataForUI = new RewardDataForUI;
					femalerwd.count = female.count;
					femalerwd.type = female.type;
					femalerwd.rewardId = m_client.IsSelfMale() ? female.male_data : female.female_data;

					femalerwd.channel = female.channel;

					//处理新增的vip_level字段。
					if (female.type == ERewardType.R_VIP && female.male_data != 0)
					{
						if (m_client.GetVideoClientPlayer() != null)
						{
							var mylevel:int = m_client.GetVideoClientPlayer().GetVipLevel();
							if (mylevel > 0) //没有贵族身份就送配置的
							{
								femalerwd.rewardId = mylevel;
							}
						}
					}

					if (VideoChannelType.IsQueryReaward(femalerwd.channel))
					{
						var gift_web:RewardReqestWeb = new RewardReqestWeb;
						gift_web.amount = femalerwd.count;
						gift_web.id = femalerwd.rewardId;
						gift_web.type = femalerwd.type;
						gift_web.channel = femalerwd.channel;
						giftArr.push(gift_web);
					}

					task.rewards.push(femalerwd);
				}
				if (giftArr.length > 0)
				{
					m_client.GetReawardCookieManager().GetRewordsInfos(giftArr, m_client.GetUICallback().OnQueryClientAnchorTaskResNewRole, 0, task, evt.adv_guard_ratio, evt.buff_percent);
				}
				else
				{
					m_client.GetUICallback().OnQueryClientAnchorTaskResNewRole(0, task, evt.adv_guard_ratio, evt.buff_percent, giftArr);
				}
			}
		}

		private function HandleCEventAnchorTaskRewardNotifyNewRole(event:INetMessage):void
		{
			var evt:CEventAnchorTaskRewardNotifyNewRoleWeb = event as CEventAnchorTaskRewardNotifyNewRoleWeb;
			var rewardConfig:CVideoActivityRewardConfig    = CVideoActivityRewardConfig.getInsatce();
			var rewards:Array                              = new Array;
			var giftArr:Array                              = new Array;
			var moneytcnt:int                              = 0; //梦幻币加成到本地
			for each (var male:CReward in evt.rewards)
			{
				var malerwd:RewardDataForUI = new RewardDataForUI;
				malerwd.count = male.count;
				malerwd.type = male.type;
				malerwd.rewardId = m_client.IsSelfMale() ? male.male_data : male.female_data;

				malerwd.channel = male.channel;

				//处理新增的vip_level字段。
				if (male.type == ERewardType.R_VIP && male.male_data != 0)
				{
					if (evt.vip_level > 0)
					{
						malerwd.rewardId = evt.vip_level;
					}
				}

				if (VideoChannelType.IsQueryReaward(malerwd.channel))
				{
					var gift_web:RewardReqestWeb = new RewardReqestWeb;
					gift_web.amount = malerwd.count;
					gift_web.id = malerwd.rewardId;
					gift_web.type = malerwd.type;
					gift_web.channel = malerwd.channel;
					giftArr.push(gift_web);
				}

				rewards.push(malerwd);
			}
			//梦幻币加成到本地
			m_client.GetVideoClientPlayer().SetVideoMoney(m_client.GetVideoClientPlayer().GetDreamMoneyNum() + moneytcnt, null);

			if (evt != null)
			{
				if (giftArr.length > 0)
				{
					m_client.GetReawardCookieManager().GetRewordsInfos(giftArr, m_client.GetUICallback().OnFinishAnchorTaskNewRole, evt.task_type, rewards, evt.adv_guard_ratio, evt.buff_percent, evt.m_is_reissue);
				}
				else
				{
					var tmpArr:Array = new Array;
					m_client.GetUICallback().OnFinishAnchorTaskNewRole(evt.task_type, rewards, evt.adv_guard_ratio, evt.buff_percent, evt.m_is_reissue, tmpArr);
				}
			}
		}
		
		private function HandleCEventLoadPreviewVideoTreasureBoxNewRoleRes(event:INetMessage ):void
		{
			var evt:CEventLoadPreviewVideoTreasureBoxNewRoleRes = event as  CEventLoadPreviewVideoTreasureBoxNewRoleRes;
			if(evt != null)
			{
				var boxItems:Array = new Array;
				var giftArr:Array = new Array;
				var rewardConfig:CVideoActivityRewardConfig = CVideoActivityRewardConfig.getInsatce();
				for each(var tmp:VideoBoxItem in evt.box_items)
				{
					var boxitem:BoxRewardDataForUI = new BoxRewardDataForUI;
					boxitem.rewardType = tmp.item_type;
					boxitem.rewardId = m_client.IsSelfMale()?tmp.item_id_male:tmp.item_id_female;//宝箱奖励男女id一样
					boxitem.rewardCount = tmp.count;	
					boxitem.channel = tmp.item_channel;	
					if( VideoChannelType.IsQueryReaward( boxitem.channel ))//游戏侧道具奖励
					{
						var gift:RewardReqestWeb = new RewardReqestWeb;
						gift.id = boxitem.rewardId;
						gift.amount = tmp.count;
						gift.type = tmp.item_type;
						gift.channel = tmp.item_channel;
						giftArr.push(gift);
					}
					
					boxItems.push(boxitem);
				}
				var game_rewards:Array = new Array;
				if(evt.box_id != VideoGiftBoxType.VideoGiftBox_5 && evt.box_id != VideoGiftBoxType.VideoGiftBoxNest_5)
				{
					if( giftArr.length >0 )//有游戏测的奖励 
					{
						m_client.GetReawardCookieManager().GetRewordsInfos(giftArr,m_client.GetUICallback().OnLoadTreasureBoxPreviewNewRole,evt.box_id,boxItems,evt.buff_percent);
					}
					else
					{
						m_client.GetUICallback().OnLoadTreasureBoxPreviewNewRole(evt.box_id,boxItems,evt.buff_percent,game_rewards);
					}
				}
				else
				{
					if( giftArr.length >0 )//有游戏测的奖励 
					{
						m_client.GetReawardCookieManager().GetRewordsInfos(giftArr,m_client.GetUICallback().OnQuerySurpriseBoxReward,boxItems,evt.buff_percent);
					}
					else
					{
						m_client.GetUICallback().OnQuerySurpriseBoxReward(boxItems,evt.buff_percent,game_rewards);
					}
				}
			}
		}

		private function HandleCEventVideoTreasureBoxRewardNewRoleWeb(event:INetMessage,last_hit_player_ids:Array = null, last_hit_player_invisibles:Array = null):void
		{
			//新增处理vip_level字段
			var evt:CEventVideoTreasureBoxRewardNewRoleWeb = event as CEventVideoTreasureBoxRewardNewRoleWeb;
			var reward_true:Array                          = new Array;
			var reward:Array                               = new Array;
			var giftArr:Array                              = new Array; //游戏测奖励
			var giftArr_true:Array                         = new Array;
			if (evt == null)
				return;
			
			Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb res:"+JSON.stringify(evt));
			for each (var tmpitem:RewardBasicItem in evt.rewards)
			{
				var rewarddata:BoxRewardForUI = new BoxRewardForUI;
				rewarddata.reward_type = tmpitem.type;
				rewarddata.reward_id = tmpitem.para1;
				rewarddata.reward_cnt = tmpitem.para3;
//				rewarddata.send_anchor = tmpitem.send_anchor;//是否发送热度宝箱奖励给主播端，1 发送，0不发送
//				rewarddata.para4 = tmpitem.para4;//密令奖励的数量
				
				rewarddata.channel = tmpitem.item_channel;
			
				//处理新增的vip_level字段。
				if (tmpitem.type == ERewardType.R_VIP && tmpitem.para1 != 0)
				{
					if (evt.vip_level > 0)
					{
						rewarddata.reward_id = evt.vip_level;
					}
				}

				if (VideoChannelType.IsQueryReaward(rewarddata.channel)) //游戏侧道具奖励
				{
					var gift:RewardReqestWeb = new RewardReqestWeb;
					gift.id = m_client.IsSelfMale() ? tmpitem.para1 : tmpitem.para2;
					gift.amount = tmpitem.para3;
					gift.type = tmpitem.type;
					gift.channel = rewarddata.channel;
					giftArr_true.push(gift);
				}
				//梦幻币礼物，直接加成存在本地
				if (rewarddata.reward_type == ERewardType.R_VideoMoney)
				{
					m_client.GetVideoClientPlayer().SetVideoMoney(m_client.GetVideoClientPlayer().GetDreamMoneyNum() + rewarddata.reward_cnt, null);
				}

				reward_true.push(rewarddata);
			}

			for each (var tmpBox:VideoBoxItem in evt.box_items)
			{
				var rewarddataAll:BoxRewardForUI = new BoxRewardForUI;
				rewarddataAll.reward_type = tmpBox.item_type;
				rewarddataAll.reward_id = tmpBox.item_id_female;
				rewarddataAll.reward_cnt = tmpBox.count;

				rewarddataAll.channel = tmpBox.item_channel;

//				if( rewarddataAll.channel == Rewardchannel.VCT_X5 )//游戏侧道具奖励
//				{
//					var giftTsu:RewardReqestWeb = new RewardReqestWeb;
//					giftTsu.id = m_client.IsSelfMale() ? tmpBox.item_id_male : tmpBox.item_id_female;
//					giftTsu.channel = tmpBox.item_channel;
//					giftTsu.amount = tmpBox.count;
//					giftTsu.type = tmpBox.item_type;
//					giftArr.push(giftTsu);
//				}
				reward.push(rewarddataAll);
			}
			var tmpRewArr:Array = new Array;
			//惊喜宝箱
			if (evt.box_id == VideoGiftBoxType.VideoGiftBox_5 || evt.box_id == VideoGiftBoxType.VideoGiftBoxNest_5)
			{
				if( giftArr_true.length > 0 )
				{
					m_client.GetReawardCookieManager().GetRewordsInfos(giftArr_true,m_client.GetUICallback().OnGetSurpriseBoxReard,reward_true,evt.buff_percent,evt.m_is_reissue);
				}
				else
				{
					m_client.GetUICallback().OnGetSurpriseBoxReard(reward_true,evt.buff_percent,evt.m_is_reissue,tmpRewArr);
				}
			}
			else//普通宝箱
			{
				if( giftArr_true.length > 0 )
				{
					Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb res GetRewordsInfos:"+JSON.stringify(evt));
					m_client.GetReawardCookieManager().GetRewordsInfos(giftArr_true,m_client.GetUICallback().OnOpenTreasuerBoxResultNewRoleWeb,evt.res,evt.box_id,evt.choose_idx,reward_true,evt.buff_percent,evt.anchor_level,evt.online,evt.m_is_reissue, evt.last_hit_player_name, evt.last_hit_player_id, evt.last_hit_player_invisible, null, null );
				}
				else
				{
					Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb res OnOpenTreasuerBoxResultNewRoleWeb:"+JSON.stringify(evt));
					Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb res OnOpenTreasuerBoxResultNewRoleWeb reward_true:"+JSON.stringify(reward_true));
					Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb res OnOpenTreasuerBoxResultNewRoleWeb tmpRewArr:"+JSON.stringify(tmpRewArr));
					if(last_hit_player_ids){
						m_client.GetUICallback().OnOpenTreasuerBoxResultNewRoleWeb(evt.res,evt.box_id,evt.choose_idx,reward_true,evt.buff_percent,evt.anchor_level,evt.online,evt.m_is_reissue, evt.last_hit_player_name, evt.last_hit_player_id, evt.last_hit_player_invisible, last_hit_player_ids, last_hit_player_invisibles, tmpRewArr);
					} else{
						m_client.GetUICallback().OnOpenTreasuerBoxResultNewRoleWeb(evt.res,evt.box_id,evt.choose_idx,reward_true,evt.buff_percent,evt.anchor_level,evt.online,evt.m_is_reissue, evt.last_hit_player_name, evt.last_hit_player_id, evt.last_hit_player_invisible, null, null, tmpRewArr);	
					}
				}
			}
		}
		private function HandleCEventVideoRoomCheckNickRes(  event:INetMessage ):void
		{
			var ev:CEventVideoRoomCheckNickRes = event as CEventVideoRoomCheckNickRes;
			
			m_client.GetUICallback().OnCheckNickRes(VideoResultType.VREST_Normal, ev.res, ev.recommend_nick);
		}
		
		
		private function HandleCEventVideoQueryVideoMoneyRes(event:INetMessage):void
		{
			var ev:CEventVideoQueryVideoMoneyRes = event as CEventVideoQueryVideoMoneyRes;
			m_client.GetUICallback().OnQueryVideoMoneyRes( ev.succ, ev.video_money);
		}
		
		
		private function HandleCEventVideoQueryBalance(event:INetMessage):void
		{
			var ev:CEventVideoQueryBalanceRes = event as CEventVideoQueryBalanceRes;
			
			m_client.GetVideoClientPlayer().SetVideoMoney(-1,Int64.fromNumber(ev.total));
			
			m_client.GetUICallback().OnQueryBalanceRes(VideoResultType.VREST_Normal, ev.res == 0, ev.total);
		}
		
		private function HandleCEventVideoRoomGetRoomListRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomGetRoomListRes = ev as CEventVideoRoomGetRoomListRes;
			Globals.s_logger.debug("HandleCEventVideoRoomGetRoomListRes 39786 =  " + JSON.stringify(evt));
			var rooms:Array = new Array;
			FillRoomPageDataForUI(evt.page_rooms, rooms, evt.super_module_room_count, evt.module_room_count);
			var nests:Array = new Array;
			FillRoomPageDataForUI(evt.page_nests, nests);
			var ui:IVideoClientLogicCallback = m_client.GetUICallback();
			if(ui != null)
			{
				ui.OnLoadRoomList(VideoResultType.VREST_Normal, evt.subject, rooms, evt.total_cnt, evt.room_id_name, nests, evt.tag, evt.super_module_room_count, evt.module_room_count);
			}
		}
		private function HandleCEventVideoRoomBeKicked(ev:INetMessage):void
		{
			m_beKickedRoom = true;
			ClearRoomWhenLeave();
			
			var evt:CEventVideoRoomBeKicked = ev as CEventVideoRoomBeKicked;
			m_client.GetUICallback().NotifyBeKicked(evt.reason,evt.device_type);
		}
		
		public function GetRoomType():int
		{
			return m_type;
		}
		public function ClearRoomData():void
		{
			var leavesucc:int = 0;
			if( m_beKickedRoom == true )
			{
				m_client.GetUICallback().NotifyLeaveRoomRes(leavesucc );
			}
			m_client.GetVideoClientPlayer().ClearClientData();
		}
		
		private function HandleCEventVideoOpenGiftPoolBoxRes(ev:INetMessage):void
		{
			var evt:CEventVideoOpenGiftPoolBoxRes = ev as CEventVideoOpenGiftPoolBoxRes;
			if(evt == null)
			{
				return;
			}
			
			if (evt.room_id != GetRoomID())
			{
				Globals.s_logger.error(" HandleCEventVideoOpenGiftPoolBoxRes ERROR  ev.m_room_id != GetRoomID()");
				return;
			}
			
			//为-1时 仅仅通知客户端播放开宝箱前的动画(并非真正开宝箱)
			/*if (evt.chooseIndex == -1 )
			{
				if (m_client.GetIsGuest() == false)//不是游客才播放特效
					m_client.GetUICallback().PlayOpenTreasureBoxEffect(evt.box_id );
				var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
				msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
				msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
				msg_data.msg = "$t$主播开始选宝箱了,大家想要左边的？右边的？还是中间的$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);				
			}*/
				
			else if ((evt.result == VideoBoxErrorCode.OVBEC_Success || evt.result == VideoBoxErrorCode.OVBEC_BoxFreezeState)
				&& evt.box_data_buf.length != 0)
			{							
				ConvertToTreasureBoxDataBuf(evt.box_data_buf, evt.cur_height, m_client.IsSelfMale(), m_vecTreasureBox);
				m_client.GetUICallback().OnLoadTreasureBoxData(VideoResultType.VREST_Normal, evt.result, evt.room_id, evt.box_id, m_vecTreasureBox);
			}
		}
		private function getRewardIcon(type:int,id:int):String
		{
			var tmp:String = "";
			if(type == LotType.LotType_VideoExp)
			{
				tmp = "video_exp";
			}
			else if(type == LotType.LotType_VideoMoney)
			{
				tmp = "video_money";
			}
			else if(type == LotType.LotType_DreamGift)
			{
				tmp += id;
			}
			return tmp;
		}
		
		private var Pattern:RegExp = /\\/g;
		/**
		 * 聊天使用CEventVideoSendGiftResult非CEventVideoSendGiftResultForWeb
		 * @param ev
		 * 
		 */		
		private function HandleVideoSendGiftResult(ev:INetMessage):void
		{	
			var result_ev:CEventVideoSendGiftResult = ev as CEventVideoSendGiftResult;
			
			if(result_ev == null)
			{
				return;
			}

			//tqos上报 begin
			var tqos:TQOSSendGift = new TQOSSendGift();
			tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nRoomId = Globals.SelfRoomID;
			tqos.nErrorCode = result_ev.result;
			tqos.StrRoomServerIP = this.m_client.GetCallCenter().GetRPip();
			tqos.Response();
			//tqos上报 end
			
			var uicb:IVideoClientLogicCallback = this.m_client.GetUICallback();
			if(uicb == null)
			{
				return ;
			}
			
			if(result_ev.result == SendVideoGiftResult.SVGR_Succ)
			{
				var data:GiftData = new GiftData;
				
				data.giftItemID = result_ev.gift_id;
				data.count = result_ev.gift_count;
				data.senderName = result_ev.sender_name.replace(Pattern,"\\\\");
				data.anchorName = result_ev.anchor_name.replace(Pattern,"\\\\");
				data.zoneName = result_ev.zone_name;
				data.giftName = result_ev.gift_name;
				data.vip_level = result_ev.vip_level;
				data.vipIcon = vipConfig.GetVipIcon(data.vip_level);
				data.guardIcon = guardConfig.GetIcon(result_ev.guard_level);
				data.sender_channelid = PersistIDUtil.get_channel_id(result_ev.sender_id);
				data.senderPlayerID = result_ev.sender_id.toString();
				data.anchorID = result_ev.anchor_qq.toString();
				data.support_degree_add = result_ev.support_degree_add;
				data.invisible = result_ev.invisible;
				data.continuous_send_gift_times = result_ev.continuous_send_gift_times;
				data.anchor_exp = result_ev.anchor_exp;
				data.wealth_level = result_ev.wealth_level;
				data.source = result_ev.source;
				
				if(data.giftItemID == diceGiftId)
				{
					var diceGiftExtInfo:DiceGiftExtInfo = new DiceGiftExtInfo(); 
					ProtoBufSerializer.load_protobuf_compound(diceGiftExtInfo, result_ev.m_gift_ext_info)
					data.m_level = diceGiftExtInfo.m_level;
					data.m_dice_val_1 = diceGiftExtInfo.m_dice_val_1;
					data.m_dice_val_2 = diceGiftExtInfo.m_dice_val_2;
					data.m_dice_val_3 = diceGiftExtInfo.m_dice_val_3;
				}
				
				
				showBytes(result_ev.m_gift_ext_info.buffer());
				
				if(this.m_arrGiftMsgCache.length + 1 > this.m_nGiftMsgCacheCap)
				{
					//send
					sendGiftMsgBatchToUI();
				}
				else 
				{
					m_arrGiftMsgCache.push(data);
				}
				var self:Boolean = false;
				if(result_ev.sender_name == m_client.GetVideoClientPlayer().GetVideoNick())
				{
					self = true;
				}
				
				if(!isForbidFreeGift(data))
				{
					uicb.OnReceiveGift(data,self);
				}
			}
			
			if(result_ev.sender_id.equal(m_client.GetSelfPersistID()))
			{
				// 只有自己送礼才处理这个回调
				var info:SendVideoGiftResultInfo = new SendVideoGiftResultInfo;
				info.result = result_ev.result;
				info.result_ext = result_ev.res_ext;
				info.reason_ext = result_ev.reason_ext;
				
				uicb.OnSendGiftRes(VideoResultType.VREST_Normal, info, result_ev.sender_id,result_ev.diamond_balance,result_ev.video_money,result_ev.gift_id,result_ev.gift_count);
				
				if( result_ev.diamond_balance != -1)
				{
					m_client.GetVideoClientPlayer().SetVideoMoney(result_ev.video_money,Int64.fromNumber(result_ev.diamond_balance));
				}
				else
				{
					m_client.GetVideoClientPlayer().SetVideoMoney(result_ev.video_money, null );
				}
				
				if(result_ev.result == SendVideoGiftResult.SVGR_Succ && result_ev.diamond_balance != -1)
				{
					var adapter:IVideoClientAdapter = m_client.GetVideoClientAdapter();
					if(adapter != null)
					{
						adapter.RefreshMobilePlayerDiamondBalance(result_ev.diamond_balance);
					}
				}
			}
			
			//判断下目标主播是否在线
			if(result_ev.anchor_data.pstid.isZero())
			{
				return;
			}
			//UI端刷新StarLight和Popular
			var apc:IAnchorPKClient = m_base.GetAnchorPKClient();
			if(apc != null)
			{
				//刷新anchorPK中的主播信息
				apc.RefreshMatchAnchorStarLightAndPopular(result_ev.anchor_data.pstid, Int64.fromNumber(result_ev.anchor_data.starlight), Int64.fromNumber(result_ev.anchor_data.popularity));
			}
			if (m_live_detail.anchor_pstid.equal(result_ev.anchor_data.pstid))
			{
				m_live_detail.popularity = result_ev.anchor_data.popularity;
				m_live_detail.startlight = result_ev.anchor_data.starlight;
				m_live_detail.followed = result_ev.anchor_data.followed;
				uicb.RefreshAnchorStarLightAndPopular(Int64.fromNumber(result_ev.anchor_data.starlight), Int64.fromNumber(result_ev.anchor_data.popularity));
			}
		}
		
		private function showBytes(bytes:ByteArray):void 
		{ 
			var s:String = ""; 
			bytes.position = 0; 
			while (bytes.bytesAvailable) 
			{ 
				s += "0x" + bytes.readByte().toString(16) + " "; 
			} 
			if (s.length > 0) s = s.substr(0, s.length - 1); 
			trace("bytes:", s); 
		}
		
		
		
		private function HandleCEventVideoChatBanForAllRoomRes(ev:INetMessage):void
		{
			var evt:CEventVideoChatBanForAllRoomRes = ev as CEventVideoChatBanForAllRoomRes;
			
			var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			msg_data.systemType = 0;
			if(evt.ban)
			{
				msg_data.msg = "$t$" + evt.target_nickName + "[" +evt.target_zoneName +"]" + "被管理员永久全房间禁言$z";
			}
			else
			{
				msg_data.msg = "$t$" + evt.target_nickName + "[" +evt.target_zoneName +"]" + "已被管理员解除永久全房间禁言$z";
			}
			
			m_client.GetUICallback().OnReceiveChatMsg(msg_data);		
			//m_client.GetUICallback().OnForbidTalkAllRoom(evt.success, evt.target_nickName, evt.target_zoneName, evt.ban);			
		}
		public function KickPlayer(playerName:String,playerZoneName:String):Boolean
		{
			var event:CEventVideoRoomKickPlayer = new CEventVideoRoomKickPlayer;
			event.target_nickName = playerName;
			event.target_zoneName = playerZoneName;
			m_client.SendEvent(event,Globals.SelfRoomID);
			return true;
		}
		private function HandleCEventVideoRoomKickPlayerRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomKickPlayerRes = ev as CEventVideoRoomKickPlayerRes;
			m_client.GetUICallback().OnKickPlayer(evt.result);
		}
		
		private function HandleCEventVideoRoomEnterRoomBroadcastAllRoom(ev:INetMessage):void
		{
			var evt:CEventVideoRoomEnterRoomBroadcastAllRoom = ev as CEventVideoRoomEnterRoomBroadcastAllRoom;
			if(m_client != null)
			{
				m_client.GetUICallback().ShowVipEnterRoomScreenScrollMsg(evt.player_name.replace(Pattern,"\\\\"), evt.room_name.replace(Pattern,"\\\\"), evt.room_id,evt.vip_level,evt.guard_level,evt.zone_name);
			}
		}
		
		private function HandleCEventNotifySendLotsOfGifts(ev:INetMessage):void
		{
			var evt:CEventNotifySendLotsOfGifts = ev as CEventNotifySendLotsOfGifts;
			//一次性送出尊贵礼物超过某个值，所有视频房间走马灯通知
			var info:VideoRoomScreenScrollInfo = new VideoRoomScreenScrollInfo;
			info.anchor = evt.anchor_name.replace(Pattern,"\\\\");
			info.sender = evt.sender_name.replace(Pattern,"\\\\");
			info.zone = evt.zone_name;
			info.giftid = evt.gift_id;
			info.num = evt.gift_count;
			m_client.GetUICallback().ShowSendGiftScreenScrollMsg(info);			
		}
		private function HandleCEventVideoRefreshFlower(ev:INetMessage):void
		{
			var evt:CEventVideoRefreshFlower = ev as CEventVideoRefreshFlower;
			if(evt == null)
			{
				return;
			}
			m_client.GetUICallback().RefreshFreeGiftInfo(evt.flower_cnt, evt.next_refresh_leftTime);
		}
		private function HandleCEventVideoSearchOnlinePlayerRes(ev:INetMessage):void
		{
			var evt:CEventVideoSearchOnlinePlayerRes = ev as CEventVideoSearchOnlinePlayerRes;
			var data:Array = new Array;
			for(var i:uint = 0; i < evt.search_results.length; ++i)
			{
				var info:VideoRoomPlayerInfo = evt.search_results[i];
				var player_data: VideoRoomPlayerData = new VideoRoomPlayerData ;
				m_base.VideoRoomPlayerInfo2VideoRoomPlayerData(info, player_data);
				data.push(player_data);
			}
			
			m_client.GetUICallback().OnSearchOnlinePlayerRes(VideoResultType.VREST_Normal, data);
		}
		
		private function HandleCEventVideoRoomChatBanRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomChatBanRes = ev as CEventVideoRoomChatBanRes;
			m_client.GetUICallback().OnForbidTalk(evt.result);
		}
		
		private function HandleVideoRoomChatBan(ev:INetMessage):void
		{
			var evt:CEventVideoRoomChatBan = ev as CEventVideoRoomChatBan;			
			
			var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			msg_data.systemType = 1;
			
			msg_data.m_senderPlayerType = RoomPlayerType.RPT_audience;
			
			msg_data.senderName = evt.op_nick;
			msg_data.senderZoneName = evt.op_zoneName;
			if(msg_data.senderZoneName == "")
			{
				msg_data.m_senderPlayerType = RoomPlayerType.RPT_admin;
			}
			
			msg_data.viplevel = evt.op_vip_level;
			msg_data.sender_defend = evt.op_guard_level_new;
			
			msg_data.receiverName = evt.target_nickName;
			msg_data.receiverZoneName = evt.target_zoneName;
			msg_data.targetGuardLevel = evt.target_guard_level_new;
			msg_data.targetVipLevel = evt.target_vip_level;
			msg_data.wealth_level = evt.op_wealth_level;
			msg_data.sender_jacket = evt.target_wealth_level;//用sender_jacket模拟目标财富等级
			msg_data.senderPlayerID = evt.op_player_id.toString();
			
			var tmpdata:ChatBanResNameData = new ChatBanResNameData(evt.target_zoneName,evt.target_nickName); 
			if(evt.ban)
			{				
				m_base.AddChatBanPlayer(tmpdata);
			}
			else
			{
				m_base.DelChatBanPlayer(tmpdata);
			}
			msg_data.ban = evt.ban;
			msg_data.perpetual = evt.perpetual;
			
			m_client.GetUICallback().NotifyPlayerForbiddenTalk(Int64.fromNumber(0), evt.target_nickName, evt.target_zoneName, evt.perpetual, evt.ban,
				evt.op_nick,evt.op_zoneName,evt.op_guard_level_new,evt.target_guard_level_new,evt.op_vip_level,evt.target_vip_level);	
			
			m_client.GetUICallback().OnReceiveChatMsg(msg_data);			
		}

		public function GetPrivateChatList():Array {
			var tmparr:Array = new Array();
			for (var i:int = 0; i < m_arrPrivateChatInfoList.length; ++i) {
				var localChatInfo:PrivateChatInfo = m_arrPrivateChatInfoList[i];
				if (localChatInfo.name != null && localChatInfo.name != "") {
					var chatinfo:PrivateChatInfo = new PrivateChatInfo();
					chatinfo.name = m_arrPrivateChatInfoList[i].name;
					chatinfo.receiverPlayerType = m_arrPrivateChatInfoList[i].receiverPlayerType;
					chatinfo.zonename = m_arrPrivateChatInfoList[i].zonename;
					chatinfo.name = chatinfo.name.replace(Pattern, "\\\\");
					tmparr.push(chatinfo);
				}
			}
			return tmparr;
		}

		private function insertChatInfo(info:PrivateChatInfo):void
		{
			if(m_client.GetVideoClientPlayer() == info.name)
			{
				return ;
			}
			for(var i:int = 0; i<m_arrPrivateChatInfoList.length; ++i)
			{
				var chatinfo:PrivateChatInfo = m_arrPrivateChatInfoList[i];
				if( chatinfo.name == info.name && chatinfo.zonename == info.zonename )
				{
					return ;
				}
			}
			m_arrPrivateChatInfoList.push(info);
		}
		
		private function HandleCEventVideoChatResult(evt:INetMessage):void
		{
			var ev:CEventVideoChatResult = evt as CEventVideoChatResult;
			var res_code : int  = VideoChatErrorCode.ChatResult2VideoChatErrCode(ev.GetResult());
			
			const INVALID_DIAMOND_BALANCE:int = -1;
			var info:VideoChatErrorInfo = new VideoChatErrorInfo;
			info.result = res_code;
			info.result_ext = ev.res_ext;
			info.reason_ext = ev.reason_ext;
			
			var sendSystemFlag:Boolean = true;
			var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			msg_data.systemType = 0;
			Globals.s_logger.debug("HandleCEventVideoChatResult ev 39719 = " + JSON.stringify(ev) );
			switch(res_code)
			{
				case VideoChatErrorCode.VIDEO_CHAT_PUBLIC_FORBIDDEN:
					msg_data.msg = "$t$对不起，当前房间关闭了公众聊天$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_CHAT_CD:
					msg_data.msg = "$t$房间管理员限制文字聊天的速度，每" + Math.ceil(ev.system_cd_time/1000) + "秒可发送一次！请" + Math.ceil(ev.cd_remain_time/1000) + "秒后再发送文字$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_WHISTLE_NEED_LIVING:
					msg_data.msg = "$t$对不起，只有在直播中才能使用飞屏$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_BAN:
					msg_data.msg = "$t$对不起，您暂时被管理员禁止发言$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_PerpetualBan:
					msg_data.msg = "$t$对不起，您在本房间被永久禁言$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_PUBLIC_COOL_DOWN:
					msg_data.msg = "$t$亲，当前发言太热烈了~请" + Math.ceil(ev.cd_remain_time/1000) + "秒后再发言！$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_WHISTLE_NO_BAN:
					msg_data.msg = "$t$您已被管理员禁言,无法使用飞屏。$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_NO_FREE_WHISTLE:
					msg_data.msg = "$t$免费飞屏已经用完啦~$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_WHISTLE_SWITCH_BAN_WHISTLE:
					msg_data.msg = "$t$管理员关闭了当前房间的飞屏功能$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_BAN_ALL_ROOM:
					msg_data.msg = "$t$对不起，您在本房间已被永久禁言$z";
					break;
				case VideoChatErrorCode.VIDEO_CHAT_NOT_FIND_TARGET:
					msg_data.msg = "$t$对不起，无法联系到该玩家或者该玩家不在房间中$z";
					msg_data.systemType = 3;//私聊找不到玩家
					msg_data.TextColor = WebColor.privateChatNotFountPlayer;
					break;
				default:
					sendSystemFlag = false;
					break;
			}
			
			if(res_code == VideoChatErrorCode.VIDEO_CHAT_SUCCESS && ev.diamond_balance != INVALID_DIAMOND_BALANCE)
			{
				var adapter : IVideoClientAdapter =  m_client.GetVideoClientAdapter()
				if(  adapter != null )
				{
					adapter.RefreshMobilePlayerDiamondBalance(ev.diamond_balance);
				}
			}
			
			if(ev.diamond_balance != -1)
			{
				m_client.GetVideoClientPlayer().SetVideoMoney(-1,Int64.fromNumber(ev.diamond_balance) );
			}
			//公屏聊天tqos上报 begin
			var tqos:TQOSChatPublic = new TQOSChatPublic();
			tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nRoomId = Globals.SelfRoomID;
			tqos.nErrorCode = res_code;
			tqos.strErrorMsg = info.reason_ext ;
			tqos.StrRoomServerIP = this.m_client.GetCallCenter().GetRPip();
			tqos.Response();
			//tqos上报 end
			
			if(sendSystemFlag)
			{
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);	
			}
			else
			{
				m_client.GetUICallback().OnSendChatMsgRes(VideoResultType.VREST_Normal, info,ev.system_cd_time, ev.cd_remain_time,ev.diamond_balance);
			}
		}
		
		private static var pattern1:RegExp =  /</g;
		private static var pattern2:RegExp = />/g;
		private static var pattern3:RegExp = /\"/g;
		private static var pattern4:RegExp = /'/g;
		private static var pattern5:RegExp = /`/g;
		private static var pattern6:RegExp = /([  ]{1})/g;
		
		//替换聊天信息的特殊字符串 < > " ` '
		private function ReplaceChatMsg(str:String):String
		{		
			var str1:String = str.replace(pattern1,"&lt");
			var str2:String = str1.replace(pattern2,"&gt");
			var str3:String = str2.replace(pattern3,"&quot");
			var str4:String = str3.replace(pattern4,"&#39");
			var str5:String = str4.replace(pattern5,"&#96");	
			var str6:String = str4.replace(pattern6,"&nbsp");
			return str6;
		}
		//isContainGuardExpression
		public function HandleVideoToClientChatMsg(evt:INetMessage):void
		{
			var  ev:CEventVideoToClientChatMessage = evt as CEventVideoToClientChatMessage;
			var msg: VideoToClientChatMessage = ev.message;
			var msg_data:VideoRoomMsgData = new VideoRoomMsgData;
			
			//如果收到中级守护一下的守护等级的人发来的消息里面有守护专属表情，直接丢掉
			if(msg.guard_level_new < 20 && isContainGuardExpression(msg.message))
			{
				return;
			}
			
			//如果屏蔽了所有私聊，直接丢弃私聊信息
			if (msg.type == CHNL_TYPE.CHNL_VIDEOROOM_PRIVATE && 
				msg.sender_type == RoomPlayerType.RPT_audience && 
				m_client.GetVideoClientPlayer().GetVideoID().equal(msg.receiver_ID)) // 是私聊并且是发给我的
				//m_client.GetVideoClientPlayer().GetVideoName() == msg.recver_name
			{
				var cookie:Cookie         = new Cookie("x51web");
				var forbidprivate:Boolean = cookie.getData("isForbidPrivateChat");
				if (forbidprivate) {
					return;
				}
			}
			//屏蔽了该玩家
			if(msg.type != CHNL_TYPE.CHNL_VIDEOROOM_WHISTLE && isInIgnoreList(msg.sender_name,msg.sender_zoneName))
			{
				return;
			}
		//	msg_data.guardIcon = guardConfig.GetIcon(msg.guard_level_new);
		//	msg_data.vipIcon = vipConfig.GetVipIcon(msg.vip_level);
			
			msg_data.msg = ReplaceChatMsg(msg.message);
			msg_data.receiverName = msg.recver_name;
			msg_data.receiverZoneName = msg.recver_zoneName;
			msg_data.senderName = msg.sender_name;
			msg_data.senderZoneName = msg.sender_zoneName;
			msg_data.senderPlayerID = msg.sender_ID.toString();
			msg_data.senderPlayerZoneID = 0;
			msg_data.m_senderPlayerType = msg.sender_type;
			msg_data.wealth_level = msg.wealth_level;
			msg_data.add_anchor_exp = ev.add_anchor_exp;
			
			if(msg_data.m_senderPlayerType == RoomPlayerType.RPT_anchor)
			{
				msg_data.senderIcon = IconString.anchorIcon;
				if(msg_data.senderPlayerID == GetAnchorQQ().toString())
				{
					msg_data.isOnLive = true;
				}
				
			}
			else if(msg_data.m_senderPlayerType == RoomPlayerType.RPT_admin)
			{
				msg_data.senderIcon = IconString.adminIcon;
			}
			
			msg_data.viplevel = msg.vip_level;
			msg_data.receiverPlayerType = msg.receiver_type;
//			msg_data.nest_assistant = msg.nest_assistant;
			msg_data.sender_defend = msg.guard_level_new;
			
			msg_data.isSelf = 0;
			switch(msg.type)
			{
				case CHNL_TYPE.CHNL_VIDEOROOM_PUBLIC://公聊
				{
					msg_data.channel = ChatChannel.VIDEOCHNL_Public;					
					msg_data.TextColor = WebColor.publicChatCommonTextColor;//公聊字体是一个颜色
					
					switch( msg_data.m_senderPlayerType )//主播和管理员的昵称颜色
					{
						case RoomPlayerType.RPT_admin:
							msg_data.NickColor = WebColor.adminNickColor;
							break;
						case RoomPlayerType.RPT_anchor:
							msg_data.NickColor = WebColor.anchorNickColor;
							break;
					}
					
					switch( msg_data.sender_defend )//根据守护等级确定昵称颜色
					{
						case GuardLevelEnum.highGuard:
							msg_data.NickColor = WebColor.highGuardNickColor;//高级
							break;
						case GuardLevelEnum.angelGuard:
							msg_data.NickColor = WebColor.angelGuardNickColor;//天使
							break;
						case GuardLevelEnum.soalGuard:
							msg_data.NickColor = WebColor.soalGuardNickColor;//灵魂
							break;
						case GuardLevelEnum.unNormalGuard:
							msg_data.NickColor = WebColor.unNormalGuardNickColor;//非凡
							break;
						case GuardLevelEnum.extremeGuard:
							msg_data.NickColor = WebColor.extremeGuardNickColor;//至尊
							break;
						default:
							msg_data.NickColor = WebColor.primaryGuardNickColor;//无守护和初中级守护
							break;
					}
					
					var is_self :Boolean  = false;
					if(msg.sender_type == RoomPlayerType.RPT_audience)
					{
						is_self = m_client.GetVideoClientPlayer().GetVideoID().equal(msg.sender_ID);
//						is_self = (msg.sender_name == m_client.GetVideoClientPlayer().GetVideoNick());
					}
					if(is_self)
					{
						m_last_chat_time = getTimer();
						firstSendChatMsg = false;
					}
				}
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_PRIVATE://私聊
					msg_data.channel = ChatChannel.VIDEOCHNL_Private;
					msg_data.TextColor=WebColor.privateChatTextColor;//私聊字体颜色
					msg_data.NickColor = WebColor.privateChatNickColor;//私聊昵称颜色
					
					var chatinfo:PrivateChatInfo = new PrivateChatInfo();
					if(m_client.GetVideoClientPlayer().GetVideoID().equal(msg.receiver_ID)//m_client.GetVideoClientPlayer().GetVideoNick() == msg_data.receiverName 
						&& m_client.GetVideoClientPlayer().GetZoneName() == msg.recver_zoneName)// 是私聊并且是发给我的
					{
						msg_data.isSelf = 1;
						chatinfo.name = msg_data.senderName;
						chatinfo.zonename = msg_data.senderZoneName;
						chatinfo.receiverPlayerType = msg_data.m_senderPlayerType;
					}
					//m_client.GetVideoClientPlayer().GetVideoNick() == msg_data.senderName
					else if(m_client.GetVideoClientPlayer().GetVideoID().toString() == msg_data.senderPlayerID)
					{
						msg_data.isSelf = 2;
						chatinfo.name = msg_data.receiverName;
						chatinfo.zonename = msg_data.receiverZoneName;
						chatinfo.receiverPlayerType = msg_data.receiverPlayerType;
					}
					insertChatInfo(chatinfo);
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_WHISTLE:
					msg_data.channel = ChatChannel.VIDEOCHNL_Whistle;
					msg_data.vipCardPattern = CVideoVipConfig.getInstance().GetCardPattern(msg.vip_level);
				//	msg_data.vipIcon = CVideoVipConfig.getInstance().GetVipIcon(msg.vip_level);
				//	msg_data.guardIcon = m_client.GetGuardConfig().GetIcon(msg.vip_level);
					//是自己的免费飞屏，则更新个数
					if (m_client.GetVideoClientPlayer())
					{
						var self_zid:String = m_client.GetVideoClientPlayer().GetVideoPersistID().toString();
						if ( msg_data.senderPlayerID == self_zid
							&& m_free_whistle_left > 0 )
						{
							--m_free_whistle_left;
						}
						if ( msg_data.senderPlayerID == self_zid)
						{//飞屏tqos上报 begin
							var tqos:TQOSSendWhistle = new TQOSSendWhistle();
							tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
							tqos.nDeviceType = ClientDeviceType.CDT_WEB;
							tqos.nRoomId = Globals.SelfRoomID;
							tqos.StrRoomServerIP = this.m_client.GetCallCenter().GetRPip();
							tqos.Response();
							//tqos上报 end
						}
					}
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_GUILD:
					msg_data.channel = ChatChannel.VIDEOCHNL_Guild;
					//					msg_data.video_guild_id = msg.videoguild_id.toString();
					break;
				case CHNL_TYPE.CHNL_VIDEOROOM_SUPERSTARHORN:
					msg_data.channel = ChatChannel.VIDEOCHNL_SUPERSTARHORN;
					//是自己的免费超新星，则更新个数
					if ( m_client && m_client.GetVideoClientPlayer() )
					{
						var self_zid2:String = m_client.GetVideoClientPlayer().GetVideoPersistID().toString();
						if ( msg_data.senderPlayerID == self_zid2 && m_free_super_star_horn_left > 0)
						{
							--m_free_super_star_horn_left;
						}
					}
					break;
				case CHNL_TYPE.CHNL_GAMENOTIFY:  
					msg_data.channel = ChatChannel.VIDEOCHNL_System;
					msg_data.TextColor = "#FFFF00";
					break;
				case CHNL_TYPE.	CHNL_SYSNOTIFY:
					msg_data.channel = ChatChannel.VIDEOCHNL_System;
					msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
					break;
				default:
					return;
			}
			//聊天消息优化 mark
			msg_data.m_is_purple = false;//(msg.m_is_purple ? true : false);
			
			if(m_client && m_client.GetUICallback())
			{
				Globals.s_logger.debug("HandleVideoToClientChatMsg msg_data 39717 = " + JSON.stringify(msg_data));
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
			}
		}
		
		private function HandleRoomIsClosing():void
		{
			m_client.GetUICallback().OnRoomIsClosing();
		}
		public function SetVipInfo( vip_level:int , vip_expire :int):void
		{
			m_vip_level = vip_level;
			m_vip_expire = vip_expire;
			//设置首页的个人信息
			//			m_client.GetVideoClientPlayer().SetVipInfo(vip_level,vip_expire);
		}
		
		public function HaveTakenVipWeeklyRewardToday():Boolean
		{
			return TimeUtil.IsSameWeek(m_take_vip_weekly_reward_time,m_client.GetLogicInternal().GetServerTime());
		}
		
		public function SetTakenVipWeeklyRewardTime(t:int ):void
		{
			m_take_vip_weekly_reward_time = t;
		}
		
		public function GetVipLevel():int
		{
			return m_vip_level;
		}
		public function GetVipExpire():int
		{
			var logic:IVideoClientLogicInternal = m_client.GetLogicInternal();
			if ( logic == null )
			{
				return 0;
			}
			
			var srvtime:int = logic.GetServerTime();
			var expire:int = m_vip_expire;
			if(expire <= srvtime)
			{
				return 0;
			}
			var left_day:int = (expire-srvtime)/86400;//一天的秒数
			if((expire - srvtime) % 86400 > 0)
			{
				left_day++;
			}
			return left_day;
		}
		
		private function HandleCEventVideoRoomEnterRoomRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomEnterRoomRes = ev as CEventVideoRoomEnterRoomRes;
			////先设置VIP信息
			var vgc:IVideoGuildClient = m_base.GetVideoGuildClient();
			var pre_vip_level:int = evt.info.vip_level;
			var info:EnterVideoRoomInitInfo = evt.info;
			Globals.s_logger.debug("HandleCEventVideoRoomEnterRoomRes 进房消息evt.result = " + evt.result + ", success=" + VideoRoomErrorCode.VIDEO_ROOM_SUCCESS+", edu_flag = " +evt.info.edu_flag);
			Globals.s_logger.debug("HandleCEventVideoRoomEnterRoomRes 进房消息evt"  + JSON.stringify(evt));
			if ( evt.result == VideoRoomErrorCode.VIDEO_ROOM_SUCCESS )
			{
				
				Globals.SelfRoomID = evt.room_id;
				m_concert = info.is_concert;
				m_is_special_room = evt.is_special_room;
				m_is_nest_room = info.is_nest_room;
				
				//演唱会累计观看人数统计相关
				if(m_concert)
				{
					var cookie:Cookie = new Cookie("x51webConcert");
					var currDate:Date = new Date();
					var lastEnterConcertRoomTime:Number = 0;
					if(cookie.getData("lastEnterConcertRoomTime") != null)
						lastEnterConcertRoomTime = cookie.getData("lastEnterConcertRoomTime");
					
					if((currDate.time - lastEnterConcertRoomTime)/(1000*60*60) > 24 )
					{
						cookie.clearData(null);
						cookie.flushData("lastEnterConcertRoomTime",currDate.time);
					}
				}
				
				// 演唱会
				if(m_base.GetConcertClient())
				{
					var concert_client:CConcertClient = m_base.GetConcertClient() as CConcertClient;
					if(concert_client != null)
					{
						concert_client.SetIsStarted(info.concert_is_open);//是否开启
						concert_client.SetHasTicket(info.has_concert_ticket);//是否有票
					}
				}
				
				m_attached_room_id = info.attached_room;
//				m_attached_anchor = null;
				m_attached_anchor = info.attached_anchor;
				m_attached_room_name = info.attached_room_name;;
				if ( evt.info.vip_notify == EnterVideoRoomInitInfo.VNT_Expired )
				{
					evt.info.vip_level = 0;
					evt.info.vip_expire = 0;
				}
				
				SetTakenVipWeeklyRewardTime(info.taken_vip_weekly_reward_time);
				m_flags = evt.info.flags;
				
				if (m_client.GetVideoClientPlayer())
				{
					m_client.GetVideoClientPlayer().SetInvisible(info.invisible, true);
				}
				// 零点倒计时
				m_seat_price_reset_notice = evt.info.seat_price_reset_notice;
			}
			else
				m_seat_price_reset_notice = 0;
			
			if (m_client.GetUICallback())
			{
				SetVipInfo(evt.info.vip_level, evt.info.vip_expire);
				var uiinfo:UIEnterVideoRoomInfo = new UIEnterVideoRoomInfo;
				uiinfo.m_room_id = evt.room_id;
				uiinfo.m_player_count = evt.info.audience_count;
				uiinfo.m_vip_level = m_vip_level;
				uiinfo.m_vip_expire = GetVipExpire();
				uiinfo.m_remain_crowdroom_count = evt.info.remain_crowdroom_count;
				uiinfo.m_cooldown_second = evt.cooldown;
				uiinfo.free_times = evt.info.free_times;
				uiinfo.seat_price_reset_notice = evt.info.seat_price_reset_notice;
				//演唱会
				uiinfo.is_concert = m_concert;
				uiinfo.has_concert_ticket = info.has_concert_ticket;
				uiinfo.concert_is_open = info.concert_is_open;
				uiinfo.nest_count = evt.nest_count;
				uiinfo.red_envelope_duration = evt.info.redenvelope_public.red_envelope_duration;
				uiinfo.small_red_envelope_duration = evt.info.redenvelope_public.small_red_envelope_duration;
//				uiinfo.lucky_draw_rest_exp_tody = evt.info.live_detail.lucky_draw_rest_exp_tody;
				FillUIRedEnvelopes(uiinfo.m_redenvelopes, evt.info.redenvelopes);
				uiinfo.activity_type = evt.info.activity_type;
				uiinfo.can_punch_in_room = evt.info.can_punch_in_room;
				uiinfo.room_skin_id = evt.info.room_skin_id;
				uiinfo.room_skin_level = evt.info.room_skin_level;
//				uiinfo.vip_attached_anchor_name = evt.info.vip_attached_anchor_name;
//				uiinfo.vip_attached_anchor_id = evt.info.vip_attached_anchor_id.toString();
				uiinfo.edu_flag = evt.info.edu_flag;
				uiinfo.concert_id = evt.concert_id;
				
				//web演唱会指定静态图片改为管理员上传的第一张图20150708 by hss
				var picurl:String = "";
				const VideoRoomMaxPicCount:int = 5;
				for(var i:int= 0; i<VideoRoomMaxPicCount; i ++)
				{
					if(info.room_pic_info & (1<<i) )
					{
						if(picurl == "")
						{
							picurl = OlinePictureDef.GetVideoRoomPictureDownloadUrl(m_base.GetPicDownloadUrl(), Globals.VideoGroupID,evt.room_id,i);
						}
						else
						{
							picurl += "," + OlinePictureDef.GetVideoRoomPictureDownloadUrl(m_base.GetPicDownloadUrl(), Globals.VideoGroupID,evt.room_id,i);
						}
					}
				}
				var concertclient:CConcertClient = m_base.GetConcertClient() as CConcertClient;
				concertclient.SetConcertStaticImageURL( picurl);
				//设置免费抢座次数				m_client.GetLogicInternal().SetVipFreeSeatLeft(evt.info.free_times); 
				Globals.s_logger.debug("HandleCEventVideoRoomEnterRoomRes 进房消息evt.edu_flag = " + uiinfo.edu_flag);
				
				m_client.GetUICallback().NotifyEnterRoomRes(VideoResultType.VREST_Normal,evt.result, uiinfo);
			}
			
			if (evt.result == VideoRoomErrorCode.VIDEO_ROOM_SUCCESS)
			{
				m_room_id = evt.room_id;
				m_room_name = info.room_name;
				Globals.room_name = info.room_name;
				SetVideoRoomStatus(info.status);				
				m_subject = info.subject;
				m_audience_count = info.audience_count;
				m_cur_giftpool_height = info.cur_giftpool_height;
				m_max_giftpool_height = info.max_giftpool_height;
				m_roomPicInfo = info.room_pic_info;
				
				m_forbid_public_chat = info.forbid_public_chat;
				Globals.room_forbid_all = info.forbid_public_chat;
				m_open_chat_cd_check = info.open_chat_cd_check;
				m_chat_cd_time = info.chat_cd_time;
				
				m_player_capacity = info.player_capacity;
				m_free_whistle_left = info.free_whistle_left;
				m_free_super_star_horn_left = info.free_super_star_horn_left;
				SetTakenVipWeeklyRewardTime(info.taken_vip_weekly_reward_time);
				m_type = info.type;
				m_public_chat_cd_on_enter = info.public_chat_cd_on_enter;
				
				var old_status:VideoRoomLiveStatus = new VideoRoomLiveStatus;
				GetLiveStatus(old_status);
				
				var old_split_screen_info:SplitScreenInfo = new SplitScreenInfo;
				GetSplitScreenInfo(old_split_screen_info);
				
				m_live_detail = info.live_detail;
				
				m_low_video_uploadspeed = info.low_video_uploadspeed;
				m_normal_video_uploadspeed = info.normal_video_uploadspeed;
				
				m_base.GetVoteClient().SetIsStartVote(!info.vote_info.vote_id.equal(Int64.fromNumber(-1)));
				m_base.GetVoteClient().SetHasVoted( info.vote_selects.length !=0);
				
				var new_status:VideoRoomLiveStatus = new VideoRoomLiveStatus;
				GetLiveStatus(new_status);
				
				var new_split_screen_info:SplitScreenInfo = new SplitScreenInfo;
				GetSplitScreenInfo(new_split_screen_info);
				
				RefreshRoomInfo();
				
				//RefreshAnchorInfo();
				//xw70857 主播相关的刷新问题
				if (ConvertLogic2UIVideoRoomStatus(info.status) == RoomStatus.VRS_Playing) {
					RefreshAnchorInfo();
				}
				
				RefreshDanceChampionInfo();
				
				UpdateLiveStatus(old_status, new_status);
				//刷新分屏信息
				UpdateSplitScreenLiveStatus(old_split_screen_info, new_split_screen_info);
				
				Globals.s_logger.debug("HandleCEventVideoRoomEnterRoomRes()   isReady = " + Globals.isReady);
				
				if(Globals.isReady)
				{
					updateLiveCDN();
				}
				else
				{
					Globals.isReady = true;
				}
//				LoadCDNInfo();
				
				m_base.ClearSelfInfo();
				m_base.GetSurpriseBoxManager().OnEnterRoom();
				
				if (info.vip_notify != 0 )
				{
					if ( info.vip_notify == EnterVideoRoomInitInfo.VNT_Expired )
					{
						m_client.GetUICallback().NotifyVipExpired(pre_vip_level);
					}
					else
					{
						m_client.GetUICallback().NotifyVipLeftDay(info.vip_level, info.vip_notify);
					}
				}				
				m_client.GetUICallback().OnQueryFreeWhistleLeft(m_free_whistle_left);
				
				var hasvoted:Boolean = m_base.GetVoteClient().HasVoted();
				//通知页面投票信息
				if(!info.vote_info.vote_id.equal(Int64.fromNumber(-1)) && !hasvoted )
				{
					var voteinfoUI:VideoVoteInfoForUI = new VideoVoteInfoForUI;
					voteinfoUI.anchor = info.vote_info.anchor.toString();
					voteinfoUI.anchor_name = info.vote_info.anchor_name;
					voteinfoUI.start_voting_time = info.vote_info.start_voting_time;
					voteinfoUI.end_voting_time = info.vote_info.end_voting_time;
					voteinfoUI.optional_max_count = info.vote_info.optional_max_count;
					voteinfoUI.vote_id = info.vote_info.vote_id.toString();
					voteinfoUI.vote_topic = info.vote_info.vote_topic;
					voteinfoUI.vote_entries = info.vote_info.vote_entries;
					var hasVote:int = 0;//有投票
					m_client.GetUICallback().OnAnchorStartVote(hasVote,voteinfoUI);
				}
				m_client.GetUICallback().OnQueryIsConcertRoom(m_concert);
				
				m_beKickedRoom = false;//初始化
				
				// xw79531 成功进房将房间id保存到cookie里面。
				// 非游客进房记录房间id
				if (m_client.GetIsGuest() == false && m_client.GetCallCenter().GetQQ() > 0) {
					var roomCookie:Cookie = new Cookie(AccountCookieConst.ACCOUNT_NAME);
					roomCookie.flushData(AccountCookieConst.RoomIDQQ, m_client.GetCallCenter().GetQQ());
					roomCookie.flushData(AccountCookieConst.RoomID, m_room_id);
				}
			}

			if(info.notify_vg_name != "")
			{
				vgc.ApproveVideoJoinApplyNotify(info.notify_vg_name);
			}
			
			//主动拉取我的后援团信息
			vgc.LoadMyVideoGuild(false);
			
			//tqos上报 begin
			var tqos:TQOSEnterRoom = new TQOSEnterRoom();
			tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nEnterSuccTime = flash.utils.getTimer() - TQOSEnterRoom.nBeginTime;
			tqos.nRoomId = evt.room_id;
			tqos.nErrorCode = evt.result;
			tqos.StrRoomServerIP = this.m_client.GetCallCenter().GetRPip();
			tqos.Response();
			//tqos上报 end
			//进入房间开启定时事件，每五分钟拉取在线玩家列表
			if( Globals.timer !=null )
			{
				Globals.timer.StopTimer();
			}
			Globals.timer = new TimerBase(Globals.intervalTime,freshPlayerList);//5分钟
			Globals.timer.StartTimer();	
			
//			HandleCEventVideoAD(getFakeADEvent());
		}
		
		public function freshPlayerList():void
		{
			m_client.GetInterfacesForUI().LoadPlayerList(Globals.pageIndex);
		}
		
		public function CheckLiveTask():void
		{
		}
		
		private var requareCndTimes:int = 3;//请求三次
		private var requestCDNUrlTimCD:int = 5*1000;//每五秒请求一次，总共请求三次
		private var requestCDNUrlTimer:TimerBase = new TimerBase(requestCDNUrlTimCD,requestCDNUrl);

		private function requestCDNUrl():void {
			var roomId:int;
			//引流页面获取CDN_url,引流id优先级最高，只有引流页面才会有值
			if (Globals.iframeRoomID > 0) {
				roomId = Globals.iframeRoomID;
			} else if (Globals.tmpRoomID > 0){
				roomId = Globals.tmpRoomID
			}
			if (roomId > 0) {
				var eventReq:CEventVideoRoomGetLiveCDN = new CEventVideoRoomGetLiveCDN;
				eventReq.room_id = roomId;
				m_client.SendEvent(eventReq, roomId);
				requareCndTimes--;
				if (requareCndTimes <= 0) {
					requestCDNUrlTimer.StopTimer();
				}
			}
		}

		private function LoadCDNInfo():void {
			/*if (Globals.tmpRoomID > 0) {
				var ev:CEventVideoRoomGetLiveCDN = new CEventVideoRoomGetLiveCDN;
				ev.room_id = Globals.tmpRoomID;
				Globals.s_logger.debug(" LoadCDNInfo()    " + Globals.tmpRoomID);
				m_client.SendEvent(ev, Globals.tmpRoomID);
			}
			requestCDNUrlTimer.StartTimer();*/
		}

		public function VideoRoomGetLiveCDN():void {
			var roomId:int;
			//引流页面获取CDN_url,引流id优先级最高，只有引流页面才会有值
			if (Globals.iframeRoomID > 0) {
				roomId = Globals.iframeRoomID;
			} else if (Globals.SelfRoomID > 0){
				roomId = Globals.SelfRoomID
			}
			/*if (roomId > 0) {
				var event:CEventVideoRoomGetLiveCDN = new CEventVideoRoomGetLiveCDN;
				event.room_id = roomId;
				Globals.s_logger.debug(" VideoRoomGetLiveCDN()    " + roomId + "  Globals.deviceType = " + Globals.deviceType);
				m_client.SendEvent(event, roomId, Globals.deviceType);
			}
			requestCDNUrlTimer.StartTimer();*/
		}
		
		private var split_screen_vid:int = 0;
		private var _vid:int = 0;
		private function HandleCEventGetVideoRoomLiveInfo(ev:INetMessage):void
		{
			var evt:CEventGetVideoRoomLiveInfoRes = ev as CEventGetVideoRoomLiveInfoRes;
			
			if(evt.live_info.vid != 0 && _vid != evt.live_info.vid)
			{
				Globals.s_logger.debug("HandleCEventGetVideoRoomLiveInfo() : _vid = " + _vid + "  evt.live_info.vid = " + evt.live_info.vid);
				iframeStartWatchInvitedAnchorLive(evt.live_info.vid,false);
			}
			else if(evt.live_info.vid == 0)
			{
				m_client.GetUICallback().OnStopVideoLive();
			}
			_vid = evt.live_info.vid;
			
			if(evt.live_info.split_screen_vid != 0 && split_screen_vid != evt.live_info.split_screen_vid)
			{
				Globals.s_logger.debug("HandleCEventGetVideoRoomLiveInfo() : split_screen_vid = " + split_screen_vid + "  evt.live_info.split_screen_vid = " + evt.live_info.split_screen_vid);
				iframeStartWatchInvitedAnchorLive(evt.live_info.split_screen_vid,true);
			}
			else if(evt.live_info.split_screen_vid == 0)
			{
				m_client.GetUICallback().OnStopWatchInvitedAnchorLive();
			}
			split_screen_vid = evt.live_info.split_screen_vid;
			
		}
		
		public function iframeStartWatchInvitedAnchorLive(vid:int,isBool:Boolean):void 
		{
			var cdn_urls:Array = new Array;
			if(vid == 0)
			{
				m_client.GetUICallback().OnStarSplitScreenLive(cdn_urls,false);
				return ;
			}
			var cdn:Array = m_cdn_info.ip_vec;
			for(var i:int = 0; i < cdn.length; ++i)
			{
				var urlstr:String = cdn[i] as String;
				urlstr += vid;
				//现网
				//urlstr += ".flv?apptype=live&xHttpTrunk=1&buname=x5h3d_platform&uin=23222439";
				//外网
				urlstr += ".flv?apptype=live&xHttpTrunk=1&buname="+ Globals.video_buname +"&uin=23222439";
				Globals.s_logger.debug("cdn url:" + urlstr + " Globals.video_buname = " + Globals.video_buname);
				cdn_urls.push(urlstr);
			}
			
			if(isBool)
			{
				m_client.GetUICallback().OnStarSplitScreenLive(cdn_urls,false);
			}
			else
			{
				m_client.GetUICallback().OnStartVideoLive(cdn_urls,0,false);
			}
				
			return ;
		}

		/**
		 * 进房基础信息。
		 * @param event
		 * 
		 */		
		private function HandleCEventVideoRoomBasicInfos(event:INetMessage):void {
			var evt:CEventVideoRoomBasicInfos = event as CEventVideoRoomBasicInfos;

			basicAnchorID = evt.anchor_data.pstid.toNumber();
			
			var ui_anchor:ClientAnchorData    = new ClientAnchorData();
			ui_anchor.name = evt.anchor_nick.replace(/\\/g, "\\\\");
			ui_anchor.anchorID = evt.anchor_data.pstid.toString();
			ui_anchor.anchorQQ = evt.anchor_data.pstid.toString();
			ui_anchor.followedAudiences = evt.anchor_data.followed;
			ui_anchor.starlight = evt.anchor_data.starlight.toString();
			ui_anchor.popularity = evt.anchor_data.popularity.toString();
			ui_anchor.anchor_level = evt.anchor_data.level;
			ui_anchor.anchor_exp = evt.anchor_data.exp;
			ui_anchor.anchor_levelup_exp = evt.levelup_need_exp;
			ui_anchor.is_basic_info = true;
			ui_anchor.anchor_badge = evt.anchor_badge;
			ui_anchor.intro = evt.anchor_intro;
			ui_anchor.bottleneck_count = evt.anchor_data.stGrowth_data.bottleneck_count;
			ui_anchor.bottleneck_gift_id = evt.bottle_neck_gift_id;
			ui_anchor.bottleneck_need_count = evt.bottle_neck_need_count;

			//ui_anchor.m_impression_data.m_impressions = evt.anchor_data.impressions;
			ui_anchor.m_impression_data.m_player_count = evt.anchor_data.impression_count;
			var impressions:Array        = [];
			var impcfg:IImpressionConfig = m_client.GetImpressionConfig();
			for (var key:String in evt.anchor_data.impressions) {
				var temp:AnchorImpressionDataForUI = new AnchorImpressionDataForUI;
				temp.m_impression_id = parseInt(key);
				temp.m_impression_name = impcfg.GetImpressionName(temp.m_impression_id);
				temp.m_count = evt.anchor_data.impressions[key];
				impressions.push(temp);
			}
			
			impressions.sortOn(["m_count", "m_impression_id"], [Array.NUMERIC | Array.DESCENDING, Array.NUMERIC]);
//			impressions.sortOn("m_count", Array.NUMERIC | Array.DESCENDING);
			ui_anchor.m_impression_data.m_impressions = impressions;
			ui_anchor.m_impression_data.m_total_count = impressions.length;

			if (evt.anchor_data.stGrowth_data.bottleneck_count < 0) //表示没有到瓶颈期
			{
				ui_anchor.is_bottleneck = false;
			} else {
				ui_anchor.is_bottleneck = true;
				ui_anchor.bottleneck_count = evt.anchor_data.stGrowth_data.bottleneck_count;
			}

			if (evt.anchor_data.anchor_portrait_url != "") {
				//XW79794 去除头像随机数
				ui_anchor.photoUrl = Globals.m_pic_download_url + "/qdancersec/" + evt.anchor_data.anchor_portrait_url; //+ "/0" + URLSuffix.CreateVersionString();
			}
			//使用老方法拼接头像
			else if (ui_anchor.anchorQQ != "") {
				m_client.GetVideoClientBase().FillAnchorPortraitUrl(ui_anchor);
//				m_client.GetVideoClientBase().FillAnchorImageUrl(ui_anchor);
			}

			if (ui_anchor.anchorQQ != "") {
				m_client.GetVideoClientBase().FillAnchorImageUrl(ui_anchor);
			}

			m_client.GetUICallback().GetUIAnchorNest().RefreshAnchorData(ui_anchor);
			var isFollow:Boolean = m_client.GetVideoClientPlayer().IsFollowingAnchor(evt.anchor_data.pstid);

			m_room_name = evt.room_name;
			Globals.room_name = evt.room_name;

			m_client.GetUICallback().RefreshAnchorInfoByData(ui_anchor, isFollow, evt.room_name);
			m_base.GetVideoGuildClient().SetCurrLivingAnchorPstid(evt.anchor_data.pstid.toString());

			var guard_seats:Array = new Array();
			for each (var seatinfo:VideoGuardSeatInfo in evt.guard_seats) {
//				if (seatinfo.m_player_id.toNumber() == m_client.GetCallCenter().GetQQ()) {
//					seatinfo.m_player_id = new Int64();
//					seatinfo.m_pic_url = "";
//				}
				var seatInfoUI:VideoGuardSeatInfoUI = new VideoGuardSeatInfoUI();
				ToVideoGuardSeatInfoForUI(seatinfo, seatInfoUI);
				guard_seats.push(seatInfoUI);
			}
			m_client.GetUICallback().OnRefreshRoomGuardSeats(evt.room_id, guard_seats);

			var vip_seats:Array = new Array();
			for (var i:int = 0; i < evt.vip_seats.length; i++) {
				var vipseatinfo:VipSeatInfo = evt.vip_seats[i];
//				if (vipseatinfo.player_id.toNumber() == m_client.GetCallCenter().GetQQ()) {
//					vipseatinfo.player_id = new Int64();
//					vipseatinfo.pic_url = "";
//				}
				var info:VipSeatInfoForUI = new VipSeatInfoForUI();
				m_base.ToVipSeatInfoForUI(vipseatinfo, info);
				if (evt.seat_protect_time != null && vipseatinfo.hasOwnProperty("vip_level")) {
					var prot:int = evt.seat_protect_time[vipseatinfo.vip_level];
					info.protect_time = prot;
				}
				vip_seats.push(info);
			}
			m_client.GetUICallback().RefreshVipSeats(vip_seats);

			m_base.RefreshSuperFans(evt.super_funs);

			var rooms:Array = new Array();
			FillRoomDataForUI(evt.rooms, rooms);
			m_client.GetUICallback().OnLoadRoomList(VideoResultType.VREST_Normal, 0, rooms, rooms.length, null, [], 0, 0,0);

			m_client.GetUICallback().RefreshRoomPlayerCount(m_room_id, evt.online_player_count, evt.room_capacity);

			if (evt.skin_level_up_task_info.room_skin_id > 0 
				&& evt.skin_level_up_task_info.room_skin_level > 0 
				&& evt.skin_level_up_task_info.room_skin_level < 9) {
				
				HandleCEventRoomSkinLevelUpTaskInfo(evt.skin_level_up_task_info);
			}
			if (evt.skin_daily_task_info.room_skin_level == 9) {
				HandleCEventRoomSkinDailyTaskInfo(evt.skin_daily_task_info);
			}
		}

		/**
		 * 点击广告
		 * @param ad_type
		 * @param ad_site
		 *
		 */
		public function ADClick(ad_type:int, ad_site:int):void {
			var event:CEventVideoRoomAdClick = new CEventVideoRoomAdClick();
			event.ad_type = ad_type;
			event.ad_site = ad_site;
			m_client.SendEvent(event, Globals.SelfRoomID);
		}

		private function HandleCEventVideoAD(event:INetMessage):void {
			var evt:CEventVideoAD    = event as CEventVideoAD;

			var adInfo:Object        = new Object();

			var fixed_video_ad:Array = [];
			for each (var fvad:VideoAD in evt.video_ad.fixed_video_ad) {
				fixed_video_ad.push(fvad.toJSObj());
			}
			adInfo["fixed_video_ad"] = fixed_video_ad;

			var background_video_ad:Array = [];
			for each (var bgvad:VideoAD in evt.video_ad.background_video_ad) {
				background_video_ad.push(bgvad.toJSObj());
			}
			adInfo["background_video_ad"] = background_video_ad;

			adInfo["edge_video_ad"] = evt.edge_video_ad.toJSObj();

			m_client.GetUICallback().OnNotifyVideoAD(adInfo);
		}

		private function getFakeADEvent():CEventVideoAD {
			var event:CEventVideoAD = new CEventVideoAD();

			var dataList:Array      =
				[{id: 1, src: "http://p.qpic.cn/qdancersec/PiajxSqBRaEI51z8202JrNqTkGmO9SFY2hATFT156JJSMia9GWibkaH6SU9w8N7gU5baicBliakfnuz4/0?v=360442399", link: "http://www.163.com", startTime: 0, endTime: 25000},
				{id: 2, src: "http://p.qpic.cn/qdancersec/ajNVdqHZLLAIZtciaD4VF2m3R5WiaEVltaHCib3j17ic0TKNMAwqJ1H1jNNp69HwLLYGs96jISCxRiaE/0?v=302620078", link: "http://www.163.com", startTime: 10000, endTime: 0},
				{id: 3, src: "http://p.qpic.cn/qdancersec/ajNVdqHZLLBtKWrlKgQVWYCQeoMClWFHU6KcPObxuvtDJadGAzovf1K6QzVHzuyQnXADJMDVgUU/0?v=558945269", link: "http://www.163.com", startTime: 52000, endTime: 1000},
				{id: 4, src: "http://p.qpic.cn/qdancersec/ajNVdqHZLLBiaDbUXKPdj9PVW7icqibxbAsy8SZ54GOVbLKficuDRhkVTT4ZXm3iaXcGibPwB6k9ibq3y4/0?v=255140543", link: "http://www.163.com", startTime: 35000, endTime: 1000},
				{id: 5, src: "http://p.qpic.cn/qdancersec/ajNVdqHZLLB4MOg6LIeZHlQiavAA3wSibxfB7TY5myUC5YCEZHrrm2HYVKw8IO6z5VZR8LZnKcLQA/0?v=93322051", link: "http://www.163.com", startTime: 19000, endTime: 1000},
				{id: 6, src: "http://p.qpic.cn/qdancersec/ajNVdqHZLLAFFCQN4VVyaybzaxNxWgBastDBMYrajiaLXthGqtDOzviam7jZQI6mlMuhIqicwPmSGY/0?v=235079790", link: "http://www.163.com", startTime: 28000, endTime: 1000}]
			
			var adList:Array = [];
			for (var i:int = 0; i < 6; i ++){
				var data:Object = dataList[i];
				var ad:VideoAD = new VideoAD();
				ad.id = data.id;
				ad.pic_link = data.src;
				ad.jump_link = data.link;
				if (i == 0) {
					ad.begin_time = m_client.GetLogicInternal().GetServerTime() + 15 + 60 * i * Math.random();
				} else {
					ad.begin_time = m_client.GetLogicInternal().GetServerTime() + 15 + 60 * (i - 1) + 60 * Math.random();
				}
				ad.end_Time = ad.begin_time + 60 * 5;
				adList.push(ad);
			}
			event.video_ad.fixed_video_ad = adList;
			event.video_ad.background_video_ad = adList;
			return event;
		}

		private var cEventVideoRoomGetLiveCDNRes:CEventVideoRoomGetLiveCDNRes = null;

		private function HandleCEventVideoRoomGetLiveCDNRes(event:INetMessage):void {
			cEventVideoRoomGetLiveCDNRes = event as CEventVideoRoomGetLiveCDNRes;
			m_concert = (cEventVideoRoomGetLiveCDNRes.room_type == VideoRoomType.RT_CONCERT);
			Globals.vkey = cEventVideoRoomGetLiveCDNRes.cdn_info.vkey;
			Globals.s_logger.debug("HandleCEventVideoRoomGetLiveCDNRes()   ip_vec.length = " + cEventVideoRoomGetLiveCDNRes.cdn_info.ip_vec.length);
			//如果下发的cnd url错误就再请求
			if (cEventVideoRoomGetLiveCDNRes.cdn_info.ip_vec.length <= 0 && requareCndTimes > 0) {
				requestCDNUrl();
				return;
			} else //表示成功，停止计时器
			{
				requestCDNUrlTimer.StopTimer();
			}

			//Globals.s_logger.debug("HandleCEventVideoRoomGetLiveCDNRes()   isReady = " + Globals.isReady);
			if (Globals.isReady) {
				updateLiveCDN();
			} else {
				Globals.isReady = true;
				updateLiveCDN();
			}
		}


		private function updateLiveCDN():void {
			Globals.s_logger.debug("updateLiveCDN()  cEventVideoRoomGetLiveCDNRes.cdn_info.ip_vec.length = " + cEventVideoRoomGetLiveCDNRes.cdn_info.ip_vec.length + "    requareCndTimes = " + requareCndTimes);
			//如果下发的cnd url错误就再请求
			if (cEventVideoRoomGetLiveCDNRes.cdn_info.ip_vec.length > 0) {
				m_cdn_info = cEventVideoRoomGetLiveCDNRes.cdn_info;
				for (var i:int = 0; i < m_cdn_info.ip_vec.length; ++i) {
					Globals.s_logger.log("videoroom: get cdn info success, address: " + m_cdn_info.ip_vec[i]);
				}

				Globals.s_logger.debug("HandleCEventVideoRoomGetLiveCDNRes() : Globals.iframeRoomID = " + Globals.iframeRoomID);

				if (Globals.iframeRoomID != 0) {
					Globals.s_logger.log("HandleCEventVideoRoomGetLiveCDNRes() : 获取vid");
					m_client.GetUICallback().GetVideoRoomLiveInfo();
					return;
				}

				if (m_start_watch_waiting_cdn) {
					m_start_watch_waiting_cdn = false;
					StartWatchLive(m_cdn_info, m_live_detail.anchor_pstid, VidToWatch());
					//推一个清晰度的消息给页面（160）
					AutoChooseDefinition();
					GetCurrentAvailableDefinition();
				}

				if (m_start_watch_invited_anchor_waiting_cdn) {
					m_start_watch_invited_anchor_waiting_cdn = false;
					StartWatchInvitedAnchorLive(m_cdn_info, m_live_detail.split_screen_info.anchorId, m_live_detail.split_screen_info.vid);
				}

				requareCndTimes = 3 //重置
				//tqos上报 begin
				TQOSCDNHttpRequest.nConnBeginTime = flash.utils.getTimer();
				//tqos上报 end
			} else {
				m_base.StartWatchLive(1);
				//推一个清晰度的消息给页面（160）
				AutoChooseDefinition();
				GetCurrentAvailableDefinition();
			}
		}

		private function UpdateLiveStatus(old_status:VideoRoomLiveStatus, new_status:VideoRoomLiveStatus):void 
		{
			if (!old_status.equal(new_status)) 
			{
				if (!old_status.anchor_pstid.isZero()) {
					StopWatchLive();
				}
				if (!new_status.anchor_pstid.isZero())
				{
					//ExternalInterface.call("console.log","AutoChooseDefinition:UpdateLiveStatus");
					m_live_detail.extra_vid = new_status.extra_vid;
					AutoChooseDefinition();
					TryStartWatchLive();
				}
				else
				{
					m_base.SetCurrentVid(0);
				}	
			}
		}
		
		private function VidToWatch():int
		{
			if(m_live_detail.vid2 != 0)
			{
				return m_live_detail.vid2;
			}
			else
			{
				return m_current_vid;
			}
		}
		
		private function TryStartWatchLive():void
		{
			if (m_cdn_info.ip_vec != null && m_cdn_info.ip_vec.length > 0)
			{
				m_start_watch_waiting_cdn = false;
				StartWatchLive(m_cdn_info, m_live_detail.anchor_pstid, VidToWatch());
			}
			else
			{
				m_start_watch_waiting_cdn = true;
			}
		}
		
		private function StartWatchLive(cdn:LiveCDNInfo, anchor_pstid:Int64, vid:int):void
		{
			m_base.SetCDNAddress(cdn.ip_vec);
			m_base.SetCurrentVid(vid);
			if(requareCndTimes > 0)
			{
				m_base.StartWatchLive(0);//0表示失败
			}
			else
			{
				m_base.StartWatchLive(1);//1表示成功
			}
			m_watching = true;
		}			
		
		private function StopWatchLive(isChangeDefinition:Boolean = false):void
		{
			m_base.ClearDataWhenStopWatchLive(isChangeDefinition);
			m_start_watch_waiting_cdn = false;
			if(!m_watching)
			{
				return;
			}
			m_watching = false;
			m_base.StopWatchLive();
			
			//tqos上报 begin
			var tqos:TQOSCDNHttpRequest = new TQOSCDNHttpRequest();
			tqos.nConnTotalTime = flash.utils.getTimer() - TQOSCDNHttpRequest.nConnBeginTime;
			tqos.nConnCnt = m_cdn_info.ip_vec.length;
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.Response();
			//tqos上报 end
		}
		
		private function HandleCEventVideoRoomRefreshCurrentAnchorDetail(ev:INetMessage):void
		{
			// 不在房间中的时候，不处理这个消息
			// 以防止在退出房间后，收到这个消息而重新拉取视频流
			if (m_room_id == 0)
			{
				return;
			}
			var evt:CEventVideoRoomRefreshCurrentAnchorDetail = ev as CEventVideoRoomRefreshCurrentAnchorDetail;
			var old_status:VideoRoomLiveStatus = new VideoRoomLiveStatus;
			GetLiveStatus(old_status);
			Globals.s_logger.debug("HandleCEventVideoRoomRefreshCurrentAnchorDetail()  evt.live_detail.popularity = " + evt.live_detail.popularity + "   m_live_detail.popularity =  " + m_live_detail.popularity  + "  evt.live_detail.startlight" + evt.live_detail.startlight + " m_live_detail.startlight = " +m_live_detail.startlight);
			
			var old_split_screen_info:SplitScreenInfo = new SplitScreenInfo();
			GetSplitScreenInfo( old_split_screen_info );
			
			//x51VideoWeb.RefreshAnchorInfoByData方法中也有更新缓存本地数据问题。
			var old_vid2:int = m_live_detail.vid2;
			if (m_live_detail.vid != evt.live_detail.vid) {
				m_live_detail = evt.live_detail;
			} else if (m_live_detail.anchor_pstid.equal(evt.live_detail.anchor_pstid) == false) {
				m_live_detail = evt.live_detail;
			}
			//XW79794 去除头像随机数  主播头像变化更新数据
			else if(m_live_detail.m_anchor_url != evt.live_detail.m_anchor_url){
				m_live_detail = evt.live_detail;
			} else if (m_live_detail.anchor_badge != evt.live_detail.anchor_badge) {
				m_live_detail = evt.live_detail;
			} 
			//XW79541 人气的时候只刷大的不刷小
			else if (m_live_detail.popularity < evt.live_detail.popularity) {
				m_live_detail = evt.live_detail;
			} else if (m_live_detail.startlight < evt.live_detail.startlight) {
				m_live_detail = evt.live_detail;
			} else if (m_live_detail.anchor_level != evt.live_detail.anchor_level) {
				//等级——只增不减
				if (m_live_detail.anchor_level < evt.live_detail.anchor_level) {
					m_live_detail = evt.live_detail;
				}
			}
			//等级相同的情况下看经验
			else if (m_live_detail.anchor_level == evt.live_detail.anchor_level
				&& m_live_detail.anchor_exp < evt.live_detail.anchor_exp) {
				m_live_detail = evt.live_detail;
			} else if (m_live_detail.followed != evt.live_detail.followed) {
				m_live_detail = evt.live_detail;
			}
			//等级经验都相同的情况下看瓶颈个数
			else if (m_live_detail.anchor_level == evt.live_detail.anchor_level) {
				if (evt.live_detail.is_bottleneck != m_live_detail.is_bottleneck) {
					if (evt.live_detail.is_bottleneck) {
						m_live_detail = evt.live_detail;
					}
				} else if (m_live_detail.anchor_exp == evt.live_detail.anchor_exp) {
					if (m_live_detail.bottleneck_count < evt.live_detail.bottleneck_count) {
						m_live_detail = evt.live_detail;
					}
				} else if (m_live_detail.anchor_exp > evt.live_detail.anchor_exp) {
					//防坑判断
					if (evt.live_detail.bottleneck_count >= 0 && evt.live_detail.bottleneck_need_count > 0
						&& m_live_detail.bottleneck_need_count <= 0) {
						m_live_detail = evt.live_detail;
					}
				}
			}

			var new_status:VideoRoomLiveStatus = new VideoRoomLiveStatus;
			GetLiveStatus(new_status);

			var new_split_screen_info:SplitScreenInfo = new SplitScreenInfo();
			GetSplitScreenInfo(new_split_screen_info);

			RefreshAnchorInfo();

			if (!old_status.anchor_pstid.equal(new_status.anchor_pstid)
				&& old_status.start_time != new_status.start_time
				&& old_status.vid != new_status.vid) {
				if (m_live_detail.anchor_pstid.isZero())
				{
					SetVideoRoomStatus(VideoRoomState.VRS_OPEN);
				}
				else
				{
					SetVideoRoomStatus(VideoRoomState.VRS_LIVE);
				}
				
				RefreshRoomStatus();
				UpdateLiveStatus(old_status, new_status);
			}
			else if( m_status == VideoRoomState.VRS_LIVE)
			{
				var new_vid2:int = m_live_detail.vid2;
				if(old_vid2 == 0 && new_vid2 != 0)
				{
					m_base.SetCDNAddress(m_cdn_info.ip_vec);
					m_base.SetCurrentVid(VidToWatch());
					m_base.StartVideoShare(VidToWatch(),m_cdn_info.ip_vec);
				}
				else if(old_vid2 != 0 && new_vid2 == 0)
				{
					m_base.SetCDNAddress(m_cdn_info.ip_vec);
					m_base.SetCurrentVid(VidToWatch());
					m_base.StopVideoShare();
				}
			}
			UpdateSplitScreenLiveStatus(old_split_screen_info, new_split_screen_info);
		}
		private function HandleCEventVideoRoomNotifyLiveStart(ev:INetMessage):void
		{
			var evt:CEventVideoRoomNotifyLiveStart = ev as CEventVideoRoomNotifyLiveStart;
			
			isNestRoomStopLive = false;
			if(m_room_id == evt.room_id)
			{
				if ( m_client.GetVideoClientPlayer() )
					m_client.GetVideoClientPlayer().UpdateFollowedAnchorStartTime(evt.anchor_id, uint(evt.start_time.toNumber()));
				
				var old_status:VideoRoomLiveStatus = new VideoRoomLiveStatus;
				GetLiveStatus(old_status);
				
				var old_split_screen_info:SplitScreenInfo = new SplitScreenInfo();
				GetSplitScreenInfo( old_split_screen_info );
				
				m_live_detail = evt.detail;
				SetVideoRoomStatus(VideoRoomState.VRS_LIVE);
				
				var new_status:VideoRoomLiveStatus = new VideoRoomLiveStatus;
				GetLiveStatus(new_status);
				
				var new_split_screen_info:SplitScreenInfo = new SplitScreenInfo();
				GetSplitScreenInfo(new_split_screen_info);
				
				RefreshRoomStatus();
				RefreshAnchorInfo();
				RefreshRoomInfo();
				UpdateLiveStatus(old_status, new_status);
				UpdateSplitScreenLiveStatus(old_split_screen_info, new_split_screen_info);
				m_base.GetSurpriseBoxManager().OnStartLive();
				
				m_cur_giftpool_height = 0;
				m_continually_board_vgid.setZero();

				//推一个清晰度的消息给页面（160）
				AutoChooseDefinition();
				GetCurrentAvailableDefinition();
			}
			else if ( m_client.GetVideoClientPlayer() )
			{
				
				if (!m_client.GetVideoClientPlayer().NeedNotifyLiveStart(evt.anchor_id, uint(evt.start_time)))
				{
					return;
				}
					
				m_client.GetVideoClientPlayer().UpdateFollowedAnchorStartTime(evt.anchor_id, uint( evt.start_time) );
				
				var portrait_url:String = "";
				OlinePictureDef. GetVideoAnchorPortraitDownloadUrl(	m_base.GetPicDownloadUrl(),
					this.m_client.GetCallCenter().GetZoneId(),
					evt.detail.anchor_pstid.toNumber());
				m_client.GetUICallback().OnFollowingAnchorLiveStartNotify(evt.detail.name,evt.room_id,portrait_url);
			}
		}
		
		private function HandleCEventVideoRoomRefreshLiveStatus(ev:INetMessage):void
		{
			var evt:CEventVideoRoomRefreshLiveStatus = ev as CEventVideoRoomRefreshLiveStatus;
			var old_status:VideoRoomLiveStatus = new VideoRoomLiveStatus;
			
			GetLiveStatus(old_status);
			if ( !old_status.anchor_pstid.equal(evt.live_status.anchor_pstid)
				|| old_status.start_time != evt.live_status.start_time
				|| old_status.vid != evt.live_status.vid)
			{
				m_live_detail = new VideoRoomLiveStatusDetail;
				m_live_detail.anchor_pstid = evt.live_status.anchor_pstid;
				m_live_detail.start_time = evt.live_status.start_time;
				m_live_detail.vid = evt.live_status.vid;
				m_live_detail.anchor_device_type = evt.live_status.anchor_device_type;
				m_live_detail.is_vertical_live = evt.live_status.is_vertical_live;
				if (m_live_detail.anchor_pstid.isZero())
				{
					SetVideoRoomStatus(VideoRoomState.VRS_OPEN);
				}
				else
				{
					SetVideoRoomStatus(VideoRoomState.VRS_LIVE);
				}
				
				RefreshRoomStatus();
				RefreshAnchorInfo();
				UpdateLiveStatus(old_status, evt.live_status);
			}
			
			var old_split_screen_info:SplitScreenInfo = new SplitScreenInfo;
			GetSplitScreenInfo( old_split_screen_info);
			if(!IsEqualScreenInfo(old_split_screen_info,evt.split_screen_info))
			{
				m_live_detail.split_screen_info = evt.split_screen_info;
				UpdateSplitScreenLiveStatus(old_split_screen_info, evt.split_screen_info);
			}
		}
		
		private var isNestRoomStopLive:Boolean = false;
		public function GetIsNestRoolStopLive():Boolean
		{
			return isNestRoomStopLive;
		}
		private function HandleCEventVideoRoomNotifyLiveStop(ev:INetMessage):void
		{
			var evt:CEventVideoRoomNotifyLiveStop = ev as CEventVideoRoomNotifyLiveStop;
			
			if(!m_is_nest_room)
			{
				m_live_detail = new VideoRoomLiveStatusDetail();
				curretnAnchorID = "";
				currentAnchorUrl = "";
			}
			else
			{
				isNestRoomStopLive = true;
			}
			m_current_definition = VideoDefinitionID.VDID_FLUENT;
			m_current_vid = 0;
			SetVideoRoomStatus(VideoRoomState.VRS_OPEN);
			RefreshRoomStatus();
			
			RefreshAnchorInfo();
			StopWatchLive();
			
			m_base.SetCurrentVid(0);
			
			if (m_stop_live_waiting_notify)
			{
				m_stop_live_waiting_notify = false;
			}
		}
		
		private function RefreshAnchorInfo():void
		{	
			var anchor_data:ClientAnchorData = new ClientAnchorData;
			var vgc:IVideoGuildClient = m_base.GetVideoGuildClient();
			if(vgc != null)
			{
				vgc.SetCurrLivingAnchorPstid(m_live_detail.anchor_pstid.toString());
			}

			GetCurrentAnchorDataForUI(anchor_data);

			var isFollow:Boolean = 	m_client.GetVideoClientPlayer().IsFollowingAnchor(Int64.fromJsonNode(anchor_data.anchorID));
			m_client.GetUICallback().RefreshAnchorInfoByData(anchor_data,isFollow, Globals.room_name);	
		}
		
		public function GetCurrentAnchorDataForUI(data:ClientAnchorData):void
		{
			ConvertLiveDetail2ClientAnchorData(m_live_detail, data);
			if (!data.anchorQQ == "")
			{
				m_base.FillAnchorImageUrl(data);
			}
		}
		
		private var curretnAnchorID:String = "";
		private var currentAnchorPhotoUrl:String = "";
		private var currentAnchorUrl:String = "";
		private function ConvertLiveDetail2ClientAnchorData(info:VideoRoomLiveStatusDetail, data:ClientAnchorData):void
		{
			Globals.s_logger.debug("ConvertLiveDetail2ClientAnchorData()  info.anchor_badge = " + info.anchor_badge);
			
			data.anchorID = info.anchor_pstid.toString();
			data.anchorQQ = info.anchor_pstid.toString();
			data.male = info.sex == 1;//SEX_Male = 1男性
			data.name = info.name.replace(Pattern,"\\\\");
			data.intro = info.description.replace(Pattern,"\\\\");
			data.popularity = info.popularity.toString();
			data.starlight = info.startlight.toString();
			data.twoweek_starlight = info.twoweek_starlight.toString();
			data.from = info.place;
			data.followedAudiences = info.followed;
			data.deputy_name = info.deputy_anchor_name;
			data.deputy_zone_name = info.deputy_anchor_zone_name.replace(Pattern,"\\\\");
			data.talent_show_rank = info.talent_show_rank;
			data.star_anchor = info.star_anchor;
			data.m_pk_anchor_winner_order = info.pk_winner_order;
			data.m_starlight_today_needed = info.starlight_needed;
			data.m_impression_data.m_total_count = info.impression.total_count;
			data.m_impression_data.m_player_count = info.impression.player_count;
			data.anchor_level = info.anchor_level;
			data.anchor_exp = info.anchor_exp;
			data.anchor_levelup_exp = info.anchor_levelup_exp;
			data.is_bottleneck = info.is_bottleneck;
			data.bottleneck_count = info.bottleneck_count;
			data.bottleneck_need_count = info.bottleneck_need_count;
			data.bottleneck_gift_id = info.bottleneck_gift_id;
			data.starlight_rest_exp_today = info.starlight_rest_exp_today;
			data.dream_gift_rest_exp_today = info.dream_gift_rest_exp_today;
			data.anchor_badge = info.anchor_badge;
			data.lucky_draw_rest_exp_today = info.lucky_draw_rest_exp_tody;
			//XW79794 去除头像随机数
			//为了防止玩家送礼频繁拉取主播头像
			if(curretnAnchorID != data.anchorID || (currentAnchorUrl != info.m_anchor_url))
			{
				curretnAnchorID = data.anchorID;
				currentAnchorUrl = info.m_anchor_url;
				if(info.m_anchor_url != "")
				{
					//XW79794 去除头像随机数
					data.photoUrl =Globals.m_pic_download_url + "/qdancersec/" +  info.m_anchor_url;//+ "/0" + URLSuffix.CreateVersionString();
				}
				currentAnchorPhotoUrl =  data.photoUrl;
			}
			else
			{
				data.photoUrl = currentAnchorPhotoUrl;
			}
			
			var impression:AnchorImpressionDataServer = info.impression;
			GetAnchorImpressionForUI(data.m_impression_data.m_impressions, impression);
		}
		
		private function GetAnchorImpressionForUI(data:Array,server_data:AnchorImpressionDataServer):void
		{
			var impcfg:IImpressionConfig = m_client.GetImpressionConfig();
			var impression_list:Array = server_data.impressions;
			for each (var tdata:AnchorImpressionData in impression_list)
			{
				var temp:AnchorImpressionDataForUI = new AnchorImpressionDataForUI;
				temp.m_impression_id = tdata.impression_id;
				temp.m_impression_name = impcfg.GetImpressionName(tdata.impression_id);
				temp.m_count = tdata.count;
				data.push(temp);
			}
		}
		
		public function IsLive():Boolean
		{
			return m_status == VideoRoomState.VRS_LIVE;
		}
		
		public function isNest():Boolean
		{
			return m_is_nest_room;
		}
		
		public function IsAnchorPKing():Boolean
		{
			var state:int = m_client.GetLogicInternal().GetAnchorPKClient().GetAnchorPKActivityStatus();
			if (state != AnchorPKActivityStatus.APAS_None)
			{
				return true;
			}
			return false;
		}
		
		public function GetChatCDTime(ignore_manual_setting :Boolean):int
		{
			if(ignore_manual_setting)
			{
				return m_server_chat_cd_time;
			}
			const video_chat_min_cd_time:int = 1000; // 最小1s
			var set_chat_cd:int = (m_open_chat_cd_check ? m_chat_cd_time : video_chat_min_cd_time);
			
			return ((set_chat_cd > m_server_chat_cd_time) ? set_chat_cd : m_server_chat_cd_time);
		}
		
		
		public function VideoCanChat(channelID:int, forbid_public_chat:Boolean, open_chat_cd_check:Boolean, anchor_or_admin:Boolean, chat_cd_time:int,last_chat_time:uint):int
		{
			
			var time :Timer;
			var res:int = VideoChatErrorCode.VIDEO_CHAT_SUCCESS;
			if(channelID != CHNL_TYPE.CHNL_VIDEOROOM_PUBLIC)
			{
				return res;
			}
			
			if(forbid_public_chat)
			{
				res = (anchor_or_admin ? VideoChatErrorCode.VIDEO_CHAT_SUCCESS : VideoChatErrorCode.VIDEO_CHAT_PUBLIC_FORBIDDEN);
			}
			if(res == VideoChatErrorCode.VIDEO_CHAT_SUCCESS)
			{
				if(open_chat_cd_check)
				{
					var nowTime:uint = getTimer();
					res = ((( nowTime- last_chat_time) > chat_cd_time) ? VideoChatErrorCode.VIDEO_CHAT_SUCCESS : VideoChatErrorCode.VIDEO_CHAT_CHAT_CD);
				}
			}
			return res;
		}
		
		public function CanChat(channelID:int, anchor_or_admin:Boolean,guard_chat_cd:Boolean):int
		{
			return VideoCanChat(channelID, m_forbid_public_chat, true, anchor_or_admin, GetChatCDTime(anchor_or_admin || guard_chat_cd), m_last_chat_time);
		}
		
		//聊天信息里是否包含守护专属表情
		private function isContainGuardExpression(msg:String):Boolean
		{
			var isContain:Boolean = false;
			
			for each(var str:String in guard_expression)
			{
				if(msg.indexOf(str) != -1)
				{
					isContain = true;
					break;
				}
			}
			return isContain;
		}
		
		private function isContainPrivilExpression(msg:String):Boolean
		{		
			for each(var str:String in privil_expression1_t)
			{
				Globals.s_logger.debug("isContainPrivilExpression()  msg = " + msg + "   str =  " + str  +  "   msg.indexOf(str) =  "+ + msg.indexOf(str));
				if(msg.indexOf(str) != -1)
				{
					return true;//包含特权表情1
				}
			}
			return false;
		}
		
		private function isContainPrivil2Expression(msg:String):Boolean
		{
			for each(var ss:String in privil_expression2_s)
			{
				if(msg.indexOf(ss) != -1)
				{
					return true;//包含特权表情2
				}
			}
			return false;
		}

		//XW78838 使用新的正则表达式 对全角符号经行判断
		private var pattern:RegExp = /[^\x00-\xff]/g;
//		private var pattern:RegExp=/[\u4e00-\u9fa5]/g;
		private var firstSendChatMsg:Boolean = true;

		
		public function SendChatMsg( msg_content:String, channelID:int, recver_id:Int64, recverName:String, recverZoneName:String, is_audience:Boolean,guard_chat_cd:Boolean):void 
		{
			
			if(msg_content.length == 0)
			{
				return;
			}

			var chCharLen:int = msg_content.match(pattern).length;
//			var signLen:int = msg_content.match(regnSig).length;

			var tmplen:int = msg_content.length + chCharLen;
			var msg_data:VideoRoomMsgData = new VideoRoomMsgData;

			msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			msg_data.systemType = 0;
			//如果是飞屏长度超过限制
			if(channelID == VideoChatChannel.VIDEOCHNL_Whistle && tmplen > 100)
			{
				msg_data.msg = "$t$对不起，您输入的字符超过限制! 最多只能输入47个中文或者95个英文字符$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
			
			//根据守护限制长度
			var guardLevel:int = m_base.GetPlayerGuardLevel();
			if(guardConfig != null)
			{
				chatlength = guardConfig.GetSWordNum(guardLevel);
			}
			
			if(tmplen > chatlength + 5 && channelID != VideoChatChannel.VIDEOCHNL_Whistle)
			{
				var uilen:int = Math.floor(chatlength/2);
				msg_data.msg = "$t$对不起，您输入的字符超过限制!" + "您最多只能一次输入"+uilen+"个中文或"+chatlength+"个英文字符$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
			
			if( channelID == VideoChatChannel.VIDEOCHNL_Private && isContainGuardExpression( msg_content ))
			{
				msg_data.msg = "$t$对不起，守护专属表情只能用于梦工厂公聊频道$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
			//守护表情是否有权限			
			if(guardLevel < 20 && isContainGuardExpression(msg_content))//&& channelID != VideoChatChannel.VIDEOCHNL_Whistle
			{				
				msg_data.msg = "$t$对不起，只有中级守护或以上的玩家才能使用守护专属表情$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
			//特权表情，我的成长等级
			var credit_level:int = m_client.GetVideoClientPlayer().GetNestCreditsLevel();
//			Globals.s_logger.debug( "特权表情   " + credit_level  + ".msg:" + msg_content );
			if(credit_level <2 && isContainPrivilExpression(msg_content) )
			{				
				msg_data.msg = "$t$对不起，只有头衔等级达到LV2或以上的玩家才能使用1级头衔特权专属表情$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
			
			if( credit_level <4 && isContainPrivil2Expression(msg_content)  )
			{
				msg_data.msg = "$t$对不起，只有头衔等级达到LV4或以上的玩家才能使用2级头衔特权专属表情$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
//			Globals.s_logger.debug( " 检查特权表情 end");
			const MaxMessageToServerAnchorLength: int= 512;//主播和管理员聊天文字数量（字节）
			var check_res:int = VideoChatErrorCode.VIDEO_CHAT_SUCCESS;
			//判断是否全房间禁言
			if(channelID == VideoChatChannel.VIDEOCHNL_Public){
				//判断如果是公聊或者私聊频道，则判断当前房间是否处于禁言状态
				if(Globals.room_ban_notice){
					if(Globals.room_banned){
						check_res = VideoChatErrorCode.VIDEO_CHAT_PUBLIC_FORBIDDEN;
						msg_data.msg = "$t$对不起，当前房间关闭了公众聊天$z";
						msg_data.res_forbid_public_chat = true;
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						return ;
					}
				}else{
					if(Globals.room_forbid_all){
						check_res = VideoChatErrorCode.VIDEO_CHAT_PUBLIC_FORBIDDEN;
						msg_data.msg = "$t$对不起，当前房间关闭了公众聊天$z";
						msg_data.res_forbid_public_chat = true;
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						return ;
					}
				}
			}
			var msg:VideoToServerChatMessage = new VideoToServerChatMessage ;
			msg.recver_zoneName = recverZoneName;
			msg.recver_name = recverName;
			msg.recver_id = recver_id;
//			Globals.s_logger.debug("SendChatMsg() check_res1 = " + check_res);
			if(msg_content.length >= MaxMessageToServerAnchorLength)//主播和管理员不大于MaxMessageToServerAnchorLength=400
			{
				var msgtxt :String = msg_content.slice(0,MaxMessageToServerAnchorLength);
				msg.message = msg_content;
			}
			else 
			{
				msg.message = msg_content;
			}
			
			switch(channelID)
			{
				case VideoChatChannel.VIDEOCHNL_Public:
					msg.type = CHNL_TYPE.CHNL_VIDEOROOM_PUBLIC;
					break;
				case VideoChatChannel.VIDEOCHNL_Private:
					msg.type = CHNL_TYPE.CHNL_VIDEOROOM_PRIVATE;
					break;
				case VideoChatChannel.VIDEOCHNL_Whistle:
					msg.type = CHNL_TYPE.CHNL_VIDEOROOM_WHISTLE;
					if( !IsLive())
					{
						check_res = VideoChatErrorCode.VIDEO_CHAT_WHISTLE_NEED_LIVING;
					}
					break;
				case VideoChatChannel.VIDEOCHNL_Guild:
					msg.type = CHNL_TYPE.CHNL_VIDEOROOM_GUILD;
					break;
				case VideoChatChannel.VIDEOCHNL_SUPERSTARHORN:
					msg.type = CHNL_TYPE.CHNL_VIDEOROOM_SUPERSTARHORN;
					break;
				default:
					return;
			}
			if(check_res == VideoChatErrorCode.VIDEO_CHAT_SUCCESS)
			{
				check_res = CanChat(msg.type, !is_audience,guard_chat_cd);
			}
			Globals.s_logger.debug("SendChatMsg check_res = " + check_res );
			if(check_res != VideoChatErrorCode.VIDEO_CHAT_SUCCESS && !firstSendChatMsg)
			{
				var cd_time:int = 0;
				var wait_time:int = 0;
				
				switch(check_res)
				{
//					case VideoChatErrorCode.VIDEO_CHAT_PUBLIC_FORBIDDEN:
//						msg_data.msg = "$t$对不起，当前房间关闭了公众聊天$z";
//						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
//						break;
					case VideoChatErrorCode.VIDEO_CHAT_CHAT_CD:
						cd_time = GetChatCDTime(!is_audience || guard_chat_cd);
						wait_time = (cd_time - (getTimer() - m_last_chat_time));
						msg_data.msg = "$t$房间管理员限制文字聊天的速度，每" + Math.ceil(cd_time/1000) + "秒可发送一次！请" + Math.ceil(wait_time/1000) + "秒后再发送文字$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_WHISTLE_NEED_LIVING:
						msg_data.msg = "$t$对不起，只有在直播中才能使用飞屏$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_BAN:
						msg_data.msg = "$t$对不起，您暂时被管理员禁止发言$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_PerpetualBan:
						msg_data.msg = "$t$对不起，您在本房间被永久禁言$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_PUBLIC_COOL_DOWN:
						cd_time = GetChatCDTime(!is_audience || guard_chat_cd);
						wait_time = (cd_time - (getTimer() - m_last_chat_time));
						msg_data.msg = "$t$亲，当前发言太热烈了~请" + Math.ceil(wait_time/1000) + "秒后再发言！$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_WHISTLE_NO_BAN:
						msg_data.msg = "$t$您已被管理员禁言,无法使用飞屏。$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_NO_FREE_WHISTLE:
						msg_data.msg = "$t$免费飞屏已经用完啦~$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_WHISTLE_SWITCH_BAN_WHISTLE:
						msg_data.msg = "$t$管理员关闭了当前房间的飞屏功能$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_BAN_ALL_ROOM:
						msg_data.msg = "$t$对不起，您在本房间已被永久禁言$z";
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
					case VideoChatErrorCode.VIDEO_CHAT_NOT_FIND_TARGET:
						msg_data.msg = "$t$对不起，无法联系到该玩家或者该玩家不在房间中$z";
						msg_data.systemType = 3;//私聊找不到玩家
						msg_data.TextColor = WebColor.privateChatNotFountPlayer;
						m_client.GetUICallback().OnReceiveChatMsg(msg_data);
						break;
				}
				return;
			}
			Globals.s_logger.debug("SendChatMsg : msg = " + msg.message);
			msg.roomid = GetRoomID();
			var event : CEventVideoToServerChatMessage  = new CEventVideoToServerChatMessage;
			event.SetMessage(msg);
			m_client.SendEvent(event,Globals.SelfRoomID);

			m_last_chat_time = getTimer();
		}
		
		private function HandleCEventVideoRoomNotifyAttachRoomInfo(ev:INetMessage):void
		{
			var evt:CEventVideoRoomNotifyAttachRoomInfo = ev as CEventVideoRoomNotifyAttachRoomInfo;
			if(evt == null)
				return;
			m_attached_room_id = evt.room_id;
			m_attached_anchor = evt.anchor_name;
			m_attached_room_name = evt. room_name;
			RefreshRoomInfo();
		}
		
		private function HandleVideoRoomPlayerCount(ev:INetMessage):void
		{
			var evt:CEventVideoRoomPlayerCount = ev as CEventVideoRoomPlayerCount;
			m_audience_count = evt.player_count;
			m_server_chat_cd_time = evt.default_chat_cd;
			if(evt.player_count > 0){
				m_player_capacity = evt.player_capacity;
			}
			
			
			m_client.GetUICallback().OnRefreshConcertTotalPlayers(evt.player_count);
			
			/*
			var lastNum:int = 0;
			var nowNum:int = 0;
			
			//如果是演唱会房间，则要统计累计观看人数
			if(m_concert)
			{
				var random1:Number = 0;
				var xishu:Number = 0;
				var beishu:Number = 0;
				var cookie:Cookie = new Cookie("x51webConcert");
				
				if(cookie.getData("concertRoomTotalPlayerCount") != null)
					lastNum = cookie.getData("concertRoomTotalPlayerCount");
				
				var currentTime:Number = new Date().time;
				
				beishu = lastNum / evt.player_count;
				
				if(lastNum == 0 || lastNum <= evt.player_count)
				{
					random1 = Math.random()*0.3;
					nowNum = evt.player_count + Math.floor(random1*evt.player_count);
				}
				else 
				{
					var lastTime:Number = cookie.getData("lastTime");
					var diffTime:Number = Math.floor((currentTime - lastTime)/1000);//单位秒
					if(beishu < 2.5)
						xishu = Math.random()*0.4+0.8;
					else if(beishu <3)
						xishu =  0.75;
					else if(beishu < 4)
						xishu = 0.6;
					else
						xishu =0.4;
					
					nowNum = lastNum + Math.ceil((diffTime*evt.player_count/6*5*0.02/60 + evt.player_count/6*0.04/60) * xishu);
				}
				cookie.flushData("concertRoomTotalPlayerCount",nowNum);
				cookie.flushData("lastTime",currentTime);
				m_client.GetUICallback().OnRefreshConcertTotalPlayers(nowNum);
			}*/
			
			if(m_client.GetUICallback() != null)
			{
				m_client.GetUICallback().RefreshRoomPlayerCount(m_room_id, evt.player_count, m_player_capacity);
			}
		}


		private function HandleCEventVideoRoomRefreshRoomAttribute(ev:INetMessage):void
		{
			var evt:CEventVideoRoomRefreshRoomAttribute = ev as CEventVideoRoomRefreshRoomAttribute;
			m_room_name = evt.room_name;
			Globals.room_name = evt.room_name;
			m_forbid_public_chat = evt.forbid_public_chat;
			m_open_chat_cd_check = evt.open_chat_cd_check;
			m_chat_cd_time = evt.chat_cd_time;
			m_player_capacity = evt.player_capacity;
			m_client.GetUICallback().RefreshRoomName(evt.room_name);
			m_client.GetUICallback().RefreshRoomPlayerCount(GetRoomID(), m_audience_count, m_player_capacity);
		}
		private var m_vip_cnt_info:Dictionary = new Dictionary;
		private var m_vip_addition:int = 0;
		
		private function HandleCEventVideoGiftPoolHeightChange(ev:INetMessage):void
		{
			var evt:CEventVideoGiftPoolHeightChange = ev as CEventVideoGiftPoolHeightChange;
			
			if(evt == null || evt.room_id != GetRoomID())
			{
				return;
			}
			
			
			m_cur_giftpool_height = evt.cur_height;
			m_max_giftpool_height = evt.max_height;
			
			m_vip_cnt_info = evt.vip_cnt_info;
			m_vip_addition = evt.vip_addition;
			
			var levelCount:Array = new Array;
			
			for (var key:String in m_vip_cnt_info)
			{
				var tmp:VipLevelCount = new VipLevelCount;
				tmp.level = int(key);
				tmp.count = m_vip_cnt_info[key];
				tmp.vipname = vipConfig.GetVipName(tmp.level);
				levelCount.push(tmp);
			}
			Globals.s_logger.debug("HandleCEventVideoGiftPoolHeightChange res = " + JSON.stringify(evt));
			m_client.GetUICallback().RefreshGiftPoolHeight(evt.cur_height, evt.max_height,evt.vip_addition,levelCount,null);
			
			//设置宝箱状态std::vector<VideoRoomTreasureBoxData> m_vecTreasureBox;
			var Boxindex:int = 0;
			for each(var boxdata:VideoRoomTreasureBoxData in m_vecTreasureBox)
			{
				boxdata.status =VideoRoomTreasureBoxStatus.VRTBS_CannotOpen;
				
				var iscontainboxindex:Boolean = false;
				for each(var index:int in evt.hasBeenOpenedBox)
				{
					if(index == boxdata.index)
					{
						iscontainboxindex = true;
						break;
					}
				}
				
				if(iscontainboxindex)
				{
					boxdata.status = VideoRoomTreasureBoxStatus.VRTBS_Opened;
				}
				else if(boxdata.require <= m_cur_giftpool_height)
				{
					boxdata.status = VideoRoomTreasureBoxStatus.VRTBS_CanOpen;
				}
				
				m_vecTreasureBox[Boxindex++].status = boxdata.status;
				
			}
			m_client.GetUICallback().OnLoadTreasureBoxData(VideoResultType.VREST_Normal, LoadTreasureBoxDataRes.LTBDR_InitBoxData, evt.room_id, -1, m_vecTreasureBox);
		}
		
		private function HandleCEventVideoGetGiftPoolBoxInfoRes(ev:INetMessage):void
		{
			var evt:CEventVideoGetGiftPoolBoxInfoRes = ev as CEventVideoGetGiftPoolBoxInfoRes;
			if(evt == null || evt.room_id != GetRoomID())
			{
				return;
			}
			
			m_cur_giftpool_height = evt.cur_height;
			m_max_giftpool_height = evt.max_height;
			m_vip_cnt_info = evt.vip_cnt_info;
			var levelCount:Array = new Array;
			
			for (var key:String in m_vip_cnt_info)
			{
				var tmp:VipLevelCount = new VipLevelCount;
				tmp.level = int(key);
				tmp.count = m_vip_cnt_info[key];
				tmp.vipname = vipConfig.GetVipName(tmp.level);
				levelCount.push(tmp);
			}
			Globals.s_logger.debug("HandleCEventVideoGetGiftPoolBoxInfoRes res = " + JSON.stringify(evt));
			m_client.GetUICallback().RefreshGiftPoolHeight( m_cur_giftpool_height, m_max_giftpool_height,evt.vip_addition,levelCount,evt.box_data_buf);
			
			//消息内容转换成客户端接口格式
			ConvertToTreasureBoxDataBuf(evt.box_data_buf, evt.cur_height, m_client.IsSelfMale(), m_vecTreasureBox);
			
			m_vip_cnt_info = evt.vip_cnt_info;
			m_vip_addition = evt.vip_addition;
			
			m_client.GetUICallback().OnLoadTreasureBoxData(VideoResultType.VREST_Normal, evt.result, evt.room_id, -1, m_vecTreasureBox);
			
			
			if(evt.result == LoadTreasureBoxDataRes.LTBDR_ResetBoxData )
			{
				var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
				msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
				msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
				msg_data.msg = "$t$热度宝箱全部开启，现已重置咯，快来和主播一起炒热气氛，等待再次惊喜降临吧$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				return;
			}
		}
		
		private function HandleCEventLoadNestListRes( ev:INetMessage):void
		{
			var evt:CEventLoadNestListRes = ev as CEventLoadNestListRes;
			if(evt == null)
			{
				return;
			}
			
			var info_list:Array = new Array ;
			var logic_data_list:Array  = evt.nest_info_logic;
			for(var idx:int = 0; idx<logic_data_list.length; idx++)
			{
				var nestinfo:NestInfoLogicData = logic_data_list[idx];
				var info:NestInfoForUI = new NestInfoForUI;
				
				info.nest_id =nestinfo.nest_id;
				info.nest_name = nestinfo.nest_name;
				info.on_line_count = nestinfo.on_line_count;
				info.nest_popularity =nestinfo.nest_popularity.toString();
				
				info.nest_status = nestinfo.is_live;//pc两个枚举是一样的，直接转换了
				info.anchor_level = nestinfo.anchor_level;
				
				info.anchor_name = nestinfo.anchor_name;
				info.pic_url = Globals.m_pic_download_url + "/qdancersec/" + nestinfo.anchor_posing_url + "/0" + URLSuffix.CreateVersionString();;
				info_list.push(info);
			}
			
			m_client.GetUICallback().OnGetNestListRes(evt.is_out_of_room, info_list,evt.attached_room_id, evt.attached_room_name);
		}

		public function HandleCEventIgnoreFreeGiftRes(ev:INetMessage):void
		{
			var evt:CEventIgnoreFreeGiftRes = ev as CEventIgnoreFreeGiftRes;
			m_client.GetUICallback().onIgnoreFreeGiftRes(evt.res, evt.is_ignore);
		}

		//============幸运抽奖 start============
		public function OpenLuckyDrawWindow(begin_time:int=-1, config_refresh_time:int=-1):void {
			var ev:CEventVideoRoomOpenLuckyDrawWindow = new CEventVideoRoomOpenLuckyDrawWindow();
			if (begin_time < 0) {
				if (LuckyDrawConfig.instance.confitData != null) {
					begin_time = LuckyDrawConfig.instance.confitData.begin_time;
				} else {
					begin_time = 0;
				}
			}
			ev.begin_time = begin_time;
			
			if(config_refresh_time < 0){
				config_refresh_time = LuckyDrawConfig.instance.refreshTime;
			}
			ev.config_refresh_time = config_refresh_time;
			m_client.SendEvent(ev, Globals.SelfRoomID);
		}

		public function CloseLuckyDrawWindow():void {
			var ev:CEventVideoRoomCloseLuckyDrawWindow = new CEventVideoRoomCloseLuckyDrawWindow();
			m_client.SendEvent(ev, Globals.SelfRoomID);
		}

		public function LuckyDraw(is_free:Boolean, is_continuous:Boolean, begin_time:int = -1, refreshTime:int = -1):void {
			var ev:CEventVideoRoomLuckyDraw = new CEventVideoRoomLuckyDraw();
			ev.is_free = is_free;
			ev.is_continuous = is_continuous;
			if (begin_time < 0) {
				if (LuckyDrawConfig.instance.confitData != null) {
					begin_time = LuckyDrawConfig.instance.confitData.begin_time;
				} else {
					begin_time = 0;
				}
			}
			ev.begin_time = begin_time;
			if (refreshTime < 0) {
				ev.config_refresh_time = LuckyDrawConfig.instance.refreshTime;
			} else {
				ev.config_refresh_time = refreshTime;
			}
			m_client.SendEvent(ev, Globals.SelfRoomID);
		}
		
		public function HandleCEventVideoRoomLuckyDrawActivityInfo(ev:INetMessage):void {
			var evt:CEventVideoRoomLuckyDrawActivityInfo = ev as CEventVideoRoomLuckyDrawActivityInfo;
			m_client.GetUICallback().OnNotifyLastFreeLuckyDrawTime(
				evt.last_free_lucky_draw_time,
				evt.free_lucky_draw_interval,
				evt.activity_begin_time,
				evt.config_refresh_time);
		}
		
		public function HandleCEventVideoRoomOpenLuckyDrawWindowRes(ev:INetMessage):void {
			var evt:CEventVideoRoomOpenLuckyDrawWindowRes = ev as CEventVideoRoomOpenLuckyDrawWindowRes;

			if (evt.info != null && evt.info.begin_time != 0) {
				LuckyDrawConfig.instance.updateConfig(evt.config_refresh_time, evt.info);
				
				var time:int = LuckyDrawConfig.instance.refreshTime;
				var info:Object = LuckyDrawConfig.instance.confitData;
			} else {
				evt.info = LuckyDrawConfig.instance.confitData;
			}
			
			//转换数据
			var queryRewards:Array                        = [];

			var infoObj:Object                            = new Object();
			infoObj["begin_time"] = evt.info.begin_time;
			infoObj["end_time"] = evt.info.end_time;
			infoObj["continuous_draw_count"] = evt.info.continuous_draw_count;
			infoObj["continuous_draw_reward_id"] = evt.info.continuous_draw_reward_id;
			infoObj["once_draw_price"] = evt.info.once_draw_price;
			infoObj["free_lucky_draw_interval"] = evt.info.free_lucky_draw_interval;
			var rewards:Array         = parseAndSortRewardDataForUI(evt.info.rewards, queryRewards);
			var rewards_x51:Array     = parseAndSortRewardDataForUI(evt.info.rewards_x51, queryRewards);
			Globals.s_logger.debug("here is sub_rewards");
			var sub_rewards:Array     = parseAndSortRewardDataForUI(evt.info.sub_rewards, queryRewards);
			Globals.s_logger.debug("here is sub_rewards:" + JSON.stringify(sub_rewards));
			var sub_rewards_x51:Array = parseAndSortRewardDataForUI(evt.info.sub_rewards_x51, queryRewards);
			var rewards_x52:Array     = parseAndSortRewardDataForUI(evt.info.rewards_x52, queryRewards);
			
			Globals.s_logger.debug("here is x52");
			var sub_rewards_x52:Array = parseAndSortRewardDataForUI(evt.info.sub_rewards_x52, queryRewards);
			infoObj["rewards"] = rewards;
			infoObj["rewards_x51"] = rewards_x51;
			infoObj["sub_rewards"] = sub_rewards;
			infoObj["sub_rewards_x51"] = sub_rewards_x51;
			infoObj["rewards_x52"] = rewards_x52;
			infoObj["sub_rewards_x52"] = sub_rewards_x52;
			
			Globals.s_logger.debug("here is infoObj['sub_rewards_x52']" + JSON.stringify(infoObj["sub_rewards_x52"]));
			infoObj["star_gifts"] = evt.info.star_gifts;
			Globals.s_logger.debug("star_gifts: "+ JSON.stringify(infoObj["star_gifts"]));
			var noticeList:Array;
			var notices:Array         = [];
//			var localNotices:Array    = LuckyDrawConfig.instance.getNoticeList();
//			if (localNotices != null && localNotices.length > 0) {
//				noticeList = localNotices.concat();
//			} else {
//				noticeList = evt.notices;
//				for each (var serverNotice:LuckyDrawNotice in evt.notices) {
//					LuckyDrawConfig.instance.pushNotice(serverNotice);
//				}
//			}
			for each (var notice:LuckyDrawNotice in evt.notices) {
				var noticeObj:Object = new Object();
				noticeObj["nick"] = notice.nick;
				noticeObj["reward"] = parseAndSortRewardDataForUI([notice.reward], queryRewards)[0];
				notices.push(noticeObj);
			}
			Globals.s_logger.debug("notices:  "+JSON.stringify(notices));
			Globals.s_logger.debug("queryRewards:  "+JSON.stringify(queryRewards));
			
			if (queryRewards.length > 0) {
				Globals.s_logger.debug("queryRewards.length > 0");
				m_client.GetReawardCookieManager().GetRewordsInfos(queryRewards, m_client.GetUICallback().OnOpenLuckyDrawWindowRes,
					evt.res, evt.last_free_lucky_draw_time, evt.config_refresh_time, infoObj, notices);
			} else {
				Globals.s_logger.debug("queryRewards.length <= 0");
				m_client.GetUICallback().OnOpenLuckyDrawWindowRes(evt.res,
					evt.last_free_lucky_draw_time, evt.config_refresh_time, infoObj, notices, []);
			}
		}

		public function HandleCEventVideoRoomLuckyDrawRes(ev:INetMessage):void {
			var evt:CEventVideoRoomLuckyDrawRes = ev as CEventVideoRoomLuckyDrawRes;
			//转换数据
			var queryRewards:Array              = [];
			var rewards:Array                   = parseAndSortRewardDataForUI(evt.rewards, queryRewards);

			//更新本地数据
			for each (var rewardUI:RewardDataForUI in rewards) {
				//免费飞屏数量
				if (rewardUI.type == ERewardType.R_Whiste) {
					var req_ev:CEventQueryFreeWhistleLeft = new CEventQueryFreeWhistleLeft();
					m_client.SendEvent(req_ev, Globals.SelfRoomID);
				}
				//梦幻币
				else if (rewardUI.type == ERewardType.R_VideoMoney) {
					m_client.GetVideoClientPlayer().SetVideoMoney(m_client.GetVideoClientPlayer().GetDreamMoneyNum() + rewardUI.count, null);
				}
				//贵族身份和时间（天数要改成秒数）
				else if (rewardUI.type == ERewardType.R_VIP) {
					m_client.GetVideoClientPlayer().SetVipInfo(rewardUI.rewardId, m_client.GetVideoClientPlayer().GetVipRemainTime() + rewardUI.count * 24 * 60 * 60);
				}
			}
			
			if (queryRewards.length > 0) {
				m_client.GetReawardCookieManager().GetRewordsInfos(queryRewards, m_client.GetUICallback().OnLuckyDrawRes,
					evt.res, evt.last_free_lucky_draw_time, evt.balance, evt.star_gifts, rewards);
			} else {
				m_client.GetUICallback().OnLuckyDrawRes(evt.res, evt.last_free_lucky_draw_time, evt.balance, evt.star_gifts, rewards, []);
			}

			if (evt.res == CEventVideoRoomLuckyDrawRes.LDEC_SUCCESS) {
				if (evt.balance >= 0) {
					m_client.GetVideoClientPlayer().SetVideoMoney(-1, Int64.fromNumber(evt.balance));
				}
			}
		}

		public function HandleCEventVideoRoomLuckyDrawNotice(ev:INetMessage):void {
			var evt:CEventVideoRoomLuckyDrawNotice = ev as CEventVideoRoomLuckyDrawNotice;
			
//			LuckyDrawConfig.instance.pushNotice(evt.notice);
			//转换数据
			var queryRewards:Array                 = [];
			var rewards:Array                      = parseAndSortRewardDataForUI([evt.notice.reward], queryRewards);
			if (queryRewards.length > 0) {
				m_client.GetReawardCookieManager().GetRewordsInfos(queryRewards, m_client.GetUICallback().OnNoticeLuckyDraw,
					evt.notice.nick, rewards[0]);
			} else {
				m_client.GetUICallback().OnNoticeLuckyDraw(evt.notice.nick, rewards[0], []);
			}
		}

		public function HandleCEventVideoRoomSyncLuckyDrawInfo(ev:INetMessage):void {
			var evt:CEventVideoRoomSyncLuckyDrawInfo = ev as CEventVideoRoomSyncLuckyDrawInfo;
			
			if (evt.info != null && evt.info.begin_time != 0) {
				LuckyDrawConfig.instance.updateConfig(evt.config_refresh_time, evt.info);
			}
			
			//转换数据
			var queryRewards:Array                   = [];

			var infoObj:Object                       = new Object();
			infoObj["begin_time"] = evt.info.begin_time;
			infoObj["end_time"] = evt.info.end_time;
			infoObj["continuous_draw_count"] = evt.info.continuous_draw_count;
			infoObj["continuous_draw_reward_id"] = evt.info.continuous_draw_reward_id;
			infoObj["once_draw_price"] = evt.info.once_draw_price;
			infoObj["free_lucky_draw_interval"] = evt.info.free_lucky_draw_interval;
			var rewards:Array         = parseAndSortRewardDataForUI(evt.info.rewards, queryRewards);
			var rewards_x51:Array     = parseAndSortRewardDataForUI(evt.info.rewards_x51, queryRewards);
			var sub_rewards:Array     = parseAndSortRewardDataForUI(evt.info.sub_rewards, queryRewards);
			var sub_rewards_x51:Array = parseAndSortRewardDataForUI(evt.info.sub_rewards_x51, queryRewards);
			var rewards_x52:Array     = parseAndSortRewardDataForUI(evt.info.rewards_x52, queryRewards);
			var sub_rewards_x52:Array = parseAndSortRewardDataForUI(evt.info.sub_rewards_x52, queryRewards);
			infoObj["rewards"] = rewards;
			infoObj["rewards_x51"] = rewards_x51;
			infoObj["sub_rewards"] = sub_rewards;
			infoObj["sub_rewards_x51"] = sub_rewards_x51;
			infoObj["rewards_x52"] = rewards_x52;
			infoObj["sub_rewards_x52"] = sub_rewards_x52;

			if (queryRewards.length > 0) {
				m_client.GetReawardCookieManager().GetRewordsInfos(queryRewards,
					m_client.GetUICallback().OnUpdateLuckyDrawInfo, evt.config_refresh_time, infoObj);
			} else {
				m_client.GetUICallback().OnUpdateLuckyDrawInfo(evt.config_refresh_time, infoObj, []);
			}
		}
		private function HandleCEventRefreshVipInfoToClient(ev:INetMessage):void {
			var evt:CEventRefreshVipInfoToClient = ev as CEventRefreshVipInfoToClient;
			
			m_client.GetVideoClientPlayer().SetVipInfo(evt.vip_info.vip_level, 
				evt.vip_info.vip_expire_time - m_client.GetVideoClientPlayer().GetVideoServerTime() / 1000);
//			m_client.GetVideoClientPlayer().GetVipRemainTime()
//			m_client.GetVideoClientPlayer().GetVideoServerTime() / 1000;
		}
		//============幸运抽奖 end============

		//============新皮肤 start============
		public function GetPunchInInfo():void {
			var ev:CEventGetPunchInInfo = new CEventGetPunchInInfo();
			m_client.SendEvent(ev, Globals.SelfRoomID);
		}

		public function HandleCEventGetPunchInInfoRes(ev:INetMessage):void {
			var evt:CEventGetPunchInInfoRes = ev as CEventGetPunchInInfoRes;

			var queryRewards:Array          = [];

			var infoObj:Object              = new Object();
			infoObj["punch_in_id"] = evt.punch_in_id;
			infoObj["punch_in_rec"] = evt.punch_in_rec;
			infoObj["punch_in_count"] = evt.punch_in_count;
			infoObj["today_index"] = evt.today_index;
			infoObj["room_left"] = evt.room_left;
			infoObj["retrieve_punch_in_left"] = evt.retrieve_punch_in_left;
			infoObj["mutiply_guard_level"] = evt.mutiply_guard_level;
			infoObj["mutiply"] = evt.mutiply;
			infoObj["retrieve_punch_in_prce"] = evt.retrieve_punch_in_prce;
			
			var date:Date = new Date(evt.punch_in_id * 1000);
			var nextMonthDate:Date = new Date(date.fullYear, date.month+1);
			nextMonthDate.time -= 1;
			var totalDate:int = nextMonthDate.date;
			var recList:Array = new Array(totalDate);
			var punch_in_rec:int = evt.punch_in_rec;
			for (var i:int = 0; i < totalDate; i++) {
//				recList[i] = (evt.punch_in_rec & Math.pow(2, i)) == Math.pow(2, i);
				if (punch_in_rec == 0) {
					recList[i] = false;
				} else {
					recList[i] = (punch_in_rec & 1) == 1;
					punch_in_rec = punch_in_rec >> 1;
				}
			}
			infoObj["punch_in_rec_list"] = recList;

			var accumulate_rewards:Array = [];
			for (var dayKey:String in evt.reward_boxes) {
				var inforewardList:PunchInInfoRewardList = evt.reward_boxes[dayKey];

				var ainfo:AccumulateRewards = new AccumulateRewards();
				ainfo.days = int(dayKey); //累计天数
				//TODO 是否将信息解析为CDailySiginRewardForUI数据，如果是需要将reward_boxes里的元素转换为CDailySiginReward

				ainfo.rewards = parseAndSortCRewards(inforewardList.rewards, queryRewards);
				accumulate_rewards.push(ainfo);
			}
			accumulate_rewards.sortOn("days", Array.NUMERIC);
			infoObj["accumulate_rewards"] = accumulate_rewards;

			if (queryRewards.length > 0) {
				m_client.GetReawardCookieManager().GetRewordsInfos(queryRewards,
					m_client.GetUICallback().OnGetPunchInInfo, infoObj);
			} else {
				m_client.GetUICallback().OnGetPunchInInfo(infoObj, []);
			}
		}

		public function PunchIn(punch_in_id:int, today_index:int, day_index:int, retrieve:Boolean, retrieve_price:int):void {
			var ev:CEventPunchIn = new CEventPunchIn();
			ev.punch_in_id = punch_in_id;
			ev.today_index = today_index;
			ev.day_index = day_index;
			ev.retrieve = retrieve;
			ev.retrieve_price = retrieve_price;
			m_client.SendEvent(ev, Globals.SelfRoomID);
		}

		public function HandleCEventPunchInRes(ev:INetMessage):void {
			var evt:CEventPunchInRes = ev as CEventPunchInRes;

			var queryRewards:Array   = [];

			var infoObj:Object       = new Object();
			infoObj["res"] = evt.res;
			infoObj["day_index"] = evt.day_index;
			infoObj["retrieve"] = evt.retrieve;
			infoObj["charm"] = evt.charm;
			infoObj["retrieve_punch_in_prce"] = evt.retrieve_punch_in_prce;
			infoObj["room_left"] = evt.room_left;
			infoObj["rewards"] = parseAndSortCRewards(evt.rewards, queryRewards, true);
			
			if (queryRewards.length > 0) {
				m_client.GetReawardCookieManager().GetRewordsInfos(queryRewards,
					m_client.GetUICallback().OnPunchIn, infoObj);
			} else {
				m_client.GetUICallback().OnPunchIn(infoObj, []);
			}

			//数据不一致或者已经签到过，需要重新获取一次数据；
			if (evt.res != CEventPunchInRes.RES_PIR_SUCCESS && evt.res != CEventPunchInRes.RES_PIR_NOT_ENOUGH_COINS) {
//				Globals.s_logger.debug("打卡：异常(res="+evt.res +")主动拉取信息300!!!");
				GetPunchInInfo();
			}

			if (evt.res == CEventPunchInRes.RES_PIR_SUCCESS) {
				if (evt.retrieve) {
					//查询炫豆数量XW72669
					m_client.GetLogicInternal().QueryBalance(0);
				}
				//由页面自行处理。
//				//增加一条系统消息
//				Globals.s_logger.debug("打卡：准备构建系统消息");
//				var msg_sys:VideoRoomMsgData = new VideoRoomMsgData();
//				msg_sys.channel = ChatChannel.VIDEOCHNL_System;
//				msg_sys.TextColor = WebColor.systemInfoTextColor;
//				msg_sys.systemType = 0;
//				if (evt.charm > 0) {
//					msg_sys.msg = "$t$成功打卡1次，为房间贡献" +　evt.charm  +"魅力值，打卡任务+1。$z";
//				} else {
//					msg_sys.msg = "$t$亲，房间今日打卡任务已完成，连续打卡可以获得专属礼物哦！$z";
//				}
//				Globals.s_logger.debug("打卡：准备发送消息");
//				m_client.GetUICallback().OnReceiveChatMsg(msg_sys);
//				Globals.s_logger.debug("打卡：发送系统消息（" + msg_sys.msg+")");
			}
		}
		private function HandleCEventNotifyPunchInRes(ev:INetMessage):void {
			var evt:CEventNotifyPunchIn = ev as CEventNotifyPunchIn;
			
			m_client.GetUICallback().OnNotifyPunchIn(evt.player_nick, evt.player_zone, evt.charm);
		}

		private var unlockRoomSkinTaskInfo:CEventUnlockRoomSkinTaskInfo;
		private function HandleCEventUnlockRoomSkinTaskInfo(ev:INetMessage):void {
			var evt:CEventUnlockRoomSkinTaskInfo = ev as CEventUnlockRoomSkinTaskInfo;
			if (unlockRoomSkinTaskInfo == null) {
				unlockRoomSkinTaskInfo = evt;
			} else if (unlockRoomSkinTaskInfo.room_id != evt.room_id) {
				unlockRoomSkinTaskInfo = evt;
			} else {
				var obj:Object = new Object();
				obj.ischange = false;
//				obj.org = JSON.stringify(unlockRoomSkinTaskInfo);
				unlockRoomSkinTaskInfo.room_skin_id = evt.room_skin_id;
				if (unlockRoomSkinTaskInfo.gift_info.length != evt.gift_info.length || evt.config_changed) {
					unlockRoomSkinTaskInfo.gift_info = evt.gift_info;
				} else if (parseSameGiftList(evt.gift_info, unlockRoomSkinTaskInfo.gift_info) == false) {
					unlockRoomSkinTaskInfo.gift_info = evt.gift_info;
				}
			}
			m_client.GetUICallback().OnNotifyUnlockRoomSkinTaskInfo(unlockRoomSkinTaskInfo.room_id, unlockRoomSkinTaskInfo.room_skin_id,
				parseRoomSkinTaskInfoList(unlockRoomSkinTaskInfo.gift_info));
		}

		private function HandleCEventNewRoomSkinBroadcastAllPlayer(ev:INetMessage):void {
			var evt:CEventNewRoomSkinBroadcastAllPlayer = ev as CEventNewRoomSkinBroadcastAllPlayer;
			var broadInfo:Object                        = new Object();
			broadInfo["room_id"] = evt.room_id;
			broadInfo["room_name"] = evt.room_name;
			broadInfo["skin_id"] = evt.room_skin_id;
			broadInfo["skin_level"] = evt.room_skin_level;
			m_client.GetUICallback().OnNewRoomSkinBroadcastAllPlayer(broadInfo);
		}

		private var roomSkinLevelUpTaskInfo:CEventRoomSkinLevelUpTaskInfo;
		private function HandleCEventRoomSkinLevelUpTaskInfo(ev:INetMessage):void {
			var evt:CEventRoomSkinLevelUpTaskInfo = ev as CEventRoomSkinLevelUpTaskInfo;

			if (roomSkinLevelUpTaskInfo == null) {
				roomSkinLevelUpTaskInfo = evt;
			} else if (roomSkinLevelUpTaskInfo.room_id != evt.room_id) {
				roomSkinLevelUpTaskInfo = evt;
			} else if (roomSkinLevelUpTaskInfo.room_skin_level < evt.room_skin_level) {
				roomSkinLevelUpTaskInfo = evt;
			} else if (roomSkinLevelUpTaskInfo.room_skin_level == evt.room_skin_level) {
				roomSkinLevelUpTaskInfo.room_id = evt.room_id;
				roomSkinLevelUpTaskInfo.room_skin_id = evt.room_skin_id;
				roomSkinLevelUpTaskInfo.current_charm_rank = evt.current_charm_rank;
				roomSkinLevelUpTaskInfo.next_level_skin_gift_count = evt.next_level_skin_gift_count;
				roomSkinLevelUpTaskInfo.is_max_level = evt.is_max_level;

				if (roomSkinLevelUpTaskInfo.charm_total < evt.charm_total  
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.charm_total = evt.charm_total;
				}
				if (roomSkinLevelUpTaskInfo.total_punchin_count < evt.total_punchin_count 
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.total_punchin_count = evt.total_punchin_count;
				}
				if (roomSkinLevelUpTaskInfo.total_takeseat_count < evt.total_takeseat_count  
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.total_takeseat_count = evt.total_takeseat_count;
				}

				if (roomSkinLevelUpTaskInfo.current_charm < evt.current_charm  
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.current_charm = evt.current_charm;
					roomSkinLevelUpTaskInfo.next_level_charm = evt.next_level_charm;
					roomSkinLevelUpTaskInfo.need_charm = evt.need_charm;
				}
				if (roomSkinLevelUpTaskInfo.current_punchin_count < evt.current_punchin_count
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.current_punchin_count = evt.current_punchin_count;
					roomSkinLevelUpTaskInfo.next_level_punchin_count = evt.next_level_punchin_count;
				}
				if (roomSkinLevelUpTaskInfo.current_takeseat_count < evt.current_takeseat_count
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.current_takeseat_count = evt.current_takeseat_count;
					roomSkinLevelUpTaskInfo.next_level_takeseat_count = evt.next_level_takeseat_count;
				}

				if (roomSkinLevelUpTaskInfo.gift_info.length != evt.gift_info.length 
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.gift_info = evt.gift_info;
				} else if (parseSameGiftList(evt.gift_info, roomSkinLevelUpTaskInfo.gift_info) == false) {
					roomSkinLevelUpTaskInfo.gift_info = evt.gift_info;
				}

				if (roomSkinLevelUpTaskInfo.today_gift_info.length != evt.today_gift_info.length 
					|| evt.config_changed || evt.daily_clear) {
					roomSkinLevelUpTaskInfo.today_gift_info = evt.today_gift_info;
				} else if (parseSameGiftList(evt.today_gift_info, roomSkinLevelUpTaskInfo.today_gift_info) == false) {
					roomSkinLevelUpTaskInfo.today_gift_info = evt.today_gift_info;
				}
			}

			var dataObj:Object = new Object();
			dataObj["charm_total"] = roomSkinLevelUpTaskInfo.charm_total; //evt.charm_total;
			dataObj["current_charm_rank"] = roomSkinLevelUpTaskInfo.current_charm_rank; //evt.current_charm_rank;
			dataObj["room_id"] = roomSkinLevelUpTaskInfo.room_id; //evt.room_id;
			dataObj["room_skin_level"] = roomSkinLevelUpTaskInfo.room_skin_level; //evt.room_skin_level;
			dataObj["room_skin_id"] = roomSkinLevelUpTaskInfo.room_skin_id; //evt.room_skin_id;
			dataObj["current_charm"] = roomSkinLevelUpTaskInfo.current_charm; //evt.current_charm;
			dataObj["current_punchin_count"] = roomSkinLevelUpTaskInfo.current_punchin_count; //evt.current_punchin_count;
			dataObj["total_punchin_count"] = roomSkinLevelUpTaskInfo.total_punchin_count; //evt.total_punchin_count;
			dataObj["current_takeseat_count"] = roomSkinLevelUpTaskInfo.current_takeseat_count; //evt.current_takeseat_count;
			dataObj["total_takeseat_count"] = roomSkinLevelUpTaskInfo.total_takeseat_count; //evt.total_takeseat_count;
			dataObj["next_level_charm"] = roomSkinLevelUpTaskInfo.next_level_charm; //evt.next_level_charm;
			dataObj["next_level_punchin_count"] = roomSkinLevelUpTaskInfo.next_level_punchin_count; //evt.next_level_punchin_count;
			dataObj["next_level_takeseat_count"] = roomSkinLevelUpTaskInfo.next_level_takeseat_count; //evt.next_level_takeseat_count;
			dataObj["next_level_skin_gift_count"] = roomSkinLevelUpTaskInfo.next_level_skin_gift_count; //evt.next_level_skin_gift_count;
			dataObj["is_max_level"] = roomSkinLevelUpTaskInfo.is_max_level; //evt.is_max_level;
			dataObj["need_charm"] = roomSkinLevelUpTaskInfo.need_charm; //evt.need_charm;

			var taskList:Array = parseRoomSkinTaskInfoList(roomSkinLevelUpTaskInfo.gift_info); //evt.gift_info);
			var skinGift:Object;
			for (var i:int = 0; i < taskList.length; i++) {
				var giftData:Object = taskList[i];
				if (giftData["skin_id"] == evt.room_skin_id) {
					skinGift = giftData;
					skinGift["next_level_count"] = giftData.total_count - giftData.current_count;
					taskList.splice(i, 1);
					break;
				}
			}
			if (skinGift != null) {
//				skinGift["next_level_count"] = evt.next_level_skin_gift_count;
			}
			dataObj["skin_gift"] = skinGift;
			dataObj["task_list"] = taskList;

			dataObj["today_task_list"] = parseRoomSkinTaskInfoList(roomSkinLevelUpTaskInfo.today_gift_info); //evt.today_gift_info);

			m_client.GetUICallback().OnNotifyRoomSkinLevelUpTaskInfo(dataObj);
		}

		private var eventSkinDailyTaskInfo:CEventRoomSkinDailyTaskInfo;
		private function HandleCEventRoomSkinDailyTaskInfo(ev:INetMessage):void {
			var evt:CEventRoomSkinDailyTaskInfo = ev as CEventRoomSkinDailyTaskInfo;

			if (eventSkinDailyTaskInfo == null) {
				eventSkinDailyTaskInfo = evt;
			} else if (eventSkinDailyTaskInfo.room_id != evt.room_id
				|| eventSkinDailyTaskInfo.task_id != evt.task_id) {
				eventSkinDailyTaskInfo = evt;
			} else {
				var obj:Object = new Object();
				obj.ischange = false;
//				obj.org = JSON.stringify(eventSkinDailyTaskInfo);

				eventSkinDailyTaskInfo.current_charm_rank = evt.current_charm_rank;
				eventSkinDailyTaskInfo.room_skin_level = evt.room_skin_level;

				if (eventSkinDailyTaskInfo.charm_total < evt.charm_total) {
					eventSkinDailyTaskInfo.charm_total = evt.charm_total;
				} else {
					obj.ischange = true;
				}

				if (eventSkinDailyTaskInfo.total_punchin_count < evt.total_punchin_count || evt.config_changed) {
					eventSkinDailyTaskInfo.total_punchin_count = evt.total_punchin_count;
				} else if (eventSkinDailyTaskInfo.total_punchin_count > evt.total_punchin_count) {
					obj.ischange = true;
				}
				if (eventSkinDailyTaskInfo.total_takeseat_count < evt.total_takeseat_count || evt.config_changed) {
					eventSkinDailyTaskInfo.total_takeseat_count = evt.total_takeseat_count;
				} else if (eventSkinDailyTaskInfo.total_takeseat_count > evt.total_takeseat_count) {
					obj.ischange = true;
				}

				if (eventSkinDailyTaskInfo.current_punchin_count < evt.current_punchin_count || evt.config_changed) {
					eventSkinDailyTaskInfo.current_punchin_count = evt.current_punchin_count;
				} else if (eventSkinDailyTaskInfo.current_punchin_count > evt.current_punchin_count) {
					obj.ischange = true;
				}
				if (eventSkinDailyTaskInfo.current_takeseat_count < evt.current_takeseat_count || evt.config_changed) {
					eventSkinDailyTaskInfo.current_takeseat_count = evt.current_takeseat_count;
				} else if (eventSkinDailyTaskInfo.current_takeseat_count > evt.current_takeseat_count) {
					obj.ischange = true;
				}

				if (eventSkinDailyTaskInfo.current_level_charm < evt.current_level_charm || evt.config_changed) {
					//下面两个值一同变化
					eventSkinDailyTaskInfo.current_level_charm = evt.current_level_charm;
					eventSkinDailyTaskInfo.current_level_need_charm = evt.current_level_need_charm;
				} else if (eventSkinDailyTaskInfo.current_level_charm > evt.current_level_charm) {
					obj.ischange = true;
				}

				if (eventSkinDailyTaskInfo.gift_info.length != evt.gift_info.length || evt.config_changed) {
					eventSkinDailyTaskInfo.gift_info = evt.gift_info;
					obj.ischange = true;
				} else if (parseSameGiftList(evt.gift_info, eventSkinDailyTaskInfo.gift_info) == false) {
					eventSkinDailyTaskInfo.gift_info = evt.gift_info;
				}
			}

			var dataObj:Object = new Object();
			dataObj["room_id"] = eventSkinDailyTaskInfo.room_id; //evt.room_id;
			dataObj["charm_total"] = eventSkinDailyTaskInfo.charm_total; //evt.charm_total;
			dataObj["current_charm_rank"] = eventSkinDailyTaskInfo.current_charm_rank; //evt.current_charm_rank;
			dataObj["current_punchin_count"] = eventSkinDailyTaskInfo.current_punchin_count; //evt.current_punchin_count;
			dataObj["total_punchin_count"] = eventSkinDailyTaskInfo.total_punchin_count; //evt.total_punchin_count;
			dataObj["current_takeseat_count"] = eventSkinDailyTaskInfo.current_takeseat_count; //evt.current_takeseat_count;
			dataObj["total_takeseat_count"] = eventSkinDailyTaskInfo.total_takeseat_count; //evt.total_takeseat_count;
			dataObj["current_charm"] = eventSkinDailyTaskInfo.current_level_charm; //evt.current_level_charm;
			dataObj["need_charm"] = eventSkinDailyTaskInfo.current_level_need_charm; //evt.current_level_need_charm;
			dataObj["room_skin_level"] = eventSkinDailyTaskInfo.room_skin_level; //evt.room_skin_level;

			dataObj["task_list"] = parseRoomSkinTaskInfoList(eventSkinDailyTaskInfo.gift_info); //evt.gift_info);

			m_client.GetUICallback().OnNotifyRoomSkinDailyTaskInfo(dataObj);
		}

		private function parseSameGiftList(srcList:Array, destList:Array):Boolean {
			var idList:Array = [];
			if (srcList.length == destList.length) {
				for each (var srcGift:RoomSkinTaskInfo in srcList) {
					for each (var destGift:RoomSkinTaskInfo in destList) {
						if (srcGift.gift_id == destGift.gift_id) {
							idList.push(srcGift.gift_id);
							if (destGift.current_gift_count < srcGift.current_gift_count) {
								destGift.current_gift_count = srcGift.current_gift_count
							}
							destGift.total_gift_count = srcGift.total_gift_count;
							break;
						}
					}
				}
			}
			return idList.length == srcList.length;
		}

		private function HandleCEventRoomSkinLevelUpNotify(ev:INetMessage):void {
			var evt:CEventRoomSkinLevelUpNotify = ev as CEventRoomSkinLevelUpNotify;

			var dataObj:Object                  = new Object();
			dataObj["room_id"] = evt.room_id;
			dataObj["skin_level"] = evt.skin_level;
			dataObj["room_size"] = evt.room_size;
			dataObj["skin_id"] = evt.skin_id;

			m_client.GetUICallback().OnNotifyRoomSkinLevelUp(dataObj);
		}

		private function HandleCEventRoomDailyTaskRewards(ev:INetMessage):void {
			var evt:CEventRoomDailyTaskRewards = ev as CEventRoomDailyTaskRewards;
			var queryRewards:Array             = [];
//			if (evt.reward_list != null) {
//				Globals.s_logger.debug("新皮肤满级日常任务奖励 数量：" + evt.reward_list.length);
//			} else {
//				Globals.s_logger.debug("新皮肤满级日常任务奖励 数量：null");
//			}
			
			var rewards:Array                  = parseAndSortCRewards(evt.reward_list, queryRewards, true);
			if (queryRewards.length > 0) {
				m_client.GetReawardCookieManager().GetRewordsInfos(queryRewards,
					m_client.GetUICallback().OnNotifyRoomDailyTaskRewards, evt.room_id, rewards);
			} else {
				m_client.GetUICallback().OnNotifyRoomDailyTaskRewards(evt.room_id, rewards, []);
			}
		}

		private function HandleCEventVideoRoomCharmBroadcastAllRoom(ev:INetMessage):void {
			var evt:CEventVideoRoomCharmBroadcastAllRoom = ev as CEventVideoRoomCharmBroadcastAllRoom;

			var dataObj:Object                           = new Object();
			dataObj["room_id"] = evt.room_id;
			dataObj["room_name"] = evt.room_name;
			dataObj["skin_level"] = evt.skin_level;
			dataObj["rank_timedimension"] = evt.rank_timedimension;
			dataObj["skin_id"] = evt.skin_id;

			m_client.GetUICallback().OnNotifyRoomCharmBroadcastAllRoom(dataObj);
		}

		private function HandleCEventRefreshRoomCharmRank(ev:INetMessage):void {
			var evt:CEventRefreshRoomCharmRank = ev as CEventRefreshRoomCharmRank;
			var ranks:Array                    = []
			for (var i:int = 0; i < evt.ranks.length; i++) {
				var rank:VideoRoomCharmRank = evt.ranks[i] as VideoRoomCharmRank;
				var data:Object             = new Object();
				data.anchor_id = rank.anchor_id.toString();
				data.room_id = rank.room_id;
				data.room_name = rank.room_name;
				data.session = rank.session;
				data.score = rank.score.toString();
				data.last_order = rank.last_order;
				if (rank.last_order == 0) {
					//表示首次入榜
					data.order_change = 101 - (Globals.roomCharmRankBeginIndex + (i + 1));
				} else {
					data.order_change = rank.last_order - (Globals.roomCharmRankBeginIndex + (i + 1));
				}

				data.skin_level = rank.skin_level;
				data.onboard_time = rank.onboard_time;
				data.record_id = rank.record_id;
				data.skin_id = rank.skin_id;
				data.anchor_status = rank.anchor_status;
				if (rank.portrait_url != "") {
					data.photo_url = Globals.m_pic_download_url + "/qdancersec/" + rank.portrait_url + "/0" + URLSuffix.CreateVersionString();
				}
				ranks.push(data);
			}
			//tqos上报 begin
			var tqos:TQOSHomePageLoadTime = new TQOSHomePageLoadTime();
			tqos.nQQ = this.m_client.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nLoadSuccTime = flash.utils.getTimer() - TQOSHomePageLoadTime.nBeginTime;
			tqos.Response();
			//tqos上报 end

			m_client.GetUICallback().OnLoadRoomCharmRank(evt.succ, ranks, evt.rank_timedimension, evt.total_size);
		}

		public function QuerySkinGift():void{
			var ev:CEventQuerySkinGift = new CEventQuerySkinGift();
			m_client.SendEvent(ev, Globals.SelfRoomID);
		}
		private function HandleCEventQuerySkinGiftRes(ev:INetMessage):void {
			var evt:CEventQuerySkinGiftRes = ev as CEventQuerySkinGiftRes;
			var skinGiftList:Array         = [];
			for each (var key:String in evt.skin_gifts) {
				var dataObj:Object = new Object();
				dataObj["skin_id"] = key;
				dataObj["gift_id"] = evt.skin_gifts[key];
				var giftData:Object = CGiftConfig.getInstance().GetGiftData(evt.skin_gifts[key]);
				if (giftData != null) {
					dataObj["gift_name"] = giftData.name;
					dataObj["gift_price"] = giftData.price;
					dataObj["gift_icon"] = giftData.icon;
					if (giftData.css_url != null) {
						dataObj["gift_url"] = giftData.css_url;
					}
				} else {
					dataObj["gift_name"] = "";
					dataObj["gift_price"] = "";
					dataObj["gift_icon"] = "";
					dataObj["gift_url"] = "";
				}
				skinGiftList.push(dataObj);
			}
			m_client.GetUICallback().OnQuerySkinGift(evt.res, skinGiftList);
		}

		public function parseRoomSkinTaskInfoList(taskInfoList:Array):Array {
			var taskList:Array = [];
			for each (var skinTask:RoomSkinTaskInfo in taskInfoList) {
				var taskInfo:Object = new Object();
				taskInfo["gift_id"] = skinTask.gift_id;

				var giftdata:Object = CGiftConfig.getInstance().GetGiftData(skinTask.gift_id);
				if (giftdata != null) {
					taskInfo["gift_name"] = giftdata.name;
					taskInfo["gift_price"] = giftdata.price;
					taskInfo["gift_icon"] = giftdata.icon;
					taskInfo["skin_id"] = giftdata.skin_id;
					if (giftdata.css_url != null) {
						taskInfo["gift_url"] = giftdata.css_url;
					}
				} else {
					taskInfo["gift_name"] = "";
					taskInfo["gift_price"] = "";
					taskInfo["gift_icon"] = "";
					taskInfo["gift_url"] = "";
					taskInfo["skin_id"] = "";
				}

				taskInfo["current_count"] = skinTask.current_gift_count;
				taskInfo["total_count"] = skinTask.total_gift_count;
				taskList.push(taskInfo);
			}
			return taskList;
		}

		//============新皮肤 end============

		public static function ConvertToTreasureBoxDataBuf(from:Array, cur_height:int, isSelfMale:Boolean, to:Array):void
		{
			var vecTreasureBox:Array = to;			
			vecTreasureBox.splice(0);
			for each(var data:EvtVidoeBoxStatusData in from)
			{
				var boxdata:VideoRoomTreasureBoxData = new VideoRoomTreasureBoxData;
				boxdata.index = data.boxID;
				boxdata.require = data.requireHeight;
				boxdata.status = VideoRoomTreasureBoxStatus.VRTBS_CannotOpen;
				if(data.hasBeenOpened)
				{
					boxdata.status = VideoRoomTreasureBoxStatus.VRTBS_Opened;
				}
				else if(data.requireHeight <= cur_height)
				{
					boxdata.status = VideoRoomTreasureBoxStatus.VRTBS_CanOpen;
				}
				vecTreasureBox.push(boxdata);
			}
		}
		public function GetRoomID():int
		{
			return m_room_id;
		}

		private function RefreshRoomStatus():void {
			var isHasTicket:Boolean = false;
			
			var width:int;
			var height:int;
			for each(var o:Object  in m_live_detail.vid_resolutions)
			{
				width = o.m_width;
				height = o.m_height;
			}
			
			//是否隐藏礼物区
			if (m_base.GetConcertClient() && m_base.GetConcertClient().HasConcertTicket() == true)
				isHasTicket = true;
			m_client.GetUICallback().RefreshRoomStatus(ConvertLogic2UIVideoRoomStatus(m_status),
				m_base.GetConcertClient().IsConcert(), isHasTicket, m_is_special_room,width,height,m_live_detail.anchor_device_type,m_live_detail.is_vertical_live);
		}

		private function RefreshRoomInfo():void
		{
			var data:VideoRoomData = new VideoRoomData;
			GetRoomDataForUI(data);
			data.picInfo = m_roomPicInfo;
			if (m_client.GetUICallback())
			{
				m_client.GetUICallback().RefreshRoomInfo(data);
			}
		}
		
		private function RefreshDanceChampionInfo():void
		{
			
		}
		
		public function GetRoomDataForUI(data:VideoRoomData):void
		{
			data.roomID = m_room_id;
			data.status = ConvertLogic2UIVideoRoomStatus(m_status);
			data.category = GetMainCategory(m_subject);
			data.playerCount = m_audience_count;
			if (m_status == VideoRoomState.VRS_LIVE)
			{
				var server_time:int = m_client.GetLogicInternal().GetServerTime();
				data.time = server_time - m_live_detail.start_time;
				if (data.time < 0)
				{
					data.time = 0;
				}
				data.time /= 60;
			}
			data.anchorID = m_live_detail.anchor_pstid.toString();
			data.anchorName = m_live_detail.name.replace(Pattern,"\\\\");
			data.roomName = m_room_name.replace(Pattern,"\\\\");
			data.roomPics = m_room_pics;
			data.picInfo = m_roomPicInfo;
			data.giftPoolHeight = m_cur_giftpool_height;
			data.player_capacity = m_player_capacity;
			data.type = m_type;
			data.attched_anchor = m_attached_anchor;
			data.attached_room_id = m_attached_room_id;
			data.attached_room_name = m_attached_room_name;
			data.bSuperRoom = m_concert;
			data.forbid_public_chat = m_forbid_public_chat;
		}
		
		public function GetVideoRoomPicUrl():void
		{
			var url_vec:Array = new Array;
			const VideoRoomMaxPicCount:int = 5;
			var max_pic_count:int = VideoRoomMaxPicCount;
			
			for(var i:int = 0;i<max_pic_count;i++)
			{
				var has_pic:Boolean= ((m_roomPicInfo & (1 << i)) != 0);
				if(has_pic)
				{
					var str:String = OlinePictureDef.GetVideoRoomPictureDownloadUrl(m_base.GetPicDownloadUrl(), Globals.VideoGroupID,Globals.SelfRoomID,i) + URLSuffix.CreateVersionString();
					url_vec.push(str);
				}
			}
			m_client.GetUICallback().OnGetVideoRoomPicUrl(url_vec);
		}
		
		private function GetSplitScreenInfo(info:SplitScreenInfo):void
		{
			info.anchorId = m_live_detail.split_screen_info.anchorId;
			info.anchorName = m_live_detail.split_screen_info.anchorName;
			info.status = m_live_detail.split_screen_info.status;
			info.vid = m_live_detail.split_screen_info.vid;
		}
		
		private function GetLiveStatus( status:VideoRoomLiveStatus):void
		{
			status.anchor_pstid = m_live_detail.anchor_pstid;
			status.start_time = m_live_detail.start_time;
			status.vid = m_live_detail.vid;
			status.extra_vid = m_live_detail.extra_vid;
		}
		
		private function SetVideoRoomStatus( vrs:int ):void
		{
			m_status = vrs;
		}
		
		private function ConvertLogic2UIVideoRoomStatus(logic_status:int):int
		{
			if (logic_status == 2 || logic_status == 0)
				return RoomStatus.VRS_Wait;
			else if (logic_status == 3)
				return RoomStatus.VRS_Playing;
			else 
				return RoomStatus.VRS_Closed;
		}
		
		private function GetMainCategory(subject:int):int
		{
			const BITS_FOR_BYTE:int = 8;
			const MaxIterationCount:int = 4 * BITS_FOR_BYTE;
			for(var i:int = 1; ((subject != 0) && (i < MaxIterationCount)); ++i)
			{
				if(0 != (subject & 0x1))
				{
					return i;
				}
				subject >>= 1;
			}
			return 0;
		}
		
		private function FillUIRedEnvelopes(uiredinfo:Array,redinfo:Array):void
		{
			for each(var redEnve:RedEnvelopeInfo in redinfo)
			{
				var uired:UIVideoRedEnvelope = new UIVideoRedEnvelope();
				uired.m_publisher = redEnve.publisher.toString();
				uired.m_nick = redEnve.nick.replace(/\\/g,"\\\\");
				uired.m_zone = redEnve.zone;
				uired.m_publish_time = redEnve.publish_time;
				uired.m_total_money = redEnve.total_money;
				uired.m_remain_money = redEnve.remain_money;
				uired.m_divide_count = redEnve.divide_count;
				uired.m_red_id = redEnve.red_id.toString();
				
				
				for each(var grabberInfo:RedEnvelopeGrabberInfo in redEnve.grabbers)
				{
					var grabber:UIVideoRedEnvelopeGrabberInfo = new UIVideoRedEnvelopeGrabberInfo();
					grabber.grabber = grabberInfo.grabber.toString();
					grabber.nick = grabberInfo.nick.replace(/\\/g,"\\\\");
					grabber.zone = grabberInfo.zone;
					grabber.grab_count = grabberInfo.grab_count;
					uired.m_grabbers.push(grabber);
				}
				
				uiredinfo.push(uired);
			}
		}
		
		public function FillRoomDataForUI(logic_rooms:Array, rooms:Array):void
		{
			for(var i:int = 0; i < logic_rooms.length; ++i)
			{
				var info:VideoRoomSyncInfo = logic_rooms[i] as VideoRoomSyncInfo;
//				Globals.s_logger.debug("FillRoomDataForUI()  info.anchor_badge = " + info.anchor_badge);
				var data:VideoRoomData = new VideoRoomData;
				data.picInfo = info.room_pic_info;
				data.status = ConvertLogic2UIVideoRoomStatus(info.state);
				
				if(info.is_closed)
				{
					data.status = RoomStatus.VRS_LOCKED;
				}
				data.roomID = info.id;
				data.roomName = info.room_name.replace(Pattern,"\\\\");
				data.anchorID = info.anchor_pstid.toString();
				data.anchorName = info.anchor_name.replace(Pattern,"\\\\");
				data.type = info.type;
				data.category = GetMainCategory(info.subject);
				data.giftPoolHeight = info.gift_pool_height;
				data.playerCount = info.player_num;
				data.player_capacity = info.player_capcity;
				data.talent_show_rank = info.talent_show_rank;
				data.star_anchor = (info.star_anchor > 0);
				data.pk_anchor_winner_order = info.pk_anchor_winner_order;
				data.ticket_room = info.ticket_room;
				data.attached_room_id = info.attached_room_id;
//				data.attached_room_name = info.attached_room_name;
				data.room_attribute_flag = info.room_attribute_flag;
				data.anchor_level = info.anchor_level;
				data.isNest = info.is_nest;
				data.is_star_gift_champion = info.is_star_gift_champion;
				data.is_anchor_pk_room = info.is_anchor_pk_room;
				data.anchor_badge = info.anchor_badge;
				data.qgame_anchor_posing_url = info.qgame_anchor_posing_url;
				data.room_skin_id = info.room_skin_id;
				data.room_skin_level = info.room_skin_level;
				data.week_star_grade = info.week_star_grade;
				data.week_star_sub_level = info.week_star_sub_level;
				
				if(info.large_anchor_posing_url && info.large_anchor_posing_url.length > 0)
				{
					data.large_anchor_posing_url = Globals.m_pic_download_url + "/qdancersec/" + info.large_anchor_posing_url + "/0" + URLSuffix.CreateVersionString();
				}
				
				if(info.small_anchor_posing_url && info.small_anchor_posing_url.length > 0)
				{
					data.small_anchor_posing_url = Globals.m_pic_download_url + "/qdancersec/" + info.small_anchor_posing_url + "/0" + URLSuffix.CreateVersionString();
				}
				
				
				if( data.room_attribute_flag & 0x02)
				{
					data.bSuperRoom = true;
				}
				else
				{
					data.bSuperRoom = false;
				}
				
				if (info.state == RoomStatus.VRS_Playing)
				{
					var server_time:int = m_client.GetLogicInternal().GetServerTime();
					data.time = server_time - info.live_start_time;
					if (data.time < 0)
					{
						data.time = 0;
					}
					data.time /= 60;
				}
				m_base.FillVideoRoomPicUrl(data);
				
				if ( data.status == RoomStatus.VRS_Playing )
				{
					m_base.FillVideoRoomLogoUrl(data);
				}
				else if( data.roomPics.length > 0)//未开播状态时候，使用相册的第一张图
				{
					data.roomLogoUrl = data.roomPics[0] + URLSuffix.CreateVersionString();
				}
				else
				{
					data.roomLogoUrl = "";
				}
				Globals.s_logger.debug("data:"+data+"-----info:"+info);
				rooms.push(data);
			}
		}
		public function FillRoomPageDataForUI(logic_rooms:Array, rooms:Array, super_module_room_count:int=0, module_room_count:int=0):void
		{
			for(var i:int = 0; i < logic_rooms.length; ++i)
			{
				var info:VideoRoomPageSyncInfo = logic_rooms[i] as VideoRoomPageSyncInfo;
				var data:VideoRoomData = new VideoRoomData;
				data.picInfo = info.room_pic_info;
				data.status = ConvertLogic2UIVideoRoomStatus(info.state);
				
				if(info.is_closed)
				{
					data.status = RoomStatus.VRS_LOCKED;
				}
				data.index = i;
				data.roomID = info.id;
				data.roomName = info.room_name.replace(Pattern,"\\\\");
				data.anchorID = info.anchor_pstid.toString();
				data.anchorName = info.anchor_name.replace(Pattern,"\\\\");
				data.type = info.type;
				data.category = GetMainCategory(info.subject);
				data.playerCount = info.player_num;
				data.player_capacity = info.player_capcity;
				data.attached_room_id = info.attached_room_id;
				data.room_attribute_flag = info.room_attribute_flag;
				data.anchor_level = info.anchor_level;
				data.isNest = info.is_nest;
				data.is_star_gift_champion = info.is_star_gift_champion;
				data.is_anchor_pk_room = info.is_anchor_pk_room;
				data.anchor_badge = info.anchor_badge;
				data.qgame_anchor_posing_url = info.qgame_anchor_posing_url;
				data.room_skin_id = info.room_skin_id;
				data.room_skin_level = info.room_skin_level;
				data.tag_name = info.tag_name;
				data.week_star_grade = info.week_star_grade;
				data.week_star_sub_level = info.week_star_sub_level;
				data.vertical_live = info.vertical_live;
				
				//进房消息使用的字段：区分是哪个模块
				if(i<super_module_room_count)
				{//演唱会模块
					data.module_type = 3;
				} 
				else if(i<(super_module_room_count + module_room_count))
				{//模块1/模块2
					data.module_type = -1;
				} 
				else
				{//其他模块
					data.module_type = 0;
				}

				Globals.s_logger.debug("info.tag_name:"+info.tag_name);
				
				if(info.large_anchor_posing_url && info.large_anchor_posing_url.length > 0)
				{
					data.large_anchor_posing_url = Globals.m_pic_download_url + "/qdancersec/" + info.large_anchor_posing_url + "/0" + URLSuffix.CreateVersionString();
				}
				
				if(info.small_anchor_posing_url && info.small_anchor_posing_url.length > 0)
				{
					data.small_anchor_posing_url = Globals.m_pic_download_url + "/qdancersec/" + info.small_anchor_posing_url + "/0" + URLSuffix.CreateVersionString();
				}
				
				
				if( data.room_attribute_flag & 0x02)
				{
					data.bSuperRoom = true;
				}
				else
				{
					data.bSuperRoom = false;
				}
				
				if (info.state == RoomStatus.VRS_Playing)
				{
					var server_time:int = m_client.GetLogicInternal().GetServerTime();
					data.time = server_time - info.live_start_time;
					if (data.time < 0)
					{
						data.time = 0;
					}
					data.time /= 60;
				}
				m_base.FillVideoRoomPicUrl(data);
				
				if ( data.status == RoomStatus.VRS_Playing )
				{
					m_base.FillVideoRoomLogoUrl(data);
				}
				else if( data.roomPics.length > 0)//未开播状态时候，使用相册的第一张图
				{
					data.roomLogoUrl = data.roomPics[0] + URLSuffix.CreateVersionString();
				}
				else
				{
					data.roomLogoUrl = "";
				}
				Globals.s_logger.debug("data:"+data+"-----info:"+info);
				rooms.push(data);
			}
		}

		/**
		 * 更新主播印象
		 * xw81665 同时支持更新主播粉丝数量。
		 * @param impressions
		 * @param followedCount
		 *
		 */
		public function UpdateLiveDetailImpression(impressions:AnchorImpressionDataServer, followedCount:int = -1):void {
			m_live_detail.impression.impressions = null;
			m_live_detail.impression = impressions;
			if (followedCount != -1) {
				m_live_detail.followed = followedCount;
			}
			RefreshAnchorInfo();
		}
		
		public function SetDefaultDefinition( definition :int):void
		{
			m_default_definition = definition;
			m_client.GetUICallback().OnSetDefaultDefinition(true);
		}
		
		public function  GetRoomStatus( ):void
		{
			RefreshRoomStatus();
		}

		/**
		 * 获取当前可用的清晰度（160）
		 * @return
		 *
		 */
		public function GetCurrentAvailableDefinition():Array {
			var definitions:Array = new Array;
			definitions.push(VideoDefinitionID.VDID_FLUENT);

			for (var idx:String in m_live_detail.extra_vid) {
				definitions.push(idx);
			}
			m_client.GetUICallback().OnGetCurrentAvailableDefinition(definitions);
			return definitions;
		}

		public function GetCurrentDefinition():int {
			m_client.GetUICallback().OnGetCurrentDefinition(m_current_definition);
			return m_current_definition;
		}

		public function  ChooseDefinition( definition :int):Boolean
		{
			if (!SetDefinition(definition))
			{
				m_client.GetUICallback().OnChooseDefinition(false);
				return false;
			}
			StopWatchLive(true);//表示是由于选择清晰度而引起的
			TryStartWatchLive();
			m_client.GetUICallback().OnChooseDefinition(true);
			return true;
		}
		
		public function  SetDefinition(definition :int):Boolean
		{
			if (m_live_detail.anchor_pstid.isZero())
			{
				return false;
			}
			if (definition == VideoDefinitionID.VDID_FLUENT)
			{
				m_current_definition = VideoDefinitionID.VDID_FLUENT;
				m_current_vid = m_live_detail.vid;
				return true;
			}
			else
			{
				for(var idx:Object  in m_live_detail.extra_vid )
				{
					if ( definition == idx )
					{
						m_current_definition = definition;
						m_current_vid = m_live_detail.extra_vid[idx];
						return true;
					}
				}
				return false;
			}
		}
		
		public function  AutoChooseDefinition():void
		{
			if(m_watching)return;
			//ExternalInterface.call("console.log","AutoChooseDefinition:");
			for(var idx:Object  in m_live_detail.extra_vid )
			{
				m_default_definition =int(idx);
				//ExternalInterface.call("console.log","AutoChooseDefinition:" + idx.toString() + "@@@" + m_live_detail.extra_vid[m_default_definition].toString());
			}
			
			//有配置的默认分辨率  用配置的
			if(VideoDefinitionID.VDID_DEFAULT != -1)
			{
				//防止默认分辨率超过最大分辨率
				if(VideoDefinitionID.VDID_DEFAULT <= m_default_definition)
				{
					m_default_definition = VideoDefinitionID.VDID_DEFAULT;
				}	
			}
			
			if (!SetDefinition(m_default_definition))
			{
				m_current_definition = VideoDefinitionID.VDID_FLUENT;
				m_current_vid = m_live_detail.vid;
			}
			m_client.GetUICallback().NotifyCurrentDefinition(m_current_definition);
		}
		
		public function TryStartWatchInvitedAnchorLive():void
		{
			if (m_cdn_info.ip_vec.length != 0)
			{
				m_start_watch_invited_anchor_waiting_cdn = false;
				StartWatchInvitedAnchorLive(m_cdn_info, m_live_detail.split_screen_info.anchorId, m_live_detail.split_screen_info.vid);
			}
			else
			{
				m_start_watch_invited_anchor_waiting_cdn = true;
			}
		}
		
		private function IsEqualScreenInfo(old_status:SplitScreenInfo,new_status:SplitScreenInfo):Boolean
		{
			if( old_status.anchorId.equal( new_status.anchorId) 
				&& old_status.vid == new_status.vid
				&& old_status.status == new_status.status
				&& old_status.anchorName == new_status.anchorName)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function UpdateSplitScreenLiveStatus(old_status:SplitScreenInfo,new_status:SplitScreenInfo):void
		{
			if(!IsEqualScreenInfo(old_status,new_status))
			{
				var isFollow:Boolean = false;
				isFollow = m_client.GetVideoClientPlayer().IsFollowingAnchor(new_status.anchorId);
				m_client.GetUICallback().RefreshSplitScreenInfo(new_status.status, new_status.anchorId.toString(), new_status.anchorName.replace(/\\/,"\\\\"),isFollow);
				
				if (new_status.status == SplitScreenStatus.SSS_Close && new_status.status != old_status.status)
				{
					StopWatchInvitedAnchorLive();
					m_base.SetCurrentInvitedAnchorVid(0);
				}
				else if (old_status.status == SplitScreenStatus.SSS_Living && new_status.status != old_status.status)
				{
					StopWatchInvitedAnchorLive();
				}
				else if (new_status.status == SplitScreenStatus.SSS_Living )//&& old_status.status == SplitScreenStatus.SSS_Open
				{
					TryStartWatchInvitedAnchorLive();
				}
			}
		}
		
		public function StartWatchInvitedAnchorLive(cdn:LiveCDNInfo,anchor_pstid:Int64,vid:int):void
		{
			//演唱会没有分屏功能
			if(m_base.GetConcertClient().IsConcert())
			{
				return;
			}
			
			m_base.SetCDNAddress(cdn.ip_vec);
			m_base.SetCurrentInvitedAnchorVid(vid);
			
			m_base.StartWatchInvitedAnchorLive();
			m_watching_invited_anchor = true;
		}
		
		public function StopWatchInvitedAnchorLive():void
		{
			m_start_watch_invited_anchor_waiting_cdn = false;
			if (!m_watching_invited_anchor)
				return;
			m_watching_invited_anchor = false;
			m_base.StopWatchInvitedAnchorLive();
		}
		
		//==========================================================================================
		//
		// 公共解析方法
		//
		//==========================================================================================
		/**
		 * 解析并分析奖品类型。列表元素为RewardDataForUI类型；outQueryRewards必传。
		 * @param rewards			RewardDataForUI类型列表
		 * @param outQueryRewards
		 * @param dealMoneyChange
		 * @param vip_level
		 * @return 
		 * 
		 */
		private function parseAndSortRewardDataForUI(rewards:Array, outQueryRewards:Array, vip_level:int = -1):Array {
			Globals.s_logger.debug("parseAndSortRewardDataForUI: "+ JSON.stringify(rewards));
			
			var rewardUIList:Array = [];
			for each (var reward:RewardBasicItem in rewards) {
				var malerwd:RewardDataForUI = new RewardDataForUI();
				malerwd.type = reward.type;
				malerwd.rare = reward.para4;//幸运转盘中判断是否稀有礼物
				Globals.s_logger.debug("parseAndSortRewardDataForUI for each: "+ JSON.stringify(reward));
//				malerwd.star_gift = reward.star_gift || false;
				if (reward.item_channel == VideoChannelType.VCT_X5 || reward.item_channel == VideoChannelType.VCT_X52) {
					malerwd.rewardId = m_client.IsSelfMale() ? reward.para1 : reward.para2;
					Globals.s_logger.debug("parseAndSortRewardDataForUI X51 X52: "+ JSON.stringify(reward));
				} else {
					malerwd.rewardId = reward.para1;
					Globals.s_logger.debug("parseAndSortRewardDataForUI X51 else: "+ JSON.stringify(reward));
				}
//				malerwd.rewardId = reward.para1; 
				malerwd.count = reward.para3;
				malerwd.channel = reward.item_channel;
				
				//处理新增的vip_level字段。
				if (reward.type == ERewardType.R_VIP && reward.para1 != 0) {
					if (vip_level == -1) {
						vip_level = m_client.GetVideoClientPlayer().GetVipLevel();
					}
					
					if (vip_level >= 1) {
						malerwd.rewardId = vip_level;
					}
				}
				
				if (VideoChannelType.IsQueryReaward(malerwd.channel)) {
					var gift_web:RewardReqestWeb = new RewardReqestWeb();
					gift_web.amount = malerwd.count;
					gift_web.id = malerwd.rewardId;
					gift_web.type = malerwd.type;
					gift_web.channel = malerwd.channel;
					gift_web.rare = malerwd.rare;
					outQueryRewards.push(gift_web);
					Globals.s_logger.debug("parseAndSortRewardDataForUI IsQueryReaward: "+ JSON.stringify(gift_web));
				}
				
				rewardUIList.push(malerwd);
			}
			Globals.s_logger.debug("rewardUIList:  "+JSON.stringify(rewardUIList));
			Globals.s_logger.debug("outQueryRewards:  "+JSON.stringify(outQueryRewards));
			return rewardUIList;
		}
		
		/**
		 * 解析并分析奖品类型。列表元素为CReward类型；outQueryRewards必传。
		 * @param rewards			CReward类型列表
		 * @param outQueryRewards
		 * @param vip_level
		 * @return 
		 * 
		 */		
		private function parseAndSortCRewards(rewards:Array, outQueryRewards:Array, 
						dealMoneyChange:Boolean = false, vip_level:int = -1):Array {
			var rewardUIList:Array = [];
			for each (var reward:CReward in rewards) {
				var malerwd:RewardDataForUI = new RewardDataForUI();
				malerwd.type = reward.type;
				malerwd.rewardId = reward.male_data; //m_client.IsSelfMale() ? reward.para1 : reward.para2;
				malerwd.count = reward.count;
				malerwd.channel = reward.channel;
				
				//处理新增的vip_level字段。
				if (reward.type == ERewardType.R_VIP && reward.male_data != 0) {
					if (vip_level == -1) {
						vip_level = m_client.GetVideoClientPlayer().GetVipLevel();
					}
					
					if (vip_level >= 1) {
						malerwd.rewardId = vip_level;
					}
				}
				
				if (VideoChannelType.IsQueryReaward(malerwd.channel)) {
					var gift_web:RewardReqestWeb = new RewardReqestWeb();
					gift_web.amount = malerwd.count;
					gift_web.id = malerwd.rewardId;
					gift_web.type = malerwd.type;
					gift_web.channel = malerwd.channel;
					outQueryRewards.push(gift_web);
				}
				
				if (dealMoneyChange && malerwd.type == ERewardType.R_VideoMoney) {
					m_client.GetVideoClientPlayer().SetVideoMoney(m_client.GetVideoClientPlayer().GetDreamMoneyNum() + malerwd.count, null);
				}
				
				rewardUIList.push(malerwd);
			}
			return rewardUIList;
		}
	}
}