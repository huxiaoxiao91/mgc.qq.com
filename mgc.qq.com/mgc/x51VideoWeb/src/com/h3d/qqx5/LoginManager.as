package com.h3d.qqx5
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.VideoChannelType;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.util.AccountCookieConst;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.util.CookieLog;
	import com.h3d.qqx5.util.MD5;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	
	import flash.external.ExternalInterface;
	
	/**
	 * 
	 * 登录续期管理类
	 * @author WangJian
	 * 
	 */	
	public class LoginManager
	{ 
		/**
		 * 	检查登录状态定时器
		 */
		private var m_checkLoginChangeTimer:TimerBase;
		private var m_nCheckLoginChangeInterval:int = 10000;
		
		private var m_bTimerStart:Boolean = false;
		
		//续期间隔  30分钟
		private var delay:int = 30*60;
		
		private var m_client:IVideoClientInternal = null;
		//秘钥
		static private var key:String = "mgc.qq.com_^_^_loginHB_Skey";
		
		public function LoginManager(client:IVideoClientInternal)
		{
			m_client = client;
		}
		
		public function start():void
		{
			var cookie:Cookie = new Cookie("x51web");
			Globals.s_logger.debug("Cookie:LoginManager.start");
			var qq:uint = (uint)(m_client.GetLocalAccountID().toNumber());
			//首页是0 不能缓存-游客和0  会异常账号
			if (qq != 0) {
				var cookieQQ:int = cookie.getData(AccountCookieConst.QQ);
				if (cookieQQ != qq) {
					CookieLog.addCookieChangeLog("saveQQ:" + qq + "->" + cookieQQ + "  roomID:" + Globals.SelfRoomID + " source:LoginManager.start");
				}
				cookie.flushData(AccountCookieConst.QQ, qq); //("qq"+qq + "_" +Globals.cookieZoonID,qq);
			}
			if (m_bTimerStart) {
				Globals.s_logger.info("LoginManager has started yet!");
				return;
			}
			m_checkLoginChangeTimer = new TimerBase(m_nCheckLoginChangeInterval, timerHandler);
			m_checkLoginChangeTimer.StartTimer();
			m_bTimerStart = true;
		}

		public function stop():void {
			if (m_checkLoginChangeTimer != null) {
				m_checkLoginChangeTimer.StopTimer();
			}
			m_bTimerStart = false;
		}

		private var needCheckQQChange:Boolean;

		/**
		 * 打开QQ异常检测
		 * @param open
		 *
		 */
		public function openQQChangCheck(open:Boolean):void {
			Globals.s_logger.debug("异常检测ChangeLogin: open？" + open);
			needCheckQQChange = open;
		}

		public function IsQQChanged():Boolean {
			if (needCheckQQChange == false) {
				return false;
			}

			//炫舞2客户端上不检测登录异常。
			if (Globals.channel == VideoChannelType.VCT_X52 && Globals.deviceType == ClientDeviceType.CDT_X52) {
				return false;
			}

			var cookie:Cookie    = new Cookie("x51web");
//			var cookieDataKey:String;
//			if (Globals.cookieQQ != 0 && Globals.cookieZoonID != 0 && m_client.GetIsGuest() == false) {
//				cookieDataKey = "" + Globals.cookieQQ  + "_" + Globals.cookieZoonID;
//			} else {
//				cookieDataKey = CallCenter.GUEST;
//			}
			var lastqqStr:String = cookie.getData(AccountCookieConst.QQ); //("qq" + cookieDataKey); //登陆态里的qq
//			if(lastqqStr == null){
//				if(cookie.getData("is_guest" + Globals.cookieQQ + Globals.cookieZoonID)){
//					lastqqStr = "" + Globals.cookieQQ;
//				}
//			}
			var lastqq:uint      = uint(lastqqStr);
			var lastzoneid:int   = cookie.getData(AccountCookieConst.ZONE_ID); //("room_proxy_zoneid" + cookieDataKey); //登陆态里的大区
			var qq:uint          = (uint)(m_client.GetLocalAccountID().toNumber()); //当前页面的qq
			var zoneid:int       = m_client.GetCallCenter().GetZoneId(); //当前页面的zoneid

			//首页不检查登陆异常；登陆态是0的时候 当前为游客时候不需要异常
			if (qq == 0 || (lastqq == 0 && m_client.GetIsGuest())) {
				var isClearGuest:Boolean = cookie.getData(AccountCookieConst.CLEAR_GUEST); //(CallCenter.CLEAR_GUEST);
				if (isClearGuest == false) {
					return false;
				}
			}

			//登出状态不做qq号变化检测
			if (Globals.isLogoutState) {
				Globals.s_logger.debug("logingManager处于登出状态!!");
				return true;
			}

			//游客
			if (lastqq != qq && m_client.GetIsGuest()) {
				Globals.s_logger.debug("IsQQChanged() : hasCharactor=" + m_client.GetCallCenter().HasCharactor()
					+ " IsGuest=" + m_client.GetIsGuest() + " isLogutState=" + Globals.isLogoutState
					+ " Globals->{cookieQQ:" + Globals.cookieQQ + ", cookieZoonID:" + Globals.cookieZoonID + "}"
					+ " Cookie->{qq:" + lastqq + "(" + lastqqStr + "), zoonid:" + lastzoneid + "}"
					+ " Current->{qq:" + qq + ", zoneid:" + zoneid + "}");
				Globals.s_logger.error("Guest" + m_client.GetIsGuest() + ".CookieQQ :" + lastqq + ",is not the same with MemoryQQ:" + qq);
				//异常处理
				LoginChange();
//				ExternalInterface.call("MGC_Comm.ChangeLogin");

				Globals.isLogoutState = true;

				var log_msg:String = "IsQQChanged() 游客状态QQ号变化（" + lastqq + "->" + qq + "）";
				Globals.s_logger.localLog("ChangeLogin: " + log_msg);

				var guest_op:Object = {"op_type": VideoWebOperationType.Change_Login, "res": VideoWebCode.CHANGE_LOGIN_ACCOUNT_CHANGE,
						"msg": log_msg};
				if (ExternalInterface.available) {
					if (x51VideoWeb.isOldFrame) {
						ExternalInterface.call("MGC_Comm.ChangeLogin", guest_op);
						Globals.s_logger.debug("IsQQChanged()    MGC_Comm.ChangeLogin");
					} else {
						ExternalInterface.call("mgc.network.recvMsg", guest_op);
						Globals.s_logger.debug("IsQQChanged()    mgc.network.recvMsg   ChangeLogin");
					}
				}

				m_client.GetInterfacesForUI().Logout(log_msg);
				return true;
			}
			Globals.s_logger.error("lastzoneid :" + lastzoneid + ",zoneid:" + zoneid);
			//lastqq != 0 && lastzoneid != 0 && 
			if ((lastqq != qq || lastzoneid != zoneid) && m_client.GetCallCenter().HasCharactor()) {
				Globals.s_logger.debug("IsQQChanged() : hasCharactor=" + m_client.GetCallCenter().HasCharactor()
					+ " IsGuest=" + m_client.GetIsGuest() + " isLogutState=" + Globals.isLogoutState
					+ " Globals->{cookieQQ:" + Globals.cookieQQ + ", cookieZoonID:" + Globals.cookieZoonID + "}"
					+ " Cookie->{qq:" + lastqq + "(" + lastqqStr + "), zoonid:" + lastzoneid + "}"
					+ " Current->{qq:" + qq + ", zoneid:" + zoneid + "}");
				Globals.s_logger.error("CookieQQ :" + lastqq + ",is not the same with MemoryQQ:" + qq + "lastzoneid:" + lastzoneid + "zoneid:" + zoneid);
				//异常处理
				LoginChange();
//				ExternalInterface.call("MGC_Comm.ChangeLogin");
				Globals.s_logger.debug("IsQQChanged():  lastqq:  " + lastqq + "   qq = " + qq + "   lastzoneid:  " + lastzoneid + "     zoneid:   " + zoneid + "    m_client.GetCallCenter().HasCharactor() =" + m_client.GetCallCenter().HasCharactor());

				Globals.isLogoutState = true;

				var log_msg2:String = "IsQQChanged() QQ号变化（" + lastqq + "->" + qq + "） 大区变化（" + lastzoneid + "->" + zoneid + "）";
				Globals.s_logger.localLog("ChangeLogin: " + log_msg2);

				var qq_op:Object = {"op_type": VideoWebOperationType.Change_Login, "res": VideoWebCode.CHANGE_LOGIN_ACCOUNT_CHANGE,
						"msg": log_msg2};
				if (ExternalInterface.available) {
					if (x51VideoWeb.isOldFrame) {
						ExternalInterface.call("MGC_Comm.ChangeLogin", qq_op);
						Globals.s_logger.debug("IsQQChanged()    MGC_Comm.ChangeLogin");
					} else {
						ExternalInterface.call("mgc.network.recvMsg", qq_op);
						Globals.s_logger.debug("IsQQChanged()    mgc.network.recvMsg   ChangeLogin");
					}
				}

				if (m_client.GetIsGuest() == false) {
					var cookieLogoutTime:String = cookie.getData(AccountCookieConst.LOGOUT_TIME);
					var logoutTime:Number       = 0;
					if (cookieLogoutTime != null && cookieLogoutTime != "") {
						logoutTime = parseFloat(cookieLogoutTime);
					}
					if (logoutTime == 0 || Globals.connectTime > logoutTime) {
						m_client.GetInterfacesForUI().Logout(log_msg);
					}
				} else {
					m_client.GetInterfacesForUI().Logout(log_msg);
				}
				return true;
			}

			return false;
		}

		private function timerHandler():void {
			//获取上次续期时间  秒
			var cookie:Cookie = new Cookie("x51web");

			//炫舞2客户端上不检测登录异常。
			if (Globals.channel == VideoChannelType.VCT_X52 && Globals.deviceType == ClientDeviceType.CDT_X52) {

			} else {
				var lastqqStr:String = cookie.getData(AccountCookieConst.QQ); //("qq" + cookieDataKey); //登陆态里的qq
				var lastqq:uint      = uint(lastqqStr);
				var qq:uint          = (uint)(this.m_client.GetLocalAccountID());
				var lastzoneid:int   = cookie.getData(AccountCookieConst.ZONE_ID); //("room_proxy_zoneid"+cookieDataKey);//登陆态里的大区
				var zoneid:int       = m_client.GetCallCenter().GetZoneId(); //当前页面的zoneid

				if (Globals.isLogoutState == false && (lastqq != qq || lastzoneid != zoneid) && m_client.GetCallCenter().HasCharactor()) {
					//			if (Globals.isLogutState == false && (lastqq != qq || lastzoneid != zoneid) && qq != 0 && lastqq != 0 && lastzoneid != 0) {
					var logInfo:String = "loginManager timer check() : hasCharactor=" + m_client.GetCallCenter().HasCharactor()
						+ " Globals->{cookieQQ:" + Globals.cookieQQ + ", cookieZoonID:" + Globals.cookieZoonID + "}"
						+ " Cookie->{qq:" + lastqq + "(" + lastqqStr + "), zoonid:" + lastzoneid + "}"
						+ " Current->{qq:" + qq + ", zoneid:" + zoneid + "}"

					Globals.s_logger.localLog("ChangeLogin: " + logInfo);

					//Globals.s_logger.error("LocalQQ is not the same with MemoryQQ");
					Globals.s_logger.error("LocalQQ :" + lastqq + ",is not the same with MemoryQQ:" + qq + "lastzoneid:" + lastzoneid + "zoneid:" + zoneid);

					Globals.isLogoutState = true;
					//异常处理
					LoginChange();

					Globals.s_logger.debug("timerHandler():  lastqq:  " + lastqq + "   qq = " + qq + "   lastzoneid:  " + lastzoneid + "     zoneid:   " + zoneid);

					var op:Object = {"op_type": VideoWebOperationType.Change_Login,
							"res": VideoWebCode.CHANGE_LOGIN_ACCOUNT_CHANGE, "msg": logInfo};
					if (ExternalInterface.available) {
						if (x51VideoWeb.isOldFrame) {
							ExternalInterface.call("MGC_Comm.ChangeLogin", op);
							Globals.s_logger.debug("timerHandler()    MGC_Comm.ChangeLogin");
						} else {
							ExternalInterface.call("mgc.network.recvMsg", op);
							Globals.s_logger.debug("timerHandler()    mgc.network.recvMsg   ChangeLogin");
						}
					}

					if (m_client.GetIsGuest() == false) {
						var cookieLogoutTime:String = cookie.getData(AccountCookieConst.LOGOUT_TIME);
						var logoutTime:Number       = 0;
						if (cookieLogoutTime != null && cookieLogoutTime != "") {
							logoutTime = parseFloat(cookieLogoutTime);
						}
						if (logoutTime == 0 || Globals.connectTime > logoutTime) {
							m_client.GetInterfacesForUI().Logout(logInfo);
						}
					} else {
						m_client.GetInterfacesForUI().Logout(logInfo);
					}
				}
			}
			var lastTime:int = cookie.getData(AccountCookieConst.TIME); //("time" + cookieDataKey);
			var nowTime:int  = (new Date()).time / 1000;
			if (lastTime) {
				//超过时间间隔
				if (nowTime - lastTime > delay) {
					//发送续期
					var secret:String = getSecret(qq.toString(), "", nowTime.toString());
//					ExternalInterface.call("MGC_Comm.LoginHb",secret);
					if (ExternalInterface.available) {
						if (x51VideoWeb.isOldFrame) {
							ExternalInterface.call("MGC_Comm.LoginHb", secret);
						} else {
							ExternalInterface.call("mgc.network.recvMsg", {"op_type": 259, "message": secret});
						}
					}
					Globals.s_logger.error("发送续期" + secret);

					//存入新时间
					//so.data.time = nowTime;
					//so.flush();
					cookie.flushData(AccountCookieConst.TIME, nowTime); //("time" + cookieDataKey, nowTime);
				}
			} else {
				//存入新时间
				//so.data.time = nowTime;
				//so.flush();
				cookie.flushData(AccountCookieConst.TIME, nowTime); //("time" + cookieDataKey, nowTime);
			}
		}
		
		/**
		 * 
		 * @param qq QQ
		 * @param ip 用户IP
		 * @param timestamp 当前时间戳
		 * @return 加密后的字符
		 * 
		 */		
		static public function getSecret(qq:String,ip:String,timestamp:String):String
		{
			//var str:String = MD5.hash(key + qq + ip + timestamp) + "|" + qq + "|" + ip + "|" + timestamp;
			var str:String = MD5.hash(key + qq + timestamp) + "|" + qq + "|" + timestamp;
			str = str.toLocaleUpperCase();
			
			return str;
		} 
		
		
		public function LoginChange():void
		{
			m_client.LoginChangeToDo();
		}
	}
}