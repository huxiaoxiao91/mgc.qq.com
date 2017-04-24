package com.h3d.qqx5.videoclient.data
{
	public class VideoRoomErrorCode
	{
	  public static const VIDEO_ROOM_SUCCESS:int = 0;
	  public static const VIDEO_ROOM_FAIL_UNKNOWN:int = 1;
	  public static const VIDEO_ROOM_FAIL:int = 2;
	  public static const VIDEO_ROOM_SERVER_BUSY:int = 3;
	  public static const VIDEO_ROOM_FAIL_ACCOUNT_NOT_EXIST:int = 4;
	  public static const VIDEO_ROOM_FAIL_LOST_DATA:int = 5;
	  public static const VIDEO_ROOM_FAIL_DUPLICATED:int = 6;
	  public static const VIDEO_ROOM_FAIL_NOT_ANCHOR:int = 7;
	  public static const VIDEO_ROOM_FAIL_IS_LIVING:int = 8;
	  public static const VIDEO_ROOM_FAIL_AUDIENCE_FULL:int = 9;
	  public static const VIDEO_ROOM_FAIL_NOT_ANCHOR_ADMIN:int = 10;
	  public static const VIDEO_ROOM_FAIL_NO_PERMISSION:int = 11;
	  public static const VIDEO_ROOM_FAIL_NO_SUCH_ROOM:int = 12;
	  public static const VIDEO_ROOM_FAIL_SELF_NOT_IN_ROOM:int = 13;
	  public static const VIDEO_ROOM_FAIL_TARGET_NOT_IN_ROOM:int = 14;
	  public static const VIDEO_ROOM_FAIL_NOT_LIVING:int = 15;
	  public static const VIDEO_ROOM_FAIL_ALREADY_IN_ROOM:int = 16;
	  public static const VIDEO_ROOM_FAIL_ENTER_BE_KICKED:int = 17;
	  public static const VIDEO_ROOM_FAIL_START_BE_STOPED:int = 18;
	  public static const VIDEO_ROOM_FAIL_BAN_CHAT_ALREADT:int = 19;
	  public static const VIDEO_ROOM_FAIL_LOGIN_ROOM_SERVER_FAIL:int = 20;
	  public static const VIDEO_ROOM_FAIL_CREATE_ROOM_FAIL:int = 21;
	  public static const VIDEO_ROOM_FAIL_VIDEO_ZONE_NET_ERROR:int = 22;
	  public static const VIDEO_ROOM_FAIL_ALREADY_ADMIN:int = 23;
	  public static const VIDEO_ROOM_FAIL_CANNOT_ENTER_ANCHORTESTROOM:int = 24;
	  public static const VIDEO_ROOM_FAIL_VIDEO_ANCHOR_FULL:int = 25;
	  public static const VIDEO_ROOM_FAIL_ADMINISTRATOR_FULL:int = 26;
	  public static const VIDEO_ROOM_FAIL_CHAT_NOT_BAN_ALREADY:int = 27;
	  public static const VIDEO_ROOM_FAIL_ROOM_BANNED:int = 28;
	  public static const VIDEO_ROOM_FAIL_ANCHORBUTNOTLIVING:int = 29;
	  public static const VIDEO_ROOM_FAIL_TARGET_NOT_AUDIENCE:int = 30;
	  public static const VIDEO_ROOM_FAIL_TARGET_IS_SELF:int = 31;
	  public static const VIDEO_ROOM_FAIL_JACKET_LIMIT:int = 32;
	  public static const VIDEO_ROOM_FAIL_HAVE_SAME_JACKET:int = 33;
	  public static const VIDEO_ROOM_FAIL_NO_JACKET:int = 34;
	  public static const VIDEO_ROOM_EVENT_LIMIT:int = 35;
	  public static const VIDEO_ROOM_FAIL_AUDIENCE_FULL_FOR_SUPERGUARD:int = 36;
	  public static const VIDEO_ROOM_FAIL_LOAD_VIDEO_CHAR_INFO:int = 37;
	  public static const VIDEO_ROOM_FAIL_VIDEO_CHAR_INFO_ERROR:int = 38;
	  public static const VIDEO_ROOM_FAIL_BAN_CHAT_TARGET_NB:int = 39;
	  public static const VIDEO_ROOM_FAIL_BAN_CHAT_BANNED_BY_OTHER:int = 40;
	  public static const VIDEO_ROOM_FAIL_SHUTTING_DOWN:int = 41;
	  public static const VIDEO_ROOM_FAIL_PK_ROOM_PK_NOT_START:int = 42;
	  public static const VIDEO_ROOM_FAIL_PK_ROOM_NOT_PK_ANCHOR:int = 43;
	  public static const VIDEO_ROOM_FAIL_PK_ROOM_NOT_ATTACK_ANCHOR:int = 44;
	  public static const VIDEO_ROOM_FAIL_NO_TICKET:int = 45;
	  public static const VIDEO_ROOM_FAIL_MOBILE_CANNOT_ENTER_PKROOM:int = 46;
	  public static const VIDEO_ROOM_FAIL_ROOM_IS_CLOSED:int = 47;
	  public static const VIDEO_ROOM_START_LIVE_FAIL_ROOM_IS_CLOSED:int = 48;
	  public static const VIDEO_ROOM_NEED_CROWD_INTO_ROOM:int = 49;
	  public static const VIDEO_ROOM_CROWD_ROOM_FAIL:int = 50;
	  public static const VIDEO_ROOM_FAIL_CROWD_INTO_ROOM_COUNT:int = 51;
	  public static const VIDEO_ROOM_ANCHOR_NEST_CANCEL:int = 52;
	  public static const VIDEO_ROOM_ANCHOR_NEST_FREEZE:int = 53;
	  public static const VIDEO_ROOM_START_LIVE_FAIL_NEST_FROZEN:int = 54;
	  public static const VIDEO_ROOM_ENTER_FLOW_LIMITED:int = 55;    //进入视频房间 -- 流量限制（1秒只能进入1000个）
	  public static const VIDEO_ROOM_CONCERT_HAS_NOT_TICKET:int = 56  // 演唱会房间没有票，无法进入
	}
}
