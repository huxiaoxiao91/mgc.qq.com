package com.h3d.qqx5.videoclient.data
{
	public class VideoGuildResultCode
	{
		public static var VGRC_Success:int		           = 0;	//成功
		public static var VGRC_Failed:int                  = 1; //失败
		public static var VGRC_NoRight:int		           = 2;	//没权限
		public static var VGRC_ServerBusy:int		       = 3;	//服务器繁忙
		public static var VGRC_Internal:int		           = 4;	//系统内部错误
		public static var VGRC_NotInVideoRoom:int	       = 5;	//不在视频房间中
		public static var VGRC_CantFindRoom:int	           = 6;	//找不到视频房间
		public static var VGRC_HasSignInToday:int		   = 7;	// 今天已经签到
		public static var VGRC_NoAnchor:int				   = 8;	// 没有支持的主播
		public static var VGRC_TicketDailyLimit:int		   = 9;	// 超出今日献月票上限
		public static var VGRC_NotEnoughWealth:int		   = 10;// 资产不足
		public static var VGRC_NotEnoughScore:int		   = 11;// 积分不足
		public static var VGRC_NotFollowedAnchor:int       = 12;// 不是关注主播（创建后援团，或者更改支持主播时）
		public static var VGRC_NotEnoughCoins:int          = 13;// 炫贝不足
		public static var VGRC_AlreadyGuildMember:int      = 14;// 已经是后援团成员了（创建后援团，被邀请入团，批准入团申请）
		public static var VGRC_GuildNameDup:int            = 15;// 后援团名字重复了（创建后援团，修改后援团名字）
		public static var VGRC_SaveGuildInfoFailed:int     = 16;// 保存后援团信息失败
		public static var VGRC_IllegalWords:int            = 17;// 敏感词过滤(后援团名称)
		public static var VGRC_IllegalWordsIntroduction:int	= 18;// 敏感字过滤（后援团简介）
		public static var VGRC_FullOfPeople:int			   = 19;//后援团人数已满
		public static var VGRC_NotAllowApply:int		   = 20;//拒绝入团申请
		public static var VGRC_RepeatSent:int			   = 21;//入团申请重复发送
		public static var VGRC_CannotHandle:int			   = 22;//无法处理(若对方当前有后援团的邀请消息尚未处理，或者已离开梦工厂，那么无法接受邀请)
		public static var VGRC_NoTheVideoGuildId:int	   = 23;//不存在该后援团ID
		public static var VGRC_HadBeenNewest:int		   = 24;//日志已是最新，不需要更新
		public static var VGRC_NotInVideoGuild:int		   = 25;//不属于后援团（却尝试做只有后援团成员才能做的事）
		public static var VGRC_NullVideoGuild:int		   = 26;//(根据后援团id)找不到后援团
		public static var VGRC_VideoGuildServerIniting:int = 27;//video_guild_server正在初始化
		public static var VGRC_TooManyJoinApplys:int       = 28; //申请后援团的记录达到最大值
		public static var VGRC_InvitationOutdated:int      = 29;//邀请超时
		public static var VGRC_FansBoardTypeError:int      = 30;//粉丝牌类别错误
		public static var VGRC_FansBoardPriceError:int     = 31;//粉丝牌价格错误
		public static var VGRC_NoJoinApplyRecord:int       = 32;//没有入团申请记录
		public static var VGRC_PositionNameDirty:int	   = 33;//官职名有敏感词
		public static var VGRC_PositionNameLenError:int	   = 34;//官职名长度错误
		public static var VGRC_UnhanledInviting:int        = 35;//当前该玩家有邀请尚未处理
		public static var VGRC_TargetNotInVideoGuild:int   = 36;//修改官职、传位等操作时，对方不在后援团中
		public static var VGRC_LessThan7Day:int			   = 37;
		public static var VGRC_PositionNameDup:int		   = 38;//官职名重复
		public static var VGRC_SameAnchor:int              = 39;//更换主播时候，更换的主播和现在的主播相同
		public static var VGRC_AudioAnchorNoPermission:int = 40;//音频主播没有权限
		public static var VGRC_DeductMoneyFailed:int	   = 41;//扣炫贝失败
		public static var VGRC_CustomFansBoardBaned:int	   = 42;//自定义粉丝牌已被封禁
	}
}