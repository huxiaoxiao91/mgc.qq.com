package com.h3d.qqx5 {

	/**
	 * web视频客户端返回码常量表
	 * @author gaolei
	 *
	 */
	public class VideoWebCode {
		/**
		 * 服务器重启后再次向服务器发送消息时，会被通知已经断开了连接
		 */
		public static const CHANGE_LOGIN_SERVER_DISCONNECT:int = 1;
		/**
		 * 账户变化
		 */
		public static const CHANGE_LOGIN_ACCOUNT_CHANGE:int    = 2;
		/**
		 * 获取homepage消息失败（三次）
		 */
		public static const CHANGE_LOGIN_HOME_PAGE_FAIL:int    = 3;
	}
}
