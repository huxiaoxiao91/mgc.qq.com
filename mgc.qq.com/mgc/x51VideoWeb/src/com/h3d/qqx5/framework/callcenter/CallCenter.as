package com.h3d.qqx5.framework.callcenter {

	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.VideoWebOperationType;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.RoomProxyInfo;
	import com.h3d.qqx5.common.comdata.UserIdentity;
	import com.h3d.qqx5.common.event.CEventQueryVideoAccountInfo;
	import com.h3d.qqx5.common.event.CEventQueryVideoAccountInfoRes;
	import com.h3d.qqx5.common.event.CEventVideoClientSigVerify;
	import com.h3d.qqx5.common.event.CEventVideoClientSigVerifyRes;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoVersion;
	import com.h3d.qqx5.enum.RoomProxyReconnectVerifyResult;
	import com.h3d.qqx5.enum.UserProxyResult;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoInitConnectionRequest;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoInitConnectionResponse;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoPlayerHeartBeatNotify;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoReconnectVerifyReponse;
	import com.h3d.qqx5.framework.callcenter.event.CEventVideoReconnectVerifyRequest;
	import com.h3d.qqx5.framework.callcenter.event.CallCenterMessageID;
	import com.h3d.qqx5.framework.interfaces.ICallCenter;
	import com.h3d.qqx5.framework.network.INetCallback;
	import com.h3d.qqx5.framework.network.INetConnection;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.MessageDispacher;
	import com.h3d.qqx5.framework.network.NetConnection;
	import com.h3d.qqx5.util.AccountCookieConst;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.util.CookieLog;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.StringConverter;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.getQualifiedClassName;
	import flash.utils.getTimer;

	/**
	 * @author Administrator
	 *
	 * 修改连接方式，只需要一次连接。取消现在每次发请求前都要发一次DoInitConnectRequest，如果已经链接了就直接发送消息。
	 * @Date 2016-4-21
	 * @author gaolei
	 *
	 */
	public class CallCenter implements ICallCenter, INetCallback {
		/**
		 * 	消息分发器
		 */
		private var _dispacth:MessageDispacher;
		/**
		 * 	底层网络连接
		 */
		private var _netConnection:INetConnection;

		/**
		 * 链接状态
		 */
		private var m_unQQ:uint                    = 0;
		private var m_connectedQQ:uint             = 0;
		private var m_strVerify:String             = "";
		private var m_nLastConnectZoneId:int       = 0;
		private var m_nTempConnectZoneId:int       = 0;

		private var _proxyID:int;
		private var _tunnelID:int;
		private var _toSendMsgs:Array              = new Array;
		private var _temp_ProxyID:int;
		private var _temp_TunnelID:int;
		private var _connected:Boolean             = false;
		private var _connecting:Boolean            = false;
		private var hasConnSucc:Boolean            = false;
		private var m_connect_error_times:int      = 0;
		private static var CONNECT_ERROR_TIMES:int = 3;
		private var m_hasCharactor:Boolean         = false;
		private var m_room_proxy_infos:Array       = null;
		private var m_account_infos:Array          = null;

		/**
		 * 	更新管理器
		 */
		private var UPDATETIMESPAN:int             = 20;
		private var updateTimer:TimerBase          = new TimerBase(UPDATETIMESPAN, updateTimerHandler);

		/**
		 * 	心跳包数据
		 */
		private var _last_send_heartbeat:int       = 0;
		private const SEND_HEARTBEAT_INTERVAL:int  = 10000;

		/**
		 * 	消息同步管理器,暂时没用
		 */
		private var _request_mgr:RequestMgr;

		private var m_client:IVideoClientInternal  = null;
		private var _loadfinishcallback:Function   = null;

		public function CallCenter(client:IVideoClientInternal, loadfinishcallback:Function) {
			_dispacth = new MessageDispacher;
			_dispacth.setNetCallBack(this);

			_netConnection = new NetConnection(_dispacth);
			_request_mgr = new RequestMgr(_dispacth);
			m_client = client;
			addCallCenterEventHandlers();

			_loadfinishcallback = loadfinishcallback;

			if (Globals.useLoadConfig) {
				//加载配置版
				loadAutoPatchConfig();
			} else {
				//写死配置版
				setPublishSettingVers();
			}


			initUpdateTimer();
			SetCookieData();
		}

		/**
		 * 设置发布版本配置
		 *
		 */
		private function setPublishSettingVers():void {
			var innerWebList:Array     = [
				"183.60.147.163",
				"119.147.129.199",
				"125.39.247.38"
				];
			var innerWebListTest:Array = [
				"119.147.131.165",
				"119.147.130.225",
				"119.147.131.163"
				];
			var intranetRandomArray:Array = [];
			switch (Globals.ipType) {
				case Globals.IP_INNER_230:
					//内部服
					SERVER_IP = "124.207.138.230";
					break;
				case Globals.IP_INNER_233:
					//内部服
					SERVER_IP = "124.207.138.233";
					break;
				case Globals.IP_INNER_30:
					//内部服
					SERVER_IP = "172.17.100.30";
					break;
				case Globals.IP_INNER_INTRANET_RANDOM:
					SERVER_IP = intranetRandomArray[int(intranetRandomArray.length * Math.random())];
					break;
				case Globals.IP_INNER_RANDOM:
					SERVER_IP = innerWebList[int(innerWebList.length * Math.random())];
					break;
				case Globals.IP_OUTER_TEST:
					//现网测试服
					SERVER_IP = innerWebListTest[int(innerWebListTest.length * Math.random())];
					break;
				case Globals.IP_OUTER:
					//现网
					SERVER_IP = "rp.mgc.qq.com";
					break;
			}

			SERVER_PORT = 31000;
			m_bReady = true;
			Globals.s_logger.info("read xml,version ip:" + SERVER_IP + ",version port:" + SERVER_PORT);
		}

		//"192.168.1.9";//"124.207.138.233";//"rp.mgc.qq.com";
		private static var SERVER_IP:String        = "124.207.138.233";
		private static var SERVER_PORT:int         = 31000;

		private function addCallCenterEventHandlers():void {
			add_message_handler(CallCenterMessageID.CLSID_CEventVideoInitConnectionResponse,
				getQualifiedClassName(CEventVideoInitConnectionResponse), onInitConnectResponse);
			add_message_handler(CallCenterMessageID.CLSID_CEventVideoReconnectVerifyReponse,
				getQualifiedClassName(CEventVideoReconnectVerifyReponse), onReconnectVerifyResponse);

			//2016-04--21 优化登录流程处理
//			add_message_handler(EEventIDVideoVersion.CLSID_CEventQueryVideoAccountInfo,
//				getQualifiedClassName(CEventQueryVideoAccountInfo), HandleVersionEvent);
			add_message_handler(EEventIDVideoVersion.CLSID_CEventQueryVideoAccountInfoRes,
				getQualifiedClassName(CEventQueryVideoAccountInfoRes), onQueryVideoAccountInfoRes);

//			add_message_handler(EEventIDVideoVersion.CLSID_CEventVideoClientSigVerify, 
//				getQualifiedClassName(CEventVideoClientSigVerify), HandleVersionEvent);
			add_message_handler(EEventIDVideoVersion.CLSID_CEventVideoClientSigVerifyRes,
				getQualifiedClassName(CEventVideoClientSigVerifyRes), onVideoClientSigVerifyRes);
		}

		//=========================================================================================
		//
		// 读取配置模块
		//
		//=========================================================================================
		private var m_bReady:Boolean               = false;
		private var loader:URLLoader               = new URLLoader();

		private function loadAutoPatchConfig():void {
			try {
				loader.load(new URLRequest(Globals.SwfFolderURL + "/config/auto_patch_client.xml"));
			} catch (error:Error) {
				Globals.s_logger.error("read auto_patch_client_web.xml faile");
				return;
			}

			loader.addEventListener(Event.COMPLETE, onAutoPatchConfigLoaded);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onAutoPatchConfigLoadError);
		}

		private function onAutoPatchConfigLoaded(e:Event):void {
			try {
				var externalXML:XML = new XML(loader.data);
				readNodes(externalXML);
			} catch (e:TypeError) {
				Globals.s_logger.error("parse the XML file fail!");
			}
		}

		private function readNodes(node:XML):void {
			var config_ip:String;
			var config_port:int;
			try {
				var addrList:XMLList = node.auto_patch_client[0].version_servers[0].IDC[0].addr;
				if (addrList.length() > 1) {
					var random:int = addrList.length() * Math.random();
					config_ip = addrList[random].@ip;
					config_port = addrList[random].@port;
				} else {
					config_ip = node.auto_patch_client[0].version_servers[0].IDC[0].addr[0].@ip;
					config_port = node.auto_patch_client[0].version_servers[0].IDC[0].addr[0].@port;
				}
				Globals.s_logger.info("read xml,version ip:" + config_ip + ",version port:" + config_port);

				SERVER_IP = config_ip;
				SERVER_PORT = config_port;
			} catch (error:Error) {
				Globals.s_logger.info("read xml error! use default setting. {ip:" + SERVER_IP + ", port:" + SERVER_PORT + "} error:" + error.toString());
			}

			m_bReady = true;
			if (_loadfinishcallback != null) {
				_loadfinishcallback();
			}
		}

		private function onAutoPatchConfigLoadError(event:IOErrorEvent):void {
			loader.removeEventListener(Event.COMPLETE, onAutoPatchConfigLoaded);
			loader.removeEventListener(IOErrorEvent.IO_ERROR, onAutoPatchConfigLoadError);
			Globals.s_logger.info("Read xml IO_Error! use default setting. {ip:" + SERVER_IP + ", port:" + SERVER_PORT + "} error:" + event.toString());
			m_bReady = true;
		}

		public function Ready():Boolean {
			return m_bReady;
		}

		//=========================================================================================
		//
		// 读取配置模块 end
		//
		//=========================================================================================

		public function GetQQ():uint {
			return m_unQQ;
		}

		public function HasCharactor():Boolean {
			return m_hasCharactor;
		}

		public function SetCharactor(has:Boolean):void {
			m_hasCharactor = has;
		}

		public function GetZoneId():int {
			return m_nLastConnectZoneId;
		}

		public function GetRPip():String {
			return SERVER_IP; //m_strLastConnectIp;
		}

		public function GetPort():int {
			return SERVER_PORT; //m_nLastConnectPort;
		}

		public function ClearCookieData(qq:Number):void {
			var cookie:Cookie = new Cookie("x51web");

			cookie.clearData([AccountCookieConst.SOURCE]);
			if (Globals.cookieQQ != 0 && Globals.cookieZoonID != 0) {
				cookie.flushData(AccountCookieConst.CLEAR_GUEST, true);
			}
			if (qq != 0) {
				cookie.clearQQData(qq);
			}

			m_nLastConnectZoneId = 0;
			m_hasCharactor = false;
		}

		public function ClearGuestCookieData(needMark:Boolean = true):void {
			var cookie:Cookie = new Cookie("x51web");
			if (Globals.cookieQQ != 0 && Globals.cookieZoonID != 0) {
//				cookie.clearData([AccountCookieConst.GUEST]);
				if (needMark) {
					cookie.flushData(AccountCookieConst.CLEAR_GUEST, true);
				}
			}
		}

		public function SetCookieData():void {
			var cookie:Cookie = new Cookie("x51web");
			cookie.print();

			m_nLastConnectZoneId = cookie.getData(AccountCookieConst.ZONE_ID);

			if (Globals.cookieZoonID != 0 && m_nLastConnectZoneId == 0) {
				m_nLastConnectZoneId = Globals.cookieZoonID;
			}

			Globals.s_logger.debug("SetCookieData(): getCookie   m_nTempConnectZoneId" + m_nTempConnectZoneId
				+ "  m_nLastConnectZoneId = " + m_nLastConnectZoneId + "   Globals.cookieQQ = " + Globals.cookieQQ
				+ "  Globals.cookieZoonID = " + Globals.cookieZoonID);
		}

		public function addNeedResponseEventID(reqId:int, ressponseID:int):void {
			_request_mgr.addNeedResponseEventID(reqId, ressponseID);
		}

		public function add_message_handler(msgid:uint, msgname:String, func:Function):void {
			_dispacth.add_message_handler(msgid, msgname, func);
		}

		public function Init(id:uint, key:String, zoneid:int, appid:int, skey:String):void {
			if (m_unQQ != id || m_nLastConnectZoneId != zoneid) {
				_connected = false;
				_connecting = false;
				_netConnection.close();
			}
//			Globals.s_logger.test("CallCenter.Init,qq:" + id + ",zoneid:" + zoneid + ",type:" + Globals.deviceType);
			m_unQQ = id;
			m_strVerify = key;
			m_nLastConnectZoneId = zoneid;
			hasConnSucc = false;
			Globals.tmpRoomID = 0; //请求连接的时候 把默认的房间连接改为初值[同个页面多次登陆 该值不重置会连续发initrequest]
			Globals.appid = appid;
			Globals.skey = skey;
//			Globals.s_logger.test("Init() skey = " + skey + "   Globals.skey = " + Globals.skey);
		}
		
		public function connectionClose():void
		{
			if(_netConnection)
			{
				_netConnection.close();
			}
		}


		private var upSendCLSID:int;

		public function sendMessageToRoomProxy(msg:INetMessage, roomID:int):void {
			if ((!m_hasCharactor || m_connectedQQ == 0) && msg.CLSID() == EEventIDVideoRoomExt.CLSID_CEventLoadPlayerInfoForHomePage) {
				//没有角色不能请求个人信息，连接上的QQ等于0的不能拉取个人信息
				return;
			}
			if (msg.CLSID() == EEventIDVideoRoom.CLSID_CEventVideoRoomLeaveRoom) {
				Globals.s_logger.error("Login CEventVideoRoomLeaveRoom");
			} else if (m_client.GetLoginManager().IsQQChanged()) {
				Globals.s_logger.error("Login QQ Changed!!");
				return;
			}

			if (Globals.SelfRoomID != roomID) {
				Globals.s_logger.info("LocalRoomID:" + Globals.SelfRoomID + " != roomID:" + roomID);
//				_toSendMsgs.push(msg);
//				DoConnect();

				if (!upSendCLSID) {
					upSendCLSID = msg.CLSID();
				}
				_toSendMsgs.push(msg);
				// ==39782 !=39775
				if (upSendCLSID == EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoom
					&& msg.CLSID() != EEventIDVideoRoom.CLSID_CEventVideoRoomGetLiveCDN) {
					DoConnect();
				}
			} else if (_connected) {
				Globals.s_logger.info("LocalRoomID:" + Globals.SelfRoomID + "  roomID:" + roomID);
				_netConnection.send_message(msg, _request_mgr.ProcessRequest(msg));
			} else if (_connecting) {
//				Globals.s_logger.info("Connection establishing!");
				_toSendMsgs.push(msg);
			} else {
//				Globals.s_logger.info("Connection not established yet!");
				_toSendMsgs.push(msg);
				DoConnect();
			}
		}

		private var queryServerIp:String           = "";
		private var queryServerPort:int            = 0;

		public function setRoomProxysAddress(ip:String, port:int):void {
			queryServerIp = ip;
			queryServerPort = port;
		}

		public function DoConnect():void {
			_connected = false;
			_connecting = true;
			if (_netConnection.is_connected()) {
				//连上过 用initrequest
//				Globals.s_logger.test("DoInitConnectRequest,debugTime:" + flash.utils.getTimer());
				DoInitConnectRequest();
			} else {
				//没有连上过
				var findMatchZoneid:Boolean = false;
				if (m_account_infos == null || m_account_infos.length == 0) {
//					Globals.s_logger.test("connectWithAccount()1");
					connectWithAccount();
				} else {
					for each (var uid:UserIdentity in m_account_infos) {
						if (m_nLastConnectZoneId == uid.zoneid) {
							if (GetQQ() != 0) {
								m_hasCharactor = true;
							}
//							Globals.s_logger.test("connectWithAccount()2");
							connectWithAccount();
							findMatchZoneid = true;
							break;
						}
					}
					if (!findMatchZoneid) {
//						Globals.s_logger.test("error: no match zoneid in room_proxy_infos!");
//						_connecting = false;
						connectWithAccount();
					}
				}
			}
		}

		private function connectWithAccount():void {
			m_nTempConnectZoneId = m_nLastConnectZoneId;
			_netConnection.connectWithAccount(SERVER_IP, SERVER_PORT,
				m_unQQ, StringConverter.convertStringToByteArray(m_strVerify));

			//在连接服务器时就要关闭检测登录
			this.m_client.GetLoginManager().stop();
			m_client.GetLoginManager().openQQChangCheck(false);
		}

		private function hasAccountInCache():Boolean {
			if (GetQQ() != 0 && m_account_infos != null && m_account_infos.length > 0) {
				for each (var uid:UserIdentity in m_account_infos) {
					if (GetQQ() == uid.account.toNumber()) {
						m_hasCharactor = true;
						return true;
					}
				}
			}
			return false;
		}

		private function initUpdateTimer():void {
			updateTimer.StartTimer();
		}

		private function updateTimerHandler():void {
			if (_netConnection != null) {
//				Globals.s_logger.test("_netConnection.update()1");
				_netConnection.update();
			}
			if (Globals.SelfRoomID != 0) {
				var currtime:int = flash.utils.getTimer();
				if (currtime - _last_send_heartbeat > SEND_HEARTBEAT_INTERVAL) {
					var heartBeat:CEventVideoPlayerHeartBeatNotify = new CEventVideoPlayerHeartBeatNotify;
					sendMessageToRoomProxy(heartBeat, Globals.SelfRoomID);
					_last_send_heartbeat = currtime;
				}
			}
			_request_mgr.UpdateRequestMgr();
		}

		public function setRoomProxys(room_proxy_infos:Array, account_infos:Array):void {
			m_room_proxy_infos = room_proxy_infos;
			m_account_infos = account_infos;
			// 无角色玩家，断开连接后会重连version，需要重置一下大区信息
//			Globals.s_logger.debug("setRoomProxys()  m_account_infos.length = " + m_account_infos.length + "  Globals.deviceType = " +Globals.deviceType );
			//if(m_account_infos.length && m_account_infos.length == 0 && Globals.deviceType != 4 && Globals.deviceType != 5)
//			m_nLastConnectZoneId = Globals.zoonId;
		}

		/**
		 * 与服务建立连接通知。
		 *  并初始化链接DoInitConnectRequest
		 *
		 */
		public function onRawConnected():void {
			Globals.s_logger.info("onConnected");
			if (isSigVerify) {
				isSigVerify = false;
				Globals.s_logger.localLog("    续签：重连后直接init，等待init响应！");
				DoInitConnectRequest();
				return;
			}
			//游客登录自动初始化连接
			if (m_unQQ == 0) {
				if (Globals.login_opt == VideoWebOperationType.VOT_ConnectVideoVersion) {
					//返回页面128
					m_client.GetUICallback().OnLoadServerListFromVersion(0, true, [], [], null);
				} else {
					//初始化连接，连接成功后->onConnectSuccess会返回页面-2
					DoInitConnectRequest();
				}
			} else {
				var guestCookie:Cookie = new Cookie("x51webGuest");
				var guestQQStr:String  = guestCookie.getData("guest_qq");
				//游客帐号
				if (guestQQStr != null && m_unQQ == uint(guestQQStr)) {
					if (Globals.login_opt == VideoWebOperationType.VOT_ConnectVideoVersion) {
						//暂时未遇到这种情况，先按QQ=0处理
						m_client.GetUICallback().OnLoadServerListFromVersion(0, true, [], [], null);
					} else {
						//直接初始化
						DoInitConnectRequest();
					}
				} else {
					if (Globals.login_opt == VideoWebOperationType.VOT_ConnectVideoVersion) {
						//查询大区列表（玩家列表）
						QueryVideoAccountInfo();
					} else {
						//有角色列表直接初始化连接
						if (hasAccountInCache()) {
							DoInitConnectRequest();
						}
						//没有角色列表的，询问角色列表。适用于登录状态跳转页面
						else {
							QueryVideoAccountInfo();
						}
					}
				}
			}
		}

		/**
		 * 断链后需要检测重连检验
		 */
		private var needReconnectVerify:Boolean    = false;

		/**
		 * 网络链接断开
		 * @param err
		 *
		 */
		public function onRawDisConnected(err:Event, isClose:Boolean = false):void {
			Globals.s_logger.info("onDisConnected:" + err.toString());
			//onConnectFail里面有重连机制。
//			if (!isClose) {
//				_netConnection.connectWithAccount(SERVER_IP, SERVER_IP, Globals.cookieQQ, StringConverter.convertStringToByteArray(m_strTempVerify));
//			}
			needReconnectVerify = true;
			onConnectFail(0);
		}

		public function onDispatchEvent(p:INetMessage, serialID:int):void {
			if (p != null) {
				_request_mgr.ProcessResponse(p, serialID);
			}
		}

		public function GetConnected():Boolean {
			Globals.s_logger.debug("GetConnected :" + _connected);
			return _connected;
		}

		public function GetConnecting():Boolean {
			return _connecting;
		}

		public function Disconnect():void {
			if (_netConnection != null) {
				_netConnection.close();
			}
		}

		private function onConnectSuccess():void {
//			Globals.s_logger.debug("hasConnSucc  :" + hasConnSucc);
			hasConnSucc = true; //连接成功过
			_proxyID = _temp_ProxyID;
			_tunnelID = _temp_TunnelID;
			_connected = true;
			_connecting = false;

			while (_toSendMsgs.length > 0) {
				var msg:INetMessage = _toSendMsgs.shift() as INetMessage;
				Globals.s_logger.info("netConnection Send:" + msg.CLSID());
				if (msg.CLSID() == EEventIDVideoVersion.CLSID_CEventVideoClientSigVerify) {
					_netConnection.send_raw_message(msg);
				} else {
					_netConnection.send_message(msg, _request_mgr.ProcessRequest(msg));
				}
			}
			m_connect_error_times = 0;

			Globals.s_logger.debug("onConnectSuccess(): setCookie   m_nTempConnectZoneId" + m_nTempConnectZoneId);
			m_nLastConnectZoneId = m_nTempConnectZoneId;

			var cookie:Cookie = new Cookie("x51web");
			cookie.flushData(AccountCookieConst.ZONE_ID, m_nLastConnectZoneId);
			if (Globals.cookieQQ != 0 && Globals.cookieZoonID != 0) {
				var cookieQQ:int = cookie.getData(AccountCookieConst.QQ);
				if (cookieQQ != m_unQQ) {
					CookieLog.addCookieChangeLog("saveQQ:" + m_unQQ + "->" + cookieQQ + "  roomID:" + Globals.SelfRoomID + " source:CallCenter.onConnectSuccess");
				}
				cookie.flushData(AccountCookieConst.QQ, m_unQQ);
//				cookie.flushData("qq" + m_unQQ + "_" + Globals.cookieZoonID, m_unQQ);
//				cookie.flushData("room_proxy_zoneid" + Globals.cookieQQ + "_" + Globals.cookieZoonID, m_nLastConnectZoneId);
			} else {
//				cookie.flushData("room_proxy_zoneid" + GUEST, m_nLastConnectZoneId);
				cookie.flushData(AccountCookieConst.CLEAR_GUEST, false);
			}

			Globals.isLogoutState = false;
			Globals.connectTime = new Date().time;

			m_connectedQQ = m_unQQ;
			if (m_hasCharactor) //
			{
				this.m_client.GetLoginManager().start();
			}
			m_client.GetLoginManager().openQQChangCheck(true);

			//返回-2（在一定条件下）
			this.m_client.OnConnectSuccessCallback();
		}

		private function clearConnect():void {
			Globals.SelfRoomID = 0;
			_connected = false;
			_connecting = false;
			_toSendMsgs.splice(0, _toSendMsgs.length);

			_request_mgr.OnLinkClosed();
		}

		private function onConnectFail(resCode:int):void {
			clearConnect();
			m_connect_error_times += 1;
			if (m_connect_error_times >= CONNECT_ERROR_TIMES) {
				this.m_client.OnConnectFailCallback();
				//Globals.sVideoClient.GetInterfacesForUI().NotifyConnected(2);
				if (resCode != 0) {
					this.m_client.OnInitConnectFailCallback(resCode);
				}
				Globals.s_logger.debug("hasConnSucc .hasConnSucc :" + hasConnSucc);
			} else if (hasConnSucc) //成功连接之后，如果断开链接，不主动去重连。
			{
				this.m_client.OnDisConnected();
				return;
			} else {
				DoConnect();
			}
		}


		/**
		 * 初始化连接请求
		 *
		 */
		private function DoInitConnectRequest():void {
			var evt:CEventVideoInitConnectionRequest = new CEventVideoInitConnectionRequest();
			evt.roomID = Globals.roomID;
			evt.trans_id = new Int64();
			evt.uid.account = Int64.fromNumber(m_unQQ);
			evt.uid.zoneid = m_nLastConnectZoneId;
			evt.appid = Globals.appid;
			evt.skey = Globals.skey;
			evt.uid.channel = Globals.channel;
			evt.client_device_type = Globals.deviceType;
			
			//防止页面没发128
			if(evt.uid.zoneid == 0 || evt.appid == 0 || evt.client_device_type == 0)return;
			
			//游客类型为1
			var cookie:Cookie = new Cookie("x51webGuest");
			var guest_qq:uint = cookie.getData("guest_qq");

//			Globals.s_logger.localLog("    续签：重连后直接init，等待init响应！");
			Globals.s_logger.localLog(" DoInitConnectRequest() {roomID:" + Globals.tmpRoomID
				+ ", account:" + evt.uid.account + ", zoneid:" + m_nLastConnectZoneId + ", channel:" + Globals.channel
				+ ", appid:" + Globals.appid + ", skey:" + Globals.skey + ", device_type:" + Globals.deviceType
				+ ", [cookie_guest:" + guest_qq + "]}");

			_netConnection.send_raw_message(evt);
		}

		/**
		 * 初始化连接回应
		 * @param resType
		 * @param p
		 *
		 */
		private function onInitConnectResponse(resType:int, p:INetMessage):void {
			if (p == null) {
				return;
			}
			var evt:CEventVideoInitConnectionResponse = p as CEventVideoInitConnectionResponse;
			Globals.s_logger.localLog("onInitConnectResponse res:" + evt.toString());
			if (evt.res == UserProxyResult.PROXY_RES_SUCCESS) {
				_temp_ProxyID = evt.proxy_id;
				_temp_TunnelID = evt.tunnel_id;

				m_client.OnSyncServerTimeCallback(evt.server_time);
				m_client.GetUICallback().onGetSystemTime();

				if (!DoReconnectVerify()) //不需要验证的话 提示连接成功，
				{
					onConnectSuccess();
					return;
				} else //需要验证，验证成功后再提示连接成功
				{
					return;
				}
			}
			// xw86089 游客数量达到上限提示。
			else if (evt.res == UserProxyResult.PROXY_FAIL_SERVER_OVER_BURDEN) {
				clearConnect();
				this.m_client.OnInitConnectFailCallback(evt.res);
			}  else {
				onConnectFail(evt.res);
			}
		}

		/**
		 * 验证重连响应
		 * @param resType
		 * @param p
		 *
		 */
		private function onReconnectVerifyResponse(resType:int, p:INetMessage):void {
			if (p == null) {
				return;
			}
			var evt:CEventVideoReconnectVerifyReponse = p as CEventVideoReconnectVerifyReponse;
			Globals.s_logger.info("onReconnectVerifyResponse res:" + evt.toString());
			if (evt.res == RoomProxyReconnectVerifyResult.RVR_SUCCESS) {
				onConnectSuccess();
			} else {
				// 续连验证失败，不需要重连几次。直接返回页面错误码。
				//onConnectFail(evt.res);
				clearConnect();
				this.m_client.OnReconnectVerifyFailCallback(evt.res);
			}
		}

		/**
		 * 询问角色信息
		 * @param qq
		 * @param verify
		 * @param m_appid
		 * @param m_skey
		 *
		 */
		private function QueryVideoAccountInfo():void {
			var evt:CEventQueryVideoAccountInfo = new CEventQueryVideoAccountInfo();
			evt.device_type = Globals.deviceType;
			var time_stamp:Date = new Date();
			evt.time_stamp = time_stamp.time;
			evt.m_appid = Globals.appid;
			evt.m_skey = Globals.skey;

			Globals.s_logger.debug("CallCenter -> QueryVideoAccountInfo() -> cconnected=" + _netConnection.is_connected()
				+ "-> {appid:" + evt.m_appid + " , skey:" + Globals.skey + ", device:" + Globals.deviceType + "}");
			if (_netConnection.is_connected()) {
				_netConnection.send_raw_message(evt);
			}
		}

		/**
		 * 询问角色信息响应
		 * @param resType
		 * @param p
		 *
		 */
		private function onQueryVideoAccountInfoRes(resType:int, p:INetMessage):void {
			if (p == null) {
				return;
			}
			Globals.s_logger.debug("onQueryVideoAccountInfoRes()");
			var evt:CEventQueryVideoAccountInfoRes = p as CEventQueryVideoAccountInfoRes;
			var account_infos:Array                = evt.account_infos;
			setRoomProxys(evt.room_proxy_infos, evt.account_infos);
			hasAccountInCache();
			var infos:Array = new Array();
			for (var idx:int = 0; idx < evt.account_infos.length; idx++) {
				var info:Object = new Object;
				info.account = UserIdentity(evt.account_infos[idx]).account.toString();
				info.channel = UserIdentity(evt.account_infos[idx]).channel;
				info.zoneid = UserIdentity(evt.account_infos[idx]).zoneid;
				infos.push(info);
			}
			var cookie:Cookie = new Cookie("x51web");
			cookie.flushData(AccountCookieConst.HAS_ACCOUNT, account_infos.length > 0);

			if (Globals.login_opt == VideoWebOperationType.VOT_ConnectVideoVersion) {
				if (Globals.isReconnection) {
					var guestcookie:Cookie = new Cookie("x51webGuest");
					var qq:uint            = guestcookie.getData("guest_qq");
					if (m_unQQ != qq) {
						Globals.isReconnection = false;
					}
				}

				var lastAccount:Object;
				if (evt.last_login_acc != null && evt.last_login_acc.account.toNumber() != 0) {
					lastAccount = new Object();
					lastAccount.account = UserIdentity(evt.last_login_acc).account.toString();
					lastAccount.channel = UserIdentity(evt.last_login_acc).channel;
					lastAccount.zoneid = UserIdentity(evt.last_login_acc).zoneid;
					lastAccount.zonename = getZoneName(UserIdentity(evt.last_login_acc).channel, UserIdentity(evt.last_login_acc).zoneid);
				}
				m_client.GetUICallback().OnLoadServerListFromVersion(evt.err_code, evt.succ,
					evt.room_proxy_infos, infos, lastAccount);
			} else {
				//登录状态跳转页面的情况
				DoInitConnectRequest();
			}
		}

		private function getZoneName(channel:int, zoneid:int):String {
			if (m_room_proxy_infos != null && m_room_proxy_infos.length > 0) {
				for each (var roomProxyInfo:RoomProxyInfo in m_room_proxy_infos) {
					if (roomProxyInfo.channel == channel && roomProxyInfo.zoneid == zoneid) {
						return roomProxyInfo.name;
					}
				}
			}
			return "";
		}

		/**
		 * 续连请求。
		 * @return
		 *
		 */
		private function DoReconnectVerify():Boolean {
//			if (_proxyID != 0 && _tunnelID != 0 && Globals.SelfRoomID != 0) {
			//增加tmpRoomID不为零时的验证（如果断链过，且tmpRoomID不为0）
			if (_proxyID != 0 && _tunnelID != 0 && (Globals.SelfRoomID != 0 || (needReconnectVerify == true &&　Globals.tmpRoomID != 0))) {
				var evt:CEventVideoReconnectVerifyRequest = new CEventVideoReconnectVerifyRequest();
				evt.trans_id = new Int64; /////////hss to do;
				evt.last_proxy_id = _proxyID;
				evt.last_tunnel_id = _tunnelID;
				_netConnection.send_message(evt, _request_mgr.ProcessRequest(evt));

				Globals.s_logger.debug("DoReconnectVerify(): setCookie   m_nTempConnectZoneId" + m_nTempConnectZoneId);
				m_nLastConnectZoneId = m_nTempConnectZoneId;

				var cookie:Cookie = new Cookie("x51web");

				//重连验证请求时，默认把登录信息记录到cookie。？会不会有问题？
				cookie.flushData(AccountCookieConst.ZONE_ID, m_nLastConnectZoneId);
				if (Globals.cookieQQ != 0 && Globals.cookieZoonID != 0) {
//					cookie.flushData("room_proxy_zoneid" + Globals.cookieQQ + "_" + Globals.cookieZoonID, m_nLastConnectZoneId);
				} else {
//					cookie.flushData("room_proxy_zoneid" + GUEST, m_nLastConnectZoneId);
					//游客0登录
					cookie.flushData(AccountCookieConst.CLEAR_GUEST, false);
				}
				if (m_hasCharactor) {
					this.m_client.GetLoginManager().start();
				}

				Globals.isLogoutState = false;
				Globals.connectTime = new Date().time;

				needReconnectVerify = false;

				Globals.s_logger.info("DoReconnectVerify evt.last_proxy_id:" + evt.last_proxy_id + " evt.last_tunnel_id:" + evt.last_tunnel_id);
				return true;
			} else {
				needReconnectVerify = false;
				return false;
			}
		}

		/**
		 * 续签中
		 */
		private var isSigVerify:Boolean            = false;

		/**
		 * 客户端续期
		 * @param appid
		 * @param key
		 *
		 */
		public function ClientSigVerify(appid:int, key:String):void {
			if (Globals.appid != appid || Globals.skey != key) {
				//续签有问题。
			}

			Globals.s_logger.localLog("客户端发送续期 ClientSigVerify{appid:" + appid + ", key:" + key + "}");
			isSigVerify = true;
			if (_connected) {
				_netConnection.send_raw_message(getClientSigVerifyEvent(appid, key));
			} else if (_connecting) {
				Globals.s_logger.info("ClientSigVerify Connection establishing!");
				_toSendMsgs.push(getClientSigVerifyEvent(appid, key));
			} else {
				Globals.s_logger.info("ClientSigVerify Connection not established yet!");
				_toSendMsgs.push(getClientSigVerifyEvent(appid, key));
				DoConnect();
			}
		}

		/**
		 * 续期请求
		 * @param appid
		 * @param key
		 * @return
		 *
		 */
		private function getClientSigVerifyEvent(appid:int, key:String):INetMessage {
			var ev:CEventVideoClientSigVerify = new CEventVideoClientSigVerify();
			ev.appid = Globals.appid;
			ev.key = Globals.skey;
			return ev;
//			_netConnection.send_raw_message(ev);
//			_netConnection.send_message(msg, _request_mgr.ProcessRequest(msg));
		}

		/**
		 * 续签返回
		 * @param resType
		 * @param p
		 *
		 */
		private function onVideoClientSigVerifyRes(resType:int, p:INetMessage):void {
			if (p == null) {
				return;
			}
			isSigVerify = false;
			Globals.s_logger.debug("onVideoClientSigVerifyRes()");
			var evt:CEventVideoClientSigVerifyRes = p as CEventVideoClientSigVerifyRes;
			if (evt.res == 0) {
				hasConnSucc = true; //连接成功过
				_connected = true;
				_connecting = false;
			}
			m_client.GetUICallback().OnVideoClientSigVerifyRes(evt.res);
			Globals.s_logger.localLog("客户端续期返回 VideoClientSigVerifyRes res=" + evt.res);
//			Globals.s_logger.debug("HandleEventVideoClientSigVerifyRes() res = " + evt.res);
		}
	}
}
