package com.h3d.qqx5.enum {

	/**
	 * USER Proxy
	 * 与 CEventVideoInitConnectionResponse 相关的
	 * @author gaolei
	 *
	 */
	public class UserProxyResult {
		/**
		 * 0 连接成功
		 */
		public static const PROXY_RES_SUCCESS:int                 = 0;
		/**
		 * -3 服务器忙（处理中）
		 * CTransQueryUserServerInfo 默认值，应该不会报。
		 */
		public static const PROXY_FAIL_SERVER_BUSY:int            = -3;
		/**
		 * -5 路由器坏了。
		 * Tunnel::handle_event_broken
		 */
		public static const PROXY_FAIL_ROUTER_BROKEN:int          = -5;
		/**
		 * -9 zone_id验证不通过
		 * zoneid==0或者zoneid对应的channel_id与channel_id不一致
		 * Tunnel::handle_event_uninit
		 */
		public static const PROXY_FAIL_INVALID_ZONEID:int         = -9;
		/**
		 * -11 签名验证失败
		 * CTransQueryUserServerInfo::OnFinishQuerySkeyVerificationInfo
		 * CTransQueryUserServerInfo::OnFinishCheckPlayerLoginStatus
		 */
		public static const PROXY_FAIL_SIG_VERIFY:int             = -11;
		/**
		 * -12 查询user server失败
		 * CTransQueryUserServerInfo::OnFinishQueryUserServerByUID
		 */
		public static const PROXY_FAIL_QUERY_USER_SERVER:int      = -12;
		/**
		 * -13 查询在线信息失败
		 * CTransQueryUserServerInfo::OnFinishQueryLiveInfoServerByUID
		 */
		public static const PROXY_FAIL_QUERY_LIVE_INFO_SERVER:int = -13;
		/**
		 * -14 游客达到上限错误码
		 * xw86089
		 */
		public static const PROXY_FAIL_SERVER_OVER_BURDEN:int     = -14;
	}
}
