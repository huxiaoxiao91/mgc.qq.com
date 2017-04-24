package com.h3d.qqx5.enum {

	/**
	 * room proxy返回错误码
	 * @author gaolei
	 *
	 */
	public class RoomProxyResult {
		public static const PROXY_RES_SUCCESS:int           = 0;
		/**
		 * -1 未知错误
		 * CTransQueryPlayerLocation::OnTransComplete
		 */
		public static const PROXY_FAIL_UNKNOW:int           = -1;
		/**
		 * -2 房间验证失败
		 * CTransQueryPlayerLocation::HandleCEventQueryPlayerLocationResponse
		 */
		public static const PROXY_FAIL_INVALIDE_ROOMID:int  = -2;
		/**
		 * -3 服务器忙（处理中）
		 * CTransQueryPlayerLocation::OnTransBegin
		 * CTransQueryPlayerLocation::HandleCEventQueryPlayerLocationResponse
		 * CTransQueryPlayerLocation::QueryPlayerLocation
		 */
		public static const PROXY_FAIL_SERVER_BUSY:int      = -3;
		/**
		 * -4 暂时无用
		 */
		public static const PROXY_FAIL_AUTHORITY:int        = -4;
		/**
		 * -5 路由器坏了。
		 * Tunnel::handle_event_broken
		 */
		public static const PROXY_FAIL_ROUTER_BROKEN:int    = -5;
		/**
		 * 内部使用
		 */
		public static const Connect_proxy_success:int       = -6;
		/**
		 * 内部使用
		 */
		public static const Connect_proxy_failure:int       = -7;
		/**
		 * 暂未使用
		 */
		public static const PROXY_RECONNECT_VERIFY_FAIL:int = -8;
		/**
		 * -9 zone_id验证不通过
		 * zoneid==0或者zoneid对应的channel_id与channel_id不一致
		 * Tunnel::handle_event_uninit
		 */
		public static const PROXY_FAIL_INVALID_ZONEID:int   = -9;
		/**
		 * -10 询问过快
		 * CTransQueryPlayerLocation::HandleCEventQueryPlayerLocationResponse
		 */
		public static const PROXY_FAIL_QUERY_SO_QUICK:int   = -10;
		/**
		 * -11 签名验证失败
		 * CTransQueryPlayerLocation::HandleCEventVideoSigVerifyRes
		 */
		public static const PROXY_FAIL_SIG_VERIFY:int       = -11;
	}
}
