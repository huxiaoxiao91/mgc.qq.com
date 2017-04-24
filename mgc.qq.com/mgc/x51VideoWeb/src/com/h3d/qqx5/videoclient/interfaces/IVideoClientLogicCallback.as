package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.common.comdata.FreeGiftInfo;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxForUI;
	import com.h3d.qqx5.modules.video_activity.VideoActivityInfoToClient;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_rank_server.shared.AnchorWeekStarMatchInfo;
	import com.h3d.qqx5.videoclient.data.ActivityCenterInfosForUI;
	import com.h3d.qqx5.videoclient.data.AnchorInfocard;
	import com.h3d.qqx5.videoclient.data.AnchorStarlightRankData;
	import com.h3d.qqx5.videoclient.data.AnchorTaskInfoUI;
	import com.h3d.qqx5.videoclient.data.CDailySiginRewardForUI;
	import com.h3d.qqx5.videoclient.data.CMemberOperationInfo;
	import com.h3d.qqx5.videoclient.data.CeremonyStartInfoForUI;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	import com.h3d.qqx5.videoclient.data.DailySigninRewardContentForUI;
	import com.h3d.qqx5.videoclient.data.GiftData;
	import com.h3d.qqx5.videoclient.data.RaffleRewardForUI;
	import com.h3d.qqx5.videoclient.data.RewardDataForUI;
	import com.h3d.qqx5.videoclient.data.RoomInfoForUI;
	import com.h3d.qqx5.videoclient.data.SendVideoGiftResultInfo;
	import com.h3d.qqx5.videoclient.data.UIEnterVideoRoomInfo;
	import com.h3d.qqx5.videoclient.data.VideoChatErrorInfo;
	import com.h3d.qqx5.videoclient.data.VideoGuardSeatInfoUI;
	import com.h3d.qqx5.videoclient.data.VideoRoomBoxReward;
	import com.h3d.qqx5.videoclient.data.VideoRoomData;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import com.h3d.qqx5.videoclient.data.VideoRoomScreenScrollInfo;
	import com.h3d.qqx5.videoclient.data.VideoVipPlayerCardInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoVoteInfoForUI;
	import com.h3d.qqx5.videoclient.data.VipAddtionInfo;
	import com.h3d.qqx5.videoclient.data.VipPriceInfoForUI;
	import com.h3d.qqx5.videoclient.data.VipSeatInfoForUI;
	
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	//逻辑主接口
	public interface IVideoClientLogicCallback
	{
		
		function onLoadFinish():void;
		//获得惊喜宝箱ui回调
		function GetSurpriseBoxCallBack():IUISurpriseBox;
		// 被踢出房间通知，reason枚举类型为VideoRoomBeKickedReason
		function NotifyBeKicked(reason:int,device_type:int):void;
		// 刷新房间信息，通知房间内玩家
		function RefreshRoomInfo(data:VideoRoomData):void;
		// 刷新房间在线人数
		function RefreshRoomPlayerCount(roomID:int , count:int , capacity:int ):void;
		// 更新主播信息，对其它玩家/主播
		function RefreshAnchorInfoByData(data:ClientAnchorData,isFollow:Boolean, roomName:String):void;
		// 更新
//		function RefreshDanceChampionInfo():void;
		// 收到聊天信息
		function OnReceiveChatMsg(msg:VideoRoomMsgData):void;
//		// 玩家被禁言/取消禁言的通知，perpetual表示是否永久禁言，forbid表示禁言还是取消禁言
		function NotifyPlayerForbiddenTalk(
			playerID:Int64, 
			targetName:String, 
			targetZoneName:String, 
			perpetual:Boolean, 
			forbid:Boolean,
			opName:String,
			opZoneName:String,
			opGuardLevel:int,
			targetGuardLevel:int,
			opVipLevel:int,
			targetVipLevel:int
		):void;
		// 收到礼物信息
		function OnReceiveGift(gift:GiftData,isSelf:Boolean = false):void;
		// 开启宝箱回调
		function OnOpenTreasureBoxRes(res:int, roomID:int,boxIndex:int,index:int, box_items:Array,reward:VideoRoomBoxReward):void;
//		// 主播上传/删除房间图片后通知房间内所有其他人
//		function RefreshRoomPicture( picIndex:int):void;
//		// 进入房间后，或视频卡后再播放时通知
//		function void OnLiveStartPlay(int play_type, int err_code) = 0;
//		// 直播视频卡了，网络通讯中断
//		function void OnLiveCommucationClose() = 0;
//		// 通知掉线
//		function void NotifyDisconnect(int res) = 0;
		// 刷新房间节目表
		function RefreshRoomSchedule(schedule:String):void;
		// 刷新房间内礼物池高度(即热度值)
		function RefreshGiftPoolHeight(curHeight:int, maxHeight:int,vip_addition:int,vip_cnt_info:Array,box_data_buf:Array):void;
		// 刷新房间状态(兼容演唱会房间，是否为演唱会，是否需要隐藏礼物区)
		function RefreshRoomStatus(status:int,isConcert:Boolean,isHasTicket:Boolean,isSpecialRoom:Boolean,width:int,height:int,anchor_device_type:int,vertical_live:Boolean):void ;
//		// 关注主播开播提醒
		function OnFollowingAnchorLiveStartNotify(anchor:String, room_id:int,logo_url:String) :void;
		// 免费礼物获得通知
		// giftNum 当前拥有的免费礼物数量
		// leftTime 下次获得剩余时间，单位 ms, -1代表不再送
		function RefreshFreeGiftInfo(giftNum:int, leftTime:int):void;
		//通知客户端播放宝箱特效
		function PlayOpenTreasureBoxEffect(index:int):void;
		// 有人送礼后刷新主播的星耀等值
		function RefreshAnchorStarLightAndPopular(star:Int64, popular:Int64):void;
//		// 主播PK,刷新防守主播的人气和星耀
//		function void RefreshDefendAnchorStarLightAndPopular(VideoInt64 anchor_id, VideoInt64 star, VideoInt64 popular) = 0;
		// 送礼超过一定数量通知全部房间滚动播出
		function ShowSendGiftScreenScrollMsg(info:VideoRoomScreenScrollInfo):void;
		// 一定级别的贵族(皇帝)进入房间消息全部房间滚动播出
		function ShowVipEnterRoomScreenScrollMsg(player_name:String,room_name:String,room_id:int,viplevel:int,guard_level:int,zone_name:String):void;
		// 刷新房间名
		function RefreshRoomName(room_name:String):void;
//		//获得守护身份通知
//		function void OnAssignGuardNotify(const std::string& player_name,
//			int guard_level,
//			const std::string& player_zone,
//			const std::string& anchor,
//			int assign_type) = 0;
//		//撤销守护身份通知
//		function void OnRecedeGuardNotify(const std::string & player_name,
//			int guard_level,
//			const std::string& player_zone,
//			const std::string& anchor,
//			int recede_type) = 0;
		//守护进房间提示
		function GuardEnterRoomNotify(player_name:String,player_zone:String,guard_level:int, invisible:Boolean):void;
		// 刷新VIP贵宾席回调
		function OnLoadVipSeats( res:int,  data:Array):void;
		// 刷新超级粉丝回调
		function OnLoadSuperFans(fanstype:int, res:int,  data:Array):void;
//		//////////////////////////////////////////////////////////////////////////
//		/* 下列操作为异步请求的callback，区分正常、超时、网络错误等情况*/
//		//////////////////////////////////////////////////////////////////////////
		// 获得房间列表回调
		function OnLoadRoomList(type:int, category:int, rooms:Array, totalCount:int, room_id_name:Dictionary, nests:Array, tag:int ,super_module_room_count:int,module_room_count:int):void;
		// 进入房间回调
		function NotifyEnterRoomRes(type:int, res:int , info:UIEnterVideoRoomInfo):void;
		// 退出房间回调
		function NotifyLeaveRoomRes(status:int):void;
		// 获取主播名片信息
		function OnLoadAnchorInfocard(type:int, succ:Boolean , data:AnchorInfocard,guardRuleUrl:String,isFollow:Boolean):void;
		// 获得玩家列表 param: pageCount为总页数
		function OnLoadPlayerList(type:int,roomID:int,players:Array, pageCount:int,playerid:Int64):void;

		// 送礼结果回调
		function OnSendGiftRes(type:int, result:SendVideoGiftResultInfo, qq:Int64,xuandou:int,video_money:int,gift_id:int,gift_cnt:int):void;
		// 获取宝箱数据回调
		function OnLoadTreasureBoxData(type:int,res:int, roomID:int, boxid:int, data:Array):void;
		// 获取主播星耀值排行榜
		function OnLoadAnchorStarlightRank(res:int ,rank : AnchorStarlightRankData,timedimension:int):void;
		// 获取主播人气值排行榜
		function OnLoadAnchorPopularityRank(type:int , res:int ,rank : AnchorStarlightRankData):void;
		// 获取主播亲密度排行榜
		function OnLoadAnchorAffinityRank(type:int, rank:Array,timedimension:int):void;
		// 获得在线列表搜索结果
		function OnSearchOnlinePlayerRes(type:int, search_res:Array):void;
		// 投票的结果
		function OnTakeVoteRes(type:int, errcode:int):void;
		// 返回房间的投票内容、自己的选择
		function OnGetVideoStartInfo(type:int, errcode:int, vote_info:VideoVoteInfoForUI, select:Array):void;
		// 获得推荐房间结果
		function OnLoadRecommendVideoRoomResult(type:int , res_type:int , recommend_info:Array):void;//std::vector<RecommendVideoRoomInfo>& 
		// 发送聊天消息结果回调，set_cd_time:聊天间隔时间 wait_time：需等待时间，两者单位均为毫秒，一般失败时会调用到
		function OnSendChatMsgRes(type:int, result:VideoChatErrorInfo, set_cd_time:int, wait_time:int,xuandou:int):void;
		// 禁言回调
		function OnForbidTalk(res:int):void;
		//梦工厂VIP贵族 begin
		//开通VIP结果回调
		function OnStartVip(type:int, errcode:int, videomoney:int, xuandou:int, cost_type:int, anchor_name:String, rebate:int):void;
		//续费VIP结果回调
		function OnRenewalVip(type:int, errcode:int, videomoney:int, xuandou:int, cost_type:int, anchor_name:String, rebate:int):void;
		//VIP即将到期提醒
		function NotifyVipLeftDay(level:int,left_day:int):void;
		//VIP过期提醒
		function NotifyVipExpired(level:int):void;
		//请求vip价格结果回调
		function OnGetVipPrice(info:VipPriceInfoForUI, rebate_info:Array):void;
		//开通VIP通知
		function NotifyPlayerStartVip(player_id:Int64, vip_level:int ):void;

		//加载梦工厂名片回调
		function OnGetPlayerVideoCardInfo(type:int, card_info:VideoVipPlayerCardInfoForUI,result:int ):void;
		//上传梦工厂头像回调
		function OnUploadPlayerVideoCardPortrait(errcode:int  ,pUrl:String):void;
		//修改梦工厂名片个人签名回调
		function OnModifyPlayerVideoCardSignature(errcode:int , signature:String):void;
		//领取VIP每日福利回调
		function OnTakeVipDailyReward(type:int, errcode:int ):void;
		//梦工厂VIP入场公告
		function NotifyVipEnterRoom(player_name:String,player_zone:String,vip_level:int,sex_male:Boolean,invisible:Boolean,isSelf:Boolean,guard_level:int,wealth_level:int):void;
		//刷新免费飞屏数量
		function OnQueryFreeWhistleLeft(count:int ):void;
		function OnQueryFreeSuperStarHornLeft(count:int ):void;
		//禁言/取消禁言，广播禁言结果这个已经有相应的接口了
		//参见NotifyPlayerForbiddenTalk，OnForbidTalk
		//梦工厂VIP贵族 end
		
		//全民选秀 begin
		//设置或取消评委回调
		function OnSetTalentShowJudgeResult(result:int):void;
		//加载星主播积分排行榜回调
		//typedef std::vector<ClientStarAnchorRankData>	ClientStarAnchorRank;
		function OnLoadStarAnchorScoreRank(type:int, res:int, rank:Array,url:String):void;
		//评委身份变化通知
//		function void TalentShowJudgeChangeNotify(const char* player_name,const char* zone_name,const char* op_name,int new_type,int old_type)  = 0;
		//开始比赛回调
		function OnStartTalentShow(result:int ):void;
		//停止比赛回调
		function OnStopTalentShow(result:int):void;
		
		//function OnTalentShowActivityEnd():void;
		//舞团争霸回调
//		function void OnDanceChampionStart()  = 0;
//		function void OnDanceChampionStop()  = 0;
		//加载当前打分情况回调
		function OnLoadTalentShowScore(type:int, res:int,scores:Array,vote_cnt:int ):void;
		//打分广播
		function OnScoreTalentShowBroadcast(scores:Array,guard_levels:Array,vip_levels:Array):void;
		//舞团争霸 点赞回调
		function OnDianZanResult(type:int, res:int ,anchor_name:String):void;
		
		function OnLoadGuildChampionRank(type:int, res:int,rank:Array):void;
		//全民选秀 end
//		function void VideoShuttingDownNotify(int minutes)  = 0;
		
		// (video guild)主播积分榜返回
		function OnLoadAnchorScoreRank(type:int,rank:Array,timedimension:int):void;
		
		// (video guild)后援团排行榜返回
		function  OnLoadVideoGuildRank(type:int,rank:Array):void;
		
		function GetVideoGuildCallback():IUIVideoGuild ;
		
		//显示粉丝牌
//		function void ShowVideoGuildBoard(const VideoGuildBoardRenderInfoForUI& info)  = 0;
		//隐藏后援团的粉丝牌
//		function void HideVideoGuildBoard(VideoInt64 vgid)  = 0;
		
		//获取后援团系统消息接口
//		function I_Video_Guild_Chat_Sys_Msg* GetIVideoGuildChatSysMsg(){return NULL;}
//		
//		function void OnDetectUploadSpeedRes( int detect_id, int upload_speed )   = 0;
//		
//		function void OnDiceResult(int n,const std::string& nick,VideoInt64 anchor_qq,int anchor_zone)  = 0;
//		
//		function void OnLoadAttachedPlayerInfoCard(const char* dynamicBuffer, int buffer_size)  = 0;
//		
//		//音频主播照片更换
//		function void RefreshAnchorImage()   = 0;
//		//通知房间私聊禁止
//		function void ShowPrivateChatBan()  = 0;
//		
//		function IUIAnchorPK* GetUIAnchorPK() {return NULL;}
//		
//		// 获取优胜主播排行榜
		function OnLoadAnchorPKWinnerRank(type:int, rank:Array, show_end_time:int ):void;
//		// 获取英豪排行榜
		function OnLoadAnchorPKRichManRank(type:int, rank:Array, show_end_time:int ):void;
//		
//		// 控制DOTNET视频窗口显示和隐藏
//		function void ShowUIVideoWindow(void* hWnd, bool bShow)   = 0;
//		
//		// 大活动时间开始、管理员进入正在活动中的房间时，主播端显示开启活动按钮
//		function void onCeremonyActivityStarted()   = 0;
//		// 大活动时间结束时，主播端隐藏开启活动按钮
//		function void onCeremonyActivityEnd()   = 0;
//		// 开启盛典活动结果（管理员）,用于失败时弹出错误提示框
//		function void onCeremonyStartRes(int res)   = 0;
//		// 盛典活动结束投票结果（管理员）
//		function void onCeremonyStopVoteRes(int res)   = 0;
//		// 盛典活动结果（管理员）
//		function void onCeremonyStopRes(int res)   = 0;
//		// 盛典活动开启时，主播、玩家进入正在活动中的房间时，刷新活动面板，state表示当前活动状态
//		function void onCeremonyStart(const CeremonyStartInfoForUI& info, int state)   = 0;
//		// 盛典活动投票终止时，刷新活动面板
//		function void onCeremonyStopVote()   = 0;
//		// 盛典活动结束时，刷新活动面板
//		function void onCeremonyStop()   = 0;
//		// 盛典活动过程中，刷新活动数据
//		function void onRefreshCeremonyInfo(const CeremonyRefreshInfoForUI& info)   = 0;
		// 切换支持的主播、送礼等
		function  onRefreshCeremonyStartInfo( info : CeremonyStartInfoForUI)  : void;
//		// 盛典活动开启时，所有房间广播走马灯消息
//		function void onCeremonyStartBroadcast(const std::vector<std::pair<int, std::string> >& room_id_names, std::vector<std::string> anchors)   = 0;
//		// 盛典活动停止投票时，所有房间广播走马灯消息
//		function void onCeremonyStopVoteBroadcast(std::vector<std::string> anchors)   = 0;
//		
		//发布主播任务，玩家在房间的回调, is_show表示显示或者隐藏，need_show_special表示显示的时候是否需要显示特效
		function AudienceOnPublishAnchorTask(is_show:Boolean, need_show_special:Boolean):void;
		//接收主播任务返回
		function OnTakeAnchorTaskRes(res:int):void;
		//放弃主播任务返回
		function OnDropAnchorTaskRes(res:int):void;
		//查询主播任务返回
		//function OnQueryClientAnchorTaskRes(task:AnchorTaskOnClientPlayerInfo):void;
		//查询主播任务返回（只给出错的时候使用）
		//function OnQueryAnchorTaskRes(res:int):void;
		//主播离开房间或者下麦导致主播任务消失
		function OnAnchorStopLive():void;
		//凌晨两点清理任务
		function OnRemoveAnchorTask():void;
		
		//收到即将关闭消息的处理，主播端客户端都需要在聊天框里显示系统消息
		function OnRoomIsClosing():void;
//		
//		//收到服务器返回的关闭时间,正在那个界面的管理员要刷新界面，开始显示倒计时
//		//客户端要显示走马灯
//		function void OnRecvCloseTime(int left_time)   = 0;
//		
		// 获取主播星耀值排行榜
		function OnLoadVideoVIPRank(type:int , rank:Array, total_size:int,  my_rank:int) :void;
//		
//		// 发出红包
//		function void OnPublishRedEnvelope(VideoInt64 red_id, const std::string& nick, const std::string& zone, int total_money, int divide_count)   = 0;
//		// 抢红包结果：red_id:红包id; grab_count:抢到的数量
//		function void OnGrabRedEnvelopeRes(VideoResultType type, int res, VideoInt64 red_id, int grab_count)   = 0;
//		// 查看红包：red_id:红包id; nick/zone:发红包人的昵称; total_money:红包总额; divide_count:红包分发数量; grabbers抢红包记录
//		function void OnLoadRedEnvelopeRes(VideoResultType type, int res, VideoInt64 red_id, const std::string& nick, const std::string& zone, int total_money, int divide_count, std::vector<UIVideoRedEnvelopeGrabberInfo>& grabbers)   = 0;
//		// 红包被抢光了
//		function void OnRedEnvelopeGrabFinish(VideoInt64 red_id)  = 0;
		// 全房间禁言系统消息
		function OnForbidTalkAllRoom(success:Boolean,nick:String,zone:String,ban:Boolean):void;
		function  GetUIAnchorNest():IUIAnchorNest;
		
		//关注收到发布任务通知
		function ListenerRecvNestTaskPublish():void;
		
		//主播获取印象信息
		function OnLoadAnchorImpressionForAnchor(type:int,data:Array,total_count:int,player_count:int):void;
		//玩家获取主播印象信息
		function OnLoadAnchorImpressionForPlayer(type:int,data:Array,anchorid:Number,status:int):void;
		//编辑主播印象
		function OnEditAnchorImpressionForPlayer(res:int):void;
		// 获取主播双周星耀值排行榜
		function OnLoadAnchorTwoweekStarlightRank(type:int, res:int, rank:AnchorStarlightRankData) :void;
		function OnGetNestListRes(result:Boolean,nest_info:Array, attached_room_id:int=0, attached_room_name:String=""):void;
		// 获得房间信息回调
		function OnLoadRoomInfo(info:RoomInfoForUI):void;
//		function void OnNestIsFreezing() = 0;
//		function void OnAssistantSetFunction(char res) = 0;
//		//收到小窝列表角标直播小窝数量回调
//		function void RefreshLiveNestCnt(int count) = 0;
//		function void RefreshNestImpression(const ClientImpressionData& data) = 0;
		function OnKickPlayer(res:int):void;
		function OnCreateRole(type:int,res:int,recommend_nick:String):void;
		function OnStartVideoLive(cdnUrls:Array,res:int,isConcert:Boolean):void;
		
		function OnStopVideoLive():void;
		
		//从版本服务器获得角色列表
		function OnLoadServerListFromVersion(type:int,succ:Boolean,room_proxy_infos:Array,account_infos:Array, lastAccount:Object):void;

		function notifyConnected(res:int, qq:uint, zoneid:int, isguest:Boolean):void;
		
		//add for web
		function OnGetPrivateInfoList(data:Array):void;
		function OnGetVipAdditionRes( data:VipAddtionInfo):void;
		function OnEncryptPortraitUrlRes(res:int,  encrypturl :String):void;
		function OnAnchorStartVote(res:int,data:VideoVoteInfoForUI ):void;
		function OnAnchorStopVote():void;//主播停止投票的通知
		function OnQueryBalanceRes(type:int,res:Boolean, balance:int):void;
		function OnMemberOperationRes(res:int, MemInfo:CMemberOperationInfo):void;
		function OnCheckNickRes(type:int, res:int, recommend_nick:String):void;		
		function OnHasVotedRes(res:Boolean):void;
		function OnIsStartVoteRes(res:Boolean):void;
		function OnQueryVideoMoneyRes(res:int, videomoney:int):void;
		// game_rewards 参数保证是最后一位
		//预览宝箱奖励回调
		function OnLoadTreasureBoxPreviewNewRole(box_id:int,reward:Array,buff_percent:int,game_rewards:Array):void;
		//查询惊喜宝箱奖励
		function OnQuerySurpriseBoxReward(reward:Array,buff_percent:int,game_rewards:Array):void;
		//新角色奖池奖励发放通知
		function OnOpenTreasuerBoxResultNewRoleWeb(res:int,box_id:int,choose_idx:int,truelyReward:Array,buff_percent:int,anchor_level:int,online:Boolean,is_reissue:Boolean, last_hit_player_name:String, last_hit_player_id:Int64, last_hit_player_invisible:Boolean, last_hit_player_ids:Array, last_hit_player_invisibles:Array, game_rewards:Array):void;
		
		//发放惊喜宝箱奖励
		function OnGetSurpriseBoxReard(Reward:Array,buff_percent:int,is_reissue:Boolean,game_rewards:Array):void;
		
		//查询主播回调
		function OnQueryClientAnchorTaskResNewRole(type:int,task:AnchorTaskInfoUI,adv_guard_ratio:int,buff_percent:int,game_rewards:Array):void;
		//完成主播任务时的奖励通知
		function OnFinishAnchorTaskNewRole(type:int,rewardlist:Array,adv_guard_ratio:int,buff_percent:int,is_reissue:Boolean,game_rewards:Array):void;
		
		//屏蔽
		function OnIgnorePlayerRes(bAdd:Boolean,res:Boolean):void;
		function OnIsInIgnoreListRes(res:Boolean):void;
		//财富排行榜回调
		function OnLoadVideoRichRank(type:int, rank:Array, total_size:int , my_rank:int,timedimension:int):void;
		// 视频等级排行榜回调
		function OnLoadVideoLevelRank(type:int, rank:Array, total_size:int , my_rank:int):void;
		// 获取活动中心信息回调
		function OnGetAcitivityCenterInfosRes(type:int,succ:int,info:ActivityCenterInfosForUI,dev_activity_cnt:int,game_rewards:Array):void;
		// 领取活动中心奖励回调
		function OnTakeVideoActivityRewardsRes(type:int, res:int, activity_id:int, activity_category:int, rewards:Array,is_reissue:Boolean,game_rewards:Array):void;
		// 领取每日工资回调 attached_wage附加工资
		function OnTakeDailyWageRes(type:int, res:int , wage:int, attached_wage:int ):void;
		// 活动完成数量通知
		function NotifyActivityCompletedCount(count:int,has_taken_wage_today:Boolean,status:int):void;
		function NotifyWebActivityGuide(is_act_guide_over:Boolean):void;
		////频闭私聊除了管理员和主播以外
		 function onForbiePrivateChat(forbid:int,res:int):void
			 
		
		//function OnModifyNickRes(type:int,res:int,recommend_nick:String,source_type:int):void;
		
		//演唱会相关
		
		// 通知正在播放的清晰度
		function NotifyCurrentDefinition(definition:int) :void;
		// 展示奖品、开始抽奖的回调，countdown分别是两个倒计时，从回调开始就要倒计时而不是打开界面才倒计时
		function OnRaffleStateNotify(state:int , rwds:Array, countdown:int) :void;
		// 显示结果回调
		function OnShowResult(state:int, result:Array, rwds:Array, countdown:int,playerid:String) :void;
		//玩家抽奖结果
		function OnDoRaffleRes(res:int , reward:RaffleRewardForUI, is_lucky:Boolean = false) :void;

		// 开启/关闭飞屏开关广播结果（所有玩家）
		function OnSwitchWhistleBroadcast(type:int , is_open:Boolean) :void;    // is_open表示当前飞屏开关状态
		
		// 刷新现场任务数据
		function RefreshLiveTaskInfo( info:Array ) :void;
		function NotifyNewLiveTask( res:Boolean ) :void;
		function NotifyDivertInfo( rooms:Array ,remcnt:int) :void;
		// 演唱会房间状态改变，演唱会是否开启
		function OnConcertStatusChange(hasticket:Boolean , is_open:Boolean) :void;
		// 设置用户保存的默认清晰度，需要在初始化视频dll后立刻调用一次，每次选择清晰度成功后也要设置
		function OnSetDefaultDefinition( res:Boolean) :void;
		// 获取当前直播支持的清晰度
		function OnGetCurrentAvailableDefinition(def:Array) :void;
		// 获取当前播放的清晰度
		function OnGetCurrentDefinition(def:int):void;
		// 选择清晰度，返回成功、失败
		function  OnChooseDefinition( res:Boolean) :void;
		function  OnGetBuyTicketAndPicURL(ticketurl:String,picurl:String):void;
		function  OnGetConcertCurLeftTime(time:int,state:int):void;
		//查询是否可以进入某房间的回调
		function OnCanEnterRoom(roomId:int, result:int,
			roomType:int, ticketRoom:Boolean, isLiving:Boolean, isSuperRoom:Boolean,
			isNestRoom:Boolean, isSpecialRoom:Boolean, skinId:int, skinLevel:int, isPK:Boolean):void;
		
		//是否需要进行新手引导教学
		function OnIsNoviceGuided(need:Boolean):void;
		
		//请求梦幻币礼物回调
		function OnQueryDreamGift(videoGift:Array, onlySkin:Boolean):void;
			
		//查询当前进入的房间是不是演唱会房间
		function OnQueryIsConcertRoom(isConcert:Boolean):void;		
			
		function OnMessageTimeOut():void;
		
		function OnGiftMsgBatch(giftMsgs:Array):void;
		
		//获取好友给自己充值的信息
		function OnGetFriendPayCashInfo(friendpays:Array):void;
		
		function OnGetPortraitUrl(Purl:String):void;
		function OnRefreshGiftEffectCnt(obj:Dictionary):void;		
		//统计演唱会房间累计观看人数
		function OnRefreshConcertTotalPlayers(num:int):void;
		
		//首登签到begin
		function OnGetFirstLoginRewardNotify(res:int,isToken:Boolean,rewards:Array,game_rewards:Array):void;//玩家领取首次登陆奖励
		/**
		 * 
		 * @param res
		 * @param rewards	奖励内容列表
		 * @param gamegifts
		 * @param isReissue	是否重发
		 * 
		 */
		function OnGetFirstLoginReward(res:int, rewards:Array, gamegifts:Array, isReissue:Boolean):void;//领取首登奖励
		function OnSignDaliyNotify(status:int,is_Daily:Boolean,is_Acc:Boolean):void;//每日签到提醒
		function OnGetSignDailyInfo(res:int,info:DailySigninRewardContentForUI,is_reissue:Boolean,reward_list:Array,game_rewards:Array):void;//获取每日签到信息
		function OnSignInDaily(res:int,rws:CDailySiginRewardForUI,is_reissue:Boolean,reward_list:Array,game_rewards:Array):void;//领取奖励
		function OnGetCumulativeReward(res:int,rws:Array,is_reissue:Boolean,reward_list:Array,game_rewards:Array):void;//领取累计奖励
		//首登签到end
		
		function OnDailyRoomActivity(activity:VideoActivityInfoToClient,activity_category:int,game_rewards:Array):void;
		function OnGetGuestInfo(res:int,id:int,encrypt_identity:String):void;
		function OnGiftIDArray(arr:Array):void;
		function RefreshConcertFreeGiftInfo(giftinfo:Array):void;
		
		function OnStarSplitScreenLive(cdnUrls:Array,isConcert:Boolean):void;//开启分屏直播
		function OnStopWatchInvitedAnchorLive():void;//停止分屏直播
		function RefreshSplitScreenInfo(status:int,anchor_id:String,anchor_name:String,is_follow:Boolean):void;//刷新分屏信息
		function OnQueryGuestCookie(hasCookie:Boolean,id:int,encrypt_identity:String):void;
		function OnQueryIsGuest(IsGuest:Boolean):void;
		
		function  OnGetConnectStatus():void;
		
		function OnGetAllTags(statur:int,tags:Array):void;
		function OnGetRandNick(nick:String,nick_pool:int,nick_record_id:int):void;
		function OnGetVideoRoomPicUrl(	urls:Array):void;
		//高级守护抢座回调
		function OnTakeRoomGuardSeat(roomId:int,seatIndex:int,res:int,seatInfoUI:VideoGuardSeatInfoUI,cost:int,player_id:String,charm:int):void;
		//座位被抢的通知
		function OnRoomGuardSeatLostNotify(roomId:int,seatIndex:int,nick:String,zone:String,cost:int,playerId:String,last_cost:int):void;
		//刷新守护宝座
		function OnRefreshRoomGuardSeats(roomId:int,seats:Array):void;
		
		//星耀榜 周兴榜变化时的走马灯消息。
		function OnVideoRankChangeBroadcastAllPlayer(anchor_name:String,timedimension:int,enScrollType:int,rank_move:int,video_rank_type:int,gift_name:String,level:int,gift_id:int,stargift_player_nick:String):void;
		//房间内刷新对当前直播的守护等级
		function OnVideoRoomRefreshGuardLevel(guard_level:int):void;
		
		//守护等级变化的走马灯
		function OnGuardLevelChangeNotify(nickName:String,zoneName:String,anchorName:String,oldGuardLevel:int,newGuardLevel:int,vipLevel:int,isSelf:Boolean):void;
		
		//发出红包
		function OnPublishRedEnvelope(red_id:String,nick:String,zone:String,total_money:int,divide_count:int,red_envelope_duration:int,small_red_envelope_duration:int):void;
		// 抢红包结果：red_id:红包id; grab_count:抢到的数量 grab_count_value换算成梦幻币的数量
		function OnGrabRedEnvelopeRes(res:int, red_id:String, grab_count:int,grab_count_value:int):void;
		//查看红包：red_id:红包id; nick/zone:发红包人的昵称; total_money:红包总额; divide_count:红包分发数量; grabbers抢红包记录
		function OnLoadRedEnvelopeRes(res:int, red_id:String, nick:String, zone:String,  total_money:int,  divide_count:int, grabbers:Array):void;
		// 红包被抢光了
		function OnRedEnvelopeGrabFinish(red_id:String ):void;
		
		//刷新主播等级榜
		function OnRefreshAnchorLevelRank(anchorRank:Array):void;
		
		//刷新我对当前主播贡献的经验值已经当日上限
		function RefreshPlayerDreamGiftAnchorExp(total_anchor_exp:int,max_anchor_exp:int):void;
		
		//主播下线时 主动开启宝箱
		function BatchVideoTreasureBoxRewardNewRoleWeb(res:int,rewards:Array,buff_percent:int,is_reissue:Boolean,last_hit_player_names:Array):void;
		
		/**
		 *周星榜返回 
		 * @param anchor_rank
		 * @param player_rank
		 * @param next_star_gifts
		 * 1
		 */		
		function LoadStarGiftRankRes(rank_ui:Array,next_star_gifts:Array,next_time:String):void;
		/**
		 * 冠军榜返回
		 * @param anchor_rank
		 * @param player_rank
		 * @param next_star_gifts
		 * 2
		 */		
		function LoadStarGiftChampionRankRes(ran_anchor:Array,rank_player:Array,none_config:Boolean):void;
		
		/**
		 * 周星冠军通知
		 * @param gift_id
		 * 
		 */		
		function StarGiftChampionNotify(gift_ids:Array,anchor_id:Int64):void;
		
		/**
		 * 主播周星数据返回
		 * @param m_anchor_id
		 * @param m_star_gifts
		 * 
		 */		
		function LoadAnchorStarGiftInfoRes(anchor_id:Int64,star_gifts:Array	,match_info:AnchorWeekStarMatchInfo,sex:int,url:String):void;
		
		/**
		 * 主播周星数据返回
		 * @param m_anchor_id
		 * @param m_star_gifts
		 * 
		 */		
		function RefreshStarGiftInfo(cur_star_gifts:Array,star_gifts:Dictionary):void;
		
		// VIP抢座
		function NotifyLostVipSeat( seat_index:int, cost:int, player_nick:String, player_zone:String):void;
		function TakeVipSeatRes( res:int, seat_index:int, balance:int, cost:int,pstid:Int64,seatinfo:VipSeatInfoForUI ,free_times:int, charm:int):void;
		function RefreshVipSeats( list:Array ):void;
		function NotifyVipTakeSeatProtectTime(seat_protect_time:Dictionary):void;
		function NotifyVipTakeSeatFull(msg:String):void;
		function OnSeatPriceResetNotice(notice:Boolean):void;
		function NotifyVipFreeSeatLeft(free_times:int):void;
		//火箭礼物
		function OnGrabDreamBox(res:int,box_id:String,money_type:int,money_count:int):void;//抢梦幻宝箱
		function OnQueryDreamBoxRec(res:int,box_id:String,tolcnt:int,player_name:String,
									total_money:int,grab_count:int,video_money_rate:int,vecs:Array):void;//查看梦幻宝箱抢夺记录
		function PublishDreamBox(box_count:int,info:DreamBoxForUI):void;//发布梦幻宝箱
		function RefreshDreamBoxCnt(box_count:int):void;//刷新梦幻宝箱数量
		function ShowRocketGiftWhistle(player_name:String,anchor_name:String,player_zone:String,wealth_level:int,guard_level:int,
									   vip_level:int,rocket_cnt:int,room_id:int,is_nest:Boolean,player_id:Int64, invisible:Boolean):void;//火箭礼物飞屏
		function NotifyDreamBoxGrabbedOut():void;//通知梦幻宝箱抢空
		function NotifyClearDreamBox():void;//通知清空梦幻宝箱
		
		function GetVideoRoomLiveInfo():void;
		function OnCheckNickOnLoginRes(status:int, nick:String):void;
		function onIgnoreFreeGiftRes(ret:int, ignore:Boolean):void;
		function OnVideoClientSigVerifyRes(res:int):void;
		function PushAllUserAdminList(m_user_admins:Array):void;//通知所有移动管理员的pstid信息
		function PushRoomBanNotice(m_room_id:int,m_banned:Boolean):void;//主播禁言所有人消息
		function HandleNotifySecretHeatBoxInfo(diff_value:Array, title:String, content:String):void;//下发宝箱开启的差值,活动标题和内容
		function handleNotifyAnchorSecretCode(secret_code:String):void;//下发主播设置（默认）的密令
		function handleNotifyPlayerSecretHeatBox(last_seconds:int, end_time:int, box_id:int):void;//通知玩家密令宝箱倒计时变化
		function handleNotifyLastHitPlayerReward(rewards:Array, gift:Array):void;//通知补刀王玩家获得的奖励
		function handleWhistleLastHitPlayer(guard_level:int, wealth_level:int, vip_level:int, zone_name:String, nick_name:String, text:String, has_portrait:int, player_pstid:Int64, invisible:Boolean):void;//广播补刀王飞屏
		function handleConcertPlaybackRoomGetRoomListRes(total_cnt:int, rooms:Array):void;//获取演唱会回放房间列表结果事件
		function handleStartConcertPlaybackRes(error_code:int, concert_id:int, video_url:String):void;//开始观看演唱会回放结果事件
		function handleRefreshWeekStarRankRes(res:int, rank:Array, contribute_player:Object, groups:Array, total_size:int, settle_time:int):void;//周星积分榜回复消息
		function handleWeekStarConfigRsp(player_url:String):void;//周星赛URL配置下发
		function handleAnchorWeekStarLevelUpNotify(grade:int, sub_level:int, grade_name:String, posing_url:String):void;//通知主播周星等级升级
		function handleAnchorWeekStarMatchSettleNotify(last_week_score:int, total_score:int, total_rank:int, group_name:String, sub_rank:int, previous_diff:int):void;//通知主播周星积分结算
		/**
		 * 通知上一次抽奖时间
		 * @param last_free_lucky_draw_time
		 * @param free_lucky_draw_interval
		 * @param activity_begin_time
		 * @param config_refresh_time
		 *
		 */
		function OnNotifyLastFreeLuckyDrawTime(last_free_lucky_draw_time:int, free_lucky_draw_interval:int, activity_begin_time:int, config_refresh_time:int):void;
		/**
		 * 打开抽奖界面返回
		 * @param res
		 * @param freeDrawTime
		 * @param configRefreshTime
		 * @param info
		 * @param notices
		 * @param queryRewards
		 *
		 */
		function OnOpenLuckyDrawWindowRes(res:int, freeDrawTime:int, configRefreshTime:int, info:Object, notices:Array, queryRewards:Array):void;
		/**
		 * 抽奖返回
		 * @param res
		 * @param freeDrawTime
		 * @param balance
		 * @param rewards
		 * @param queryRewards
		 *
		 */
		function OnLuckyDrawRes(res:int, freeDrawTime:int, balance:int, star_gifts:Array, rewards:Array, queryRewards:Array):void;
		/**
		 * 抽奖通知
		 * @param nick
		 * @param reward
		 * @param queryRewards
		 *
		 */
		function OnNoticeLuckyDraw(nick:String, reward:RewardDataForUI, queryRewards:Array):void;
		/**
		 * 抽奖信息更新
		 * @param config_refresh_time
		 * @param info
		 * @param queryRewards
		 *
		 */
		function OnUpdateLuckyDrawInfo(config_refresh_time:int, info:Object, queryRewards:Array):void;

		/**
		 * 获取打卡界面信息
		 * @param info
		 * @param queryRewards
		 *
		 */
		function OnGetPunchInInfo(info:Object, queryRewards:Array):void;
		/**
		 * 打卡返回的信息
		 * @param info
		 * @param queryRewards
		 *
		 */
		function OnPunchIn(info:Object, queryRewards:Array):void;
		/**
		 *
		 * @param nick
		 * @param zone
		 * @param charm
		 * @return
		 *
		 */
		function OnNotifyPunchIn(nick:String, zone:String, charm:int):void;

		/**
		 * 魅力榜
		 * @param res
		 * @param ranks
		 * @param timedimension
		 * @param totalSize
		 *
		 */
		function OnLoadRoomCharmRank(res:int, ranks:Array, timedimension:int, totalSize:int):void;
		/**
		 * 解锁房间皮肤任务信息
		 * @param room_id
		 * @param skin_id
		 * @param task_list
		 *
		 */
		function OnNotifyUnlockRoomSkinTaskInfo(room_id:int, skin_id:int, task_list:Array):void;
		/**
		 * 下发解锁皮肤成功走马灯消息
		 * @param broadInfo
		 *
		 */
		function OnNewRoomSkinBroadcastAllPlayer(broadInfo:Object):void;
		/**
		 * 皮肤升级任务信息
		 * @param taskInfo
		 *
		 */
		function OnNotifyRoomSkinLevelUpTaskInfo(taskInfo:Object):void;
		/**
		 * 房间每日任务信息
		 * @param taskInfo
		 *
		 */
		function OnNotifyRoomSkinDailyTaskInfo(taskInfo:Object):void;
		/**
		 * 房间皮肤升级通知
		 * @param taskInfo
		 *
		 */
		function OnNotifyRoomSkinLevelUp(info:Object):void;
		/**
		 * 房间皮肤满级后，每日任务达成下发奖励消息
		 * @param room_id
		 * @param rewards
		 * @param queryRewards
		 *
		 */
		function OnNotifyRoomDailyTaskRewards(room_id:int, rewards:Array, queryRewards:Array):void;
		/**
		 * 魅力榜变成第一走马灯消息
		 * @param broadInfo
		 *
		 */
		function OnNotifyRoomCharmBroadcastAllRoom(broadInfo:Object):void;
		/**
		 * 皮肤礼物信息
		 * @param res
		 * @param skin_gifts
		 * @return
		 *
		 */
		function OnQuerySkinGift(res:int, skin_gifts:Array):void;
		/**
		 * 获取系统时间
		 *
		 */
		function onGetSystemTime():void;
		/**
		 * 广告通知
		 * @param adInfo
		 *
		 */
		function OnNotifyVideoAD(adInfo:Object):void;
		/**
		 * 开通vip飞屏
		 * @param player_name
		 * @param weath_level
		 * @param vip_level
		 * @param anchor_name
		 *
		 */
		function NoticeBuyVip(player_name:String, weath_level:int, vip_level:int, anchor_name:String):void;
		/**
		 * 通知页面服务器连接消息
		 * @param res
		 *
		 */
		function NoticeConnectMsg(res:int):void;
	}	
}