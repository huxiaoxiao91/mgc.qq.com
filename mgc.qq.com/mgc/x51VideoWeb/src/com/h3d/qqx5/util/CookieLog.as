package com.h3d.qqx5.util {

	import com.h3d.qqx5.common.ClientDebugInfo;
	import com.h3d.qqx5.common.Globals;
	
	import flash.net.SharedObject;

	/**
	 * cookie级别的log，记录登录态变化。
	 * 	登录态变化可能会发生在不同页面上，原始的log不能够体现其的变化。
	 * @author gaolei
	 *
	 */
	public class CookieLog {
		private static const SO_NAME:String     = "cookie_log";

		private static const MAX_LOG_AMOUNT:int = 40;

		private static function getLogFileTime():String {
			var date:Date  = new Date();

			var ret:String = "";
			ret += date.fullYear.toString() + "-"
			ret += (date.month + 1).toString() + "-";
			ret += date.date.toString() + "_"
			ret += ((date.hours < 10) ? "0" : "") + date.hours.toString() + ":";
			ret += ((date.minutes < 10) ? "0" : "") + date.minutes.toString() + ":";
			ret += ((date.seconds < 10) ? "0" : "") + date.seconds.toString();

			return ret;
		}

		public static function addLogicClearLog(clientSource:String, reason:String):void {
			addLog('{"client":' + clientSource + "_" + ClientDebugInfo.clientID + ', "reason":' + reason + ", roomID:" + Globals.SelfRoomID + '}');
		}

		public static function addCookieChangeLog(log:String):void {
			if (Globals.isDubug) {
				try {
					var so:SharedObject = SharedObject.getLocal(SO_NAME, "/");
					var soLog:String    = so.data.clog;
					if (soLog == "" || soLog == null) {
						soLog = "";
					}
					var logs:Array = soLog.split("\n");
					logs.push(getLogFileTime() + "  " + log);
					while (logs.length > MAX_LOG_AMOUNT * 2) {
						logs.shift();
					}
					soLog = logs.join("\n");
					so.data.clog = soLog;
					so.flush();
				} catch (error:Error) {

				}
			}
		}

		public static function addLog(info:String):void {
			if (Globals.isDubug) {
				try {
					var so:SharedObject = SharedObject.getLocal(SO_NAME, "/");
					var soLog:String    = so.data.log;
					if (soLog == "" || soLog == null) {
						soLog = "";
					}
					var logs:Array = soLog.split("\n");
					logs.push(getLogFileTime() + "  " + info);
					while (logs.length > MAX_LOG_AMOUNT) {
						logs.shift();
					}
					soLog = logs.join("\n");
					so.data.log = soLog;
					so.flush();
				} catch (error:Error) {

				}
			}
		}

		public static function getLogs():String {
			try {
				var so:SharedObject = SharedObject.getLocal(SO_NAME, "/");
				var soLog:String    = so.data.log;
				if (soLog == "" || soLog == null) {
					soLog = "";
				}
				if (so.data.clog != null && so.data.clog != "") {
					soLog += "\n\nCookieChangeLog:\n";
					soLog += so.data.clog;
				}
				return soLog;
			} catch (error:Error) {

			}
			return "";
		}
	}
}
