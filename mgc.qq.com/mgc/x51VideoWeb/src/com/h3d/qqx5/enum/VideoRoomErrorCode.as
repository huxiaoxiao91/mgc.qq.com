package com.h3d.qqx5.enum {

	/**
	 * @author liuchui
	 */
	public class VideoRoomErrorCode {
		public static const VIDEO_ROOM_SUCCESS:int                                 = 0;
		public static const VIDEO_ROOM_FAIL_UNKNOWN:int                            = 1;
		public static const VIDEO_ROOM_FAIL:int                                    = 2;
		public static const VIDEO_ROOM_SERVER_BUSY:int                             = 3;
		public static const VIDEO_ROOM_FAIL_ACCOUNT_NOT_EXIST:int                  = 4;
		public static const VIDEO_ROOM_FAIL_LOST_DATA:int                          = 5;
		public static const VIDEO_ROOM_FAIL_DUPLICATED:int                         = 6;
		public static const VIDEO_ROOM_FAIL_NOT_ANCHOR:int                         = 7;
		public static const VIDEO_ROOM_FAIL_IS_LIVING:int                          = 8;
		public static const VIDEO_ROOM_FAIL_AUDIENCE_FULL:int                      = 9; //< 观众数量已满（普通玩家提示这个，文字提示是忽悠他开通特权）

		public static const VIDEO_ROOM_FAIL_NOT_ANCHOR_ADMIN:int                   = 10; //< 不是主播也不是管理员
		public static const VIDEO_ROOM_FAIL_NO_PERMISSION:int                      = 11; //< 没有权限
		public static const VIDEO_ROOM_FAIL_NO_SUCH_ROOM:int                       = 12; //< 没有该房间
		public static const VIDEO_ROOM_FAIL_SELF_NOT_IN_ROOM:int                   = 13; //< 自己不在房间中
		public static const VIDEO_ROOM_FAIL_TARGET_NOT_IN_ROOM:int                 = 14; //< 目标不在房间中
		public static const VIDEO_ROOM_FAIL_NOT_LIVING:int                         = 15; //< 房间没有直播
		public static const VIDEO_ROOM_FAIL_ALREADY_IN_ROOM:int                    = 16; //< 已经在房间中
		public static const VIDEO_ROOM_FAIL_ENTER_BE_KICKED:int                    = 17; //< 被踢出房间后一段时间不能进入该房间
		public static const VIDEO_ROOM_FAIL_START_BE_STOPED:int                    = 18; //< 被进制直播后一段时间不能直播
		public static const VIDEO_ROOM_FAIL_BAN_CHAT_ALREADT:int                   = 19; //< 玩家已经被禁言了

		public static const VIDEO_ROOM_FAIL_LOGIN_ROOM_SERVER_FAIL:int             = 20; //< 进入目标RoomServer失败
		public static const VIDEO_ROOM_FAIL_CREATE_ROOM_FAIL:int                   = 21; //< 创建房间失败
		public static const VIDEO_ROOM_FAIL_VIDEO_ZONE_NET_ERROR:int               = 22; //< 视频区网络错误
		public static const VIDEO_ROOM_FAIL_ALREADY_ADMIN:int                      = 23; //< 已经是管理员了
		public static const VIDEO_ROOM_FAIL_CANNOT_ENTER_ANCHORTESTROOM:int        = 24; //< 不能进入主播测试房间
		public static const VIDEO_ROOM_FAIL_VIDEO_ANCHOR_FULL:int                  = 25; //主播数量已满
		public static const VIDEO_ROOM_FAIL_ADMINISTRATOR_FULL:int                 = 26; //管理员数量已满
		public static const VIDEO_ROOM_FAIL_CHAT_NOT_BAN_ALREADY:int               = 27; //< 玩家没被禁言了
		public static const VIDEO_ROOM_FAIL_ROOM_BANNED:int                        = 28; //< 房间被封禁，无法进入
		public static const VIDEO_ROOM_FAIL_ANCHORBUTNOTLIVING:int                 = 29; //< 是主播，但是没在直播中

		public static const VIDEO_ROOM_FAIL_TARGET_NOT_AUDIENCE:int                = 30; //< 操作目标不是观众
		public static const VIDEO_ROOM_FAIL_TARGET_IS_SELF:int                     = 31; //< 操作目标是自己
		public static const VIDEO_ROOM_FAIL_JACKET_LIMIT:int                       = 32; //< 马甲数量到上限了
		public static const VIDEO_ROOM_FAIL_HAVE_SAME_JACKET:int                   = 33; //< 已经有同样类型的马甲了
		public static const VIDEO_ROOM_FAIL_NO_JACKET:int                          = 34; //< 没有马甲
		public static const VIDEO_ROOM_EVENT_LIMIT:int                             = 35;
		public static const VIDEO_ROOM_FAIL_AUDIENCE_FULL_FOR_SUPERGUARD:int       = 36; //< 对各种特权来说，房间人也满了(这个枚举对应的是普通提示)
		public static const VIDEO_ROOM_FAIL_LOAD_VIDEO_CHAR_INFO:int               = 37; //< 加载videocharinfo失败
		public static const VIDEO_ROOM_FAIL_VIDEO_CHAR_INFO_ERROR:int              = 38; //< videocharinfo错误
		public static const VIDEO_ROOM_FAIL_BAN_CHAT_TARGET_NB:int                 = 39; //对方拥有防止禁言的VIP权限，或者对方的守护等级比自己高，那么禁言操作失败

		public static const VIDEO_ROOM_FAIL_BAN_CHAT_BANNED_BY_OTHER:int           = 40; //守护解除禁言的目标是被主播或管理员禁言的，那么解除禁言失败
		public static const VIDEO_ROOM_FAIL_SHUTTING_DOWN:int                      = 41; //视频区关服中
		public static const VIDEO_ROOM_FAIL_PK_ROOM_PK_NOT_START:int               = 42; //主播pk房间，在房间开启，但比赛未开启的时段，主播不可申请上麦
		public static const VIDEO_ROOM_FAIL_PK_ROOM_NOT_PK_ANCHOR:int              = 43; //主播pk房间，未进入攻击时段，两名参赛主播可以上麦，其他主播不可以上麦
		public static const VIDEO_ROOM_FAIL_PK_ROOM_NOT_ATTACK_ANCHOR:int          = 44; //主播pk房间，攻击时段段内，非攻击状态的主播不可以上麦
		public static const VIDEO_ROOM_FAIL_NO_TICKET:int                          = 45; //没有梦工厂门票，不允许进入特定房间
		public static const VIDEO_ROOM_FAIL_MOBILE_CANNOT_ENTER_PKROOM:int         = 46; //手机端不允许进入PK房间
		public static const VIDEO_ROOM_FAIL_ROOM_IS_CLOSED:int                     = 47; //房间已经关闭
		public static const VIDEO_ROOM_START_LIVE_FAIL_ROOM_IS_CLOSED:int          = 48;
		public static const VIDEO_ROOM_NEED_CROWD_INTO_ROOM:int                    = 49; //需要有限次数挤房进入

		public static const VIDEO_ROOM_CROWD_ROOM_FAIL:int                         = 50; //挤房失败了
		public static const VIDEO_ROOM_FAIL_CROWD_INTO_ROOM_COUNT:int              = 51; //达到挤入房间次数上限
		public static const VIDEO_ROOM_ANCHOR_NEST_CANCEL:int                      = 52; //小窝被注销
		public static const VIDEO_ROOM_ANCHOR_NEST_FREEZE:int                      = 53; //小窝被冻结
		public static const VIDEO_ROOM_START_LIVE_FAIL_NEST_FROZEN:int             = 54; //开始直播失败，小窝被冻结
		public static const VIDEO_ROOM_ENTER_FLOW_LIMITED:int                      = 55; //进入视频房间 -- 流量限制（1秒只能进入1000个）
		public static const VIDEO_ROOM_CONCERT_HAS_NOT_TICKET:int                  = 56; //演唱会房间没有票，无法进入
		public static const VIDEO_ROOM_FAIL_WEB_CANNOT_ENTER_PKROOM:int            = 57; //WEB不允许进入PK房间
		public static const VIDEO_ROOM_FAIL_WEB_CANNOT_ENTER_CEREMONY:int          = 58; //WEB不允许进入年度盛典
		public static const VIDEO_ROOM_FAIL_WEB_CANNOT_ENTER_NOT_LIVING_NEST:int   = 59; //web无法进入未直播的小窝

		public static const VIDEO_ROOM_FAIL_WEB_CANNOT_ENTER_NORMAL_TICKETROOM:int = 60; //WEB不允许进入普通卖票房间（非演唱会卖票房间）
		public static const VIDEO_ROOM_FAIL_WEB_CANNOT_ENTER_AUDIOROOM:int         = 61; //WEB不允许进入音频房间
		public static const VIDEO_ROOM_FAIL_ENCRYPT_PORTRAIT:int                   = 62;
		public static const VIDEO_ROOM_FAIL_OPT_FAILED_SPECIAL_ROOM:int            = 63; //特殊房间内操作失败
		public static const VIDEO_ROOM_FAIL_GUEST_TAKE_CAPACITY:int                = 64; //游客占用房间人数，房间人满
		public static const VIDEO_ROOM_FAIL_PLAYER_NAME_NOT_SET:int                = 65;
		public static const VIDEO_ROOM_FAIL_IS_STARTING_LIVE:int                   = 66; //别的主播正在开始直播过程中
	}
}
