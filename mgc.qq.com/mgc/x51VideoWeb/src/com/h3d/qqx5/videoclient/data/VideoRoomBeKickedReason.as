package com.h3d.qqx5.videoclient.data
{
	public class VideoRoomBeKickedReason
	{
		public static var VIDEO_ROOM_BE_KICKED_SELF:int                  = 0;//离开房间
		public static var VIDEO_ROOM_BE_KICKED_BY_CMD:int                = 1;//被命令行提出
		public static var VIDEO_ROOM_BE_KICKED_ROOM_CLOSE:int            = 2;//房间关闭
		public static var VIDEO_ROOM_BE_KICKED_BY_ADMIN:int              = 3;//悲管理员提出
		public static var VIDEO_ROOM_BE_KICKED_TIMEOUT:int               = 4;//超时
		public static var VIDEO_ROOM_BE_KICKED_SDK_BAN_ANCHOR:int        = 5;//被主播提出
		public static var VIDEO_ROOM_BE_KICKED_DUPLICATED:int            = 6;//重复登录
		public static var VIDEO_ROOM_BE_KICKED_MOBILE_ON_PKACT_START:int = 7;//
		public static var VIDEO_ROOM_BE_KICKED_ADMIN_CLOSE_ROOM:int      = 8;//管理员关闭房间
		public static var VIDEO_ROOM_BE_KICKED_NEST_DELETED:int          = 9;//小窝被删除
		public static var VIDEO_ROOM_BE_KICKED_NEST_FROZEN:int           = 10;//小窝被冻结
		public static var VIDEO_ROOM_BE_KICKED_BY_ASSISTANT:int          = 11;//被助手提出
		public static var VIDEO_ROOM_BE_KICKED_BY_WEB_OTHER_TAB:int      = 12;//web端打开一个新标签页进入新的房间
	}
}