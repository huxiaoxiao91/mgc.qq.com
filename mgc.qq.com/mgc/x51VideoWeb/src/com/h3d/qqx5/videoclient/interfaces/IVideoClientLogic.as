package com.h3d.qqx5.videoclient.interfaces
{
	/**
	 * @author liuchui
	 */
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.CeremonyRefreshInfoForUI;
	import com.h3d.qqx5.videoclient.data.CeremonyStartInfoForUI;
	import com.h3d.qqx5.videoclient.data.EnterOption;
	import com.h3d.qqx5.videoclient.data.VideoGuardPrivilegeData;
	import com.h3d.qqx5.videoclient.xmlconfig.IImpressionConfig;
	
	import flash.utils.ByteArray;

	public interface IVideoClientLogic
	{
		function SetLogicCallBack(cb:IVideoClientLogicCallback):void;
//		// 获得当前房间类型列表，同步，type表示房间类型，值为枚举VideoRoomType
//		function LoadRoomCategoryList( type:int) :Array;   
//		//获取视频礼物配置
//		virtual IVideoGiftConfig* GetVideoGiftConfig() const = 0;
//		//获取后援团交互相关配置
//		virtual IVideoGuildInteractConfig* GetVideoGuildInteractConfig() const = 0;
//		//获得视频礼物配置
//		virtual const VideoGiftData* GetVideoGiftData(int giftID) const = 0;
		// 举报主播
		function ReportAnchor( type:int, content:String, pic:ByteArray, anchor:Int64, anchor_name:String):Boolean;
//		//获取房间logo的url，UI传入正确的VideoRoomData对象，逻辑端填充其中的roomLogoUrl字段
//		virtual void FillVideoRoomLogoUrl(VideoRoomData& room_data) = 0;
//		// 获得当前房间信息
//		virtual void GetRoomDataForUI(VideoRoomData& data) const = 0;
		// 获得当前房间主播信息
		//function GetCurrentAnchorDataForUI(data:ClientAnchorData):void;
//		// 获取视频快照
//		virtual void GetVideoSnapshot(char*& pBuffer, int& iLength) = 0;
//		// 释放视频快照
//		virtual void ReleaseSnapshot() = 0;
		//获取视频房间列表面板上的广告url
		function GetVideoAdUrl():String;
//		// 副麦相关接口，删除副麦 主播端，x5客户端都实现
//		virtual bool DelDeputyAnchor() = 0;
//		// 获得飞屏哨子价格
//		public function GetWhistlePropPrice():void;
//		virtual int GetSuperStarPrice() = 0;
		// 房间是否有发起投票
		function IsStartVote():Boolean;
		// 自己是否投过票
		function HasVoted() :Boolean;
		// 得到玩家的守护等级
		//virtual int GetPlayerGuardLevel() = 0;
		// 获得守护配置
		//virtual IFansGuardConfig* GetGuardConfig()=0;
		//获得印象配置
		function GetImpressionConfig():IImpressionConfig;
		// 获得某等级守护的权限
		function GetGuardConfigData(guard_level:int):VideoGuardPrivilegeData;
		// 获取超级粉丝
		function LoadSuperFans(fanstype:int,anchorID:Int64):Boolean;
		//////////////////////////////////////////////////////////////////////////
//		/* 下列操作为异步方式，需要向sdk server发起请求，callback中区分正常、超时、网络错误等情况*/
		//////////////////////////////////////////////////////////////////////////
		
		
		
		
		
		
		// 获得房间列表，异步，type表示房间类型，值为枚举VideoRoomType islivingnest 是否获取直播
		function LoadRoomList(type:int , category:int , beginIndex:int , requestNum:int, module_type:int, tag:int=0,position:int=0,source:int=0):void;
		// 进入房间，异步?????
		function EnterRoom(roomID:int,data:ByteArray,options:EnterOption,source:int, tag:int, module_type:int, page_capacity:int, room_list_pos:int):Boolean;
		// 退出房间，异步
		function LeaveRoom():Boolean;
		// 获得主播名片信息，异步
		function  GetAnchorCardInfo(anchorID:Int64):Boolean;
		// 获取房间内玩家列表, param: pageIndex页序号，异步
		function LoadPlayerList(pageIndex:int):Boolean;
		// 获取宝箱数据，异步
		function GetTreasureBoxData(roomID:int ):Boolean;
		// 房间内亲密度排行榜，异步
		function LoadVideoRoomAffinityRank(timedimension:int = 0):Boolean;
		// 主播星耀值排行榜，异步
		function LoadVideoRoomAnchorStarlightRank(timedimension:int = 0):Boolean;
		// 主播人气值排行榜，异步
		function LoadVideoRoomAnchorPopularityRank():Boolean;
		// 玩家贡献榜，异步
		function LoadActivityPlayerRank():Boolean;
		// 送礼，异步
		function SendGift(gift_id:int,gift_cnt:int,anchor_id:Int64,star_gift:Boolean):Boolean;
		// 搜索在线列表，异步
		function SearchOnlinePlayer( key_words:String):void;
		// 投票，参数为玩家选择的选项索引列表，索引从0开始，异步
		function TakeVote(select:Array) :void;
		// 请求投票信息，异步
		function GetVoteStartInfo():void;
		// 获得推荐房间列表,prob概率[0-100],recommend_count推荐房间最大数量，异步
		function  LoadRecommendVideoRoom(type:int ,prob: int ,recommend_count:int ):void;
		// 发送聊天信息ChatChannel
		function  SendChatMsg( msg:String, channelID:int, recver_id:Int64, recver_name:String, recver_zoneName:String) :Boolean;
		//梦工厂VIP贵族 begin
		//获取VIP价格信息
		function GetVipPrice():Boolean;
		//获取免费飞屏数量
		function  GetFreeWhistleCount():int;
		//获取免费超新星数量
		function GetFreeSuperStarHornLeft():int;
		function SetVipFreeWhistleLeft( left:int  ):void;
		
		function SetVipFreeSuperStarHornLeft(left:int ):void;
		//开通VIP
		function StartVip(vip_level:int, duration:int, cost_type:int, anchor_id:Int64):Boolean;
		//续费VIP
		function RenewalVip(vip_level:int, duration:int, cost_type:int, anchor_id:Int64):Boolean;
		//获取梦工厂名片信息
		function GetPlayerVideoCardInfoById(player_id:Int64, source:int ):Boolean;
		//上传梦工厂名片头像
		function UploadVideoCardPortait(content:ByteArray):Boolean;
		//修改梦工厂名片个性签名
		function ModifyVideoCardSignature(sig:String):Boolean;
		//领取VIP每日福利
		function TakeVipDailyReward():Boolean;
		//在自己的梦工厂名片上取消主播关注
		function CancelFollowAnchorFromVideoCard(anchor_id:String):Boolean;
		//守护禁言或者解除禁言沿用ForbidTalk接口
		//查询VIP等级
		function GetVideoVipLevel():int;
		//查询VIP剩余日期
		function GetVideoVipExpire():int;
		//今天是否领取过VIP福利
		function HaveTakenVipDailyRewardToday():Boolean;
		function ForbidTalk(ban:Boolean, perpetual:Boolean, pstid:Int64):Boolean;
		function IsChatBanned(zone_name:String, player_name:String ):Boolean;
		function IsPerpetualChatBan(zone_name:String, player_name:String ):Boolean;
		//梦工厂VIP贵族 end
		function GetLivingNetworkStatus():int;
		//全民选秀 begin
		//设置或取消评委，judge_type为TSJT_Invalid表示取消
		function SetTalentShowJudge(player_name:String,zone_name:String, judge_type:int):void;
		//加载星主播积分排行榜
		function LoadStarAnchorScoreRank():void;
		//查询是否具有评委身份，同步接口
		function GetPlayerJudgeType(player_name:String, zone_name:String):int;
		//打分
		function ScoreTalentShow(scores:Array):void;
		//加载当前分数
		function LoadTalentShowScore():void;
		//开始比赛
		function StartTalentShow() :void;
		//停止比赛
		function StopTalentShow():void;
		//获取房间的活动比赛状态
		function GetTalentShowStatus(activity_type:int):int;
		//当前是否在全民选秀活动期间（和玩家所处房间无关）
		function InTalentShowActivity( activity_type:int):Boolean;
		//加载舞团联盟争霸排行榜
		function LoadGuildChampionRank():void;
		//点赞
		function DianZan():void;
		//获取舞团争霸介绍url
		function GetGuildChampionIntroUrl():String;
		//全民选秀 end
		// (video guild)加载主播积分榜
		function LoadAnchorScoreRank(timedimension:int):Boolean;
		// (video guild)加载后援团排行榜
		function LoadVideoGuildRank():Boolean;
		function GetVideoGuildClient():IVideoGuildClient;
		function GenerateAnchorPortraitUrl(anchor_id:Int64):String;
		function LoadAttachedPlayerInfoCard(anchor_id:Int64):void;
		function GetAnchorPKClient():IAnchorPKClient;
		// 获取VIP贵宾席
		function LoadVipSeats(anchorID:Int64):Boolean;// { return false; }
		//加载优胜主播榜
		function LoadAnchorPKWinnerRank():Boolean;
		//加载英豪榜
		function LoadAnchorPKRichManRank():Boolean;
		//获取梦工厂门票购买url		
		function GetVideoRoomTicketUrl():String;
		//获取梦工厂门票特效
		function GetVideoRoomTicketEffect():String;
		// 玩家用：选择或更换支持的主播
		function ChooseSupportAnchor(anchor:Int64):void;
		// 获得活动信息（包括各个主播的信息、玩家自己支持的主播和玩家自己对各个主播的支持度，其他数据不要使用，可能为脏数据）
		function GetCeremonyStartInfo():CeremonyStartInfoForUI;
		// 获得活动信息（包括各个主播的支持度和粉丝排行）
		function GetCeremonyInfo():CeremonyRefreshInfoForUI;
		// 获得活动状态（枚举VideoCeremonyState）
		function GetCeremonyState():int;
		// 获得支持的主播是否在线
		function IsAnchorOnline(anchor_id:Int64):Boolean;
		//主播任务
		function TakeAnchorTask():void; //领取
		//function QueryClientAnchorTask():void; //查询
		function DropAnchorTask():void; //放弃
		// 玩家vip榜，异步
		function LoadVideoVIPRank(begin_index:int , end_index:int ):Boolean;//{ return true; }
		//获取热度加成信息，VIP等级和人数，加成点数
		function GetGiftPoolAdditionInfo():void;//std::map<int,int>& vip_player_num, int& buff_num
		// 抢红包
		function GrabRedEnvelope(red_id:String):void;
		// 查看红包
		function LoadRedEnvelopeInfo(red_id:Int64):void;
		// 记录屏蔽列表
		function AddChatIngoreList(player_id:Int64):void;
		function RemoveChatIngoreList(player_id:Int64):void;
		// 永久全房间禁言
		function ForbidTalkForAllRoom(playerId:Int64, ban:Boolean):Boolean;
		function GetAnchorNestClient():IAnchorNestClient;
		function LoadNestAssistantList():void;
		function LoadAnchorImpressionForAnchor(anchor_id:Int64):void;
		function LoadAnchorImpressionForPlayer(anchor_id:Int64):void;
		function EditAnchorImpression(anchor_id:Int64,data:Array):void; //const std::vector<AnchorImpressionEditForUI>& data
		//主播双周星耀值排行榜，异步
		function LoadVideoRoomAnchorTwoweekStarlightRank():Boolean;		
		//查询某个小窝任务奖励
		function QueryNestTaskReward(index:int):void;
		//加载小窝列表
		function LoadNestList():void;
		// 加载某个房间信息
		function LoadRoomInfo(roomID:int ):void;
		function AssistantSetFunction(player_id:Int64, forbid_public_chat:Boolean, open_chat_cd:Boolean, chat_cd_time:int, cooldown_cd:int, room_id:int):void;
		function GetPublicChatCoolDownTimeOnEnter():int;
		function GetChatParameter(forbidden_public_chat:Boolean, open_chat_cd:Boolean,chat_cd_time:int):void;
		function KickPlayer(playerName:String,playerZoneName:String):Boolean;
		function CreateRole(nick:String,gender:int,nick_pool:int,nick_record_id:int,is_auto_create:Boolean):void;
		function ConnectVideoVersion(qq:uint,verify:String,m_appid:uint,m_skey:String):void;
		function NotifyConnected(res:int):void;
		//add for web
		function GetPrivateInfoList():void;
		function LoadMemberOperationInfo(member_id:Int64, name:String, zoneName:String):Boolean;
		function QueryBalance(save_num:int): Boolean;
		function EncryptPortraitUrl(url:String ,cnt:int): Boolean;
		function CheckNick(nick:String):void;
		function QueryVideoMoney(): Boolean;
		//预览宝箱
		function LoadPreviewTreasureBoxDataNewRole(box_id:int,activity_id:int = 0):void;
		//查询主播任务
		function QueryClientAnchorTaskNewRole():void;
		//屏蔽
		function isInIgnoreList( strNickName:String, strZoneName:String):Boolean;
		function IgnorePlayer( player_id:Int64,strNickName:String, strZoneName:String, bAdd:Boolean):void;
		//LoadPlayerInfoForHomePage
		function LoadPlayerInfoForHomePage():void;
		
		// 玩家财富排行榜
		function LoadVideoRichRank(begin_index:int, end_index:int,timedimension:int = 0):void;
		// 加载视频等级排行榜，异步
		function LoadVideoLevelRank(begin_index:int, end_index:int):void;
		// 获取活动中心信息
		function GetActivityCenterInfos():void;
		// 领取活动中心奖励
		function TakeVideoActivityRewards(activity_id:int, activity_category:int):void;
		// 领取每日工资
		function TakeDailyWage():void;
		//频闭私聊，除了主播和管理员以外
		function ForbidPrivateChat(forbid:int):void;
		
		
		////////////////////////////演唱会相关
		// 点抽奖按钮的接口
		function QueryRaffle() :void;
		// 点红包抽奖
		function DoRaffle() :void;
		
		// 设置用户保存的默认清晰度，需要在初始化视频dll后立刻调用一次，每次选择清晰度成功后也要设置
		function SetDefaultDefinition( definition:int) :void;
		function  GetRoomStatus( ):void;
		// 获取当前直播支持的清晰度
		function GetCurrentAvailableDefinition() :Array;
		// 获取当前播放的清晰度
		function GetCurrentDefinition():int;
		// 选择清晰度，返回成功、失败
		function  ChooseDefinition( definition:int) :Boolean;
		function  GetConcertCurLeftTime():void;
		function GetBuyTicketAndPicURL():void;

		//查询是否可以进入某房间
		function CanEnterRoom(roomid:int):void;

		function Logout(reason:String = ""):void;

		//设置已经进行过新手引导了
		function SetNoviceGuided():void;

		//请求梦幻币礼物数量
		function QueryDreamGift():void

		//查询活动中心完成数量
		function GetActivityCompleteCount():void;
		
		//查询当前进入房间是不是演唱会房间
		function QueryIsConcertRoom():Boolean;
		
		//获取好友给自己充值的信息
		function GetFriendPayCashInfo():void;
		
		//获取个人头像数据
		function GetPortraitUrl():void;
		function GetGiftEffectCnt():void;
		//首登签到begin
		function GetFirstLoginRewardNotify(real_login:Boolean):void;//玩家领取首次登陆奖励
		function GetFirstLoginReward():void;//领取首登奖励
		function GetSignDailyInfo():void;//获取每日签到信息
		function SignInDaily():void;//领取奖励
		function SignDaliyNotify():void;//请求签到提醒
		function GetCumulativeReward(accday:int):void;//领取累计奖励
		//首登签到end
		
		function GetGuestInfo():void;
		function QueryGuestCookie():void;
		function QueryIsGuest():void;		
		
		//屏蔽免费礼物(免费花花和梦幻币礼物)
		function ForbiFreeGift(forbid:Boolean):void;
		
		function GetAllTags(is_home:Boolean):void;
		function GetRandNick(last_nick_pool:int,gender:int):void;
		function GetVideoRoomPicUrl():void;
		//新增高级守护  座位id，所有者id号，耗费炫逗数量
		function TakeRoomGuardSeat(seatIndex:int,owner:Int64,cost:int):void;//抢座
		
		
		//加载主播等级榜
		function RefreshAnchorLevelRank():void;
		
		//请求周星榜请求
		function VideoStarGiftRankWeb():Boolean;
		//请求冠军榜请求
		function VideoStarGiftChampionRankWeb():Boolean;
		//请求主播周星数据
		function LoadAnchorStarGiftInfo(m_anchor_id:Int64):void;
		
		//
		function TakeVipSeat(cost:int, seat_index:int  ):void;
		function GetSeatPriceResetNotice():void;
		
		function GetStarGiftInfo():void;
		//抢梦幻宝箱
		function GrabDreamBox(box_id:Int64):void;
		//查抢梦幻宝箱记录
		function QueryDreamBoxRec(box_id:Int64,index:int):void;
		
		//获取vid
		function GetVideoRoomLiveInfo(roomID:int):void;
		
		function RequestGetVideoRoomLiveInfo():void;
		
		function GetCheckNickOnLogin():void;

		/**
		 * 设置是否忽略免费礼物
		 * @param ignore
		 *
		 */
		function RequestIgnoreFreeGift(ignore:Boolean):void;
		
		function VideoClientSigVerify(appid:int,key:String):void;
		
		function handleFinishEducation(flag:int):void;//通知教学完成
		function sendPlayerDrawSecretHeatBoxReward(is_forbid_talk:Boolean):void;//玩家点击密令按钮领取奖励
		function concertPlaybackRoomGetRoomList(from:int, req_count:int):void;  // 获取演唱会回放房间列表事件
		function startConcertPlayback(concert_id:int):void;  // 开始观看演唱会回放事件
		function getWeekStarNotifySucc(flag:int):void; // 周星赛结算和获奖提示确认
		function WeekStarConfigReq():void;//周星赛URL配置请求
		function GetWeekStarRankList(sub_rank_name:String, begin_index:int, end_index:int):void;//周星赛URL配置请求
	}	
}