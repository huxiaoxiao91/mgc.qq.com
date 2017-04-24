package com.h3d.qqx5.videoclient.data {

	public class VideoRoomFollowErrorNo {
		public static const VRFEN_OK:int            = 0;
		/**
		 * 关注列表已满 可转义成判断关注主播的玩家是否满级
		 */
		public static const VRFEN_FULL:int          = 1;
		/**
		 * 没有该主播
		 */
		public static const VRFEN_NO_ANCHOR:int     = 2;
		/**
		 * 其他未知错误
		 */
		public static const VRFEN_UNKNOWN:int       = 3;
		/**
		 * 已关注
		 */
		public static const VRFEN_ALREADY:int       = 4;
		public static const VRFEN_SERVER_BUSY:int   = 5;
		/**
		 * 读写数据库出错
		 */
		public static const VRFEN_DB_ERROR:int      = 6;
		/**
		 * 主播名字太长
		 */
		public static const VRFEN_NAME_TOO_LONG:int = 7;
		public static const VRFEN_NO_ACCOUNT:int    = 8;
		/**
		 * 关注主播的玩家需要继续升级
		 */
		public static const VRFEN_LEVEL_UP:int      = 9;
	}
}
