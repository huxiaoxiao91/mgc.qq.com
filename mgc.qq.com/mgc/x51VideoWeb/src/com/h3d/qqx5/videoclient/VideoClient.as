package com.h3d.qqx5.videoclient
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.CEventVideoRoomBanNotice;
	import com.h3d.qqx5.common.event.CEventAddDeputyAnchor;
	import com.h3d.qqx5.common.event.CEventAddDeputyAnchorRes;
	import com.h3d.qqx5.common.event.CEventAdminOpenOrCloseRoomRes;
	import com.h3d.qqx5.common.event.CEventAllVipSeatsOccupiedBroadcastAllRoom;
	import com.h3d.qqx5.common.event.CEventAnchorGrowthConfig;
	import com.h3d.qqx5.common.event.CEventAnchorNameChangeNotify;
	import com.h3d.qqx5.common.event.CEventAnchorTaskRewardNotifyNewRoleWeb;
	import com.h3d.qqx5.common.event.CEventAssignTalentJudge;
	import com.h3d.qqx5.common.event.CEventAssignTalentJudgeRes;
	import com.h3d.qqx5.common.event.CEventBatchLoadAnchorNestInfo;
	import com.h3d.qqx5.common.event.CEventBatchLoadAnchorNestInfoRes;
	import com.h3d.qqx5.common.event.CEventBatchVideoTreasureBoxRewardNewRoleWeb;
	import com.h3d.qqx5.common.event.CEventBroadcastAssignTalentJudgeMsg;
	import com.h3d.qqx5.common.event.CEventCheckNickOnLogin;
	import com.h3d.qqx5.common.event.CEventCheckNickOnLoginRes;
	import com.h3d.qqx5.common.event.CEventCloseOrOpenRoom;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoBegin;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoEnd;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoRefresh;
	import com.h3d.qqx5.common.event.CEventCommonActivityPlayerRank;
	import com.h3d.qqx5.common.event.CEventConcertPlaybackRoomGetRoomList;
	import com.h3d.qqx5.common.event.CEventConcertPlaybackRoomGetRoomListRes;
	import com.h3d.qqx5.common.event.CEventConcertStatusChange;
	import com.h3d.qqx5.common.event.CEventConfirmFirstLoginReward;
	import com.h3d.qqx5.common.event.CEventConfirmFirstLoginRewardRes;
	import com.h3d.qqx5.common.event.CEventDelDeputyAnchor;
	import com.h3d.qqx5.common.event.CEventDianZan;
	import com.h3d.qqx5.common.event.CEventDianZanResult;
	import com.h3d.qqx5.common.event.CEventDice;
	import com.h3d.qqx5.common.event.CEventDiceResult;
	import com.h3d.qqx5.common.event.CEventEditAnchorImpress;
	import com.h3d.qqx5.common.event.CEventEditAnchorImpressRes;
	import com.h3d.qqx5.common.event.CEventEditVideoAccount;
	import com.h3d.qqx5.common.event.CEventEditVideoAccountRes;
	import com.h3d.qqx5.common.event.CEventEncryptPortraitUrl;
	import com.h3d.qqx5.common.event.CEventEncryptPortraitUrlRes;
	import com.h3d.qqx5.common.event.CEventEnterRoomNotifyVoteInfo;
	import com.h3d.qqx5.common.event.CEventFinishEducation;
	import com.h3d.qqx5.common.event.CEventFirstLoginRewardNotify;
	import com.h3d.qqx5.common.event.CEventFollowAnchorOp;
	import com.h3d.qqx5.common.event.CEventFollowAnchorOpRes;
	import com.h3d.qqx5.common.event.CEventGetActivityCompletedCount;
	import com.h3d.qqx5.common.event.CEventGetActivityCompletedCountRes;
	import com.h3d.qqx5.common.event.CEventGetAllTags;
	import com.h3d.qqx5.common.event.CEventGetAllTagsRes;
	import com.h3d.qqx5.common.event.CEventGetAnchorFans;
	import com.h3d.qqx5.common.event.CEventGetAnchorFansRes;
	import com.h3d.qqx5.common.event.CEventGetDailySigninRewardContent;
	import com.h3d.qqx5.common.event.CEventGetDailySigninRewardContentRes;
	import com.h3d.qqx5.common.event.CEventGetFriendPayCashNotice;
	import com.h3d.qqx5.common.event.CEventGetGuestInfo;
	import com.h3d.qqx5.common.event.CEventGetGuestInfoRes;
	import com.h3d.qqx5.common.event.CEventGetJudgeTypes;
	import com.h3d.qqx5.common.event.CEventGetSigninRewardNotify;
	import com.h3d.qqx5.common.event.CEventGetSigninRewardNotifyRes;
	import com.h3d.qqx5.common.event.CEventGetVideoPlayerInfo;
	import com.h3d.qqx5.common.event.CEventGetVideoPlayerInfoRes;
	import com.h3d.qqx5.common.event.CEventGetVideoRoomLiveInfo;
	import com.h3d.qqx5.common.event.CEventGetVideoRoomLiveInfoRes;
	import com.h3d.qqx5.common.event.CEventGetVideoVoteHistory;
	import com.h3d.qqx5.common.event.CEventGetVideoVoteStartInfo;
	import com.h3d.qqx5.common.event.CEventGetVideoVoteStartInfoRes;
	import com.h3d.qqx5.common.event.CEventIgnoreFreeGift;
	import com.h3d.qqx5.common.event.CEventIgnoreFreeGiftRes;
	import com.h3d.qqx5.common.event.CEventInviteToDeputyAnchor;
	import com.h3d.qqx5.common.event.CEventLoadAllNestForRank;
	import com.h3d.qqx5.common.event.CEventLoadAllNestForRankRes;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpress;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpressForPlayer;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpressForPlayerRes;
	import com.h3d.qqx5.common.event.CEventLoadAnchorImpressRes;
	import com.h3d.qqx5.common.event.CEventLoadAnchorNameBatch;
	import com.h3d.qqx5.common.event.CEventLoadAnchorNameBatchRes;
	import com.h3d.qqx5.common.event.CEventLoadAnchorStarGiftInfoRes;
	import com.h3d.qqx5.common.event.CEventLoadAttachedPlayerInfo;
	import com.h3d.qqx5.common.event.CEventLoadAttachedPlayerInfoCard;
	import com.h3d.qqx5.common.event.CEventLoadAttachedPlayerInfoCardRes;
	import com.h3d.qqx5.common.event.CEventLoadAttachedPlayerInfoRes;
	import com.h3d.qqx5.common.event.CEventLoadFollowingAnchorInfo;
	import com.h3d.qqx5.common.event.CEventLoadFollowingAnchorInfoRes;
	import com.h3d.qqx5.common.event.CEventLoadMemberOperationInfo;
	import com.h3d.qqx5.common.event.CEventLoadMemberOperationInfoRes;
	import com.h3d.qqx5.common.event.CEventLoadNestID;
	import com.h3d.qqx5.common.event.CEventLoadNestIDRes;
	import com.h3d.qqx5.common.event.CEventLoadNestList;
	import com.h3d.qqx5.common.event.CEventLoadNestListRes;
	import com.h3d.qqx5.common.event.CEventLoadPlayerInfoForHomePage;
	import com.h3d.qqx5.common.event.CEventLoadPlayerInfoForHomePageRes;
	import com.h3d.qqx5.common.event.CEventLoadPreviewVideoTreasureBoxNewRole;
	import com.h3d.qqx5.common.event.CEventLoadPreviewVideoTreasureBoxNewRoleRes;
	import com.h3d.qqx5.common.event.CEventLoadRecommendVideoRoom;
	import com.h3d.qqx5.common.event.CEventLoadRecommendVideoRoomRes;
	import com.h3d.qqx5.common.event.CEventLoadStarGiftChampionRankRes;
	import com.h3d.qqx5.common.event.CEventLoadStarGiftRankRes;
	import com.h3d.qqx5.common.event.CEventLoadTalentShowScore;
	import com.h3d.qqx5.common.event.CEventLoadTalentShowScoreRes;
	import com.h3d.qqx5.common.event.CEventLoadVideoLevelRankRes;
	import com.h3d.qqx5.common.event.CEventLuckPlayerListIncrement;
	import com.h3d.qqx5.common.event.CEventMobileBlockPublicChat;
	import com.h3d.qqx5.common.event.CEventNestAssistantSetFunction;
	import com.h3d.qqx5.common.event.CEventNestAssistantSetFunctionRes;
	import com.h3d.qqx5.common.event.CEventNofityDeputyAnchorChange;
	import com.h3d.qqx5.common.event.CEventNotifyAllUserAdmin;
	import com.h3d.qqx5.common.event.CEventNotifyAllPlayerRoomIsClosing;
	import com.h3d.qqx5.common.event.CEventNotifyAnchorSecretCode;
	import com.h3d.qqx5.common.event.CEventNotifyConcertVideoGiftUsableIDs;
	import com.h3d.qqx5.common.event.CEventNotifyDivert;
	import com.h3d.qqx5.common.event.CEventNotifyFreeTakeSeatLeft;
	import com.h3d.qqx5.common.event.CEventNotifyFriendPayCash;
	import com.h3d.qqx5.common.event.CEventNotifyIsNoviceGuided;
	import com.h3d.qqx5.common.event.CEventNotifyLastHitPlayerReward;
	import com.h3d.qqx5.common.event.CEventNotifyLostVipSeat;
	import com.h3d.qqx5.common.event.CEventNotifyPlayerSecretHeatBox;
	import com.h3d.qqx5.common.event.CEventNotifyPkMatchInfo;
	import com.h3d.qqx5.common.event.CEventNotifyRaffleState;
	import com.h3d.qqx5.common.event.CEventNotifyRoomActivityComplete;
	import com.h3d.qqx5.common.event.CEventNotifySecretHeatBoxInfo;
	import com.h3d.qqx5.common.event.CEventNotifySendLotsOfGifts;
	import com.h3d.qqx5.common.event.CEventNotifyShowVideoGuildBoard;
	import com.h3d.qqx5.common.event.CEventNotifySplitScreenInfoChange;
	import com.h3d.qqx5.common.event.CEventNotifyUserAdminSystemInfo;
	import com.h3d.qqx5.common.event.CEventNotifyVipTakeSeatProtectTime;
	import com.h3d.qqx5.common.event.CEventPlayerDrawSecretHeatBoxReward;
	import com.h3d.qqx5.common.event.CEventQueryAnchorTaskNewRole;
	import com.h3d.qqx5.common.event.CEventQueryAnchorTaskNewRoleResWeb;
	import com.h3d.qqx5.common.event.CEventQueryDreamGift;
	import com.h3d.qqx5.common.event.CEventQueryDreamGiftRes;
	import com.h3d.qqx5.common.event.CEventRefreshAffinityRank;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorLevelRank;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorPKRank;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorScoreRank;
	import com.h3d.qqx5.common.event.CEventRefreshCommonActivityData;
	import com.h3d.qqx5.common.event.CEventRefreshFollowedAnchorsIDToClient;
	import com.h3d.qqx5.common.event.CEventRefreshGuildChampionRank;
	import com.h3d.qqx5.common.event.CEventRefreshLiveNestCnt;
	import com.h3d.qqx5.common.event.CEventRefreshLiveTaskInfoToClient;
	import com.h3d.qqx5.common.event.CEventRefreshPkGift;
	import com.h3d.qqx5.common.event.CEventRefreshPkProgressInfo;
	import com.h3d.qqx5.common.event.CEventRefreshPkValue;
	import com.h3d.qqx5.common.event.CEventRefreshPlayerContributePKRank;
	import com.h3d.qqx5.common.event.CEventRefreshPopularityRank;
	import com.h3d.qqx5.common.event.CEventRefreshRocketBuff;
	import com.h3d.qqx5.common.event.CEventRefreshRoomGuardSeats;
	import com.h3d.qqx5.common.event.CEventRefreshStarAnchorRank;
	import com.h3d.qqx5.common.event.CEventRefreshStarGiftInfo;
	import com.h3d.qqx5.common.event.CEventRefreshStarlightRank;
	import com.h3d.qqx5.common.event.CEventRefreshTwoweekStarlightRank;
	import com.h3d.qqx5.common.event.CEventRefreshVideoCeremonyActivity;
	import com.h3d.qqx5.common.event.CEventRefreshVideoCharInfoToClient;
	import com.h3d.qqx5.common.event.CEventRefreshVideoGiftConfig;
	import com.h3d.qqx5.common.event.CEventRefreshVideoGuildRank;
	import com.h3d.qqx5.common.event.CEventRefreshVideoRichRank;
	import com.h3d.qqx5.common.event.CEventRefreshVideoVIPRank;
	import com.h3d.qqx5.common.event.CEventRefreshVipInfoToClient;
	import com.h3d.qqx5.common.event.CEventRefreshVipSeats;
	import com.h3d.qqx5.common.event.CEventReportAnchor;
	import com.h3d.qqx5.common.event.CEventReportAnchorResult;
	import com.h3d.qqx5.common.event.CEventRoomCloseTime;
	import com.h3d.qqx5.common.event.CEventRoomGuardSeatLostNotify;
	import com.h3d.qqx5.common.event.CEventRoomOperationDenied;
	import com.h3d.qqx5.common.event.CEventScoreTalentShow;
	import com.h3d.qqx5.common.event.CEventScoreTalentShowBroadcast;
	import com.h3d.qqx5.common.event.CEventScoreTalentShowRes;
	import com.h3d.qqx5.common.event.CEventSetInvisibleOp;
	import com.h3d.qqx5.common.event.CEventSetInvisibleOpRes;
	import com.h3d.qqx5.common.event.CEventSetNoviceGuided;
	import com.h3d.qqx5.common.event.CEventSetVideoChatParameter;
	import com.h3d.qqx5.common.event.CEventSetVideoChatParameterRes;
	import com.h3d.qqx5.common.event.CEventSigninAccumulate;
	import com.h3d.qqx5.common.event.CEventSigninAccumulateRes;
	import com.h3d.qqx5.common.event.CEventSigninDaily;
	import com.h3d.qqx5.common.event.CEventSigninDailyRes;
	import com.h3d.qqx5.common.event.CEventStartConcertPlayback;
	import com.h3d.qqx5.common.event.CEventStartConcertPlaybackRes;
	import com.h3d.qqx5.common.event.CEventWeekStarConfigReq;
	import com.h3d.qqx5.common.event.CEventWeekStarConfigRsp;
	import com.h3d.qqx5.common.event.CEventStarGiftChampionNotify;
	import com.h3d.qqx5.common.event.CEventStartTalentShowMatch;
	import com.h3d.qqx5.common.event.CEventStartVideoCeremony;
	import com.h3d.qqx5.common.event.CEventStartVideoCeremonyBroadcast;
	import com.h3d.qqx5.common.event.CEventStartVideoCeremonyRes;
	import com.h3d.qqx5.common.event.CEventStartVideoVote;
	import com.h3d.qqx5.common.event.CEventStopTalentShowMatch;
	import com.h3d.qqx5.common.event.CEventStopVideoCeremony;
	import com.h3d.qqx5.common.event.CEventStopVideoCeremonyRes;
	import com.h3d.qqx5.common.event.CEventStopVideoCeremonyVote;
	import com.h3d.qqx5.common.event.CEventStopVideoCeremonyVoteBroadcast;
	import com.h3d.qqx5.common.event.CEventStopVideoCeremonyVoteRes;
	import com.h3d.qqx5.common.event.CEventStopVideoVote;
	import com.h3d.qqx5.common.event.CEventSwitchWhistleBroadcast;
	import com.h3d.qqx5.common.event.CEventSyncAnchor;
	import com.h3d.qqx5.common.event.CEventSyncChatBannedPlayers;
	import com.h3d.qqx5.common.event.CEventSyncPlayerDreamGiftAnchorExp;
	import com.h3d.qqx5.common.event.CEventSyncTalentShowJudge;
	import com.h3d.qqx5.common.event.CEventSyncVideoAccount;
	import com.h3d.qqx5.common.event.CEventTakeRoomGuardSeat;
	import com.h3d.qqx5.common.event.CEventTakeRoomGuardSeatRes;
	import com.h3d.qqx5.common.event.CEventTakeVideoVote;
	import com.h3d.qqx5.common.event.CEventTakeVipSeat;
	import com.h3d.qqx5.common.event.CEventTakeVipSeatRes;
	import com.h3d.qqx5.common.event.CEventTalentShowStateChangeNotify;
	import com.h3d.qqx5.common.event.CEventTestPing;
	import com.h3d.qqx5.common.event.CEventTestPingRes;
	import com.h3d.qqx5.common.event.CEventVSStopDeputyAnchor;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyAnchorEnterLeaveRoom;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyChooseSupportAnchor;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyLoadInfoFromDBRes;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyPlayerAffinityChanged;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyPlayerEnterRoom;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyPlayerEnterRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyPlayerSendGift;
	import com.h3d.qqx5.common.event.CEventVideoCeremonySaveInfoToDB;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyStartInfo;
	import com.h3d.qqx5.common.event.CEventVideoCeremonySyncDataInRoomServer;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyTimeEnd;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyTimeStart;
	import com.h3d.qqx5.common.event.CEventVideoCeremonyTransmitWhistleMsg;
	import com.h3d.qqx5.common.event.CEventVideoChatBanForAllRoom;
	import com.h3d.qqx5.common.event.CEventVideoChatBanForAllRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoChatResult;
	import com.h3d.qqx5.common.event.CEventVideoEventSpeedLimit;
	import com.h3d.qqx5.common.event.CEventVideoGetExternalRewardCountDescRes;
	import com.h3d.qqx5.common.event.CEventVideoGetExternalRewardDesc;
	import com.h3d.qqx5.common.event.CEventVideoGetExternalRewardDescRes;
	import com.h3d.qqx5.common.event.CEventVideoGetGiftPoolBoxInfo;
	import com.h3d.qqx5.common.event.CEventVideoGetGiftPoolBoxInfoRes;
	import com.h3d.qqx5.common.event.CEventVideoGiftPoolHeightChange;
	import com.h3d.qqx5.common.event.CEventVideoLoadRoomAdmins;
	import com.h3d.qqx5.common.event.CEventVideoLoadRoomAdminsRes;
	import com.h3d.qqx5.common.event.CEventVideoOpenGiftPoolBox;
	import com.h3d.qqx5.common.event.CEventVideoOpenGiftPoolBoxRes;
	import com.h3d.qqx5.common.event.CEventVideoPlayerHeartBeatNotify;
	import com.h3d.qqx5.common.event.CEventVideoQueryBalance;
	import com.h3d.qqx5.common.event.CEventVideoQueryBalanceRes;
	import com.h3d.qqx5.common.event.CEventVideoQueryVideoMoney;
	import com.h3d.qqx5.common.event.CEventVideoQueryVideoMoneyRes;
	import com.h3d.qqx5.common.event.CEventVideoRaffle;
	import com.h3d.qqx5.common.event.CEventVideoRaffleRes;
	import com.h3d.qqx5.common.event.CEventVideoRankChangeBroadcastAllPlayer;
	import com.h3d.qqx5.common.event.CEventVideoRefreshFlower;
	import com.h3d.qqx5.common.event.CEventVideoRefreshFreeGift;
	import com.h3d.qqx5.common.event.CEventVideoRoomAdminOperation;
	import com.h3d.qqx5.common.event.CEventVideoRoomAdminOperationRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomAdminStopLive;
	import com.h3d.qqx5.common.event.CEventVideoRoomAdminStopLiveRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomAnchorImageRefresh;
	import com.h3d.qqx5.common.event.CEventVideoRoomAssignSuperGuard;
	import com.h3d.qqx5.common.event.CEventVideoRoomAssignSuperGuardRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomBasicInfos;
	import com.h3d.qqx5.common.event.CEventVideoRoomBeKicked;
	import com.h3d.qqx5.common.event.CEventVideoRoomCanEnterRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomCanEnterRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomChatBan;
	import com.h3d.qqx5.common.event.CEventVideoRoomChatBanRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomCheckNick;
	import com.h3d.qqx5.common.event.CEventVideoRoomCheckNickRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomCloseLuckyDrawWindow;
	import com.h3d.qqx5.common.event.CEventVideoRoomCreateVideoRole;
	import com.h3d.qqx5.common.event.CEventVideoRoomCreateVideoRoleRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomDeleteRoomPic;
	import com.h3d.qqx5.common.event.CEventVideoRoomDeleteRoomPicRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoomBroadcast;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoomBroadcastAllRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomEnterRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetLiveCDN;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetLiveCDNRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomInfoRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomList;
	import com.h3d.qqx5.common.event.CEventVideoRoomGetRoomListRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomGuardLevelChange;
	import com.h3d.qqx5.common.event.CEventVideoRoomKickPlayer;
	import com.h3d.qqx5.common.event.CEventVideoRoomKickPlayerRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomLeaveRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomLeaveRoomRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomLiveBeStoped;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadPlayerList;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadPlayerListRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadProgramme;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadSuperFans;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadSuperGuardResult;
	import com.h3d.qqx5.common.event.CEventVideoRoomLoadVipSeatsInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDraw;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDrawActivityInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDrawNotice;
	import com.h3d.qqx5.common.event.CEventVideoRoomLuckyDrawRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomModifyNick;
	import com.h3d.qqx5.common.event.CEventVideoRoomModifyNickRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomNotifyAnchorStartLive;
	import com.h3d.qqx5.common.event.CEventVideoRoomNotifyAttachRoomInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomNotifyLiveStart;
	import com.h3d.qqx5.common.event.CEventVideoRoomNotifyLiveStop;
	import com.h3d.qqx5.common.event.CEventVideoRoomOpenLuckyDrawWindow;
	import com.h3d.qqx5.common.event.CEventVideoRoomOpenLuckyDrawWindowRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomPlayerCount;
	import com.h3d.qqx5.common.event.CEventVideoRoomPlayerTakeVipSeat;
	import com.h3d.qqx5.common.event.CEventVideoRoomQueryFollowedAnchorLiveStart;
	import com.h3d.qqx5.common.event.CEventVideoRoomRecedeSuperGuard;
	import com.h3d.qqx5.common.event.CEventVideoRoomRecedeSuperGuardRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshCurrentAnchorDetail;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshGuardLevel;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshLiveStatus;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshRoomAttribute;
	import com.h3d.qqx5.common.event.CEventVideoRoomRefreshRoomPicInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomRequestDeputyAnchor;
	import com.h3d.qqx5.common.event.CEventVideoRoomRequestDeputyAnchorRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomRequestQstoreDownloadKey;
	import com.h3d.qqx5.common.event.CEventVideoRoomRequestQstoreDownloadKeyRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomShareConfig;
	import com.h3d.qqx5.common.event.CEventVideoRoomStartLiveRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomSyncAdminRooms;
	import com.h3d.qqx5.common.event.CEventVideoRoomSyncAnchorRooms;
	import com.h3d.qqx5.common.event.CEventVideoRoomSyncLuckyDrawInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomTransmitToAllOtherRoom;
	import com.h3d.qqx5.common.event.CEventVideoRoomTransmitToAllPlayer;
	import com.h3d.qqx5.common.event.CEventVideoRoomTransmitToAllVideoGuildPlayer;
	import com.h3d.qqx5.common.event.CEventVideoRoomTransmitToOnePlayer;
	import com.h3d.qqx5.common.event.CEventVideoRoomUploadAnchorImage;
	import com.h3d.qqx5.common.event.CEventVideoRoomUploadAnchorImageRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomUploadAnchorPortrait;
	import com.h3d.qqx5.common.event.CEventVideoRoomUploadAnchorPortraitRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomUploadRoomPic;
	import com.h3d.qqx5.common.event.CEventVideoRoomUploadRoomPicRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomVipSeatsInfo;
	import com.h3d.qqx5.common.event.CEventVideoRoomWebTipsNotify;
	import com.h3d.qqx5.common.event.CEventVideoSearchOnlinePlayer;
	import com.h3d.qqx5.common.event.CEventVideoSearchOnlinePlayerRes;
	import com.h3d.qqx5.common.event.CEventVideoSendGift;
	import com.h3d.qqx5.common.event.CEventVideoSendGiftResult;
	import com.h3d.qqx5.common.event.CEventVideoShutDown;
	import com.h3d.qqx5.common.event.CEventVideoSyncPlayerChatBanState;
	import com.h3d.qqx5.common.event.CEventVideoToClientChatMessage;
	import com.h3d.qqx5.common.event.CEventVideoToServerChatMessage;
	import com.h3d.qqx5.common.event.CEventVideoTreasureBoxRewardNewRoleWeb;
	import com.h3d.qqx5.common.event.CEventVideoUserLogin;
	import com.h3d.qqx5.common.event.CEventVideoVoteHistoryRes;
	import com.h3d.qqx5.common.event.CEventVideoVoteRes;
	import com.h3d.qqx5.common.event.CEventVipGuildMemberGiftAddAnchorScore;
	import com.h3d.qqx5.common.event.CEventVisitAnchor;
	import com.h3d.qqx5.common.event.CEventVisitAnchorRes;
	import com.h3d.qqx5.common.event.CEventWhistleLastHitPlayer;
	import com.h3d.qqx5.common.event.CEventRefreshWeekStarRankRes;
	import com.h3d.qqx5.common.event.CEventWeekStarConfigReq;
	import com.h3d.qqx5.common.event.CEventWeekStarConfigRsp;
	import com.h3d.qqx5.common.event.CEventWeekStarNotifySucc;
	import com.h3d.qqx5.common.event.CEventAnchorWeekStarMatchSettleNotify;
	import com.h3d.qqx5.common.event.CEventAnchorWeekStarLevelUpNotify;
	import com.h3d.qqx5.common.event.ad.CEventVideoAD;
	import com.h3d.qqx5.common.event.ad.CEventVideoRoomAdClick;
	import com.h3d.qqx5.common.event.eventid.AnchorLoginDatabaseEventID;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.common.event.eventid.AnchorSyncInfoEventID;
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.common.event.eventid.ConcertEventID;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.event.eventid.EventNewGrowthID;
	import com.h3d.qqx5.common.event.eventid.HotboxSecretBoxLastHitPlayerEventID;
	import com.h3d.qqx5.common.event.eventid.MobileUserAdminId;
	import com.h3d.qqx5.common.event.eventid.NewGrowthEventID;
	import com.h3d.qqx5.common.event.eventid.PlaybackEventID;
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.common.event.eventid.SplitScreenEventID;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;
	import com.h3d.qqx5.common.event.eventid.VideoPersonalCardEventID;
	import com.h3d.qqx5.common.event.eventid.VideoVoteEvent;
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
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
	import com.h3d.qqx5.common.specialevent.CEventVideoSendGiftResultForWeb;
	import com.h3d.qqx5.common.specialevent.CEventVideoToClientChatMessageForWeb;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.callcenter.CallCenter;
	import com.h3d.qqx5.framework.callcenter.event.CEventClientConnectRoomProxyTransResult;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoInitConnectionRequest;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoInitConnectionResponse;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoReconnectVerifyReponse;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoReconnectVerifyRequest;
	import com.h3d.qqx5.framework.callcenter.event.CallCenterMessageID;
	import com.h3d.qqx5.framework.interfaces.ICallCenter;
	import com.h3d.qqx5.framework.network.CEventRoomProxyWrapEvent;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.MessageID;
	import com.h3d.qqx5.modules.anchor_nest.events.AnchorNestEventID;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAddNestPopularityCreditsRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestGetSupportUIInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestGetSupportUIInfoRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestNormalSupport;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestNormalSupportRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestNotifyAdvSupport;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestRefreshAnchorData;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestRefreshPopularityInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventChangeAttchRoomToRank;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventChangeNestAttachedRoomInDB;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventChangeNestStatusInDB;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventDelAllNestStar;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventDelAnchorNestAssistant;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventDelAnchorNestInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventDelAnchorNestRank;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventDelPlayerNestStar;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventFreezeNestByOwnerQQ;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventGetGuardWage;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventGetNestGrowUpInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventLoadAnchorNestInfoFromDB;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventLoadAnchorNestInfoRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventLoadPlayerNestStar;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventLoadPlayerNestStarRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventNestGrowUpInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventNotifyNestIsFreezing;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventRefreshAddPopularityToClient;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventRefreshNestCreditsLevel;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventRefreshVideoAnchorNestRank;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventSaveAnchorNestAssistant;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventSaveAnchorNestInfoToDB;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventSaveAnchorNestInfoToDBRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventSavePlayerNestStar;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventUpdateAnchorNestRank;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventUpdatePlayerNestStarToDB;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventVideoRoomAddNestAssistant;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventVideoRoomAddNestAssistantRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventVideoRoomDelNestAssistant;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventVideoRoomDelNestAssistantRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventVideoRoomLoadNestAssistantList;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventVideoRoomLoadNestAssistantListRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventVideoRoomNestAssistantChange;
	import com.h3d.qqx5.modules.anchor_nest.events.CeventVideoRoomInitNestAssistantList;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKForecast;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKLoadMatchDetail;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKLoadMatchDetailRes;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKLoadPlayerAvatar;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKLoadPlayerAvatarRes;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKMatchEndBroadcast;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKMatchStop;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKNotifyAnchorData;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKNotifyAnchorSelfInfo;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKNotifyBuff;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKNotifyClearAvatar;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKNotifyPlayerAvatar;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKNotifyPlayerAvatarExtInfo;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKPreAttack;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKShowEnd;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKStartMatch;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKStartMatchNotify;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKStartMatchRes;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKStopMatch;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKStopMatchRes;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKSyncActivityStatus;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKSyncInfoEnterRoom;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventAnchorPKSyncMatchStatus;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventGetAnchorListInRoom;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventGetAnchorListInRoomRes;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventLoadAnchorPKWinnerFromDB;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventLoadAnchorPKWinnerFromDBRes;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventPlayerContributionInCurPK;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventPlayerContributionInCurPKRes;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventRefreshAnchorPKRichmanRank;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventRefreshAnchorPKWinnerRank;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventSaveAnchorPKGuildToDB;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventUpdateAnchorPKRichmanRank;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventVideoRoomNotifyPKAnchorStartLive;
	import com.h3d.qqx5.modules.anchor_pk.event.VideoAnchorPKEventID;
	import com.h3d.qqx5.modules.anchor_task.shared.event.AnchorTaskEventID;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventDropAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventDropAnchorTaskRes;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventNotifyAnchorTaskUnavailable;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventNotifyAudiencePublishAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventPublishAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventPublishAnchorTaskRes;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventQueryAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventRemoveAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventTakeAnchorTask;
	import com.h3d.qqx5.modules.anchor_task.shared.event.CEventTakeAnchorTaskRes;
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
	import com.h3d.qqx5.modules.nest_task.event.AnchorNestTaskEventID;
	import com.h3d.qqx5.modules.nest_task.event.CEventNotifyAnchorPublishNestTask;
	import com.h3d.qqx5.modules.nest_task.event.CEventNotifyAudienceTreasureBoxStatus;
	import com.h3d.qqx5.modules.nest_task.event.CEventNotifyNestTaskFinished;
	import com.h3d.qqx5.modules.nest_task.event.CEventQueryNestTaskRewardNewRole;
	import com.h3d.qqx5.modules.nest_task.event.CEventQueryNestTaskRewardNewRoleRes;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTask;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTaskRes;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTreasureBox;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTreasureBoxErrRes;
	import com.h3d.qqx5.modules.rand_nick.CEventGetRandNick;
	import com.h3d.qqx5.modules.rand_nick.CEventGetRandNickRes;
	import com.h3d.qqx5.modules.rand_nick.RandNickEventID;
	import com.h3d.qqx5.modules.red_envelope.share.CEventChatIgnoreListOperate;
	import com.h3d.qqx5.modules.red_envelope.share.CEventGrabRedEnvelope;
	import com.h3d.qqx5.modules.red_envelope.share.CEventGrabRedEnvelopeRes;
	import com.h3d.qqx5.modules.red_envelope.share.CEventLoadRedEnvelope;
	import com.h3d.qqx5.modules.red_envelope.share.CEventLoadRedEnvelopeRes;
	import com.h3d.qqx5.modules.red_envelope.share.CEventPublishRedEnvelope;
	import com.h3d.qqx5.modules.red_envelope.share.VideoRedEnvelopeEventId;
	import com.h3d.qqx5.modules.surprise_box.event.CEventOpenSurpriseBox;
	import com.h3d.qqx5.modules.surprise_box.event.CEventOpenSurpriseBoxRes;
	import com.h3d.qqx5.modules.surprise_box.event.CEventQuerySurpriseBox;
	import com.h3d.qqx5.modules.surprise_box.event.CEventQuerySurpriseBoxRes;
	import com.h3d.qqx5.modules.surprise_box.event.CEventUpdateSurpriseBoxStatus;
	import com.h3d.qqx5.modules.surprise_box.event.VideoSurpriseBoxEventID;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	import com.h3d.qqx5.modules.video_activity.event.CEventGetActivityCenterInfosRes;
	import com.h3d.qqx5.modules.video_activity.event.CEventNotifyActivityCompletedCount;
	import com.h3d.qqx5.modules.video_activity.event.CEventNotifyWebActivityGuide;
	import com.h3d.qqx5.modules.video_activity.event.CEventTakeDailyWageRes;
	import com.h3d.qqx5.modules.video_activity.event.CEventTakeVideoActivityRewardsRes;
	import com.h3d.qqx5.modules.video_guild.share.event.*;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventAddVideoVipRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventBuyVideoVip;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventBuyVideoVipRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventBuyVipNotice;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventCancelFollowAnchorFromPlayerCard;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventCancelFollowAnchorFromPlayerCardRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventGetVideoPlayerCardInfo;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventGetVideoPlayerCardInfoRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventModifyVideoPlayerCardSignature;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventModifyVideoPlayerCardSignatureRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventNotifyUploadVideoCardPortrait;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryBuyVideoVipPrice;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryBuyVideoVipPriceRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeSuperStarHornLeft;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeSuperStarHornLeftRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeWhistleLeft;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeWhistleLeftRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventTakeVideoVipDailyRewards;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventTakeVideoVipDailyRewardsRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventUploadVideoPlayerCardPortrait;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventUploadVideoPlayerCardPortraitRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventVideoVipExpireNotify;
	import com.h3d.qqx5.modules.video_vip.shared.event.VideoVipEventID;
	import com.h3d.qqx5.share.game_event.CEventFragment;
	import com.h3d.qqx5.share.game_event.EventFragmentID;
	import com.h3d.qqx5.tqos.TQOSHomePageLoadTime;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorNestClient;
	import com.h3d.qqx5.videoclient.interfaces.IClientSurpriseBoxManager;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientPlayer;
	import com.h3d.qqx5.videoclient.interfaces.IVideoGuildClient;
	import com.h3d.qqx5.videoclient.main.CRedEnvelopeClient;
	import com.h3d.qqx5.videoclient.main.CX5VideoClient;
	
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;
	
	/**
	 * @author liuchui
	 */
	public class VideoClient
	{
		private var _videoClient:CX5VideoClient = null;
		private var _callCenter:ICallCenter = null;
//		private var _versionCallCenter:VersionCallCenter = null;
		private var _loadFinish:Boolean = false;
		//private var m_videoModuleManager:VideoClientModuleManager = null;
		public function VideoClient(callback:IVideoClientLogicCallback)
		{
			_videoClient = new CX5VideoClient;
			_callCenter = new CallCenter(_videoClient, LoadFinish);
			
			_videoClient.SetCallCenter(_callCenter);
			_videoClient.GetInterfacesForUI().SetLogicCallBack(callback);
			
//			_versionCallCenter = new VersionCallCenter(LoadFinish);
//			Globals.sVersionCallCenter = _versionCallCenter;
			
			RegisterEventAndTrans();
			/*
			m_videoModuleManager = new VideoClientModuleManager();
			var moduledump:VideoClientModuleDump = new VideoClientModuleDump(m_videoModuleManager);
			m_videoModuleManager.AddVideoModule(moduledump,moduledump.GetModuleName());
			m_videoModuleManager.InitVideoModules(_callCenter,_versionCallCenter);
			var module:VideoClientModuleBase = m_videoModuleManager.GetModule(moduledump.GetModuleName());
			var id:IDump = module as IDump;
			id.Haha();
			*/
		}
		
		public function LoadFinish():void
		{
			if(_videoClient.GetUICallback() != null)
			{
				TQOSHomePageLoadTime.nBeginTime = flash.utils.getTimer();
				_videoClient.GetUICallback().onLoadFinish();
			}
			else 
			{
				_loadFinish = true;
			}
		}
		
		public function GetCX5VideoClient():CX5VideoClient
		{
			return _videoClient;
		}
		public function GetCRedEnvelopeClient():CRedEnvelopeClient
		{
			return _videoClient.GetCRedEnvelopeClient();
		}
		
		public function GetVideoGuildClient():IVideoGuildClient
		{
			return _videoClient.GetVideoGuildClient();
		}
		
		public function GetNestClient():IAnchorNestClient
		{
			return _videoClient.GetNestClient();
		}
		
		public function GetSurpriseBoxMng():IClientSurpriseBoxManager
		{
			return _videoClient.GetSurpriseBoxMng();
		}
		
		public function GetVideoClientPlayer():IVideoClientPlayer
		{
			return _videoClient.GetVideoClientPlayer();
		}
		
		private function RegisterEventAndTrans():void
		{
			register_video_room_client_server_event_no_use();
			register_anchor_sync_events();
			register_edit_account_events();
			event_video_room_register_no_use();
			event_register_video_personal_card();
			//room_proxy_events_register();
			//room_proxy_wrap_events_register();
			event_fragment_register();
			video_surprise_box_event_register_no_use();
			video_vote_event_register_no_use();
			video_guild_event_register_no_use();
			video_vip_event_register_no_use();
			video_anchor_pk_event_register_no_use();
			video_clear_room_event_register_no_use();
			video_ceremony_event_register_no_use();
			video_anchor_task_event_register_no_use();
			video_red_envelope_event_register_no_use();
			video_anchor_nest_event_register_no_use();
			video_create_role_event_register_no_use();
			
			video_concert_event_register_no_use();
			video_raffle_event_reg_no_use();
			//热度宝箱密令和补刀王相关
			register_secret_box_server_event();
			//演唱会回放相关
			register_playback_server_event();
			//周星赛
			register_weekstar_server_event();
		}
		
		
		private function video_raffle_event_reg_no_use():void
		{
			_callCenter.add_message_handler(RaffleEventID.CLSID_CEventNotifyRaffleState, 
				getQualifiedClassName(CEventNotifyRaffleState), HandleServerEvent);
			_callCenter.add_message_handler(RaffleEventID.CLSID_CEventVideoRaffle, 
				getQualifiedClassName(CEventVideoRaffle), HandleServerEvent);
			_callCenter.add_message_handler(RaffleEventID.CLSID_CEventVideoRaffleRes, 
				getQualifiedClassName(CEventVideoRaffleRes), HandleServerEvent);
			_callCenter.add_message_handler(RaffleEventID.CLSID_CEventLuckPlayerListIncrement, 
				getQualifiedClassName(CEventLuckPlayerListIncrement), HandleServerEvent);
		}
		private function video_concert_event_register_no_use():void
		{
			_callCenter.add_message_handler(ConcertEventID.CLSID_CEventSwitchWhistleBroadcast, 
				getQualifiedClassName(CEventSwitchWhistleBroadcast), HandleServerEvent);	
			_callCenter.add_message_handler(ConcertEventID.CLSID_CEventConcertStatusChange, 
				getQualifiedClassName(CEventConcertStatusChange), HandleServerEvent);
			_callCenter.add_message_handler(ConcertEventID.CLSID_CEventRefreshLiveTaskInfoToClient, 
				getQualifiedClassName(CEventRefreshLiveTaskInfoToClient), HandleServerEvent);
			_callCenter.add_message_handler(ConcertEventID.CLSID_CEventNotifyDivert, 
				getQualifiedClassName(CEventNotifyDivert), HandleServerEvent);

		}
		
		private function video_create_role_event_register_no_use():void
		{
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCreateVideoRole, 
				getQualifiedClassName(CEventVideoRoomCreateVideoRole), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCreateVideoRoleRes, 
				getQualifiedClassName(CEventVideoRoomCreateVideoRoleRes), HandleServerEvent);
		}
		
		
		private function room_proxy_wrap_events_register():void
		{
			_callCenter.add_message_handler(MessageID.CLSID_CEventRoomProxyWrapEvent, 
				getQualifiedClassName(CEventRoomProxyWrapEvent), HandleServerEvent);
		}
		
		private function event_fragment_register():void
		{
			
			_callCenter.add_message_handler(EventFragmentID.CLSID_CEventFragment, 
				getQualifiedClassName(CEventFragment), HandleServerEvent);
		}
		
		private function video_surprise_box_event_register_no_use():void
		{
			_callCenter.add_message_handler(VideoSurpriseBoxEventID.CLSID_CEventUpdateSurpriseBoxStatus, 
				getQualifiedClassName(CEventUpdateSurpriseBoxStatus), HandleServerEvent);
			_callCenter.add_message_handler(VideoSurpriseBoxEventID.CLSID_CEventOpenSurpriseBox, 
				getQualifiedClassName(CEventOpenSurpriseBox), HandleServerEvent);
			_callCenter.add_message_handler(VideoSurpriseBoxEventID.CLSID_CEventQuerySurpriseBoxRes, 
				getQualifiedClassName(CEventQuerySurpriseBoxRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoSurpriseBoxEventID.CLSID_CEventQuerySurpriseBox, 
				getQualifiedClassName(CEventQuerySurpriseBox), HandleServerEvent);
			_callCenter.add_message_handler(VideoSurpriseBoxEventID.CLSID_CEventOpenSurpriseBoxRes, 
				getQualifiedClassName(CEventOpenSurpriseBoxRes), HandleServerEvent);
		}
		
		private function video_vote_event_register_no_use():void
		{
			
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventStartVideoVote, 
				getQualifiedClassName(CEventStartVideoVote), HandleServerEvent);
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventStopVideoVote, 
				getQualifiedClassName(CEventStopVideoVote), HandleServerEvent);
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventTakeVideoVote, 
				getQualifiedClassName(CEventTakeVideoVote), HandleServerEvent);
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventGetVideoVoteHistory, 
				getQualifiedClassName(CEventGetVideoVoteHistory), HandleServerEvent);
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventVideoVoteHistoryRes, 
				getQualifiedClassName(CEventVideoVoteHistoryRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventVideoVoteRes, 
				getQualifiedClassName(CEventVideoVoteRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventGetVideoVoteStartInfo, 
				getQualifiedClassName(CEventGetVideoVoteStartInfo), HandleServerEvent);
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventGetVideoVoteStartInfoRes, 
				getQualifiedClassName(CEventGetVideoVoteStartInfoRes), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoVoteEvent.CLSID_CEventEnterRoomNotifyVoteInfo, 
				getQualifiedClassName(CEventEnterRoomNotifyVoteInfo), HandleServerEvent);
		}
		
		private function video_guild_event_register_no_use():void
		{
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadVideoGuildList, 
				getQualifiedClassName(CEventLoadVideoGuildList), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadMyVideoGuild, 
				getQualifiedClassName(CEventLoadMyVideoGuild), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadMyVideoGuildResult, 
				getQualifiedClassName(CEventLoadMyVideoGuildResult), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadVideoGuildListResult, 
				getQualifiedClassName(CEventLoadVideoGuildListResult), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildReqSimpleInfo ,
				getQualifiedClassName(CEventVideoGuildReqSimpleInfo), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildReqSimpleInfoRes, 
				getQualifiedClassName(CEventVideoGuildReqSimpleInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildHash ,
				getQualifiedClassName(CEventVideoGuildHash), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildHashError ,
				getQualifiedClassName(CEventVideoGuildHashError), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildCreate ,
				getQualifiedClassName(CEventVideoGuildCreate), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildCreateRes ,
				getQualifiedClassName(CEventVideoGuildCreateRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildCreateNotify ,
				getQualifiedClassName(CEventVideoGuildCreateNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildCreateNotifyRes ,
				getQualifiedClassName(CEventVideoGuildCreateNotifyRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventCheckVideoGuildNameDup ,
				getQualifiedClassName(CEventCheckVideoGuildNameDup), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventCheckVideoGuildNameDupRes ,
				getQualifiedClassName(CEventCheckVideoGuildNameDupRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildOperateLogicLock ,
				getQualifiedClassName(CEventVideoGuildOperateLogicLock), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildOperateLogicLockRes ,
				getQualifiedClassName(CEventVideoGuildOperateLogicLockRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorCardGetVideoGuildList ,
				getQualifiedClassName(CEventAnchorCardGetVideoGuildList), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorCardGetVideoGuildListResult,
				getQualifiedClassName(CEventAnchorCardGetVideoGuildListResult), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadVideoGuildLogRecord ,
				getQualifiedClassName(CEventLoadVideoGuildLogRecord), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadVideoGuildLogRecordResult ,
				getQualifiedClassName(CEventLoadVideoGuildLogRecordResult), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventUpdateVideoGuildLogRecordResult ,
				getQualifiedClassName(CEventUpdateVideoGuildLogRecordResult), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildRefreshToGuildSummary ,
				getQualifiedClassName(CEventVideoGuildRefreshToGuildSummary), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSendVideoGuildJoinApply ,
				getQualifiedClassName(CEventSendVideoGuildJoinApply), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSendVideoGuildJoinApplyRes ,
				getQualifiedClassName(CEventSendVideoGuildJoinApplyRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuild ,
				getQualifiedClassName(CEventInviteToJoinVideoGuild), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuildRes,
				getQualifiedClassName(CEventInviteToJoinVideoGuildRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuildNotify ,
				getQualifiedClassName(CEventInviteToJoinVideoGuildNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildInvite ,
				getQualifiedClassName(CEventOperateVideoGuildInvite), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildInviteRes ,
				getQualifiedClassName(CEventOperateVideoGuildInviteRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildInviteNotify ,
				getQualifiedClassName(CEventOperateVideoGuildInviteNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApply ,
				getQualifiedClassName(CEventOperateVideoGuildJoinApply), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyRes ,
				getQualifiedClassName(CEventOperateVideoGuildJoinApplyRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyNotify, 
				getQualifiedClassName(CEventOperateVideoGuildJoinApplyNotify), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyNotifyRes ,
				getQualifiedClassName(CEventOperateVideoGuildJoinApplyNotifyRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyNotifyCount ,
				getQualifiedClassName(CEventOperateVideoGuildJoinApplyNotifyCount), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAddVideoGuildMemberFromJoinApply ,
				getQualifiedClassName(CEventAddVideoGuildMemberFromJoinApply), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAddVideoGuildMemberFromJoinApplyRes, 
				getQualifiedClassName(CEventAddVideoGuildMemberFromJoinApplyRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAcceptJoinApplyTargetOnlineNotify ,
				getQualifiedClassName(CEventAcceptJoinApplyTargetOnlineNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetVideoGuildJoinApplyList ,
				getQualifiedClassName(CEventGetVideoGuildJoinApplyList), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetVideoGuildJoinApplyListRes ,
				getQualifiedClassName(CEventGetVideoGuildJoinApplyListRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventUpdateMyVideoGuildInfo ,
				getQualifiedClassName(CEventUpdateMyVideoGuildInfo), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventUpdateMyVideoGuildInfoRes, 
				getQualifiedClassName(CEventUpdateMyVideoGuildInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildRename, 
				getQualifiedClassName(CEventVideoGuildRename), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildRenameRes, 
				getQualifiedClassName(CEventVideoGuildRenameRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVerifyAnchorType ,
				getQualifiedClassName(CEventVerifyAnchorType), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVerifyAnchorTypeRes ,
				getQualifiedClassName(CEventVerifyAnchorTypeRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventForbidVideoGuildJoinApply ,
				getQualifiedClassName(CEventForbidVideoGuildJoinApply), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventRefuseVideoGuildJoinApplyNotify ,
				getQualifiedClassName(CEventRefuseVideoGuildJoinApplyNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildKickMember, 
				getQualifiedClassName(CEventVideoGuildKickMember), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildDisband, 
				getQualifiedClassName(CEventVideoGuildDisband), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildDismiss ,
				getQualifiedClassName(CEventVideoGuildDismiss), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildChangeAnchor, 
				getQualifiedClassName(CEventVideoGuildChangeAnchor), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildChangeAnchorRes, 
				getQualifiedClassName(CEventVideoGuildChangeAnchorRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildChangeAnchorNotify ,
				getQualifiedClassName(CEventVideoGuildChangeAnchorNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildDisbandNotify ,
				getQualifiedClassName(CEventVideoGuildDisbandNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildDemiseNotify ,
				getQualifiedClassName(CEventVideoGuildDemiseNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuild ,
				getQualifiedClassName(CEventLoadDBVideoGuild), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuildPosition ,
				getQualifiedClassName(CEventLoadDBVideoGuildPosition), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuildRes ,
				getQualifiedClassName(CEventLoadDBVideoGuildRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadVideoGuildLogFromDB, 
				getQualifiedClassName(CEventLoadVideoGuildLogFromDB), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadVideoGuildLogFromDBRes, 
				getQualifiedClassName(CEventLoadVideoGuildLogFromDBRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSaveVideoGuildLogToDB, 
				getQualifiedClassName(CEventSaveVideoGuildLogToDB), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSaveVideoGuildLogToDBRes ,
				getQualifiedClassName(CEventSaveVideoGuildLogToDBRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventDeleteVideoGuildLogFromDB ,
				getQualifiedClassName(CEventDeleteVideoGuildLogFromDB), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventDeleteVideoGuildLogFromDBRes ,
				getQualifiedClassName(CEventDeleteVideoGuildLogFromDBRes), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuildPositionRes, 
				getQualifiedClassName(CEventLoadDBVideoGuildPositionRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSaveDBVideoGuildPosition ,
				getQualifiedClassName(CEventSaveDBVideoGuildPosition), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventDelDBVideoGuildPosition ,
				getQualifiedClassName(CEventDelDBVideoGuildPosition), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildInfoSaveToDB ,
				getQualifiedClassName(CEventVideoGuildInfoSaveToDB), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildInfoSaveToDBRes ,
				getQualifiedClassName(CEventVideoGuildInfoSaveToDBRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildInfoDelFromDB ,
				getQualifiedClassName(CEventVideoGuildInfoDelFromDB), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSaveDBVideoGuildMember ,
				getQualifiedClassName(CEventSaveDBVideoGuildMember), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuildMember, 
				getQualifiedClassName(CEventLoadDBVideoGuildMember), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventDelDBVideoGuildMember ,
				getQualifiedClassName(CEventDelDBVideoGuildMember), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuildMemberRes ,
				getQualifiedClassName(CEventLoadDBVideoGuildMemberRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuildApplyRes, 
				getQualifiedClassName(CEventLoadDBVideoGuildApplyRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadDBVideoGuildApply ,
				getQualifiedClassName(CEventLoadDBVideoGuildApply), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildJoinApplySaveToDB ,
				getQualifiedClassName(CEventVideoGuildJoinApplySaveToDB), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildJoinApplyDelFromDB, 
				getQualifiedClassName(CEventVideoGuildJoinApplyDelFromDB), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoginVideoRoomNotify ,
				getQualifiedClassName(CEventLoginVideoRoomNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildStartLiveNotify ,
				getQualifiedClassName(CEventVideoGuildStartLiveNotify), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGetAnchorFirstGuild, 
				getQualifiedClassName(CEventVideoGetAnchorFirstGuild), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGetAnchorFirstGuildRes, 
				getQualifiedClassName(CEventVideoGetAnchorFirstGuildRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSendVideoGuildMonthTicket, 
				getQualifiedClassName(CEventSendVideoGuildMonthTicket), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSendVideoGuildMonthTicketRes, 
				getQualifiedClassName(CEventSendVideoGuildMonthTicketRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSendVideoGuildSignIn, 
				getQualifiedClassName(CEventSendVideoGuildSignIn), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildBuyFansBoard ,
				getQualifiedClassName(CEventVideoGuildBuyFansBoard), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildBuyFansBoardRes ,
				getQualifiedClassName(CEventVideoGuildBuyFansBoardRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetFirstVideoGuildBoardInfo, 
				getQualifiedClassName(CEventGetFirstVideoGuildBoardInfo), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildClearApply ,
				getQualifiedClassName(CEventVideoGuildClearApply), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildBroadcast ,
				getQualifiedClassName(CEventVideoGuildBroadcast), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventNotifyAnchorScoreChange, 
				getQualifiedClassName(CEventNotifyAnchorScoreChange), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGuildServerNotifyGuildScore ,
				getQualifiedClassName(CEventGuildServerNotifyGuildScore), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadAnchorGuilds ,
				getQualifiedClassName(CEventLoadAnchorGuilds), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventLoadAnchorGuildsRes ,
				getQualifiedClassName(CEventLoadAnchorGuildsRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorQueryScoreRank ,
				getQualifiedClassName(CEventAnchorQueryScoreRank), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGuildServerRequestAnchorRank ,
				getQualifiedClassName(CEventGuildServerRequestAnchorRank), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGuildServerRequestAnchorRankRes ,
				getQualifiedClassName(CEventGuildServerRequestAnchorRankRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildAddScore ,
				getQualifiedClassName(CEventVideoGuildAddScore), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorRequestWelfareDistribution ,
				getQualifiedClassName(CEventAnchorRequestWelfareDistribution), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorRequestWelfareDistributionRes ,
				getQualifiedClassName(CEventAnchorRequestWelfareDistributionRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorDoWelfareDistribution ,
				getQualifiedClassName(CEventAnchorDoWelfareDistribution), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorDoWelfareDistributionRes ,
				getQualifiedClassName(CEventAnchorDoWelfareDistributionRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventAnchorGiveGuildScore ,
				getQualifiedClassName(CEventAnchorGiveGuildScore), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventQueryAnchorGuildCount ,
				getQualifiedClassName(CEventQueryAnchorGuildCount), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventSyncPlayerVideoGuildID, 
				getQualifiedClassName(CEventSyncPlayerVideoGuildID), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetVideoGuildInfo, 
				getQualifiedClassName(CEventGetVideoGuildInfo), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetVideoGuildInfoRes ,
				getQualifiedClassName(CEventGetVideoGuildInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetVideoGuildName ,
				getQualifiedClassName(CEventGetVideoGuildName), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetVideoGuildNameRes, 
				getQualifiedClassName(CEventGetVideoGuildNameRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildModifyPosition ,
				getQualifiedClassName(CEventVideoGuildModifyPosition), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildRefreshPosition ,
				getQualifiedClassName(CEventVideoGuildRefreshPosition), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildModifyMemberPosition, 
				getQualifiedClassName(CEventVideoGuildModifyMemberPosition), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildExit ,
				getQualifiedClassName(CEventVideoGuildExit), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildChange ,
				getQualifiedClassName(CEventVideoGuildChange), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventUpdateVideoGuildMemberVipLevel ,
				getQualifiedClassName(CEventUpdateVideoGuildMemberVipLevel), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGuildMemberAddContScore,
				getQualifiedClassName(CEventGuildMemberAddContScore), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetAnchorVideoGuildCount ,
				getQualifiedClassName(CEventGetAnchorVideoGuildCount), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventGetVideoGuildInfoByName ,
				getQualifiedClassName(CEventGetVideoGuildInfoByName), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildQuerySpAnchor ,
				getQualifiedClassName(CEventVideoGuildQuerySpAnchor), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventVideoGuildQuerySpAnchorRes ,
				getQualifiedClassName(CEventVideoGuildQuerySpAnchorRes), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventModifyFansBoardName, 
				getQualifiedClassName(CEventModifyFansBoardName), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventModifyFansBoardNameRes, 
				getQualifiedClassName(CEventBanCustomFansBoard), HandleServerEvent);
			_callCenter.add_message_handler(VideoGuildEventID.CLSID_CEventBanCustomFansBoardRes ,
				getQualifiedClassName(CEventBanCustomFansBoardRes), HandleServerEvent);
			
		}
		private function video_vip_event_register_no_use():void
		{
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventQueryBuyVideoVipPrice ,
				getQualifiedClassName(CEventQueryBuyVideoVipPrice), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventQueryBuyVideoVipPriceRes ,
				getQualifiedClassName(CEventQueryBuyVideoVipPriceRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventBuyVideoVip ,
				getQualifiedClassName(CEventBuyVideoVip), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventBuyVideoVipRes ,
				getQualifiedClassName(CEventBuyVideoVipRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventGetVideoPlayerCardInfo ,
				getQualifiedClassName(CEventGetVideoPlayerCardInfo), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventGetVideoPlayerCardInfoRes ,
				getQualifiedClassName(CEventGetVideoPlayerCardInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventUploadVideoPlayerCardPortrait ,
				getQualifiedClassName(CEventUploadVideoPlayerCardPortrait), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventUploadVideoPlayerCardPortraitRes ,
				getQualifiedClassName(CEventUploadVideoPlayerCardPortraitRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventModifyVideoPlayerCardSignature ,
				getQualifiedClassName(CEventModifyVideoPlayerCardSignature), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventModifyVideoPlayerCardSignatureRes ,
				getQualifiedClassName(CEventModifyVideoPlayerCardSignatureRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventTakeVideoVipDailyRewards ,
				getQualifiedClassName(CEventTakeVideoVipDailyRewards), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventTakeVideoVipDailyRewardsRes ,
				getQualifiedClassName(CEventTakeVideoVipDailyRewardsRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventCancelFollowAnchorFromPlayerCard ,
				getQualifiedClassName(CEventCancelFollowAnchorFromPlayerCard), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventCancelFollowAnchorFromPlayerCardRes ,
				getQualifiedClassName(CEventCancelFollowAnchorFromPlayerCardRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventQueryFreeWhistleLeft ,
				getQualifiedClassName(CEventQueryFreeWhistleLeft), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventQueryFreeWhistleLeftRes ,
				getQualifiedClassName(CEventQueryFreeWhistleLeftRes), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventNotifyUploadVideoCardPortrait ,
				getQualifiedClassName(CEventNotifyUploadVideoCardPortrait), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventVideoVipExpireNotify ,
				getQualifiedClassName(CEventVideoVipExpireNotify), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventQueryFreeSuperStarHornLeft ,
				getQualifiedClassName(CEventQueryFreeSuperStarHornLeft), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventQueryFreeSuperStarHornLeftRes ,
				getQualifiedClassName(CEventQueryFreeSuperStarHornLeftRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventAddVideoVipRes ,
				getQualifiedClassName(CEventAddVideoVipRes), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventNotifyFreeTakeSeatLeft ,
				getQualifiedClassName(CEventNotifyFreeTakeSeatLeft), HandleServerEvent);
			_callCenter.add_message_handler(VideoVipEventID.CLSID_CEventBuyVipNotice ,
				getQualifiedClassName(CEventBuyVipNotice), HandleServerEvent);
		}
		
		private function video_clear_room_event_register_no_use():void
		{
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventCloseOrOpenRoom ,
				getQualifiedClassName(CEventCloseOrOpenRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRoomCloseTime ,
				getQualifiedClassName(CEventRoomCloseTime), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRoomOperationDenied ,
				getQualifiedClassName(CEventRoomOperationDenied), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventNotifyAllPlayerRoomIsClosing ,
				getQualifiedClassName(CEventNotifyAllPlayerRoomIsClosing), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventAdminOpenOrCloseRoomRes ,
				getQualifiedClassName(CEventAdminOpenOrCloseRoomRes), HandleServerEvent);
		}
		
		private function video_anchor_pk_event_register_no_use():void
		{
			
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventVideoRoomNotifyPKAnchorStartLive ,
				getQualifiedClassName(CEventVideoRoomNotifyPKAnchorStartLive), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKStartMatch ,
				getQualifiedClassName( CEventAnchorPKStartMatch ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKStartMatchRes ,
				getQualifiedClassName(CEventAnchorPKStartMatchRes  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKStopMatch ,
				getQualifiedClassName(CEventAnchorPKStopMatch  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKStopMatchRes ,
				getQualifiedClassName(CEventAnchorPKStopMatchRes  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKStartMatchNotify ,
				getQualifiedClassName( CEventAnchorPKStartMatchNotify ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKForecast ,
				getQualifiedClassName( CEventAnchorPKForecast ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKPreAttack ,
				getQualifiedClassName( CEventAnchorPKPreAttack ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyAnchorData,
				getQualifiedClassName( CEventAnchorPKNotifyAnchorData ), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKSyncMatchStatus ,
				getQualifiedClassName( CEventAnchorPKSyncMatchStatus ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKSyncActivityStatus ,
				getQualifiedClassName( CEventAnchorPKSyncActivityStatus ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventGetAnchorListInRoom ,
				getQualifiedClassName( CEventGetAnchorListInRoom ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventGetAnchorListInRoomRes ,
				getQualifiedClassName( CEventGetAnchorListInRoomRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKSyncInfoEnterRoom ,
				getQualifiedClassName( CEventAnchorPKSyncInfoEnterRoom ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyPlayerAvatar ,
				getQualifiedClassName( CEventAnchorPKNotifyPlayerAvatar ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKLoadPlayerAvatar ,
				getQualifiedClassName(CEventAnchorPKLoadPlayerAvatar  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKLoadPlayerAvatarRes ,
				getQualifiedClassName( CEventAnchorPKLoadPlayerAvatarRes ), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKLoadMatchDetail ,
				getQualifiedClassName( CEventAnchorPKLoadMatchDetail ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKLoadMatchDetailRes ,
				getQualifiedClassName( CEventAnchorPKLoadMatchDetailRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventRefreshAnchorPKWinnerRank ,
				getQualifiedClassName( CEventRefreshAnchorPKWinnerRank ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventLoadAnchorPKWinnerFromDB ,
				getQualifiedClassName( CEventLoadAnchorPKWinnerFromDB ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventLoadAnchorPKWinnerFromDBRes ,
				getQualifiedClassName( CEventLoadAnchorPKWinnerFromDBRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventRefreshAnchorPKRichmanRank ,
				getQualifiedClassName( CEventRefreshAnchorPKRichmanRank ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventUpdateAnchorPKRichmanRank ,
				getQualifiedClassName( CEventUpdateAnchorPKRichmanRank ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKShowEnd ,
				getQualifiedClassName(CEventAnchorPKShowEnd  ), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKMatchStop ,
				getQualifiedClassName( CEventAnchorPKMatchStop ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyBuff ,
				getQualifiedClassName( CEventAnchorPKNotifyBuff ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyAnchorSelfInfo ,
				getQualifiedClassName( CEventAnchorPKNotifyAnchorSelfInfo ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventSaveAnchorPKGuildToDB ,
				getQualifiedClassName( CEventSaveAnchorPKGuildToDB ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyPlayerAvatarExtInfo ,
				getQualifiedClassName( CEventAnchorPKNotifyPlayerAvatarExtInfo ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventPlayerContributionInCurPK ,
				getQualifiedClassName( CEventPlayerContributionInCurPK ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventPlayerContributionInCurPKRes ,
				getQualifiedClassName( CEventPlayerContributionInCurPKRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyClearAvatar ,
				getQualifiedClassName( CEventAnchorPKNotifyClearAvatar ), HandleServerEvent);
			_callCenter.add_message_handler(VideoAnchorPKEventID.CLSID_CEventAnchorPKMatchEndBroadcast ,
				getQualifiedClassName( CEventAnchorPKMatchEndBroadcast ), HandleServerEvent);
		}
		
		private function video_ceremony_event_register_no_use():void
		{
			
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyTimeStart ,
				getQualifiedClassName(CEventVideoCeremonyTimeStart), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyTimeEnd ,
				getQualifiedClassName(  CEventVideoCeremonyTimeEnd), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStartVideoCeremony ,
				getQualifiedClassName( CEventStartVideoCeremony ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStopVideoCeremonyVote ,
				getQualifiedClassName( CEventStopVideoCeremonyVote ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStopVideoCeremony ,
				getQualifiedClassName( CEventStopVideoCeremony ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyChooseSupportAnchor ,
				getQualifiedClassName( CEventVideoCeremonyChooseSupportAnchor ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStartVideoCeremonyRes ,
				getQualifiedClassName( CEventStartVideoCeremonyRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyStartInfo ,
				getQualifiedClassName(CEventVideoCeremonyStartInfo  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStopVideoCeremonyVoteRes ,
				getQualifiedClassName( CEventStopVideoCeremonyVoteRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStopVideoCeremonyRes ,
				getQualifiedClassName( CEventStopVideoCeremonyRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventRefreshVideoCeremonyActivity ,
				getQualifiedClassName( CEventRefreshVideoCeremonyActivity ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerEnterRoom ,
				getQualifiedClassName( CEventVideoCeremonyPlayerEnterRoom ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerEnterRoomRes ,
				getQualifiedClassName( CEventVideoCeremonyPlayerEnterRoomRes ), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerSendGift ,
				getQualifiedClassName(CEventVideoCeremonyPlayerSendGift  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyAnchorEnterLeaveRoom ,
				getQualifiedClassName(CEventVideoCeremonyAnchorEnterLeaveRoom  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerAffinityChanged ,
				getQualifiedClassName(CEventVideoCeremonyPlayerAffinityChanged  ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyTransmitWhistleMsg ,
				getQualifiedClassName( CEventVideoCeremonyTransmitWhistleMsg ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStartVideoCeremonyBroadcast ,
				getQualifiedClassName( CEventStartVideoCeremonyBroadcast ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventStopVideoCeremonyVoteBroadcast ,
				getQualifiedClassName( CEventStopVideoCeremonyVoteBroadcast ), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonySyncDataInRoomServer ,
				getQualifiedClassName( CEventVideoCeremonySyncDataInRoomServer ), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonyLoadInfoFromDBRes ,
				getQualifiedClassName(  CEventVideoCeremonyLoadInfoFromDBRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoCeremonyEventId.CLSID_CEventVideoCeremonySaveInfoToDB ,
				getQualifiedClassName( CEventVideoCeremonySaveInfoToDB ), HandleServerEvent);
			
		}
		
		private function video_anchor_task_event_register_no_use():void
		{
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventPublishAnchorTask ,
				getQualifiedClassName(  CEventPublishAnchorTask), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventPublishAnchorTaskRes ,
				getQualifiedClassName( CEventPublishAnchorTaskRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventNotifyAudiencePublishAnchorTask ,
				getQualifiedClassName(  CEventNotifyAudiencePublishAnchorTask), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventTakeAnchorTask ,
				getQualifiedClassName( CEventTakeAnchorTask ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventTakeAnchorTaskRes ,
				getQualifiedClassName( CEventTakeAnchorTaskRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventQueryAnchorTask ,
				getQualifiedClassName(CEventQueryAnchorTask  ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventDropAnchorTask ,
				getQualifiedClassName( CEventDropAnchorTask ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventRemoveAnchorTask ,
				getQualifiedClassName( CEventRemoveAnchorTask ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventDropAnchorTaskRes ,
				getQualifiedClassName( CEventDropAnchorTaskRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventNotifyAnchorTaskUnavailable ,
				getQualifiedClassName( CEventNotifyAnchorTaskUnavailable ), HandleServerEvent);
			
		}
		
		private function video_red_envelope_event_register_no_use():void
		{
			_callCenter.add_message_handler(VideoRedEnvelopeEventId.CLSID_CEventPublishRedEnvelope ,
				getQualifiedClassName( CEventPublishRedEnvelope ), HandleServerEvent);
			_callCenter.add_message_handler(VideoRedEnvelopeEventId.CLSID_CEventGrabRedEnvelope ,
				getQualifiedClassName( CEventGrabRedEnvelope ), HandleServerEvent);
			_callCenter.add_message_handler(VideoRedEnvelopeEventId.CLSID_CEventGrabRedEnvelopeRes ,
				getQualifiedClassName( CEventGrabRedEnvelopeRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoRedEnvelopeEventId.CLSID_CEventLoadRedEnvelope ,
				getQualifiedClassName( CEventLoadRedEnvelope ), HandleServerEvent);
			_callCenter.add_message_handler(VideoRedEnvelopeEventId.CLSID_CEventLoadRedEnvelopeRes ,
				getQualifiedClassName( CEventLoadRedEnvelopeRes ), HandleServerEvent);
			_callCenter.add_message_handler(VideoRedEnvelopeEventId.CLSID_CEventChatIgnoreListOperate ,
				getQualifiedClassName( CEventChatIgnoreListOperate ), HandleServerEvent);
			
		}
		
		private function video_anchor_nest_event_register_no_use():void
		{
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventRefreshVideoAnchorNestRank ,
				getQualifiedClassName(CEventRefreshVideoAnchorNestRank ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventUpdateAnchorNestRank ,
				getQualifiedClassName(CEventUpdateAnchorNestRank ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventSaveAnchorNestInfoToDB ,
				getQualifiedClassName( CEventSaveAnchorNestInfoToDB), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventSaveAnchorNestInfoToDBRes ,
				getQualifiedClassName(CEventSaveAnchorNestInfoToDBRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventLoadAnchorNestInfoFromDB ,
				getQualifiedClassName(CEventLoadAnchorNestInfoFromDB ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventLoadAnchorNestInfoRes ,
				getQualifiedClassName(CEventLoadAnchorNestInfoRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventDelAnchorNestInfo ,
				getQualifiedClassName( CEventDelAnchorNestInfo), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventVideoRoomLoadNestAssistantList ,
				getQualifiedClassName( CEventVideoRoomLoadNestAssistantList), HandleServerEvent);
			
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventVideoRoomLoadNestAssistantListRes ,
				getQualifiedClassName( CEventVideoRoomLoadNestAssistantListRes), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventVideoRoomAddNestAssistant ,
				getQualifiedClassName(CEventVideoRoomAddNestAssistant ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventVideoRoomAddNestAssistantRes ,
				getQualifiedClassName(CEventVideoRoomAddNestAssistantRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventVideoRoomDelNestAssistant ,
				getQualifiedClassName(CEventVideoRoomDelNestAssistant ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventVideoRoomDelNestAssistantRes ,
				getQualifiedClassName(CEventVideoRoomDelNestAssistantRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventDelAnchorNestAssistant ,
				getQualifiedClassName(CEventDelAnchorNestAssistant ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventSaveAnchorNestAssistant ,
				getQualifiedClassName(CEventSaveAnchorNestAssistant ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventNotifyNestIsFreezing ,
				getQualifiedClassName(CEventNotifyNestIsFreezing ), HandleServerEvent);
			
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventChangeNestStatusInDB ,
				getQualifiedClassName(CEventChangeNestStatusInDB ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventChangeNestAttachedRoomInDB ,
				getQualifiedClassName( CEventChangeNestAttachedRoomInDB), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventLoadPlayerNestStar ,
				getQualifiedClassName( CEventLoadPlayerNestStar), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventLoadPlayerNestStarRes ,
				getQualifiedClassName(CEventLoadPlayerNestStarRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventSavePlayerNestStar ,
				getQualifiedClassName(CEventSavePlayerNestStar ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventDelPlayerNestStar ,
				getQualifiedClassName( CEventDelPlayerNestStar), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventDelAllNestStar ,
				getQualifiedClassName( CEventDelAllNestStar), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAnchorNestNormalSupport ,
				getQualifiedClassName( CEventAnchorNestNormalSupport), HandleServerEvent);
			
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAnchorNestNormalSupportRes ,
				getQualifiedClassName(CEventAnchorNestNormalSupportRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAnchorNestNotifyAdvSupport ,
				getQualifiedClassName(CEventAnchorNestNotifyAdvSupport ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAnchorNestRefreshPopularityInfo ,
				getQualifiedClassName( CEventAnchorNestRefreshPopularityInfo), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAnchorNestGetSupportUIInfo ,
				getQualifiedClassName(CEventAnchorNestGetSupportUIInfo ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAnchorNestGetSupportUIInfoRes ,
				getQualifiedClassName( CEventAnchorNestGetSupportUIInfoRes), HandleServerEvent);
			
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAnchorNestRefreshAnchorData ,
				getQualifiedClassName(CEventAnchorNestRefreshAnchorData ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventDelAnchorNestRank ,
				getQualifiedClassName(CEventDelAnchorNestRank ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventUpdatePlayerNestStarToDB ,
				getQualifiedClassName(CEventUpdatePlayerNestStarToDB ), HandleServerEvent);

			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventChangeAttchRoomToRank ,
				getQualifiedClassName(CEventChangeAttchRoomToRank ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CeventVideoRoomInitNestAssistantList ,
				getQualifiedClassName( CeventVideoRoomInitNestAssistantList), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventVideoRoomNestAssistantChange ,
				getQualifiedClassName(CEventVideoRoomNestAssistantChange ), HandleServerEvent);

			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventRefreshAddPopularityToClient ,
				getQualifiedClassName(CEventRefreshAddPopularityToClient ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventFreezeNestByOwnerQQ ,
				getQualifiedClassName(CEventFreezeNestByOwnerQQ ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventGetNestGrowUpInfo ,
				getQualifiedClassName(CEventGetNestGrowUpInfo ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventNestGrowUpInfo ,
				getQualifiedClassName(CEventNestGrowUpInfo ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventAddNestPopularityCreditsRes ,
				getQualifiedClassName(CEventAddNestPopularityCreditsRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventGetGuardWage ,
				getQualifiedClassName(CEventGetGuardWage ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestEventID.CLSID_CEventRefreshNestCreditsLevel ,
				getQualifiedClassName(CEventRefreshNestCreditsLevel ), HandleServerEvent);
			
			//小窝任务相关
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventNotifyNestTaskFinished, 
				getQualifiedClassName(CEventNotifyNestTaskFinished ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventTakeNestTaskRes, 
				getQualifiedClassName(CEventTakeNestTaskRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventTakeNestTask, 
				getQualifiedClassName( CEventTakeNestTask), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventQueryNestTaskRewardNewRole, 
				getQualifiedClassName( CEventQueryNestTaskRewardNewRole), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventQueryNestTaskRewardNewRoleRes, 
				getQualifiedClassName(CEventQueryNestTaskRewardNewRoleRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventTakeNestTreasureBoxErrRes, 
				getQualifiedClassName(CEventTakeNestTreasureBoxErrRes ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventNotifyAudienceTreasureBoxStatus, 
				getQualifiedClassName(CEventNotifyAudienceTreasureBoxStatus ), HandleServerEvent);
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventTakeNestTreasureBox, 
				getQualifiedClassName(CEventTakeNestTreasureBox ), HandleServerEvent);
			
			_callCenter.add_message_handler(AnchorNestTaskEventID.CLSID_CEventNotifyAnchorPublishNestTask, 
				getQualifiedClassName(CEventNotifyAnchorPublishNestTask ), HandleServerEvent);
			
			//小窝PK
			_callCenter.add_message_handler(AnchorPKEventID.CLSID_CEventRefreshAnchorPKRank, 
				getQualifiedClassName(CEventRefreshAnchorPKRank), HandleServerEvent);
			_callCenter.add_message_handler(AnchorPKEventID.CLSID_CEventRefreshPlayerContributePKRank, 
				getQualifiedClassName(CEventRefreshPlayerContributePKRank), HandleServerEvent);
			_callCenter.add_message_handler(AnchorPKEventID.CLSID_CEventRefreshRocketBuff, 
				getQualifiedClassName(CEventRefreshRocketBuff), HandleServerEvent);
			_callCenter.add_message_handler(AnchorPKEventID.CLSID_CEventRefreshPkProgressInfo, 
				getQualifiedClassName(CEventRefreshPkProgressInfo), HandleServerEvent);
			_callCenter.add_message_handler(AnchorPKEventID.CLSID_CEventNotifyPkMatchInfo, 
				getQualifiedClassName(CEventNotifyPkMatchInfo), HandleServerEvent);
			_callCenter.add_message_handler(AnchorPKEventID.CLSID_CEventRefreshPkValue, 
				getQualifiedClassName(CEventRefreshPkValue), HandleServerEvent);
			_callCenter.add_message_handler(AnchorPKEventID.CLSID_CEventRefreshPkGift, 
				getQualifiedClassName(CEventRefreshPkGift), HandleServerEvent);
			
			//圣诞节活动
			_callCenter.add_message_handler(CommonActivityEventID.CLSID_CEventCommonActivityInfoBegin, 
				getQualifiedClassName(CEventCommonActivityInfoBegin), HandleServerEvent);
			_callCenter.add_message_handler(CommonActivityEventID.CLSID_CEventCommonActivityInfoEnd, 
				getQualifiedClassName(CEventCommonActivityInfoEnd), HandleServerEvent);
			_callCenter.add_message_handler(CommonActivityEventID.CLSID_CEventCommonActivityInfoRefresh, 
				getQualifiedClassName(CEventCommonActivityInfoRefresh), HandleServerEvent);
			_callCenter.add_message_handler(CommonActivityEventID.CLSID_CEventRefreshCommonActivityData, 
				getQualifiedClassName(CEventRefreshCommonActivityData), HandleServerEvent);
			_callCenter.add_message_handler(CommonActivityEventID.CLSID_CEventCommonActivityPlayerRank, 
				getQualifiedClassName(CEventCommonActivityPlayerRank), HandleServerEvent);
		}
		
		private function room_proxy_events_register():void
		{
			_callCenter.add_message_handler(CallCenterMessageID.CLSID_CEventVideoInitConnectionRequest, 
				getQualifiedClassName(CEventVideoInitConnectionRequest), HandleServerEvent);
			_callCenter.addNeedResponseEventID(CallCenterMessageID.CLSID_CEventVideoInitConnectionRequest, 
				CallCenterMessageID.CLSID_CEventVideoInitConnectionResponse);
			_callCenter.add_message_handler(CallCenterMessageID.CLSID_CEventVideoInitConnectionResponse, 
				getQualifiedClassName(CEventVideoInitConnectionResponse), HandleServerEvent);
			_callCenter.add_message_handler(CallCenterMessageID.CLSID_CEventClientConnectRoomProxyTransResult, 
				getQualifiedClassName(CEventClientConnectRoomProxyTransResult), HandleServerEvent);
			_callCenter.add_message_handler(CallCenterMessageID.CLSID_CEventVideoReconnectVerifyRequest, 
				getQualifiedClassName(CEventVideoReconnectVerifyRequest), HandleServerEvent);
			_callCenter.add_message_handler(CallCenterMessageID.CLSID_CEventVideoReconnectVerifyReponse, 
				getQualifiedClassName(CEventVideoReconnectVerifyReponse), HandleServerEvent);
			
		}
		private function event_register_video_personal_card():void
		{
			_callCenter.add_message_handler(VideoPersonalCardEventID.CLSID_CEventVisitAnchor, 
				getQualifiedClassName(CEventVisitAnchor), HandleServerEvent);
			_callCenter.add_message_handler(VideoPersonalCardEventID.CLSID_CEventVisitAnchorRes, 
				getQualifiedClassName(CEventVisitAnchorRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoPersonalCardEventID.CLSID_CEventGetAnchorFans, 
				getQualifiedClassName(CEventGetAnchorFans), HandleServerEvent);
			_callCenter.add_message_handler(VideoPersonalCardEventID.CLSID_CEventGetAnchorFansRes, 
				getQualifiedClassName(CEventGetAnchorFansRes), HandleServerEvent);
		}
		private function event_video_room_register_no_use():void
		{
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomPlayerCount, 
				getQualifiedClassName(CEventVideoRoomPlayerCount), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLoadPlayerList, 
				getQualifiedClassName(CEventVideoRoomLoadPlayerList), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLoadPlayerListRes, 
				getQualifiedClassName(CEventVideoRoomLoadPlayerListRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomPlayerTakeVipSeat, 
				getQualifiedClassName(CEventVideoRoomPlayerTakeVipSeat), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomVipSeatsInfo, 
				getQualifiedClassName(CEventVideoRoomVipSeatsInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoToClientChatMessage, 
				getQualifiedClassName(CEventVideoToClientChatMessage), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoToClientChatMessageForWeb, 
				getQualifiedClassName(CEventVideoToClientChatMessageForWeb), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoToServerChatMessage, 
				getQualifiedClassName(CEventVideoToServerChatMessage), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoChatResult, 
				getQualifiedClassName(CEventVideoChatResult), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToAllPlayer, 
				getQualifiedClassName(CEventVideoRoomTransmitToAllPlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToOnePlayer, 
				getQualifiedClassName(CEventVideoRoomTransmitToOnePlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToAllVideoGuildPlayer, 
				getQualifiedClassName(CEventVideoRoomTransmitToAllVideoGuildPlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventTestPing, 
				getQualifiedClassName(CEventTestPing), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventTestPingRes, 
				getQualifiedClassName(CEventTestPingRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRefreshFlower, 
				getQualifiedClassName(CEventVideoRefreshFlower), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoSendGift, 
				getQualifiedClassName(CEventVideoSendGift), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoSendGiftResult, 
				getQualifiedClassName(CEventVideoSendGiftResult), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoSendGiftResultForWeb, 
				getQualifiedClassName(CEventVideoSendGiftResultForWeb), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventNotifySendLotsOfGifts, 
				getQualifiedClassName(CEventNotifySendLotsOfGifts), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventNotifyShowVideoGuildBoard, 
				getQualifiedClassName(CEventNotifyShowVideoGuildBoard), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoOpenGiftPoolBox, 
				getQualifiedClassName(CEventVideoOpenGiftPoolBox), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoOpenGiftPoolBoxRes, 
				getQualifiedClassName(CEventVideoOpenGiftPoolBoxRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoGetGiftPoolBoxInfo, 
				getQualifiedClassName(CEventVideoGetGiftPoolBoxInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoGiftPoolHeightChange, 
				getQualifiedClassName(CEventVideoGiftPoolHeightChange), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoGetGiftPoolBoxInfoRes, 
				getQualifiedClassName(CEventVideoGetGiftPoolBoxInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLoadVipSeatsInfo, 
				getQualifiedClassName(CEventVideoRoomLoadVipSeatsInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventReportAnchor, 
				getQualifiedClassName(CEventReportAnchor), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventReportAnchorResult, 
				getQualifiedClassName(CEventReportAnchorResult), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoSyncPlayerChatBanState, 
				getQualifiedClassName(CEventVideoSyncPlayerChatBanState), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoSearchOnlinePlayer, 
				getQualifiedClassName(CEventVideoSearchOnlinePlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoSearchOnlinePlayerRes, 
				getQualifiedClassName(CEventVideoSearchOnlinePlayerRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVipGuildMemberGiftAddAnchorScore, 
				getQualifiedClassName(CEventVipGuildMemberGiftAddAnchorScore), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomTransmitToAllOtherRoom, 
				getQualifiedClassName(CEventVideoRoomTransmitToAllOtherRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadNestList, 
				getQualifiedClassName(CEventLoadNestList), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadNestListRes, 
				getQualifiedClassName(CEventLoadNestListRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAnchorNameBatch, 
				getQualifiedClassName(CEventLoadAnchorNameBatch), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAnchorNameBatchRes, 
				getQualifiedClassName(CEventLoadAnchorNameBatchRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAllNestForRank, 
				getQualifiedClassName(CEventLoadAllNestForRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAllNestForRankRes, 
				getQualifiedClassName(CEventLoadAllNestForRankRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventBatchLoadAnchorNestInfo, 
				getQualifiedClassName(CEventBatchLoadAnchorNestInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventBatchLoadAnchorNestInfoRes, 
				getQualifiedClassName(CEventBatchLoadAnchorNestInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventAddAnchorPropertyUpdateDataServer, 
				getQualifiedClassName(CEventVideoChatResult), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshLiveNestCnt, 
				getQualifiedClassName(CEventRefreshLiveNestCnt), HandleServerEvent);
			
			// add new
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadPreviewVideoTreasureBoxNewRole, 
				getQualifiedClassName(CEventLoadPreviewVideoTreasureBoxNewRole), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadPreviewVideoTreasureBoxNewRoleRes, 
				getQualifiedClassName(CEventLoadPreviewVideoTreasureBoxNewRoleRes), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventQueryAnchorTaskNewRole, 
				getQualifiedClassName(CEventQueryAnchorTaskNewRole), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventQueryAnchorTaskNewRoleResWeb, 
				getQualifiedClassName(CEventQueryAnchorTaskNewRoleResWeb), HandleServerEvent);
			_callCenter.add_message_handler(AnchorTaskEventID.CLSID_CEventAnchorTaskRewardNotifyNewRoleWeb, 
				getQualifiedClassName(CEventAnchorTaskRewardNotifyNewRoleWeb), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventNotifyActivityCompletedCount, 
				getQualifiedClassName(CEventNotifyActivityCompletedCount), HandleServerEvent);
			
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCanEnterRoom, 
				getQualifiedClassName(CEventVideoRoomCanEnterRoom), HandleServerEvent);			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCanEnterRoomRes, 
				getQualifiedClassName(CEventVideoRoomCanEnterRoomRes), HandleServerEvent);	
			
			_callCenter.addNeedResponseEventID(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCanEnterRoom, 
				EEventIDVideoRoomExt.CLSID_CEventVideoRoomCanEnterRoomRes);			
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventQueryDreamGift, 
				getQualifiedClassName(CEventQueryDreamGift), HandleServerEvent);			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventQueryDreamGiftRes, 
				getQualifiedClassName(CEventQueryDreamGiftRes), HandleServerEvent);			
			
			//加密url
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventEncryptPortraitUrlRes, 
				getQualifiedClassName(CEventEncryptPortraitUrlRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventEncryptPortraitUrl, 
				getQualifiedClassName(CEventEncryptPortraitUrl), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshVideoGiftConfig, 
				getQualifiedClassName(CEventRefreshVideoGiftConfig), HandleServerEvent);
			
			//首登和签到相关
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoUserLogin, 
				getQualifiedClassName( CEventVideoUserLogin ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventFirstLoginRewardNotify, 
				getQualifiedClassName(CEventFirstLoginRewardNotify  ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventConfirmFirstLoginReward, 
				getQualifiedClassName(CEventConfirmFirstLoginReward  ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventConfirmFirstLoginRewardRes, 
				getQualifiedClassName( CEventConfirmFirstLoginRewardRes ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetSigninRewardNotify, 
				getQualifiedClassName( CEventGetSigninRewardNotify ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetSigninRewardNotifyRes, 
				getQualifiedClassName( CEventGetSigninRewardNotifyRes ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetDailySigninRewardContent, 
				getQualifiedClassName( CEventGetDailySigninRewardContent ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetDailySigninRewardContentRes, 
					getQualifiedClassName( CEventGetDailySigninRewardContentRes ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventSigninDaily, 
				getQualifiedClassName(CEventSigninDaily  ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventSigninAccumulate, 
				getQualifiedClassName(CEventSigninAccumulate  ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventSigninDailyRes, 
				getQualifiedClassName( CEventSigninDailyRes ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventSigninAccumulateRes, 
				getQualifiedClassName( CEventSigninAccumulateRes ), HandleServerEvent);	
			
//			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNotifyConcertVideoGiftUsableIDs, 
//				getQualifiedClassName( CEventNotifyConcertVideoGiftUsableIDs ), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRefreshFreeGift, 
				getQualifiedClassName( CEventVideoRefreshFreeGift ), HandleServerEvent);	
			//游客
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetGuestInfo, 
				getQualifiedClassName( CEventGetGuestInfo ), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetGuestInfoRes, 
				getQualifiedClassName( CEventGetGuestInfoRes ), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomLeaveRoomRes, 
				getQualifiedClassName(  CEventVideoRoomLeaveRoomRes), HandleServerEvent);	
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetAllTags, 
				getQualifiedClassName(  CEventGetAllTags), HandleServerEvent);		
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetAllTagsRes, 
					getQualifiedClassName(  CEventGetAllTagsRes), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardDesc, 
				getQualifiedClassName(  CEventVideoGetExternalRewardDesc), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardDescRes, 
				getQualifiedClassName(  CEventVideoGetExternalRewardDescRes), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardCountDescRes, 
				getQualifiedClassName(  CEventVideoGetExternalRewardCountDescRes), HandleServerEvent);	
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventTakeRoomGuardSeat, 
				getQualifiedClassName(CEventTakeRoomGuardSeat), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventTakeRoomGuardSeatRes, 
				getQualifiedClassName(CEventTakeRoomGuardSeatRes), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRoomGuardSeatLostNotify, 
				getQualifiedClassName(CEventRoomGuardSeatLostNotify), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshRoomGuardSeats, 
				getQualifiedClassName(CEventRefreshRoomGuardSeats), HandleServerEvent);	
			//随机账号
			_callCenter.add_message_handler(RandNickEventID.CLSID_CEventGetRandNick, 
				getQualifiedClassName(CEventGetRandNick), HandleServerEvent);	
			_callCenter.add_message_handler(RandNickEventID.CLSID_CEventGetRandNickRes, 
				getQualifiedClassName(CEventGetRandNickRes), HandleServerEvent);	
			//火箭礼物
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventPublishDreamBox, 
				getQualifiedClassName(CEventPublishDreamBox), HandleServerEvent);	
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventRefreshDreamBoxCount, 
				getQualifiedClassName(CEventRefreshDreamBoxCount), HandleServerEvent);
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventGrabDreamBox, 
				getQualifiedClassName(CEventGrabDreamBox), HandleServerEvent);	
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventGrabDreamBoxRes, 
				getQualifiedClassName(CEventGrabDreamBoxRes), HandleServerEvent);
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventGetDreamBoxGrabRec, 
				getQualifiedClassName(CEventGetDreamBoxGrabRec), HandleServerEvent);	
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventGetDreamBoxGrabRecRes, 
				getQualifiedClassName(CEventGetDreamBoxGrabRecRes), HandleServerEvent);
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventBroadcastAllRoomRocketGift, 
				getQualifiedClassName(CEventBroadcastAllRoomRocketGift), HandleServerEvent);	
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventNotifyDreamBoxGrabbedOut, 
				getQualifiedClassName(CEventNotifyDreamBoxGrabbedOut), HandleServerEvent);
			_callCenter.add_message_handler(DreamBoxEventID.CLSID_CEventClearDreamBox, 
				getQualifiedClassName(CEventClearDreamBox), HandleServerEvent);
			
		}
		private function register_edit_account_events():void
		{
			_callCenter.add_message_handler(AnchorLoginDatabaseEventID.CLSID_CEventEditVideoAccount, 
				getQualifiedClassName(CEventEditVideoAccount), HandleServerEvent);
			_callCenter.add_message_handler(AnchorLoginDatabaseEventID.CLSID_CEventEditVideoAccountRes, 
				getQualifiedClassName(CEventEditVideoAccountRes), HandleServerEvent);
			_callCenter.add_message_handler(AnchorLoginDatabaseEventID.CLSID_CEventAnchorNameChangeNotify, 
				getQualifiedClassName(CEventAnchorNameChangeNotify), HandleServerEvent);
			_callCenter.add_message_handler(AnchorLoginDatabaseEventID.CLSID_CEventEditRoomName, 
				getQualifiedClassName(CEventSyncVideoAccount), HandleServerEvent);
			_callCenter.add_message_handler(AnchorLoginDatabaseEventID.CLSID_CEventEditRoomNameRes, 
				getQualifiedClassName(CEventSyncVideoAccount), HandleServerEvent);
		}
		private function register_anchor_sync_events():void
		{
			_callCenter.add_message_handler(AnchorSyncInfoEventID.CLSID_CEventSyncVideoAccount, 
				getQualifiedClassName(CEventSyncVideoAccount), HandleServerEvent);
			_callCenter.add_message_handler(AnchorSyncInfoEventID.CLSID_CEventSyncAnchor, 
				getQualifiedClassName(CEventSyncAnchor), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomBanNotice, 
				getQualifiedClassName(CEventVideoRoomBanNotice), HandleServerEvent);
		}
		//  注册
		private function register_video_room_client_server_event_no_use():void
		{
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoom, 
				getQualifiedClassName(CEventVideoRoomEnterRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomRes, 
				getQualifiedClassName(CEventVideoRoomEnterRoomRes), HandleServerEvent);
			
			_callCenter.addNeedResponseEventID(EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoom, 
				EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomRes);	
			
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLeaveRoom, 
				getQualifiedClassName(CEventVideoRoomLeaveRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomBeKicked, 
				getQualifiedClassName(CEventVideoRoomBeKicked), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomList, 
				getQualifiedClassName(CEventVideoRoomGetRoomList), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomListRes, 
				getQualifiedClassName(CEventVideoRoomGetRoomListRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomNotifyLiveStart, 
				getQualifiedClassName(CEventVideoRoomNotifyLiveStart), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomNotifyAnchorStartLive, 
				getQualifiedClassName(CEventVideoRoomNotifyAnchorStartLive), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomNotifyLiveStop, 
				getQualifiedClassName(CEventVideoRoomNotifyLiveStop), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomGetLiveCDN, 
				getQualifiedClassName(CEventVideoRoomGetLiveCDN), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomGetLiveCDNRes, 
				getQualifiedClassName(CEventVideoRoomGetLiveCDNRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomStartLiveRes, 
				getQualifiedClassName(CEventVideoRoomStartLiveRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshLiveStatus, 
				getQualifiedClassName(CEventVideoRoomRefreshLiveStatus), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshCurrentAnchorDetail, 
				getQualifiedClassName(CEventVideoRoomRefreshCurrentAnchorDetail), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLiveBeStoped, 
				getQualifiedClassName(CEventVideoRoomLiveBeStoped), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomChatBan, 
				getQualifiedClassName(CEventVideoRoomChatBan), HandleServerEvent);			
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomChatBanRes, 
				getQualifiedClassName(CEventVideoRoomChatBanRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomKickPlayer, 
				getQualifiedClassName(CEventVideoRoomKickPlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomKickPlayerRes, 
				getQualifiedClassName(CEventVideoRoomKickPlayerRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomShareConfig, 
				getQualifiedClassName(CEventVideoRoomShareConfig), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLoadProgramme, 
				getQualifiedClassName(CEventVideoRoomLoadProgramme), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomAdminStopLive, 
				getQualifiedClassName(CEventVideoRoomAdminStopLive), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomAdminStopLiveRes, 
				getQualifiedClassName(CEventVideoRoomAdminStopLiveRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRequestQstoreDownloadKey, 
				getQualifiedClassName(CEventVideoRoomRequestQstoreDownloadKey), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRequestQstoreDownloadKeyRes, 
				getQualifiedClassName(CEventVideoRoomRequestQstoreDownloadKeyRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorPortrait, 
				getQualifiedClassName(CEventVideoRoomUploadAnchorPortrait), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorPortraitRes, 
				getQualifiedClassName(CEventVideoRoomUploadAnchorPortraitRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomUploadRoomPic, 
				getQualifiedClassName(CEventVideoRoomUploadRoomPic), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomUploadRoomPicRes, 
				getQualifiedClassName(CEventVideoRoomUploadRoomPicRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomDeleteRoomPic, 
				getQualifiedClassName(CEventVideoRoomDeleteRoomPic), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomDeleteRoomPicRes, 
				getQualifiedClassName(CEventVideoRoomDeleteRoomPicRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshRoomPicInfo, 
				getQualifiedClassName(CEventVideoRoomRefreshRoomPicInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventFollowAnchorOpRes, 
				getQualifiedClassName(CEventFollowAnchorOpRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventFollowAnchorOp, 
				getQualifiedClassName(CEventFollowAnchorOp), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadFollowingAnchorInfoRes, 
				getQualifiedClassName(CEventLoadFollowingAnchorInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadFollowingAnchorInfo, 
				getQualifiedClassName(CEventLoadFollowingAnchorInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomSyncAnchorRooms, 
				getQualifiedClassName(CEventVideoRoomSyncAnchorRooms), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomSyncAdminRooms, 
				getQualifiedClassName(CEventVideoRoomSyncAdminRooms), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshAffinityRank, 
				getQualifiedClassName(CEventRefreshAffinityRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshRoomAttribute, 
				getQualifiedClassName(CEventVideoRoomRefreshRoomAttribute), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshStarlightRank, 
				getQualifiedClassName(CEventRefreshStarlightRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshTwoweekStarlightRank, 
				getQualifiedClassName(CEventRefreshTwoweekStarlightRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshPopularityRank, 
				getQualifiedClassName(CEventRefreshPopularityRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventAddDeputyAnchor, 
				getQualifiedClassName(CEventAddDeputyAnchor), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventAddDeputyAnchorRes, 
				getQualifiedClassName(CEventAddDeputyAnchorRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRequestDeputyAnchor, 
				getQualifiedClassName(CEventVideoRoomRequestDeputyAnchor), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventDelDeputyAnchor, 
				getQualifiedClassName(CEventDelDeputyAnchor), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventNofityDeputyAnchorChange, 
				getQualifiedClassName(CEventNofityDeputyAnchorChange), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRequestDeputyAnchorRes, 
				getQualifiedClassName(CEventVideoRoomRequestDeputyAnchorRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventInviteToDeputyAnchor, 
				getQualifiedClassName(CEventInviteToDeputyAnchor), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVSStopDeputyAnchor, 
				getQualifiedClassName(CEventVSStopDeputyAnchor), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventSetVideoChatParameter, 
				getQualifiedClassName(CEventSetVideoChatParameter), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventSetVideoChatParameterRes, 
				getQualifiedClassName(CEventSetVideoChatParameterRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoLoadRoomAdmins, 
				getQualifiedClassName(CEventVideoLoadRoomAdmins), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoLoadRoomAdminsRes, 
				getQualifiedClassName(CEventVideoLoadRoomAdminsRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomAdminOperation, 
				getQualifiedClassName(CEventVideoRoomAdminOperation), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomAdminOperationRes, 
				getQualifiedClassName(CEventVideoRoomAdminOperationRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshGuardLevel, 
				getQualifiedClassName(CEventVideoRoomRefreshGuardLevel), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomGuardLevelChange, 	
				getQualifiedClassName(CEventVideoRoomGuardLevelChange), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomAssignSuperGuard, 
				getQualifiedClassName(CEventVideoRoomAssignSuperGuard), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomAssignSuperGuardRes, 
				getQualifiedClassName(CEventVideoRoomAssignSuperGuardRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRecedeSuperGuard, 
				getQualifiedClassName(CEventVideoRoomRecedeSuperGuard), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomRecedeSuperGuardRes, 
				getQualifiedClassName(CEventVideoRoomRecedeSuperGuardRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLoadSuperFans, 
				getQualifiedClassName(CEventVideoRoomLoadSuperFans), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomLoadSuperGuardResult, 
				getQualifiedClassName(CEventVideoRoomLoadSuperGuardResult), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcast, 
				getQualifiedClassName(CEventVideoRoomEnterRoomBroadcast), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomQueryFollowedAnchorLiveStart, 
				getQualifiedClassName(CEventVideoRoomQueryFollowedAnchorLiveStart), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshVideoCharInfoToClient, 
				getQualifiedClassName(CEventRefreshVideoCharInfoToClient), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshFollowedAnchorsIDToClient, 
				getQualifiedClassName(CEventRefreshFollowedAnchorsIDToClient), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventGetVideoPlayerInfo, 
				getQualifiedClassName(CEventGetVideoPlayerInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventGetVideoPlayerInfoRes, 
				getQualifiedClassName(CEventGetVideoPlayerInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoPlayerHeartBeatNotify, 
				getQualifiedClassName(CEventVideoPlayerHeartBeatNotify), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadRecommendVideoRoom, 
				getQualifiedClassName(CEventLoadRecommendVideoRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadRecommendVideoRoomRes, 
				getQualifiedClassName(CEventLoadRecommendVideoRoomRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventMobileBlockPublicChat, 
				getQualifiedClassName(CEventMobileBlockPublicChat), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventSyncChatBannedPlayers, 
				getQualifiedClassName(CEventSyncChatBannedPlayers), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventStartTalentShowMatch, 
				getQualifiedClassName(CEventStartTalentShowMatch), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventStopTalentShowMatch, 
				getQualifiedClassName(CEventStopTalentShowMatch), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventAssignTalentJudge, 
				getQualifiedClassName(CEventAssignTalentJudge), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventAssignTalentJudgeRes, 
				getQualifiedClassName(CEventAssignTalentJudgeRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventBroadcastAssignTalentJudgeMsg, 
				getQualifiedClassName(CEventBroadcastAssignTalentJudgeMsg), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadTalentShowScore, 
				getQualifiedClassName(CEventLoadTalentShowScore), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadTalentShowScoreRes, 
				getQualifiedClassName(CEventLoadTalentShowScoreRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventScoreTalentShow, 
				getQualifiedClassName(CEventScoreTalentShow), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventScoreTalentShowRes, 
				getQualifiedClassName(CEventScoreTalentShowRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshStarAnchorRank, 
				getQualifiedClassName(CEventRefreshStarAnchorRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshGuildChampionRank, 
				getQualifiedClassName(CEventRefreshGuildChampionRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshAnchorScoreRank, 
				getQualifiedClassName(CEventRefreshAnchorScoreRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshVideoGuildRank, 
				getQualifiedClassName(CEventRefreshVideoGuildRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventTalentShowStateChangeNotify, 
				getQualifiedClassName(CEventTalentShowStateChangeNotify), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventScoreTalentShowBroadcast, 
				getQualifiedClassName(CEventScoreTalentShowBroadcast), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventSyncTalentShowJudge, 
				getQualifiedClassName(CEventSyncTalentShowJudge), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventGetJudgeTypes, 
				getQualifiedClassName(CEventGetJudgeTypes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoShutDown, 
				getQualifiedClassName(CEventVideoShutDown), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventDice, 
				getQualifiedClassName(CEventDice), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventDiceResult, 
				getQualifiedClassName(CEventDiceResult), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventDianZan, 
				getQualifiedClassName(CEventDianZan), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventDianZanResult, 
				getQualifiedClassName(CEventDianZanResult), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcastAllRoom, 
				getQualifiedClassName(CEventVideoRoomEnterRoomBroadcastAllRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfo, 
				getQualifiedClassName(CEventLoadAttachedPlayerInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfoRes, 
				getQualifiedClassName(CEventLoadAttachedPlayerInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfoCard, 
				getQualifiedClassName(CEventLoadAttachedPlayerInfoCard), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfoCardRes, 
				getQualifiedClassName(CEventLoadAttachedPlayerInfoCardRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorImage, 
				getQualifiedClassName(CEventVideoRoomUploadAnchorImage), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorImageRes, 
				getQualifiedClassName(CEventVideoRoomUploadAnchorImageRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomAnchorImageRefresh, 
				getQualifiedClassName(CEventVideoRoomAnchorImageRefresh), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoEventSpeedLimit, 
				getQualifiedClassName(CEventVideoEventSpeedLimit), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventRefreshVideoVIPRank, 
				getQualifiedClassName(CEventRefreshVideoVIPRank), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventSetInvisibleOp, 
				getQualifiedClassName(CEventSetInvisibleOp), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventSetInvisibleOpRes, 
				getQualifiedClassName(CEventSetInvisibleOpRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoChatBanForAllRoom, 
				getQualifiedClassName(CEventVideoChatBanForAllRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoChatBanForAllRoomRes, 
				getQualifiedClassName(CEventVideoChatBanForAllRoomRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpress, 
				getQualifiedClassName(CEventLoadAnchorImpress), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressRes, 
				getQualifiedClassName(CEventLoadAnchorImpressRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadNestID, 
				getQualifiedClassName(CEventLoadNestID), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadNestIDRes, 
				getQualifiedClassName(CEventLoadNestIDRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressForPlayer, 
				getQualifiedClassName(CEventLoadAnchorImpressForPlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressForPlayerRes, 
				getQualifiedClassName(CEventLoadAnchorImpressForPlayerRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventEditAnchorImpress, 
				getQualifiedClassName(CEventEditAnchorImpress), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventEditAnchorImpressRes, 
				getQualifiedClassName(CEventEditAnchorImpressRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomInfo, 
				getQualifiedClassName(CEventVideoRoomGetRoomInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomInfoRes, 
				getQualifiedClassName(CEventVideoRoomGetRoomInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNestAssistantSetFunction, 
				getQualifiedClassName(CEventNestAssistantSetFunction), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNestAssistantSetFunctionRes, 
				getQualifiedClassName(CEventNestAssistantSetFunctionRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomNotifyAttachRoomInfo, 
				getQualifiedClassName(CEventVideoRoomNotifyAttachRoomInfo), HandleServerEvent);	
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadMemberOperationInfo, 
				getQualifiedClassName(CEventLoadMemberOperationInfo), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadMemberOperationInfoRes, 
				getQualifiedClassName(CEventLoadMemberOperationInfoRes), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadPlayerInfoForHomePage, 
				getQualifiedClassName(CEventLoadPlayerInfoForHomePage), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadPlayerInfoForHomePageRes, 
				getQualifiedClassName(CEventLoadPlayerInfoForHomePageRes), HandleServerEvent);	
			
			//_callCenter.addNeedResponseEventID(EEventIDVideoRoomExt.CLSID_CEventLoadPlayerInfoForHomePage, 
			//	EEventIDVideoRoomExt.CLSID_CEventLoadPlayerInfoForHomePageRes);
			
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoQueryVideoMoney, 
				getQualifiedClassName(CEventVideoQueryVideoMoney), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoQueryVideoMoneyRes, 
				getQualifiedClassName(CEventVideoQueryVideoMoneyRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoQueryBalance, 
				getQualifiedClassName(CEventVideoQueryBalance), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoQueryBalanceRes, 
				getQualifiedClassName(CEventVideoQueryBalanceRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCheckNick, 
				getQualifiedClassName(CEventVideoRoomCheckNick), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCheckNickRes, 
				getQualifiedClassName(CEventVideoRoomCheckNickRes), HandleServerEvent);	
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadPreviewVideoTreasureBoxNewRole, 
				getQualifiedClassName(CEventLoadPreviewVideoTreasureBoxNewRole), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadPreviewVideoTreasureBoxNewRoleRes, 
				getQualifiedClassName(CEventLoadPreviewVideoTreasureBoxNewRoleRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoTreasureBoxRewardNewRoleWeb, 
				getQualifiedClassName(CEventVideoTreasureBoxRewardNewRoleWeb), HandleServerEvent);		
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadVideoLevelRankRes, 
				getQualifiedClassName(CEventLoadVideoLevelRankRes), HandleServerEvent);					
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshVideoRichRank, 
				getQualifiedClassName(CEventRefreshVideoRichRank), HandleServerEvent);	
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventTakeDailyWageRes, 
				getQualifiedClassName(CEventTakeDailyWageRes), HandleServerEvent);		
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventTakeVideoActivityRewardsRes, 
				getQualifiedClassName(CEventTakeVideoActivityRewardsRes), HandleServerEvent);			
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventGetActivityCenterInfosRes, 
				getQualifiedClassName(CEventGetActivityCenterInfosRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomModifyNick, 
				getQualifiedClassName(CEventVideoRoomModifyNick), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomModifyNickRes, 
				getQualifiedClassName(CEventVideoRoomModifyNickRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNotifyIsNoviceGuided, 
				getQualifiedClassName(CEventNotifyIsNoviceGuided), HandleServerEvent);			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventSetNoviceGuided, 
				getQualifiedClassName(CEventSetNoviceGuided), HandleServerEvent);
			
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventGetActivityCompletedCount, 
				getQualifiedClassName(CEventGetActivityCompletedCount), HandleServerEvent);			
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventGetActivityCompletedCountRes, 
				getQualifiedClassName(CEventGetActivityCompletedCountRes), HandleServerEvent);
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventNotifyWebActivityGuide, 
				getQualifiedClassName(CEventNotifyWebActivityGuide), HandleServerEvent);
			
			//-----启用好友充值消息 start-----
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetFriendPayCashNotice, 
				getQualifiedClassName(CEventGetFriendPayCashNotice), HandleServerEvent);			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNotifyFriendPayCash, 
				getQualifiedClassName(CEventNotifyFriendPayCash), HandleServerEvent);
			//-----启用好友充值消息 end-----
			
			_callCenter.add_message_handler(VideoActivityEventID.CLSID_CEventNotifyRoomActivityComplete, 
				getQualifiedClassName(CEventNotifyRoomActivityComplete), HandleServerEvent);			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNotifyConcertVideoGiftUsableIDs, 
				getQualifiedClassName(CEventNotifyConcertVideoGiftUsableIDs), HandleServerEvent);
			
			_callCenter.add_message_handler(SplitScreenEventID.CLSID_CEventNotifySplitScreenInfoChange, 
				getQualifiedClassName(CEventNotifySplitScreenInfoChange), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRankChangeBroadcastAllPlayer, 
				getQualifiedClassName(CEventVideoRankChangeBroadcastAllPlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshAnchorLevelRank, 
				getQualifiedClassName(CEventRefreshAnchorLevelRank), HandleServerEvent);
			
			_callCenter.add_message_handler(NewGrowthEventID.CLSID_CEventSyncPlayerDreamGiftAnchorExp, 
				getQualifiedClassName(CEventSyncPlayerDreamGiftAnchorExp), HandleServerEvent);
			
			_callCenter.add_message_handler(EventNewGrowthID.CLSID_CEventAnchorGrowthConfig, 
				getQualifiedClassName(CEventAnchorGrowthConfig), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventBatchVideoTreasureBoxRewardNewRoleWeb, 
				getQualifiedClassName(CEventBatchVideoTreasureBoxRewardNewRoleWeb), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadStarGiftRankRes, 
				getQualifiedClassName(CEventLoadStarGiftRankRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadStarGiftChampionRankRes, 
				getQualifiedClassName(CEventLoadStarGiftChampionRankRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventStarGiftChampionNotify, 
				getQualifiedClassName(CEventStarGiftChampionNotify), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventLoadAnchorStarGiftInfoRes, 
				getQualifiedClassName(CEventLoadAnchorStarGiftInfoRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshStarGiftInfo, 
				getQualifiedClassName(CEventRefreshStarGiftInfo), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventTakeVipSeat, 
				getQualifiedClassName(CEventTakeVipSeat), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventTakeVipSeatRes, 
				getQualifiedClassName(CEventTakeVipSeatRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNotifyLostVipSeat, 
				getQualifiedClassName(CEventNotifyLostVipSeat), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshVipSeats, 
				getQualifiedClassName(CEventRefreshVipSeats), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNotifyVipTakeSeatProtectTime, 
				getQualifiedClassName(CEventNotifyVipTakeSeatProtectTime), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventAllVipSeatsOccupiedBroadcastAllRoom, 
				getQualifiedClassName(CEventAllVipSeatsOccupiedBroadcastAllRoom), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetVideoRoomLiveInfo, 
				getQualifiedClassName(CEventGetVideoRoomLiveInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetVideoRoomLiveInfoRes, 
				getQualifiedClassName(CEventGetVideoRoomLiveInfoRes), HandleServerEvent);
			
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventCheckNickOnLogin, 
				getQualifiedClassName(CEventCheckNickOnLogin), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventCheckNickOnLoginRes, 
				getQualifiedClassName(CEventCheckNickOnLoginRes), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventIgnoreFreeGift, 
				getQualifiedClassName(CEventIgnoreFreeGift), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventIgnoreFreeGiftRes, 
				getQualifiedClassName(CEventIgnoreFreeGiftRes), HandleServerEvent);

			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomWebTipsNotify,
				getQualifiedClassName(CEventVideoRoomWebTipsNotify), HandleServerEvent);
			
			_callCenter.add_message_handler(MobileUserAdminId.CLSID_CEventNotifyAllUserAdmin,
				getQualifiedClassName(CEventNotifyAllUserAdmin), HandleServerEvent);
			
			_callCenter.add_message_handler(MobileUserAdminId.CLSID_CEventNotifyUserAdminSystemInfo,
				getQualifiedClassName(CEventNotifyUserAdminSystemInfo), HandleServerEvent);

			
			
			//抽奖
			register_lucky_draw_server_event();
			
			//新皮肤
			register_new_skin_server_event();
		}

		private function register_lucky_draw_server_event():void {
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawActivityInfo,
				getQualifiedClassName(CEventVideoRoomLuckyDrawActivityInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomOpenLuckyDrawWindow,
				getQualifiedClassName(CEventVideoRoomOpenLuckyDrawWindow), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomOpenLuckyDrawWindowRes,
				getQualifiedClassName(CEventVideoRoomOpenLuckyDrawWindowRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCloseLuckyDrawWindow,
				getQualifiedClassName(CEventVideoRoomCloseLuckyDrawWindow), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDraw,
				getQualifiedClassName(CEventVideoRoomLuckyDraw), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawRes,
				getQualifiedClassName(CEventVideoRoomLuckyDrawRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomLuckyDrawNotice,
				getQualifiedClassName(CEventVideoRoomLuckyDrawNotice), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomSyncLuckyDrawInfo,
				getQualifiedClassName(CEventVideoRoomSyncLuckyDrawInfo), HandleServerEvent);
			
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshVipInfoToClient,
				getQualifiedClassName(CEventRefreshVipInfoToClient), HandleServerEvent);
		}

		private function register_new_skin_server_event():void {
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetPunchInInfo,
				getQualifiedClassName(CEventGetPunchInInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventGetPunchInInfoRes,
				getQualifiedClassName(CEventGetPunchInInfoRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventPunchIn,
				getQualifiedClassName(CEventPunchIn), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventPunchInRes,
				getQualifiedClassName(CEventPunchInRes), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNotifyPunchIn,
				getQualifiedClassName(CEventNotifyPunchIn), HandleServerEvent);

			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventUnlockRoomSkinTaskInfo,
				getQualifiedClassName(CEventUnlockRoomSkinTaskInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventNewRoomSkinBroadcastAllPlayer,
				getQualifiedClassName(CEventNewRoomSkinBroadcastAllPlayer), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRoomSkinLevelUpTaskInfo,
				getQualifiedClassName(CEventRoomSkinLevelUpTaskInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRoomSkinDailyTaskInfo,
				getQualifiedClassName(CEventRoomSkinDailyTaskInfo), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRoomSkinLevelUpNotify,
				getQualifiedClassName(CEventRoomSkinLevelUpNotify), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRoomDailyTaskRewards,
				getQualifiedClassName(CEventRoomDailyTaskRewards), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomCharmBroadcastAllRoom,
				getQualifiedClassName(CEventVideoRoomCharmBroadcastAllRoom), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventRefreshRoomCharmRank,
				getQualifiedClassName(CEventRefreshRoomCharmRank), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventQuerySkinGift,
				getQualifiedClassName(CEventQuerySkinGift), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventQuerySkinGiftRes,
				getQualifiedClassName(CEventQuerySkinGiftRes), HandleServerEvent);

			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomBasicInfos,
				getQualifiedClassName(CEventVideoRoomBasicInfos), HandleServerEvent);

			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoAD,
				getQualifiedClassName(CEventVideoAD), HandleServerEvent);
			_callCenter.add_message_handler(EEventIDVideoRoomExt.CLSID_CEventVideoRoomADClick,
				getQualifiedClassName(CEventVideoRoomAdClick), HandleServerEvent);
		}
		public function register_secret_box_server_event():void{
			_callCenter.add_message_handler(HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifySecretHeatBoxInfo,
				getQualifiedClassName(CEventNotifySecretHeatBoxInfo), HandleServerEvent);
			_callCenter.add_message_handler(HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventFinishEducation,
				getQualifiedClassName(CEventFinishEducation), HandleServerEvent);
			_callCenter.add_message_handler(HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyAnchorSecretCode,
				getQualifiedClassName(CEventNotifyAnchorSecretCode), HandleServerEvent);
			_callCenter.add_message_handler(HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventPlayerDrawSecretHeatBoxReward,
				getQualifiedClassName(CEventPlayerDrawSecretHeatBoxReward), HandleServerEvent);
			_callCenter.add_message_handler(HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyPlayerSecretHeatBox,
				getQualifiedClassName(CEventNotifyPlayerSecretHeatBox), HandleServerEvent);
			_callCenter.add_message_handler(HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventNotifyLastHitPlayerReward,
				getQualifiedClassName(CEventNotifyLastHitPlayerReward), HandleServerEvent);
			_callCenter.add_message_handler(HotboxSecretBoxLastHitPlayerEventID.CLSID_CEventWhistleLastHitPlayer,
				getQualifiedClassName(CEventWhistleLastHitPlayer), HandleServerEvent);
			
		}
		public function register_playback_server_event():void{
			_callCenter.add_message_handler(PlaybackEventID.CLSID_CEventConcertPlaybackRoomGetRoomList,
				getQualifiedClassName(CEventConcertPlaybackRoomGetRoomList), HandleServerEvent);
			_callCenter.add_message_handler(PlaybackEventID.CLSID_CEventConcertPlaybackRoomGetRoomListRes,
				getQualifiedClassName(CEventConcertPlaybackRoomGetRoomListRes), HandleServerEvent);
			_callCenter.add_message_handler(PlaybackEventID.CLSID_CEventStartConcertPlayback,
				getQualifiedClassName(CEventStartConcertPlayback), HandleServerEvent);
			_callCenter.add_message_handler(PlaybackEventID.CLSID_CEventStartConcertPlaybackRes,
				getQualifiedClassName(CEventStartConcertPlaybackRes), HandleServerEvent);
		}
		public function register_weekstar_server_event():void{
			_callCenter.add_message_handler(WeekStarEventID.CLSID_CEventRefreshWeekStarRankRes,
				getQualifiedClassName(CEventRefreshWeekStarRankRes), HandleServerEvent);
			_callCenter.add_message_handler(WeekStarEventID.CLSID_CEventWeekStarConfigReq,
				getQualifiedClassName(CEventWeekStarConfigReq), HandleServerEvent);
			_callCenter.add_message_handler(WeekStarEventID.CLSID_CEventWeekStarConfigRsp,
				getQualifiedClassName(CEventWeekStarConfigRsp), HandleServerEvent);
			_callCenter.add_message_handler(WeekStarEventID.CLSID_CEventWeekStarNotifySucc,
				getQualifiedClassName(CEventWeekStarNotifySucc), HandleServerEvent);
			_callCenter.add_message_handler(WeekStarEventID.CLSID_CEventAnchorWeekStarLevelUpNotify,
				getQualifiedClassName(CEventAnchorWeekStarLevelUpNotify), HandleServerEvent);
			_callCenter.add_message_handler(WeekStarEventID.CLSID_CEventAnchorWeekStarMatchSettleNotify,
				getQualifiedClassName(CEventAnchorWeekStarMatchSettleNotify), HandleServerEvent);
		}
		
		public function HandleServerEvent(resType:int, p : INetMessage):void
		{
			if(resType == VideoResultType.VREST_TimeOut || resType == VideoResultType.VREST_ConnectionClosed)
			{
				Globals.s_logger.error("Key Message TimeOut or Connection closed!");
				_videoClient.HandleMessageTimeOut();
			}
			else 
			{
				_videoClient.HandleServerEvent(p);
			}
//			p = null;
		}			
	}	
}