package com.h3d.qqx5.util {

	import flash.external.ExternalInterface;

	/**
	 * 帐号常量
	 * @author gaolei
	 *
	 */
	public class AccountCookieConst {
		public static const ACCOUNT_NAME:String = "x51web";

		private static var _pageSource:String   = null;

		private static function get pageSource():String {
			if (_pageSource == null) {
				if (ExternalInterface.available) {
					try {
						//合并代码后使用新的方法MgcAPI.SNSBrowser.IsQQGame() 返回boolean值
						_pageSource = ExternalInterface.call("mgc.tools.getPageSource");
					} catch (error:Error) {
						_pageSource = "";
					}
				}
			}
			return _pageSource;
		}

		public static function get SOURCE():String {
			return pageSource;
		}

		public static function get QQ():String {
			return pageSource + "_qq";
		}

		public static function get ZONE_ID():String {
			return pageSource + "_room_proxy_zoneid";
		}

		public static function get HAS_ACCOUNT():String {
			return pageSource + "_hasAccount";
		}

		//= "guset";
		public static function get GUEST():String {
			return pageSource + "_guset";
		}

		public static function get IS_GUEST():String {
			return pageSource + "_is_guest";
		}

		public static function get CLEAR_GUEST():String {
			return pageSource + "_clear_guest";
		}

		public static function get LOGOUT_TIME():String {
			return pageSource + "_logout_time";
		}

		public static function get TIME():String {
			return pageSource + "_time";
		}

		public static function get RoomID():String {
			return pageSource + "_roomId";
		}

		public static function get RoomIDQQ():String {
			return pageSource + "_roomIdQQ";
		}

		public static function get MISSION_GUIDE_OVER():String {
			return pageSource + "_msGuideOver";
		}

		public static const CLIENT_ID:String    = "clientId";

		//		public static function get CONNECTED_TIME():String {
		//			return pageSource + "_connected_time";
		//		}
	}
}
