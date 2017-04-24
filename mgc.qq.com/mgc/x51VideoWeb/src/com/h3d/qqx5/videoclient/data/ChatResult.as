package com.h3d.qqx5.videoclient.data
{
	public class ChatResult
	{
		public static const CR_Succ:int = 0;
		public static const CR_Fail:int = 1;
		public static const CR_OutoffLine:int = 2;//对方已不在线
		public static const CR_InBlackList:int = 3;//在对方黑名单内
		public static const CR_InChooseChannelState:int = 4;//对方处于选择频道状态
		public static const CR_GuildForbidSpeak:int = 5;//舞团禁言
		public static const CR_BeBanChat:int = 6;//被GM禁言
		public static const CR_BeGMExclusiveChat:int = 7;//GM独占房间聊天频道
		public static const CR_GMForbidPlayerChat:int = 8;//GM禁止对局玩家发言
		public static const CR_GMForbidObserverChat:int = 9;//GM禁止观战玩家发言
		public static const CR_NoElection:int = 10;//非竞选活动期间无法使用竞选频道发言
		public static const CR_WrongCandidateSeqID:int = 11;//错误选手编号
		public static const CR_BeBanChatByMayor:int = 12;//被镇长们禁言
		public static const CR_BeBanChatByMsgFilter:int = 13;//被消息过滤系统禁言
		public static const CR_OutOfVideoRoom:int = 14;//对方已不在该视频房间内
		public static const CR_Video_ForbidPublicChat:int = 15;//视频房间禁止公屏聊天
		public static const CR_Video_Chat_TooFrequent:int = 16;//视屏房间公屏聊天过于频繁
		public static const CR_Video_Whistle_NotLiving:int = 17;//没有直播不可以发飞屏
		public static const CR_Video_PerpetualBanChat:int = 18;//视频房间内被永久禁言
		public static const CR_Video_Whistle_BanChat:int = 19;//禁言状态不能使用飞屏
		public static const CR_Video_Superstarhorn_BanChat:int = 20;//禁言状态不能使用超新星喇叭
		public static const CR_GuildManufactory:int = 21;//
		public static const CR_Video_NoFreeWhistle:int = 22;//免费飞屏数量已经用尽
		public static const CR_Video_Not_In_Match:int = 23;//不在比赛中，不能发送免费飞屏（主播端）
		public static const CR_Video_SuperStarHorn_NotLiving:int = 24;//没有直播时不可以发超新星喇叭
		public static const CR_Video_Whistle_NoXuanBei:int = 25;//扣炫贝失败
		public static const CR_NotGuildMember:int = 26;//非舞团成员
		public static const CR_PublicChnlCooldDown:int = 27;//公屏 CD 时间未到
		public static const CR_MobileFlashOff:int = 28;//手机闪断
		public static const CR_StrangerOverServer:int = 29;//陌生人不允许跨服聊天
		public static const CR_BeBanChatAllRoom:int = 30;//被全房间禁言
		public static const CR_WhistleSwitchBanWhistle:int = 31; //操作失败，飞屏开关禁止飞屏 
		public static const CR_NestBanGuardPrivateChat:int = 32; //小窝私聊不能发守护表情
		public static const CR_Whistle_Fail:int = 36;//服务器导致飞屏发送失败
	}
}
