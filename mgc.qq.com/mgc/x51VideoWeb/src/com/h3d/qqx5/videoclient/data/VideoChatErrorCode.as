package com.h3d.qqx5.videoclient.data
{
	public class VideoChatErrorCode
	{	
		public static var VIDEO_CHAT_SUCCESS:int = 0;
		public static var VIDEO_CHAT_PUBLIC_FORBIDDEN:int = 1;    // 禁止公众频道聊天
		public static var VIDEO_CHAT_CHAT_CD:int = 2;             // 聊天cd中
		public static var VIDEO_CHAT_NOT_FIND_TARGET:int = 3;     // 私聊找不到目标玩家
		public static var VIDEO_CHAT_WHISTLE_NEED_LIVING:int = 4; // 直播中才可以发飞屏
		public static var VIDEO_CHAT_ROOM_LIMIT_SILENT_DROP:int = 5;	//单房间阈值达到，悄悄地丢弃
		public static var VIDEO_CHAT_WHISTLE_NO_BAN:int = 6;		// 禁言状态不能使用飞屏
		public static var VIDEO_CHAT_NO_FREE_WHISTLE:int = 7;     // 免费飞屏已经用尽
		public static var VIDEO_CHAT_NOT_IN_MATCH:int = 8;        // 不在比赛中，不能发送免费飞屏，主播端使用
		public static var VIDEO_CHAT_FAIL:int = 9;
		public static var VIDEO_CHAT_BAN:int = 10;                 // 被禁言
		public static var VIDEO_CHAT_PerpetualBan:int = 11;        // 永久禁言
		public static var VIDEO_CHAT_NOXUANBEI:int = 12;//炫逗不足
		public static var VIDEO_CHAT_PUBLIC_COOL_DOWN:int = 13;    //公屏聊天CD时间未到
		public static var VIDEO_CHAT_SUPERSTARHORN_NO_BAN:int = 14;		// 禁言状态不能使用超新星喇叭
		public static var VIDEO_CHAT_BAN_BY_MSG_FILTER:int = 15;	//被腾讯的消息过滤系统禁止
		public static var VIDEO_CHAT_BAN_ALL_ROOM:int = 16;        // 被全房间禁言
		public static var VIDEO_CHAT_WHISTLE_SWITCH_BAN_WHISTLE:int = 17;//飞屏开关禁止飞屏
		public static var VIDEO_WHISTLE_FAIL:int = 18; //服务器导致飞屏发送失败
		
		
		public static function  ChatResult2VideoChatErrCode(chat_res : int):int
		{
			var res : int  = VIDEO_CHAT_SUCCESS;
			switch(chat_res)
			{
				case ChatResult.CR_Succ:
					break;
				case ChatResult.CR_Video_ForbidPublicChat:
					res = VIDEO_CHAT_PUBLIC_FORBIDDEN;
					break;
				case ChatResult.CR_Video_Chat_TooFrequent:
					res = VIDEO_CHAT_CHAT_CD;
					break;
				case ChatResult.CR_OutOfVideoRoom:
					res = VIDEO_CHAT_NOT_FIND_TARGET;
					break;
				case ChatResult.CR_Video_Whistle_NotLiving:
					res = VIDEO_CHAT_WHISTLE_NEED_LIVING;
					break;
				case ChatResult.CR_Video_Whistle_BanChat:
					res = VIDEO_CHAT_WHISTLE_NO_BAN;
					break;
				case ChatResult.CR_Video_Superstarhorn_BanChat:
					res = VIDEO_CHAT_SUPERSTARHORN_NO_BAN;
					break;
				case ChatResult.CR_Video_NoFreeWhistle:
					res = VIDEO_CHAT_NO_FREE_WHISTLE;
					break;
				case ChatResult.CR_Video_Not_In_Match:
					res = VIDEO_CHAT_NOT_IN_MATCH;
					break;
				case ChatResult.CR_Video_Whistle_NoXuanBei:
					res = VIDEO_CHAT_NOXUANBEI;;
					break;
				case ChatResult.CR_Fail:
					res = VIDEO_CHAT_FAIL;
					break;
				case ChatResult.CR_BeBanChat:
					res = VIDEO_CHAT_BAN;
					break;
				case ChatResult.CR_Video_PerpetualBanChat:
					res = VIDEO_CHAT_PerpetualBan;
					break;
				case ChatResult.CR_PublicChnlCooldDown:
					res = VIDEO_CHAT_PUBLIC_COOL_DOWN;
					break;
				case ChatResult.CR_BeBanChatByMsgFilter:
					res = VIDEO_CHAT_BAN_BY_MSG_FILTER;
					break;
				case ChatResult.CR_BeBanChatAllRoom:
					res = VIDEO_CHAT_BAN_ALL_ROOM;
					break;
				case ChatResult.CR_WhistleSwitchBanWhistle:
					res = VIDEO_CHAT_WHISTLE_SWITCH_BAN_WHISTLE;
					break;
				case ChatResult.CR_Whistle_Fail:
					res = VIDEO_WHISTLE_FAIL;
					break;
				default:
					break;
			}
			return res;
		}
	}
}