package com.h3d.qqx5.common {

	import com.h3d.qqx5.util.AccountCookieConst;
	import com.h3d.qqx5.util.Cookie;

	public class ClientDebugInfo {
		public function ClientDebugInfo() {
		}

		public static const LAST_BUG_NO:String = "XW";
		public static const VERSION:String     = "version_2016_7_6_001";

		private static var _clientId:int       = -1;

		public static function get clientID():int {
			if (_clientId < 0) {
				var cookie:Cookie = new Cookie(AccountCookieConst.ACCOUNT_NAME);
				_clientId = cookie.getData(AccountCookieConst.CLIENT_ID);
				_clientId++;
				if (_clientId > 100000) {
					_clientId = 0;
				}
				cookie.flushData(AccountCookieConst.CLIENT_ID, _clientId);
			}
			return _clientId;
		}
	}
}
