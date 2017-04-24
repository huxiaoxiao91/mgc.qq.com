package com.h3d.qqx5 {

	/**
	 * @author liuchui
	 */
	public class VideoWebOperationType {
		public static const VOT_GiftMsgBatch:int                          = -11;
		public static const VOT_TimeOut:int                               = -4;
		public static const VOT_SWFAddToStage:int                         = -3;
		public static const VOT_ConnectRoomProxyServer:int                = -2; //连接roomproxy
		public static const VOT_SetCookie:int                             = -1;

		public static const VOT_LoadRoomList:int                          = 0;
		public static const VOT_GetVideoADUrl:int                         = 1;
		public static const VOT_RefreshPlayerCharInfo:int                 = 2;
		public static const VOT_LoadAnchorStarlightRank:int               = 3;
		public static const VOT_LoadAnchorAffinityRank:int                = 4;
		public static const VOT_LoadVideoRoomAnchorPopularityRank:int     = 5;
		public static const VOT_LoadStarAnchorScoreRank:int               = 6;
		public static const VOT_LoadGuildChampionRank:int                 = 7;
		public static const VOT_LoadAnchorScoreRank:int                   = 8;
		public static const VOT_LoadVideoGuildRank:int                    = 9;

		public static const VOT_LoadAnchorPKWinnerRank:int                = 10;
		public static const VOT_LoadAnchorPKRichManRank:int               = 11;
		public static const VOT_EnterRoom:int                             = 12;
		public static const VOT_LeaveRoom:int                             = 13;
		public static const VOT_LoadAnchorInfocard:int                    = 14; //加载主播名片
		public static const VOT_LoadPlayerList:int                        = 15; //在线玩家列表
		public static const VOT_LoadTreasureBoxData:int                   = 17; //加载热度宝箱
		public static const VOT_SendGift:int                              = 19; //送礼

		public static const VOT_SearchOnlinePlayer:int                    = 20;
		public static const VOT_TakeVote:int                              = 21;
		public static const VOT_GetVoteStartInfo:int                      = 22;
		public static const VOT_LoadRecommendVideoRoomResult:int          = 23;
		public static const VOT_SendChatMsg:int                           = 24;
		public static const VOT_GetVipPrice:int                           = 25;
		public static const VOT_QueryFreeWhistleLeft:int                  = 26;
		public static const VOT_LoadVipSeat:int                           = 27;
		public static const VOT_LoadSuperFans:int                         = 28;
		public static const VOT_RefreshAnchorInfo:int                     = 29; //刷新主播信息

		public static const VOT_RefreshRoomInfo:int                       = 30;
		public static const VOT_NotifyVipLeftDay:int                      = 32;
		public static const VOT_RefreshRoomPlayerCount:int                = 33;
		public static const VOT_RefreshGiftPoolHeight:int                 = 34; //刷新热度条
		public static const VOT_RefreshRoomStatus:int                     = 35;
		public static const VOT_ReceiveGift:int                           = 36; //礼物消息广播
		public static const VOT_RefreshAnchorStarLightAndPopular:int      = 37; //刷新主播的星耀等值
		public static const VOT_RefreshFreeGiftInfo:int                   = 38;
		public static const VOT_ShowSendGiftScreenScrollMsg:int           = 39;
		public static const VOT_ShowVipEnterRoomScreenScrollMsg:int       = 40;
		public static const VOT_GuardEnterRoom:int                        = 41;
		public static const VOT_VipEnterRoom:int                          = 42;
		public static const VOT_KickPlayer:int                            = 43;
		public static const VOT_ForbidTalk:int                            = 44; //禁言
		public static const VOT_PlayerForbiddenTalk:int                   = 45;
		public static const VOT_OnReceiveChatMsg:int                      = 46;
		public static const VOT_BeKicked:int                              = 47;
		public static const VOT_RefreshRoomSchedule:int                   = 48; //不用
		public static const VOT_PlayerStartVip:int                        = 49;

		public static const VOT_ForbidTalkAllRoom:int                     = 50;
		public static const VOT_LoadRoomInfo:int                          = 51; //加载房间信息
		public static const VOT_StartVideoLive:int                        = 52;
		public static const VOT_StopVideoLive:int                         = 53;
		public static const VOT_LoadMyVideoGuild:int                      = 54;
		public static const VOT_LoadVideoGuildMemberList:int              = 55;
		public static const VOT_KickVideoGuildMember:int                  = 56;
		public static const VOT_ExitVideoGuild:int                        = 57;
		public static const VOT_ModifyVideoGuildMemberPosition:int        = 58;
		public static const VOT_ModifyVideoGuildPositionInfo:int          = 59;

		public static const VOT_LoadVideoGuildList:int                    = 60;
		public static const VOT_DisbandVideoGuild:int                     = 61;
		public static const VOT_CancelDisbandVideoGuild:int               = 62;
		public static const VOT_DesmissVideoGuild:int                     = 63;
		public static const VOT_CancelDemiseVideoGuild:int                = 64;
		public static const VOT_LoadVideoGuildPositions:int               = 65;
		public static const VOT_CreateVideoGuild:int                      = 66;
		public static const VOT_SendVideoGuildJoinApply:int               = 67;
		public static const VOT_GetVideoGuildJoinApplyList:int            = 68;
		public static const VOT_OperateJoinApply:int                      = 69;

		public static const VOT_OperateJoinApplyNotify:int                = 70;
		public static const VOT_JoinInvitationNotify:int                  = 71;
		public static const VOT_InvitePlayerJoinVideoGuild:int            = 72;
		public static const VOT_InvitePlayerJoinVideoGuildResult:int      = 73;
		public static const VOT_OperateJoinInvitation:int                 = 74;
		public static const VOT_ChangeSupportAnchor:int                   = 75;
		public static const VOT_GetVideoGuildInfo:int                     = 76;
		public static const VOT_GetPlayerVideoCardInfo:int                = 77;
		public static const VOT_UploadPlayerVideoCardInfo:int             = 78; //上传头像
		public static const VOT_ModifyPlayerVideoCardInfo:int             = 79;

		public static const VOT_ModifySelfVideoGuildName:int              = 80;
		public static const VOT_SendDailySignIn:int                       = 81;
		public static const VOT_SendVideoGuildMonthTicket:int             = 82;
		public static const VOT_BuyVideoGuildBoard:int                    = 83;
		public static const VOT_BeDismissed:int                           = 84;
		public static const VOT_DemiseSuccess:int                         = 85;
		public static const VOT_VideoGuildDisband:int                     = 86;
		public static const VOT_PlayerBeKicked:int                        = 87;
		public static const VOT_UpdateVideoGuildLog:int                   = 88;
		public static const VOT_SurportAnchorChange:int                   = 89;

		public static const VOT_RequestWelfareDistribution:int            = 90;
		public static const VOT_WelfareDistributeRes:int                  = 91;
		public static const VOT_ModifyFansBoardName:int                   = 92;
		public static const VOT_GetSelfVideoGuildInfo:int                 = 93;
		public static const VOT_ForbidJoinApply:int                       = 94;
		public static const VOT_LoadVideoGuildTicketBoardPage:int         = 95;
		public static const VOT_GetLogRecordOfVideoGuild:int              = 96;
		public static const VOT_SetVideoGuildID:int                       = 97;
		public static const VOT_ApproveVideoJoinApply:int                 = 98;
		public static const VOT_GetRenameVideoGuildCost:int               = 99;

		public static const VOT_GetChangeAnchorCost:int                   = 100;
		public static const VOT_IgnoreJoinInvitation:int                  = 101;
		public static const VOT_ModifySelfVideoGuildDesc:int              = 102;
		public static const VOT_ModifySelfVideoGuildNotice:int            = 103;
		public static const VOT_GetSelfVideoGuildID:int                   = 104;
		public static const VOT_StartVip:int                              = 105; //开通贵族
		public static const VOT_RenewalVip:int                            = 106; //续费
		public static const VOT_TakeVipDailyReward:int                    = 107;
		public static const VOT_DianZan:int                               = 108;
		public static const VOT_LoadVideoVIPRank:int                      = 109;

		public static const VOT_LoadAnchorTwoweekStarlightRank:int        = 110;
		public static const VOT_ReportAnchor:int                          = 111;
		public static const VOT_LoadAnchorImpressionForAnchor:int         = 112;
		public static const VOT_LoadAnchorImpressionForPlayer:int         = 113;
		public static const VOT_EditAnchorImpressionForPlayer:int         = 114;
		public static const VOT_OpenTreasureBox:int                       = 115; //开宝箱,不用了
		public static const VOT_FollowAnchor:int                          = 116;
		public static const VOT_CancelFollowAnchor:int                    = 117;
		public static const VOT_LoadFollowingAnchorsInfo:int              = 118;
		public static const VOT_CreateRole:int                            = 119;

		public static const VOT_PlayOpenTreasureBoxEffect:int             = 120;
		public static const VOT_PublishAnchorTask:int                     = 121; //发布主播任务，玩家在房间的回调
		public static const VOT_TakeAnchorTask:int                        = 122; //接受主播任务
		public static const VOT_DropAnchorTask:int                        = 123; //放弃主播任务
		public static const VOT_QueryAnchorTask:int                       = 124; //查询主播任务
		public static const VOT_AnchorStopLive:int                        = 125; //主播离开房间或者下麦导致主播任务消失
		public static const VOT_RemoveAnchorTask:int                      = 126; //凌晨两点清理任务
		public static const VOT_VipExpired:int                            = 127; //vip过期提醒
		public static const VOT_ConnectVideoVersion:int                   = 128; //连接版本服务器
		public static const VOT_MemberOperationInfo:int                   = 129; //成员操作列表中的信息请求

		public static const VOT_QueryBalance:int                          = 130; //余额查询
		public static const VOT_NotifyAnchorStartVote:int                 = 131; //主播发起新投票的通知
		public static const VOT_EncryptPortraitUrl:int                    = 132; //加密头像url
		public static const VOT_GetVipAddition:int                        = 133; //获取贵族加成信息
		public static const VOT_CheckNick:int                             = 134; //检查重名
		public static const VOT_AnchorLiveStartNotify:int                 = 135; //开播提醒
		public static const VOT_GetPrivateInfoList:int                    = 136; //私聊列表
		public static const VOT_IsStartedVote:int                         = 137; // 房间有否有发起投票
		public static const VOT_HasVoted:int                              = 138; // 自己是否投过票
		public static const VOT_IsFollowedAnchor:int                      = 139; // 是否关注了主播

		public static const VOT_SetInvisible:int                          = 140; // 设置隐身状态
		public static const VOT_LoadPreviewTreasureBoxData:int            = 141; //预览宝箱奖励数据
		public static const VOT_OpenTreasuerBoxResult:int                 = 142; //打开宝箱获得奖励
		public static const VOT_FinishAnchorTask:int                      = 143; //完成主播任务
		public static const VOT_GetImpressionIDName:int                   = 144; //主播印象id和名称的对应值
		public static const VOT_IgnorePlayer:int                          = 145; //屏蔽取消屏蔽
		public static const VOT_IsInIgnoreList:int                        = 146; //是否在屏蔽列表
		public static const VOT_LoadPlayerInfoForHomePage:int             = 147; //首页的个人信息 
		public static const VOT_LoadVideoLevelRank:int                    = 148; //视频等级排行榜
		public static const VOT_LoadVideoRichRank:int                     = 149; //财富排行榜

		public static const VOT_TakeDailyWageRes:int                      = 150; //领取每日工资
		public static const VOT_GetAcitivityCenterInfos:int               = 151; //获取活动信息
		public static const VOT_TakeVideoActivityRewards:int              = 152; //领取活动中心奖励
		public static const VOT_ActivityCompletedCount:int                = 153; //活动中心完成的数量
		public static const VOT_QueryVideoMoney:int                       = 154; //查询梦幻币余额
		public static const VOT_ModifyNick:int                            = 156; //修改玩家昵称

		//演唱会相关///////////////////////////////////////////////////////begin
		public static const VOT_ConcertStatusChange:int                   = 157; //演唱会房间状态改变
		public static const VOT_NotifyCurrentDefinition:int               = 158; // 通知正在播放的清晰度
		public static const VOT_GetCurrentDefinition:int                  = 159; // 获取当前视频的清晰度
		public static const VOT_GetCurrentAvailableDefinition:int         = 160; // 获取可选的清晰度
		public static const VOT_SetDefaultDefinition:int                  = 161; // 设置默认的视频清晰度
		public static const VOT_ChooseDefinition:int                      = 162; // 选择视频清晰度
		public static const VOT_NotifyRaffleState:int                     = 163; //展示奖品、开始抽奖的回调，countdown分别是两个倒计时，从回调开始就要倒计时而不是打开界面才倒计时
		public static const VOT_GetBuyTicketAndPicURL:int                 = 164; //// 购票和房间网址
		public static const VOT_OnSwitchWhistleBroadcast:int              = 165; //开启/关闭飞屏开关广播结果（所有玩家）
		public static const VOT_RefreshLiveTaskInfo:int                   = 166; //// 刷新现场任务数据
		public static const VOT_QueryRaffle:int                           = 167; //查询抽奖
		public static const VOT_DoRaffle:int                              = 168; //// 抽奖
		public static const VOT_NotifyNewLiveTask:int                     = 169; //// 新增现场任务通知
		//演唱会相关//////////////////////////////end/////////////////////////end

		public static const VOT_ForbidPrivateChat:int                     = 170; //频闭私聊除了管理员和主播以外
		public static const VOT_Logout:int                                = 171; //退出登录
		public static const VOT_CheckCanEnterRoom:int                     = 172; //查询是否可以进入房间
		public static const VOT_AnchorStopVote:int                        = 173; //主播停止投票
		public static const VOT_GetConcertCurLeftTime:int                 = 174; //获取演唱会当前状态现在剩余的时间
		public static const VOT_NotifyDivertInfo:int                      = 175; //分流推荐
		public static const VOT_GetSelfVipLevelAndRemainTime:int          = 176; //获取玩家自身的贵族等级和剩余时间
		public static const VOT_RefreshRoomName:int                       = 177; //刷新房间名称
		public static const VOT_GetConnectStatus:int                      = 178; //获取当前连接状态
		public static const VOT_ClearCookie:int                           = 179; //清理登陆cookie

		public static const VOT_NoviceGuided:int                          = 180; //是否需要进行新手教学
		public static const VOT_SetNoviceGuided:int                       = 181; //设置新手教学，以便下次补在进行新手教学了
		public static const VOT_NotifyMoneyChange:int                     = 182; //通知个人钱数发生改变
		public static const VOT_QueryDreamGift:int                        = 183; //请求梦幻币礼物数量
		public static const VOT_QueryIsConcertRoom:int                    = 184; //查询当前进入的房间是否是演唱会房间
		public static const VOT_GetFriendPayCashInfo:int                  = 185; //获取好友给自己充值的信息
		public static const VOT_GetPortraitUrl:int                        = 186; //获取自己的头像
		public static const VOT_GetGiftEffectCnt:int                      = 187; //礼物数量对应的特效
		public static const VOT_RefreshConcertTotalPlayers:int            = 188; //刷新演唱会房间累计观看人数

		//首登签到相关接口---begin
		public static const VOT_GetFirstLoginRewardNotify:int             = 189; //玩家领取首次登陆奖励【请求和回调】
		public static const VOT_GetFirstLoginReward:int                   = 190; //领取首登奖励【请求和回调】
		public static const VOT_SignDaliyNotify:int                       = 191; //每日签到提醒
		public static const VOT_GetSignDailyInfo:int                      = 192; //获取每日签到信息【请求和回调】
		public static const VOT_SignInDaily:int                           = 193; //领取奖励【请求和回调】
		public static const VOT_GetCumulativeReward:int                   = 194; //领取累计奖励【请求和回调】
		//首登签到相关接口---end

		public static const VOT_RefreshConcertFreeGiftInfo:int            = 196; //刷新演唱会的特殊免费礼物
		public static const VOT_Gift_ID_Array:int                         = 197; //返回可以显示的礼物ID数组
		public static const VOT_GetGuestInfo:int                          = 198; //获取游客账号
		public static const VOT_DailyRoomActivity:int                     = 199; //特定房间内特定时间在线完成

		public static const VOT_RefreshSplitScreenInfo:int                = 200; //分屏受邀直播信息
		public static const VOT_OnStarSplitScreenLive:int                 = 201; //开启分屏直播
		public static const VOT_StopWatchInvitedAnchorLive:int            = 202; //停止分屏直播
		public static const VOT_IsGuest:int                               = 203; //是否为游客登录状态
		public static const VOT_QueryGuestCookie:int                      = 204; //查询缓存的游客账号
		public static const VOT_HaveJoinGuildAndPosition:int              = 205; //查询玩家是否加入了后援团
		public static const VOT_GetMembersCanBeDismissed:int              = 206; //满足被传位条件的成员列表

		//小窝捧场和成长相关接口---begin
		public static const VOT_LoadSupportInfo:int                       = 207; //加载捧场界面信息
		public static const VOT_SendNormalSupport:int                     = 208; //普通捧场
		public static const VOT_NotifyAdvancedSupport:int                 = 209; //高级捧场特效通知
		public static const VOT_TakeAnchorNestTask:int                    = 210; //领取小窝任务
		public static const VOT_RefreshAnchorData:int                     = 211; //刷新主播数据
		public static const VOT_NotifyNestTaskFinished:int                = 212; //通知小窝任务完成
		public static const VOT_AddNestPopularity:int                     = 213; //人气增加的通知
		public static const VOT_GetNestGrowUp:int                         = 214; //获取成长信息
		public static const VOT_AddNestPopularityCredits:int              = 215; //增加小窝人气、小窝积分结果回调4
		public static const VOT_GetGuardWage:int                          = 216; //领取守护工资奖励
		public static const VOT_RefreshAnchorNestPopularity:int           = 217; //刷新主播人气信息
		public static const VOT_RefreshNestCreditsPanel:int               = 218; //刷新小窝积分面板信息
		public static const VOT_GetNestList:int                           = 219; //获取旗下主播列表
		public static const VOT_QueryNestTaskReward:int                   = 220; //查询团务奖励
		public static const VOT_NotifyNestTaskBoxStatus:int               = 221; //通知人气宝箱状态
		public static const VOT_QueryNestTreasureBoxReward:int            = 222; //查看人气宝箱奖励
		public static const VOT_TakeNestTreasureBox:int                   = 223; //领取人气宝箱
		//小窝捧场和成长相关接口---end

		//惊喜宝箱---begin
		public static const VOT_QuerySurpriseBoxReward:int                = 224; //查询惊喜宝箱奖励
		public static const VOT_OpenQuerySurpriseBox:int                  = 225; //打开惊喜宝箱
		public static const VOT_UpdateSurpriseBoxStatus:int               = 226; //更新惊喜宝箱奖励
		public static const VOT_GetSurpriseBoxRewadr:int                  = 227; //获得惊喜宝箱奖励
		//惊喜宝箱---end

		//高级守护begin
		public static const VOT_TakeRoomGuardSeat:int                     = 230; //抢座
		public static const VOT_RoomGuardSeatLostNotify:int               = 231; //被抢的通知
		public static const VOT_RefreshRoomGuardSeats:int                 = 232; //刷新座位
		//高级守护end

		//页签
		public static const VOT_GetAllTags:int                            = 233; //获取所有页签
		public static const VOT_GetRandNick:int                           = 234; //获取随机昵称
		public static const VOT_StarlightRankChangeBroadcastAllPlayer:int = 235; //星耀榜 周星榜变化时的走马灯消息。
		public static const VOT_RefreshPlayerGuardLevelToLiveAnchor:int   = 236; //刷新玩家对当前正在直播的守护等级
		public static const VOT_GetVideoRoomPicUrl:int                    = 237; //获取房间内的幻灯片
		public static const VOT_NotifyAttachRoom:int                      = 238; //通知附属的房间id
		public static const VOT_GuardLevelChangeNotify:int                = 239; //守护等级升降的提示
		public static const VOT_NotifyPublishNestTask:int                 = 240; //团务和人气宝箱红点提示通知
		public static const VOT_ForbidFreeGift:int                        = 250; //屏蔽免费礼物

		//红包begin
		public static const VOT_PublishRedEnvelope:int                    = 251; //发布红包
		public static const VOT_GrabRedEnvelope:int                       = 252; //抢红包
		public static const VOT_LoadRedEnvelope:int                       = 253; //查看红包
		public static const VOT_RedEnvelopeGrabFinish:int                 = 254; //红包被抢光了
		//红包end

		//新成长
		public static const VOT_RefreshAnchorLevelRank:int                = 255; //刷新主播等级榜
		public static const VOT_SyncPlayerDreamGiftAnchorExp:int          = 256; //刷新我对当前主播贡献的经验值已经当日上限
		//主播下线时 主动开启宝箱
		public static const VOT_BatchVideoTreasureBoxRewardNewRoleWeb:int = 257;
		//ChangeLogin
		public static const Change_Login:int                              = 258;
		//定时通知web刷新缓存
		public static const Login_Hb:int                                  = 259;
		//加载周星榜请求
		public static const VOT_VideoStarGiftRankWeb:int                  = 270;
		//冠军榜请求
		public static const VOT_VideoStarGiftChampionRankWeb:int          = 271;
		//周星冠军通知
		public static const VOT_StarGiftChampionNotify:int                = 272;
		//主播周星数据
		public static const VOT_LoadAnchorStarGiftInfo:int                = 273;
		//刷新周星礼物信息
		public static const VOT_RefreshStarGiftInfo:int                   = 274;

		//VIP抢座begin
		public static const VOT_NotifyLostVipSeat:int                     = 275;
		public static const VOT_TakeVipSeat:int                           = 276;
		public static const VOT_RefreshVipSeats:int                       = 277;
		public static const VOT_NotifyVipTakeSeatProtectTime:int          = 278;
		public static const VOT_NotifyVipTakeSeatFull:int                 = 279;
		public static const VOT_GetSeatPriceResetNotice:int               = 280;
		public static const VOT_NotifyVipFreeSeatLeft:int                 = 281;
		//VIP抢座 end

		// 火箭 begin
		public static const VOT_GrabDreamBox:int                          = 282; //抢梦幻宝箱
		public static const VOT_QueryDreamBoxRec:int                      = 283; //查看梦幻宝箱抢夺记录
		public static const VOT_PublishDreamBox:int                       = 284; //发布梦幻宝箱
		public static const VOT_RefreshDreamBoxCnt:int                    = 285; //刷新梦幻宝箱数量
		public static const VOT_ShowRocketGiftWhistle:int                 = 286; //火箭礼物飞屏
		public static const VOT_NotifyDreamBoxGrabbedOut:int              = 287; //通知梦幻宝箱抢空
		public static const VOT_NotifyClearDreamBox:int                   = 288; //通知清空梦幻宝箱
		//火箭 end

		public static const VOT_NotifyWebActivityGuide:int                = 289; //通知开始提示引导
		//获取vid
		public static const VOT_NotifyVideoRoomLiveInfo:int               = 290;
		//检测用户名是否重复
		public static const VOT_NotifyCheckNickOnLogin:int                = 291;
		//忽略免费礼物消息
		public static const VOT_IgnoreFreeGift:int                        = 292;
		//登录续期
		public static const VOT_VideoClientSigVerify:int                  = 293;

		//=======================================================================
		//
		// 幸运抽奖
		//
		//=======================================================================
		/**
		 * 294-通知上一次免费抽奖时间（推送）
		 * {op_type:293, last_free_lucky_draw_time:nnnn, free_lucky_draw_interval:nnn}
		 */
		public static const VOT_NotifyLastFreeLuckyDrawTime:int           = 294;
		/**
		 * 295-打开抽奖界面（请求/返回）
		 * 请求：{op_type:294, begin_time:nnnn}
		 * 返回：
		 */
		public static const VOT_OpenLuckyDrawWindow:int                   = 295;
		/**
		 * 296-关闭抽奖界面
		 * 请求：{op_type:295}
		 */
		public static const VOT_CloseLuckyDrawWindow:int                  = 296;
		/**
		 * 297-抽奖（请求/返回）
		 */
		public static const VOT_LuckyDraw:int                             = 297;
		/**
		 * 298-抽奖通知（推送）
		 */
		public static const VOT_NoticeLuckyDraw:int                       = 298;
		/**
		 * 299-抽奖信息更新（推送）
		 */
		public static const VOT_UpdateLuckyDrawInfo:int                   = 299;

		//=======================================================================
		//
		// 新皮肤
		//
		//=======================================================================
		/**
		 * 300-获取打卡界面信息
		 */
		public static const VOT_GetPunchInInfo:int                        = 300;
		/**
		 * 301-打卡
		 */
		public static const VOT_PunchIn:int                               = 301;
		/**
		 * （弃用，主播端消息）302-打卡增加魅力值通知（他人）
		 */
		public static const VOT_NotifyPunchIn:int                         = 302;

		/**
		 * 303-服务器下发解锁皮肤任务进度信息
		 */
		public static const VOT_UnlockRoomSkinTaskInfo:int                = 303;
		/**
		 * 304-解锁皮肤任务完成，下发解锁皮肤成功走马灯消息
		 */
		public static const VOT_NewRoomSkinBroadcastAllPlayer:int         = 304;
		/**
		 * 305-开启房间皮肤升级任务时，下发房间皮肤升级任务信息给界面显示
		 */
		public static const VOT_RoomSkinLevelUpTaskInfo:int               = 305;
		/**
		 * 306-开启房间每日任务时，下发房间每日任务信息给界面显示
		 */
		public static const VOT_RoomSkinDailyTaskInfo:int                 = 306;
		/**
		 * 308-消息作用：通知房间皮肤升级
		 */
		public static const VOT_RoomSkinLevelUpNotify:int                 = 308;
		/**
		 * 309-房间皮肤满级后，每日任务达成下发奖励消息
		 */
		public static const VOT_RoomDailyTaskRewards:int                  = 309;
		/**
		 * 310-魅力榜变成第一走马灯消息
		 */
		public static const VOT_VideoRoomCharmBroadcastAllRoom:int        = 310;
		/**
		 * 311-刷新房间魅力榜
		 */
		public static const VOT_RefreshRoomCharmRank:int                  = 311;
		/**
		 * 313-询问皮肤与专属礼物对应关系
		 */
		public static const VOT_QuerySkinGift:int                         = 313;
		/**
		 * 314-获取服务器时间
		 */
		public static const VOT_GET_SYSTEM_TIME:int                       = 314;
		/**
		 * 315-广告
		 */
		public static const VOT_AD:int                                    = 315;
		/**
		 * 316-房间内广告被点击
		 */
		public static const VOT_ViderRoomADClick:int                      = 316;

		/**
		 * 317-购买贵族飞屏通知消息
		 */
		public static const VOT_NoticeBuyVip:int                          = 317;
		/**
		 * 318-连接服务器消息
		 */
		public static const VOT_CONNECT_MSG:int                           = 318;
		/**
		 * 319-任务引导结束
		 */
		public static const VOT_MISSION_GUIDE_OVER:int                    = 319;
		
		/**
		 * 320-主播PK总榜
		 */
		public static const VOT_RefreshAnchorPKRank:int                   = 320;
		
		/**
		 * 321-玩家贡献榜
		 */
		public static const VOT_RefreshPlayerContributePKRank:int                   = 321;
		
		/**
		 * 322-刷新火箭buff 主动下发
		 */
		public static const VOT_RefreshRocketBuff:int                   = 322;
		
		/**
		 * 323-刷新pk赛进度条信息，10s一次
		 */
		public static const VOT_RefreshPkProgressInfo:int                   = 323;
		
		/**
		 * 324-刷新pk比赛信息，包括比赛开始倒计时，开始比赛，比赛结束的结果通知
		 */
		public static const VOT_NotifyPkMatchInfo:int                   = 324;
		
		/**
		 * 325-刷新pk值信息，1s一次
		 */
		public static const VOT_RefreshPkValue:int                   = 325;
		
		/**
		 * 326-刷新pk礼物，pk的角标
		 */
		public static const VOT_RefreshPkGift:int                   = 326;		
		/**
		 *  向客户端发送通用活动开始信息
		 */
		public static const VOT_CommonActivityInfoBegin : int 		= 327;
		/**
		 *  向客户端发送通用活动结束信息
		 */
		public static const VOT_CommonActivityInfoEnd : int 		= 328;
		/**
		 *  向客户端发送通用活动配置更新信息
		 */
		public static const VOT_CommonActivityInfoRefresh : int 	= 329;
		/**
		 *  向客户端发送通用活动地板数据信息（包括主播排名，主播收到的礼物数，底板等级）
		 */
		public static const VOT_RefreshCommonActivityData : int 	= 330;	
		/**
		 *  向客户端发送的玩家贡献榜信息
		 */
		public static const VOT_CommonActivityPlayerRank: int 		= 331;
		/**
		 * 向客户端发送 所有移动管理员的pstid信息
		 */
		public static const VOT_GetAllUserAdminList: int 			= 332;
		public static const VOT_PushRoomBanNotice: int				=333;
		/**
		 * 下发密令宝箱数据，包括宝箱开启差值，活动标题，活动内容
		 */
		public static const VOT_NotifySecretHeatBoxInfo: int		= 334;
		/**
		 * 当客户端完成教学任务时，发送对应的教学任务的flag,给服务器。
		 */
		public static const VOT_FinishEducation: int			= 335;
		/**
		 * 当主播开播时，下发主播设置（默认）的密令给玩家。
		 */
		public static const VOT_NotifyAnchorSecretCode: int			= 336;
		/**
		 * 玩家领取密令宝箱:点击密令按钮，发送请求即可，没有返回数据
		 */
		public static const VOT_PlayerDrawSecretHeatBoxReward: int			= 337;
		/**
		 * 通知玩家密令宝箱倒计时变化
		 */
		public static const VOT_NotifyPlayerSecretHeatBox: int			= 338;
		/**
		 * 通知补刀王玩家获得的奖励
		 */
		public static const VOT_NotifyLastHitPlayerReward: int			= 339;
		/**
		 * 广播补刀王飞屏
		 */
		public static const VOT_WhistleLastHitPlayer: int			= 340;
		/**
		 * 演唱会回放新增接口
		 */ 
		/**
		 * 获取演唱会回放房间列表事件
		 */
		public static const VOT_ConcertPlaybackRoomGetRoomList: int			= 341;
		/**
		 * 开始观看演唱会回放事件
		 */
		public static const VOT_StartConcertPlayback: int					= 342;
		/**
		 * 周星赛结算和获奖提示确认
		 */ 
		public static const VOT_WeekStarNotifySucc: int					= 343;
		/**
		 * 周星赛URL配置请求
		 */ 
		public static const VOT_WeekStarURLConfig:int				=344;
		/**
		 * 通知主播周星等级升级
		 */ 
		public static const VOT_AnchorWeekStarLevelUpNotify:int				=345;
		/**
		 * 通知主播周星积分结算
		 */ 
		public static const VOT_AnchorWeekStarMatchSettleNotify:int				=346;
		/**
		 * 获取周星积分榜数据
		 */ 
		public static const VOT_GetWeekStarRankList:int				=347;
		
	}
}
