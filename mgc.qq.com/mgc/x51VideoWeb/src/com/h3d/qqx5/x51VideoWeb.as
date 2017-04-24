package com.h3d.qqx5
{
	import com.h3d.qqx5.common.ClientDebugInfo;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.PlayerContributePKRank;
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.comdata.VideoChannelType;
	import com.h3d.qqx5.common.comdata.WeekStarPlayerContributeRank;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoBegin;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoEnd;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoRefresh;
	import com.h3d.qqx5.common.event.CEventCommonActivityPlayerRank;
	import com.h3d.qqx5.common.event.CEventCommonActivityPlayerRankModel;
	import com.h3d.qqx5.common.event.CEventNotifyPkMatchInfo;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorPKRank;
	import com.h3d.qqx5.common.event.CEventRefreshCommonActivityData;
	import com.h3d.qqx5.common.event.CEventRefreshPkGift;
	import com.h3d.qqx5.common.event.CEventRefreshPkProgressInfo;
	import com.h3d.qqx5.common.event.CEventRefreshPkValue;
	import com.h3d.qqx5.common.event.CEventRefreshPlayerContributePKRank;
	import com.h3d.qqx5.common.event.CEventRefreshRocketBuff;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.gift.GiftPKManage;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAdvSupportLogInfo;
	import com.h3d.qqx5.modules.dream_box.data.DreamBoxForUI;
	import com.h3d.qqx5.modules.video_activity.VideoActivityInfoToClient;
	import com.h3d.qqx5.tqos.TQOSEnterRoom;
	import com.h3d.qqx5.util.AccountCookieConst;
	import com.h3d.qqx5.util.ChatFormatUtil;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.util.CookieLog;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.Logger;
	import com.h3d.qqx5.util.StringUtil;
	import com.h3d.qqx5.videoclient.VideoClient;
	import com.h3d.qqx5.videoclient.data.AccumulateRewards;
	import com.h3d.qqx5.videoclient.data.ActivityCenterInfosForUI;
	import com.h3d.qqx5.videoclient.data.ActivityInfoForUI;
	import com.h3d.qqx5.videoclient.data.ActivityRewardForUI;
	import com.h3d.qqx5.videoclient.data.AnchorImpressionEditForUI;
	import com.h3d.qqx5.videoclient.data.AnchorInfocard;
	import com.h3d.qqx5.videoclient.data.AnchorNestPopularityInfo;
	import com.h3d.qqx5.videoclient.data.AnchorNestSupportInfo;
	import com.h3d.qqx5.videoclient.data.AnchorStarlightRankData;
	import com.h3d.qqx5.videoclient.data.AnchorTaskInfoUI;
	import com.h3d.qqx5.videoclient.data.BoxRewardDataForUI;
	import com.h3d.qqx5.videoclient.data.BoxRewardForUI;
	import com.h3d.qqx5.videoclient.data.CDailySiginRewardForUI;
	import com.h3d.qqx5.videoclient.data.CMemberOperationInfo;
	import com.h3d.qqx5.videoclient.data.CReward;
	import com.h3d.qqx5.videoclient.data.CeremonyStartInfoForUI;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	import com.h3d.qqx5.videoclient.data.DailyActivityInfoForUI;
	import com.h3d.qqx5.videoclient.data.DailySigninRewardContentForUI;
	import com.h3d.qqx5.videoclient.data.ERewardType;
	import com.h3d.qqx5.videoclient.data.EnterOption;
	import com.h3d.qqx5.videoclient.data.GiftData;
	import com.h3d.qqx5.videoclient.data.RaffleRewardForUI;
	import com.h3d.qqx5.videoclient.data.RewardDataForUI;
	import com.h3d.qqx5.videoclient.data.RewardForUI;
	import com.h3d.qqx5.videoclient.data.RoomInfoForUI;
	import com.h3d.qqx5.videoclient.data.SendVideoGiftResultInfo;
	import com.h3d.qqx5.videoclient.data.SignRewardForUI;
	import com.h3d.qqx5.videoclient.data.UIEnterVideoRoomInfo;
	import com.h3d.qqx5.videoclient.data.VideoChatErrorInfo;
	import com.h3d.qqx5.videoclient.data.VideoClientCharInfo;
	import com.h3d.qqx5.videoclient.data.VideoGuardSeatInfoUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildMemberInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildPositionInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoRoomBoxReward;
	import com.h3d.qqx5.videoclient.data.VideoRoomData;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import com.h3d.qqx5.videoclient.data.VideoRoomScreenScrollInfo;
	import com.h3d.qqx5.videoclient.data.VideoVipPlayerCardInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoVoteInfoForUI;
	import com.h3d.qqx5.videoclient.data.VipAddtionInfo;
	import com.h3d.qqx5.videoclient.data.VipPriceInfoForUI;
	import com.h3d.qqx5.videoclient.data.VipSeatInfoForUI;
	import com.h3d.qqx5.videoclient.gamereward.RewardInfoManager;
	import com.h3d.qqx5.videoclient.interfaces.IUIAnchorNest;
	import com.h3d.qqx5.videoclient.interfaces.IUIAnchorPK;
	import com.h3d.qqx5.videoclient.interfaces.IUISurpriseBox;
	import com.h3d.qqx5.videoclient.interfaces.IUIVideoGuild;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientPlayerOPCallback;
	import com.h3d.qqx5.videoclient.main.AnchorImpressionIDToName;
	import com.h3d.qqx5.videoclient.xmlconfig.CGiftConfig;
	import com.h3d.qqx5.video_rank_server.shared.AnchorWeekStarMatchInfo;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.KeyboardEvent;
	import flash.events.TimerEvent;
	import flash.external.ExternalInterface;
	import flash.net.FileReference;
	import flash.system.Security;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuItem;
	import flash.ui.Keyboard;
	import flash.utils.ByteArray;
	import flash.utils.Dictionary;
	import flash.utils.getTimer;
	import flash.utils.setTimeout;
	
	[SWF(width="800", height="200", frameRate="30", backgroundColor="#ffFFFF")]

	public class x51VideoWeb extends Sprite implements IVideoClientLogicCallback, IVideoClientPlayerOPCallback, IUISurpriseBox, IUIVideoGuild, IUIAnchorPK, IUIAnchorNest
	{
		public var m_videoClient:VideoClient = null;
		private var _videoClientAdapter:VideoClientX5Bridge;
		private var jscallback:ExternalCallbakInterface;
		private var rewardmanager:RewardInfoManager;
		private var delay:int = 30*60;
		//优化选项f
//		private var giftopt:OperaCallOptimize = null;
		private var giftnptify :OperaCallOptimize = null;
		private var superfans :OperaCallOptimize = null;
		private var chatMsg:OperaCallOptimize = null;
		private var giftpoolhigh:OperaCallOptimize = null;	
		private var giftpoolhigh17:OperaCallOptimize = null;
		private var vipenter:OperaCallOptimize = null;
		//优化选项end
		private var m_BeKicked:Boolean = false;
		private var giftIdArray:Array;
		private var getFrameVid:TimerBase;
		
		private var version_number:String = "version:388.3.8.1";
		//是否是老框架
		public static var isOldFrame:Boolean = false;
		
		public static var isDrainage:Boolean = false;
		
		private var giftPKManage:GiftPKManage;
		
		public function x51VideoWeb()
		{
			Globals.useLoadConfig = true; //true//false
			Globals.isDubug = false;
			Globals.ipType = Globals.IP_OUTER;

			//log中需要判断当前版本，发布版log条目数为500，debug版log条目为5000
			var logger:Logger = new Logger(this, "`");
			Globals.s_logger = logger;

			Globals.s_logger.debug("开始构建");

			Security.allowDomain("*");
			initAsMethodsForJs();

			//清除右键菜单
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			this.contextMenu = myContextMenu;

//			initVersion();
//			Globals.s_logger.debug("test_timer223232323");
			if (stage == null) {
				addEventListener(Event.ADDED_TO_STAGE, addStageHandler);
			} else {
				addStageHandler(null);
			}

			//ExternalInterface.marshallExceptions = true;
			//ExternalInterface.addCallback("g", g);
//			var m_user_admins:Array = ["7810931945270086", "1737201986076965688"];
//			PushAllUserAdminList(m_user_admins);
//			setTimeout(PushAllUserAdminList,3000, m_user_admins);
		}

		private function addStageHandler(event:Event):void {
			var paramObj:Object = LoaderInfo(this.root.loaderInfo).parameters;

			if (paramObj.isOldFrame == "true") {
				x51VideoWeb.isOldFrame = true;
			} else {
				x51VideoWeb.isOldFrame = false;
			}

			if (paramObj.hasOwnProperty("isDrainage") && paramObj.isDrainage) {
				x51VideoWeb.isDrainage = paramObj.isDrainage;
			}

//			Globals.s_logger.debug("isDrainage = " + x51VideoWeb.isDrainage + "   paramObj.isDrainage = " + paramObj.isDrainage);

			Globals.s_logger.debug(stage.loaderInfo.url);
			var lastIndex:int = stage.loaderInfo.url.lastIndexOf("/");
			if (lastIndex == -1) {
				Globals.s_logger.error("ConfigUrlError!");
				return;
			}
			Globals.SwfFolderURL = stage.loaderInfo.url.substring(0, lastIndex);

			if (Globals.useLoadConfig) {
				//读取版本配置配置信息
				new VersionConfigLoader().loadConfig(loadVersionConfigCompleted);
			} else {
				setPublishSettingVers();
			}

//			Globals.s_logger.debug("swf add to stage,debugTime:" + flash.utils.getTimer());

//			Globals.s_logger.debug("load client_version_config.xml");

			stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDownHandler);
			
//			setInterval(testLog, 1000)
		}

//		private var logIndex:int = 0;
//		private function testLog():void{
//			Globals.s_logger.localLog("Test Local Log -> " + logIndex);
//			logIndex ++;
//		}

		private var needSaveLog:String;

		private function keyDownHandler(e:KeyboardEvent):void {
			//ctrl+1 或者 小键盘1
			if (e.ctrlKey && e.keyCode == Keyboard.NUMBER_1 || e.keyCode == Keyboard.NUMPAD_1) {
//				var requestfile:FileReference = new FileReference();
//				var requestFileName:String = "web_request_log_" + getLogFileTime() + ".txt";
//				var requestInfo:String = RequestCounter.getCounterLog();
//				requestfile.save(requestInfo, requestFileName);
			}
			//ctrl+2 或者 小键盘2
			else if (e.ctrlKey && e.keyCode == Keyboard.NUMBER_2 || e.keyCode == Keyboard.NUMPAD_2) {
				if (needSaveLog == null) {
					var file:FileReference = new FileReference();
					file.addEventListener(Event.COMPLETE, onSaveFileConmlete);
					file.addEventListener(Event.CANCEL, onSaveFileCancel);
					file.addEventListener(IOErrorEvent.IO_ERROR, onSaveFileIOError);

					var name:String = "web_logic_log_" + getLogFileTime() + ".txt";
					needSaveLog = Logger.LOCAL_LOG;
					file.save(needSaveLog, name);
					Logger.LOCAL_LOG = "";
				}
			}
			//ctrl+3 或者 小键盘3
			else if (e.ctrlKey && e.keyCode == Keyboard.NUMBER_3 || e.keyCode == Keyboard.NUMPAD_3) {
				var cookiefile:FileReference = new FileReference();
				var cookieFileName:String = "web_cookie_log_" + getLogFileTime() + ".txt";
				var info:String = CookieLog.getLogs();
				cookiefile.save(info, cookieFileName);
			}

			if (Globals.isDubug || Globals.ipType != Globals.IP_OUTER) {
				if (e.keyCode == Keyboard.D) {
					if (ExternalInterface.available) {
						ExternalInterface.call("alert",
							"最近修改的BUG号：XW83949" + "<br/>" + ClientDebugInfo.VERSION);
					}
				}
			}
		}
		private function onSaveFileConmlete(event:Event):void{
			needSaveLog = null;
		}
		private function onSaveFileCancel(event:Event):void{
			Logger.LOCAL_LOG = needSaveLog + Logger.LOCAL_LOG;
			needSaveLog = null;
		}
		private function onSaveFileIOError(event:IOErrorEvent):void{
			Logger.LOCAL_LOG = needSaveLog + Logger.LOCAL_LOG;
			needSaveLog = null;
		}

		static public function getLogFileTime():String {
			var date:Date  = new Date();

			var ret:String = "";
			ret += date.fullYear.toString() + "-"
			ret += (date.month + 1).toString() + "-";
			ret	+= date.date.toString() + "_"
			ret += ((date.hours < 10) ? "0" : "") + date.hours.toString() + "_";
			ret += ((date.minutes < 10) ? "0" : "") + date.minutes.toString() + "_";
			ret += ((date.seconds < 10) ? "0" : "") + date.seconds.toString();

			return ret;
		}

		/**
		 * 设置发布版本配置
		 *
		 */
		private function setPublishSettingVers():void {
			CGiftConfig.GiftConfig = "http://ossweb-img.qq.com/images/mgc/css_img/config/gift.xml?v=" + (new Date()).time;
			CGiftConfig.iconPath = "http://ossweb-img.qq.com/images/mgc/css_img/flash/gift/gift_";

			initVersion();
			initContent();
			onLoadFinish();
		}

		private function loadVersionConfigCompleted(loader:VersionConfigLoader):void {
			if (loader != null) {
				version_number = loader.webClientVer;

//				if (loader.giftConfigURL != null && loader.giftConfigURL != "")
				CGiftConfig.GiftConfig = loader.webGiftConfigURL;
//				if (loader.iconPath != null && loader.iconPath != "")
				CGiftConfig.iconPath = loader.webGiftIconPath;
//				CVideoRoomClient.FLV_URL_SUFFIX = loader.flv_url;

				initVersion();
				initContent();

//				ExternalInterface.call("alert", "读取版本配置信息成功。webClientVer:"+JSON.stringify(loader));
			} else {
				Globals.s_logger.debug("load version_config faile");
			}
		}

		private function initVersion():void {
			var myContextMenu:ContextMenu = new ContextMenu();
			myContextMenu.hideBuiltInItems();
			this.contextMenu = myContextMenu;

			var item:ContextMenuItem = new ContextMenuItem(version_number);
			myContextMenu.customItems.push(item);
		}

		//loadConnection
		public function x51VideoHandleGift(argc:String):void {
			request_as(argc);
		}

		public function GetUIAnchorNest():IUIAnchorNest {
			return this;
		}

		private function initContent():void
		{
			m_videoClient = new VideoClient(this);
			_videoClientAdapter = new VideoClientX5Bridge;
			jscallback = new ExternalCallbakInterface;
			rewardmanager = new RewardInfoManager();
			giftPKManage = new GiftPKManage(this);
			m_videoClient.GetCX5VideoClient().SetVideoClientAdapter(_videoClientAdapter);
			//m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SetLogicCallBack(this);
			m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().SetPlayerOpCallback(this);
			m_videoClient.GetCX5VideoClient().Init();
			//优化
//			giftopt = new OperaCallOptimize(500,2,5,VideoWebOperationType.VOT_ReceiveGift);
			giftnptify = new OperaCallOptimize(3000, 1, 2, VideoWebOperationType.VOT_ShowSendGiftScreenScrollMsg);
			superfans = new OperaCallOptimize(500, 2, 2, VideoWebOperationType.VOT_LoadSuperFans);
			chatMsg = new OperaCallOptimize(200, 5, 5, VideoWebOperationType.VOT_OnReceiveChatMsg);
			giftpoolhigh = new OperaCallOptimize(1000, 1, 2, VideoWebOperationType.VOT_RefreshGiftPoolHeight);
			giftpoolhigh17 = new OperaCallOptimize(1000, 1, 2, VideoWebOperationType.VOT_LoadTreasureBoxData);
			vipenter = new OperaCallOptimize(3000, 1, 2, VideoWebOperationType.VOT_ShowVipEnterRoomScreenScrollMsg);


			//测试
//			var gclient:GClient = new GClient();
//			gclient.addRequestFun(request_as);
//			this.addChild(gclient);
//			gclient.start();
		}

		public function onLoadFinish():void {
			if (ExternalInterface.available) {
				var tojson:Object = new Object;
				tojson.op_type = VideoWebOperationType.VOT_SWFAddToStage;
//				ExternalInterface.call("response_as",tojson,false);
				if (x51VideoWeb.isDrainage) {
					ExternalInterface.call("response_as", tojson, false);
					Globals.s_logger.debug("返回页面串  response_as：" + JSON.stringify(tojson));
				} else {
					ExternalInterface.call("mgc.network.recvMsg", tojson, false);
					Globals.s_logger.debug("返回页面串  mgc.network.recvMsg：" + JSON.stringify(tojson));
				}

//				var js_heartbeat_timer:Timer = new Timer(25);
//				js_heartbeat_timer.addEventListener(TimerEvent.TIMER, onJSHeartbeatTimerHandler);
//				js_heartbeat_timer.start();
//				jsTimerLastTime = getTimer();
			}
		}

		private var jsTimerLastTime:int;

		private function onJSHeartbeatTimerHandler(event:TimerEvent):void {
			if (ExternalInterface.available) {
				var ct:int = getTimer();
				ExternalInterface.call("MGC_Timer._asHeartbeat", ct - jsTimerLastTime);
//				Globals.s_logger.localLog("jsTimer : dt -> " + (ct - jsTimerLastTime));
				jsTimerLastTime = ct;
			}
		}

		// JavaScript 调用 ActionScript 时，ActionScript 端的函数
		private function initAsMethodsForJs():void {
			// 注册一个需要被 JavaScript 调用的函数
			if (ExternalInterface.available) {
				ExternalInterface.addCallback("request_as", request_as);
				ExternalInterface.addCallback("isReady", isReady);
			}
		}
		
		private function isReady():Boolean
		{
			return m_videoClient.GetCX5VideoClient().GetCallCenter() != null 
				&& m_videoClient.GetCX5VideoClient().GetCallCenter().Ready();
//			return (Globals.sVersionCallCenter!=null) && Globals.sVersionCallCenter.Ready();
		}
		
		public function notifyConnected(res:int, qq:uint, zoneid:int, isguest:Boolean):void
		{
			Globals.s_logger.debug("swf callback to web connected,debugTime:" + flash.utils.getTimer());
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ConnectRoomProxyServer;
			tojson.res = res;
			tojson.qq = qq;
			tojson.zoneid = zoneid;
			tojson.isGuest = isguest;
			tojson.channel = Globals.channel;
			
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		public function  onRefreshCeremonyStartInfo( info : CeremonyStartInfoForUI)  : void
		{
			return ;
		}
		
		private var _params:Object;
		
		/**
		 * 
		 * @param jsonparam
		 * @param callbackfunc
		 * @param args
		 */
		private function request_as(jsonparam:Object,callbackfunc:String = null,...args):void
		{
			if (Globals.isDubug) {
				Globals.s_logger.debug("接收页面请求串:" + JSON.stringify(jsonparam) + " callbackfunc:" + callbackfunc);
			}
//			Globals.s_logger.debug("callbackfunc:" + callbackfunc);

			if (!jsonparam) {
				Globals.s_logger.error("request_as:jsonparam is Null!!!:" + jsonparam + " callbackfunc:" + callbackfunc);
				return;
			}

			//判断obj str
			var params:Object = null;
			if (jsonparam is String) {
				params = JSON.parse((jsonparam as String));
			} else {
				params = jsonparam;
			}

			var op_type:int = int(params.op_type);
			if (m_BeKicked && (op_type != VideoWebOperationType.VOT_Logout
				&& op_type != VideoWebOperationType.VOT_ConnectRoomProxyServer  
				&& op_type != VideoWebOperationType.VOT_ConnectVideoVersion
				&& op_type != VideoWebOperationType.VOT_SetCookie )	)
				return ;
			
			if(callbackfunc != null )
			{
				var type:int = int(params.op_type);
				
				if(type == VideoWebOperationType.VOT_LoadRoomList )// 拉取房间信息的特殊处理+1000 
					jscallback.RegisterFunc(1000+params.category,params,callbackfunc,args);
				else
					jscallback.RegisterFunc(type,params,callbackfunc,args );
			}
		
			switch(op_type)
			{
				//续期操作 TODO
				case 999:
					//返回状态 0：成功 其他：失败
					params.ret;
					//最新登录态cookie
					params.mgc_login
					break;
				
				case VideoWebOperationType.VOT_SetCookie:
					QuerryCookie(params);
					//setCookie(params);
					break;
				case VideoWebOperationType.VOT_ConnectRoomProxyServer:
//					Globals.s_logger.test(JSON.stringify(jsonparam));
					Globals.roomID = params.roomId;
					_params = {};
					_params.jsonparam = params;
					_params.callbackfunc = callbackfunc;
					_params.args = args;
					Globals.login_opt = VideoWebOperationType.VOT_ConnectRoomProxyServer;
					ConnectProxyServer(params);
					break;
				case VideoWebOperationType.VOT_LoadRoomList:
//					Globals.s_logger.debug("web request VOT_LoadRoomList,debugTime:" + flash.utils.getTimer());
					requestloadRoomlist(params);
					break;
				case VideoWebOperationType.VOT_GetVideoADUrl:
					requestVideoAdUrl(params);
					break;
				case VideoWebOperationType.VOT_LoadAnchorStarlightRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoRoomAnchorStarlightRank(params.timedimension);
					break;
				case VideoWebOperationType.VOT_LoadVideoRoomAnchorPopularityRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoRoomAnchorPopularityRank();
					break;
				case VideoWebOperationType.VOT_LoadStarAnchorScoreRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadStarAnchorScoreRank();
					break;
				case VideoWebOperationType.VOT_LoadGuildChampionRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadGuildChampionRank();
					break;
				case VideoWebOperationType.VOT_LoadAnchorScoreRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadAnchorScoreRank(params.timedimension);
					break;
				case VideoWebOperationType.VOT_LoadVideoGuildRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoGuildRank();
					break;
				case VideoWebOperationType.VOT_LoadAnchorPKWinnerRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadAnchorPKWinnerRank();
					break;
				case VideoWebOperationType.VOT_LoadAnchorPKRichManRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadAnchorPKRichManRank();
					break;		
				case VideoWebOperationType.VOT_CommonActivityPlayerRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadActivityPlayerRank();
					break;
				case VideoWebOperationType.VOT_EnterRoom:
					TQOSEnterRoom.nBeginTime = flash.utils.getTimer();
					var option:EnterOption = new EnterOption;
					option.crowd_into = params.crowd_into;
					option.invisible = params.invisible;
					Globals.s_logger.debug("EnterRoom page to server x51 =  " +  params.source + "," +  params.module_type + "," +  params.page_capacity + "," +  params.room_list_pos);
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().EnterRoom(params.roomID, null, option, params.source, params.tag, params.module_type, params.page_capacity, params.room_list_pos);
					break;
				case VideoWebOperationType.VOT_LeaveRoom:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LeaveRoom();
					break;
				case VideoWebOperationType.VOT_LoadAnchorInfocard:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetAnchorCardInfo(Int64.fromJsonNode(params.anchorID));
					break;
				case VideoWebOperationType.VOT_LoadPlayerList:
					Globals.pageIndex = params.pageIndex;
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadPlayerList(params.pageIndex);
					break;
				case VideoWebOperationType.VOT_LoadTreasureBoxData:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetTreasureBoxData(params.roomID);
					break;
				case VideoWebOperationType.VOT_LoadAnchorAffinityRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoRoomAffinityRank(params.timedimension);
					break;
				case VideoWebOperationType.VOT_SendGift:
					var argc1:Object = {"e_c":"mgc.gift","c_t":4};
					ExternalInterface.call("EAS.SendClick",argc1);
					var anchorqq:Int64 = new Int64(0,0);
					var star_gift:Boolean = false;
					if( params.anchorID != null)
						anchorqq = Int64.fromJsonNode(params.anchorID);
					if( params.star_gift != null )
						star_gift = params.star_gift;
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SendGift(params.gift_id,params.gift_cnt, anchorqq,star_gift);
					break;
				case VideoWebOperationType.VOT_SearchOnlinePlayer:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SearchOnlinePlayer(params.key_words);
					break;
				case VideoWebOperationType.VOT_TakeVote:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().TakeVote(params.select);
					break;
				case VideoWebOperationType.VOT_GetVoteStartInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetVoteStartInfo();
					break;
				case VideoWebOperationType.VOT_LoadRecommendVideoRoomResult:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadRecommendVideoRoom(params.type,params.prob,params.recommend_count);
					break;				
				case VideoWebOperationType.VOT_SendChatMsg:
					requestSendChatMsg(params);					
					break;
				case VideoWebOperationType.VOT_GetVipPrice:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetVipPrice();
					break;
				case VideoWebOperationType.VOT_QueryFreeWhistleLeft:
					var WhistleLeft:int = m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetFreeWhistleCount();
					break;
				case VideoWebOperationType.VOT_LoadSuperFans:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadSuperFans(params.fanstype,Int64.fromJsonNode(params.anchorID));
					break;
				case VideoWebOperationType.VOT_KickPlayer:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().KickPlayer(params.playerName, params.playerZoneName);
					break;
				case VideoWebOperationType.VOT_GetPlayerVideoCardInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetPlayerVideoCardInfoById(Int64.fromJsonNode(params.player_id), params.source);
					break;
				case VideoWebOperationType.VOT_ModifyPlayerVideoCardInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ModifyVideoCardSignature(params.sign);
					break;
				case VideoWebOperationType.VOT_UploadPlayerVideoCardInfo:
					var ContenBytes:ByteArray=new ByteArray();  
					ContenBytes = com.h3d.qqx5.util.Base64.decode(params.content);
//					var _loader:Loader = new Loader();
//					_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onLoadComplete);
//					_loader.loadBytes(ContenBytes);
					//ContenBytes.writeUTF(params.content);
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().UploadVideoCardPortait(ContenBytes);
					break;
				case VideoWebOperationType.VOT_LoadAnchorImpressionForAnchor:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadAnchorImpressionForAnchor(Int64.fromJsonNode(params.anchor_id));
					break;
				case VideoWebOperationType.VOT_RefreshRoomStatus:
					
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetRoomStatus();
					break;
				case VideoWebOperationType.VOT_LoadAnchorImpressionForPlayer:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadAnchorImpressionForPlayer(Int64.fromJsonNode(params.anchor_id));
					break;
				case VideoWebOperationType.VOT_EditAnchorImpressionForPlayer:
					var impresss:Array = new Array;
					for(var i:int = 0; i < params.data.length; ++i)
					{
						var t:AnchorImpressionEditForUI = new AnchorImpressionEditForUI();
						t.m_op_type = params.data[i].editType;
						t.m_impression_id = params.data[i].impressionID;
						impresss.push(t);
					}
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().EditAnchorImpression(Int64.fromJsonNode(params.anchor_id),impresss);					
					break;
				case VideoWebOperationType.VOT_TakeAnchorTask://接受主播任务
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().TakeAnchorTask();
					break;
				case VideoWebOperationType.VOT_QueryAnchorTask://查询主播任务
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().QueryClientAnchorTaskNewRole();
					break;
				case VideoWebOperationType.VOT_DropAnchorTask://放弃主播任务
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().DropAnchorTask();
					break;
				case VideoWebOperationType.VOT_LoadVideoGuildList://加载舞团列表 page从0开始  //---已测试
					m_videoClient.GetVideoGuildClient().LoadVideoGuildList(params.page,params.name_pattern,params.sort_type);
					break;
				case VideoWebOperationType.VOT_LoadMyVideoGuild://查看我的后援团界面
					m_videoClient.GetVideoGuildClient().LoadMyVideoGuild(true,params.from_home);
					break;
				case VideoWebOperationType.VOT_LoadVideoGuildMemberList://打开“成员管理”标签页
					m_videoClient.GetVideoGuildClient().LoadVideoGuildMemberList();
					break;
				case VideoWebOperationType.VOT_KickVideoGuildMember://开除成员
					m_videoClient.GetVideoGuildClient().KickVideoGuildMember(Int64.fromJsonNode(params.player_id));
					break;
				case VideoWebOperationType.VOT_ExitVideoGuild://退出后援团
					m_videoClient.GetVideoGuildClient().ExitVideoGuild();
					break;
				case VideoWebOperationType.VOT_ModifyVideoGuildMemberPosition://修改成员职位
					m_videoClient.GetVideoGuildClient().ModifyVideoGuildMemberPosition(Int64.fromJsonNode(params.player_id),params.new_position);
					break;
				case VideoWebOperationType.VOT_ModifyVideoGuildPositionInfo://修改职位信息
					var posinfo:VideoGuildPositionInfoForUI = new VideoGuildPositionInfoForUI();//params.info
					posinfo.m_position_id = params.position_id;
					posinfo.m_position_name = params.position_name;
					posinfo.Manage = params.manage;
					posinfo.InviteApprove = params.inviteApprove;
					posinfo.Kick = params.kick;
					posinfo.Ticket = params.ticket;
					posinfo.PositionManage = params.positionManage;
					m_videoClient.GetVideoGuildClient().ModifyVideoGuildPositionInfo(posinfo);
					break;
				case VideoWebOperationType.VOT_LoadVideoGuildPositions://加载职位信息
					m_videoClient.GetVideoGuildClient().LoadVideoGuildPositions();
					break;
				case VideoWebOperationType.VOT_DisbandVideoGuild://解散
					m_videoClient.GetVideoGuildClient().DisbandVideoGuild();
					break;
				case VideoWebOperationType.VOT_CancelDisbandVideoGuild://取消解散
					m_videoClient.GetVideoGuildClient().CancelDisbandVideoGuild();
					break;
				case VideoWebOperationType.VOT_DesmissVideoGuild://传位
					m_videoClient.GetVideoGuildClient().DismissVideoGuild(Int64.fromJsonNode(params.player_id),params.mibao);
					break;
				case VideoWebOperationType.VOT_CancelDemiseVideoGuild://取消传位
					m_videoClient.GetVideoGuildClient().CancelDemiseVideoGuild();
					break;
				case VideoWebOperationType.VOT_CreateVideoGuild://创建后援团，异步
					m_videoClient.GetVideoGuildClient().CreateVideoGuild(params.guild_name,Int64.fromJsonNode(params.anchor_pstid),params.guild_desc);
					break;
				case VideoWebOperationType.VOT_GetVideoGuildJoinApplyList://打开申请审核标签页，异步
					m_videoClient.GetVideoGuildClient().GetJoinApplyList();
					break;
				case VideoWebOperationType.VOT_SendVideoGuildJoinApply://向某个后援团发送入团申请
					m_videoClient.GetVideoGuildClient().SendVideoGuildJoinApply(Int64.fromJsonNode(params.vgid) );
					break;
				case VideoWebOperationType.VOT_OperateJoinApply://批准或拒绝某个入团申请，异步
					m_videoClient.GetVideoGuildClient().OperateJoinApply(Int64.fromJsonNode(params.player_id),params.is_approve);
					break;
				case VideoWebOperationType.VOT_InvitePlayerJoinVideoGuild://邀请某人加入后援团，异步
					m_videoClient.GetVideoGuildClient().InvitePlayerJoinVideoGuild(Int64.fromJsonNode(params.target_id),params.inv_from);
					break;
				case VideoWebOperationType.VOT_OperateJoinInvitation://同意（拒绝）加入后援团邀请，异步
					m_videoClient.GetVideoGuildClient().OperateJoinInvitation(Int64.fromJsonNode(params.vgid),params.is_agree);
					break;
				case VideoWebOperationType.VOT_IgnoreJoinInvitation://忽略加入后援团邀请，不需要回调//hss2
					m_videoClient.GetVideoGuildClient().IgnoreJoinInvitation(Int64.fromJsonNode(params.vgid));
					break;
				case VideoWebOperationType.VOT_ChangeSupportAnchor://更换支持的主播，异步
					m_videoClient.GetVideoGuildClient().ChangeSupportAnchor(Int64.fromJsonNode(params.anchor_pstid),params.anchor_nick);
					break;
				case VideoWebOperationType.VOT_GetVideoGuildInfo://查看后援团名片，异步  //---已测试
					m_videoClient.GetVideoGuildClient().GetVideoGuildInfo(Int64.fromJsonNode(params.vgid) );
					break;
				case VideoWebOperationType.VOT_ModifySelfVideoGuildDesc://修改自己的后援团描述，异步
					m_videoClient.GetVideoGuildClient().ModifySelfVideoGuildDesc(params.desc);
					break;
				case VideoWebOperationType.VOT_ModifySelfVideoGuildNotice://修改自己的后援团公告，异步
					m_videoClient.GetVideoGuildClient().ModifySelfVideoGuildNotice(params.notice);
					break;
				case VideoWebOperationType.VOT_ModifySelfVideoGuildName://修改自己的后援团名字
					m_videoClient.GetVideoGuildClient().ModifySelfVideoGuildName(params.name);
					break;
				case VideoWebOperationType.VOT_SendDailySignIn://当日签到
					m_videoClient.GetVideoGuildClient().SendDailySignIn();
					break;
				case VideoWebOperationType.VOT_SendVideoGuildMonthTicket://送月票
					m_videoClient.GetVideoGuildClient().SendVideoGuildMonthTicket(params.cnt);
					break;
				case VideoWebOperationType.VOT_BuyVideoGuildBoard://购买粉丝牌
					m_videoClient.GetVideoGuildClient().BuyVideoGuildBoard(params.boardtype,params.add_time);
					break;
//				case VideoWebOperationType.VOT_GetSelfVideoGuildID:	//获取自己所在的后援团ID，0表示没有所在的后援团//hss4
//					m_videoClient.GetVideoGuildClient().GetSelfVideoGuildID();
//					break;
				case VideoWebOperationType.VOT_ForbidJoinApply://设置自己的后援团是否接受入团申请//hss5
					m_videoClient.GetVideoGuildClient().ForbidJoinApply(params.is_forbid);
					break;
//				case VideoWebOperationType.VOT_LoadVideoGuildTicketBoardPage://打开月票&粉丝牌标签页//hss6
//					m_videoClient.GetVideoGuildClient().LoadVideoGuildTicketBoardPage();
//					break;
				case VideoWebOperationType.VOT_GetLogRecordOfVideoGuild://获取后援团日志(排好序的，最新的在vector最后面)SetVideoGuildID//hss7
					m_videoClient.GetVideoGuildClient().GetLogRecordOfVideoGuild(Int64.fromJsonNode(params.vgid));
					break;
				case VideoWebOperationType.VOT_GetRenameVideoGuildCost://获得后援团重命名价格的接口，
					m_videoClient.GetVideoGuildClient().GetRenameVideoGuildCost();
					break;
				case VideoWebOperationType.VOT_GetChangeAnchorCost://获得后援团更改主播价格的接口，//hss11
					m_videoClient.GetVideoGuildClient().GetChangeAnchorCost();
					break;				
//				case VideoWebOperationType.VOT_ModifyFansBoardName://修改自己的粉丝牌名字，异步
//					m_videoClient.GetVideoGuildClient().ModifyFansBoardName(params.name);
//					break;
				case VideoWebOperationType.VOT_RequestWelfareDistribution://请求分屏福利积分
					m_videoClient.GetVideoGuildClient().requestWelfareDistribution(Int64.fromJsonNode(params.anchor_id),params.page,params.sortType);
					break;
				case VideoWebOperationType.VOT_ForbidTalk:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ForbidTalk(params.ban,params.perpetual,Int64.fromJsonNode(params.pstid));
					break;
				case VideoWebOperationType.VOT_ForbidTalkAllRoom:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ForbidTalkForAllRoom(Int64.fromJsonNode(params.playerId),params.ban)
					break;
				case VideoWebOperationType.VOT_LoadRoomInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadRoomInfo(params.roomid);
					break;
				case VideoWebOperationType.VOT_StartVip:
					if (params.vip_level == m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetVipLevel() 
						&& String(params.anchor_id) == m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetAttachedAnchorID()) {
						OnStartVip(0, 9, 0, 0, params.costtype, "", 0);
					} else {
						m_videoClient.GetCX5VideoClient().GetInterfacesForUI().StartVip(
							params.vip_level, params.duration, params.costtype, Int64.fromJsonNode(params.anchor_id));
					}
					break;
				case VideoWebOperationType.VOT_RenewalVip:
					if (params.vip_level != m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetVipLevel()) {
						OnRenewalVip(0, 9, 0, 0, params.costtype, "", 0);
					} else {
						m_videoClient.GetCX5VideoClient().GetInterfacesForUI().RenewalVip(
							params.vip_level, params.duration, params.costtype, Int64.fromJsonNode(params.anchor_id));
					}
					break;
				case VideoWebOperationType.VOT_TakeVipDailyReward:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().TakeVipDailyReward();
					break;
				case VideoWebOperationType.VOT_DianZan:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().DianZan();
					break;
				case VideoWebOperationType.VOT_LoadVideoVIPRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoVIPRank(params.begin_index,params.end_index);
					break;
				case VideoWebOperationType.VOT_LoadAnchorTwoweekStarlightRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoRoomAnchorTwoweekStarlightRank();
					break;
				case VideoWebOperationType.VOT_ReportAnchor://hss12
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ReportAnchor( params.type, params.content, null,Int64.fromJsonNode(params.anchor), params.anchor_name);
					OnReportAnchor();//举报主播回调
					break;		
				case VideoWebOperationType.VOT_CreateRole:
					if(params.nick.replace(/&nbsp;/g,"").length == 0 || params.nick.replace(/&nbsp/g,"").length == 0 || StringUtil.trim(params.nick).length == 0)
					{
						Globals.s_logger.debug("web user.nick:" + params.nick);
						var tojson:Object = new Object;
						tojson.op_type = VideoWebOperationType.VOT_CreateRole;
						tojson.res = 5;
						tojson.recommend_nick = params.nick;
						jscallback.Apply(tojson.op_type,tojson,false);
					}
					else
					{
						//增加is_auto_create参数，true表示是自动创建，false表示手动创建
						m_videoClient.GetCX5VideoClient().GetInterfacesForUI().CreateRole(params.nick,params.gender,params.nick_pool,params.nick_record_id,params.is_auto_create);
					}
					break;
				case VideoWebOperationType.VOT_FollowAnchor:
					m_videoClient.GetVideoClientPlayer().FollowAnchor(Int64.fromJsonNode(params.anchor_id), params.anchor_nick);
					break;
				case VideoWebOperationType.VOT_CancelFollowAnchor:
					m_videoClient.GetVideoClientPlayer().CancelFollowAnchor( Int64.fromJsonNode(params.anchor_id), params.anchor_nick);
					break;
				case VideoWebOperationType.VOT_LoadFollowingAnchorsInfo:
					m_videoClient.GetVideoClientPlayer().LoadFollowingAnchorInfos();
					break;
				case VideoWebOperationType.VOT_ConnectVideoVersion:
					Globals.s_logger.debug("进入128请求");
					Globals.login_opt = VideoWebOperationType.VOT_ConnectVideoVersion;
					Globals.deviceType = params.m_device_type;
					Globals.channel = params.m_channel;
					
					Globals.cookieQQ = params.qq;
					
					//直接链接roomproxy
					//{"m_skey":"","op_type":128,"m_device_type":2,"qq":0,"vertify_info":null,"m_channel":0,"m_appid":1600000566}
					var cm_qq:Number = params.qq;
					var cm_channel:int = params.m_channel;
					var cm_appid:int = params.m_appid;
					var cm_skey:String = params.m_skey;
					m_videoClient.GetCX5VideoClient().GetCallCenter().connectionClose();
					m_videoClient.GetCX5VideoClient().GetCallCenter().Init(cm_qq, null, 0, cm_appid, cm_skey);
					m_videoClient.GetCX5VideoClient().GetCallCenter().DoConnect();
//					if(params.qq == null)
//					{
//						Globals.s_logger.debug("接收参数   params.m_appid = " + params.m_appid);
//						if(params.m_appid)
//							m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ConnectVideoVersion(0,"",params.m_appid,"");
//					}
//					else
//					{
//						if (params.qq == 0 || params.qq == "0") {
//							Globals.isUsedGestLogin = true;
//							if(Globals.needClearGuestCookie){
//								this.m_videoClient.GetCX5VideoClient().GetCallCenter().ClearGuestCookieData(false);
//								Globals.needClearGuestCookie = false;
//							}
//						} else if (Globals.sVersionCallCenter != null) {
//							//防止使用第一次游客登录建立的连接
//							Globals.sVersionCallCenter.Disconnect();
//						}
//						if (params.hasOwnProperty("m_skey") && params.m_skey) {
//							Globals.s_logger.debug("接收参数   params.m_appid = " + params.m_appid + "    params.m_skey = " + params.m_skey);
//							m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ConnectVideoVersion(params.qq,params.vertify_info,params.m_appid,params.m_skey);
//						}
//						else
//						{
//							Globals.s_logger.debug("接收参数   params.m_appid = " + params.m_appid + "  params.m_skey = null");
//							m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ConnectVideoVersion(params.qq,params.vertify_info,params.m_appid,null);
//						}
//					}
					break;
				case VideoWebOperationType.VOT_GetPrivateInfoList:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetPrivateInfoList();
					break;
				//成员操作列表的请求
				case VideoWebOperationType.VOT_MemberOperationInfo:
					var memberId:Int64;
					if (params.hasOwnProperty("member_id")) {
						memberId = Int64.fromJsonNode(params.member_id);
					} else {
						memberId = new Int64();
					}
					var memberName:String = "";
					if (params.hasOwnProperty("name")) {
						memberName = params.name;
					}
					var zoneName:String = "";
					if (params.hasOwnProperty("zoneName")) {
						zoneName = params.zoneName;
					}
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadMemberOperationInfo(memberId, memberName, zoneName);
					break;
				//余额查询
				case VideoWebOperationType.VOT_QueryBalance:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().QueryBalance(params.save_num);
					break;
				//梦幻币余额查询
				case VideoWebOperationType.VOT_QueryVideoMoney:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().QueryVideoMoney();
					break;
				//加密头像url
				case VideoWebOperationType.VOT_EncryptPortraitUrl:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().EncryptPortraitUrl(params.url,0);
					break;
				case VideoWebOperationType.VOT_GetVipAddition:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetGiftPoolAdditionInfo();
					break;
				case VideoWebOperationType.VOT_CheckNick:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().CheckNick(params.nick);
					break;
				case VideoWebOperationType.VOT_IsStartedVote:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().IsStartVote();
					break;
				case VideoWebOperationType.VOT_HasVoted:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().HasVoted();
					break;
				case VideoWebOperationType.VOT_IsFollowedAnchor:
					m_videoClient.GetVideoClientPlayer().IsFollowingAnchor(Int64.fromJsonNode(params.AnchorID) );				
					break;
				case VideoWebOperationType.VOT_SetInvisible:
					m_videoClient.GetVideoClientPlayer().SetInvisible(params.invisible,params.client);				
					break;
				
				case VideoWebOperationType.VOT_LoadPreviewTreasureBoxData:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadPreviewTreasureBoxDataNewRole(params.box_id);				
					break;
				case VideoWebOperationType.VOT_GetImpressionIDName:
					OnGetImpressionIDAndName(AnchorImpressionIDToName.GetImpressionIDToName());
					break;
				case VideoWebOperationType.VOT_IgnorePlayer:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().IgnorePlayer( Int64.fromJsonNode(params.player_id),params.strNickName, params.strZoneName,  params.bAdd);
					break;
				case VideoWebOperationType.VOT_IsInIgnoreList:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().isInIgnoreList(params.strNickName,params.strZoneName);
					break;
				case VideoWebOperationType.VOT_LoadPlayerInfoForHomePage:
					requestPlayerCharInfo(params);				
					break;
				case VideoWebOperationType.VOT_LoadVideoLevelRank:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoLevelRank(params.begin_index,params.end_index);
					break;
				case VideoWebOperationType.VOT_LoadVideoRichRank:
					Globals.richRankRequestBeginIndex = params.begin_index;
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadVideoRichRank(params.begin_index,params.end_index,params.timedimension);
					break;
				case VideoWebOperationType.VOT_TakeDailyWageRes:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().TakeDailyWage();
					break;
				case VideoWebOperationType.VOT_GetAcitivityCenterInfos:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetActivityCenterInfos();
					break;
				case VideoWebOperationType.VOT_TakeVideoActivityRewards:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().TakeVideoActivityRewards(params.activity_id,params.category);
					break;
				case VideoWebOperationType.VOT_ModifyNick:
					m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().ModifyNick(params.nick,params.source_type,params.rand_nick_pool,params.nick_record_id);
					break;
				case VideoWebOperationType.VOT_DoRaffle:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().DoRaffle();
					break;
				case VideoWebOperationType.VOT_QueryRaffle:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().QueryRaffle();
					break;
				case VideoWebOperationType.VOT_SetDefaultDefinition:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SetDefaultDefinition(params.definition);
					break;
				case VideoWebOperationType.VOT_GetCurrentAvailableDefinition:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetCurrentAvailableDefinition();
					break;
				case VideoWebOperationType.VOT_GetCurrentDefinition:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetCurrentDefinition();
					break;
				case VideoWebOperationType.VOT_ChooseDefinition:
					setTimeout(m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ChooseDefinition,100,params.definition);
					break;
				case VideoWebOperationType.VOT_GetBuyTicketAndPicURL:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetBuyTicketAndPicURL();
					break;
				case VideoWebOperationType.VOT_ForbidPrivateChat://屏蔽私聊，除了主播和管理员
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().ForbidPrivateChat(params.forbid);
					var forbiden:int = params.forbid;
					onForbiePrivateChat(forbiden,0);
					break;
				case VideoWebOperationType.VOT_Logout://登出
					//页面发送登出请求后，都会刷新页面
//					Globals.isLogoutState = true;
					var cookie:Cookie = new Cookie("x51web");
					cookie.flushData(AccountCookieConst.LOGOUT_TIME, new Date().time);
					Globals.s_logger.localLog("接收到页面登出请求，后续操作。");
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().Logout("WEB Logout");
					break;
				case VideoWebOperationType.VOT_CheckCanEnterRoom://屏蔽私聊，除了主播和管理员
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().CanEnterRoom(params.roomid);
					break;		
				case VideoWebOperationType.VOT_GetConcertCurLeftTime://演唱会剩余时间
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetConcertCurLeftTime();
					break;		
				case VideoWebOperationType.VOT_GetSelfVipLevelAndRemainTime:////获取玩家自身的贵族等级和剩余时间
					GetSelfVipLevelAndRemainTime();
					break;
				case VideoWebOperationType.VOT_GetConnectStatus://获取连接状态
					OnGetConnectStatus();
					break;
				case VideoWebOperationType.VOT_ClearCookie://清理登陆缓存
					Globals.s_logger.localLog("ClearCookieData: 接收页面请求！");
					var cc_cookie:Cookie = new Cookie("x51web");
					CookieLog.addLogicClearLog(AccountCookieConst.SOURCE,
						"页面请求179清理缓存，qq(" + params.qq + ") cookieQQ(" + cc_cookie.getData(AccountCookieConst.QQ) + ")");
					this.m_videoClient.GetCX5VideoClient().GetCallCenter().ClearCookieData(params.qq);
					this.m_videoClient.GetCX5VideoClient().GetCallCenter().ClearGuestCookieData(false);
					break;
				case VideoWebOperationType.VOT_SetNoviceGuided://新手教学一次后，设置，以便下次判断不在进行新手教学
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SetNoviceGuided();
					break;
				case VideoWebOperationType.VOT_QueryDreamGift://请求梦幻币礼物数量 
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().QueryDreamGift();
					break;
				case VideoWebOperationType.VOT_ActivityCompletedCount://查询活动中心活动完成数量 
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetActivityCompleteCount();
					break;
				case VideoWebOperationType.VOT_GetFriendPayCashInfo://查询好友为自己充值的信息
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetFriendPayCashInfo();
					break;
				case VideoWebOperationType.VOT_GetPortraitUrl:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetPortraitUrl();
					break;
				case VideoWebOperationType.VOT_GetGiftEffectCnt:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetGiftEffectCnt();
					break;
				case VideoWebOperationType.VOT_GetFirstLoginRewardNotify:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetFirstLoginRewardNotify(params.real_login);
					break;
				case VideoWebOperationType.VOT_GetFirstLoginReward:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetFirstLoginReward();
					break;
				case VideoWebOperationType.VOT_GetSignDailyInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetSignDailyInfo();
					break;
				case VideoWebOperationType.VOT_SignInDaily:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SignInDaily();
					break;
				case VideoWebOperationType.VOT_GetCumulativeReward:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetCumulativeReward(params.accday);
					break;
				case VideoWebOperationType.VOT_SignDaliyNotify:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SignDaliyNotify();
					break;
				case VideoWebOperationType.VOT_GetGuestInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetGuestInfo();
					break;
				case VideoWebOperationType.VOT_Gift_ID_Array:
					if (giftIdArray && giftIdArray.length > 0) {
						var tojsonGift:Object = new Object;
						tojsonGift.op_type = VideoWebOperationType.VOT_Gift_ID_Array;

						tojsonGift.giftIdArray = giftIdArray;
						jscallback.Apply(tojsonGift.op_type, tojsonGift, false);
//						Globals.s_logger.debug("接收到 194 请求 返回giftIdArray = " + JSON.stringify(giftIdArray));
					}
					break;
				case VideoWebOperationType.VOT_QueryGuestCookie:
					this.m_videoClient.GetCX5VideoClient().QueryGuestCookie();
					break;
				case VideoWebOperationType.VOT_IsGuest:
					if(m_videoClient != null){
						this.m_videoClient.GetCX5VideoClient().QueryIsGuest();
					}
					break;
				case VideoWebOperationType.VOT_GetMembersCanBeDismissed:
					m_videoClient.GetVideoGuildClient().GetMembersCanBeDismissed();
					break;
				
				case VideoWebOperationType.VOT_LoadSupportInfo://加载捧场界面
					this.m_videoClient.GetNestClient().LoadSupportInfo(Int64.fromJsonNode(params.playerid));
					break;
				case VideoWebOperationType.VOT_SendNormalSupport://普通捧场
					this.m_videoClient.GetNestClient().SendNormalSupport(Int64.fromJsonNode(params.playerid));
					break;
				case VideoWebOperationType.VOT_TakeAnchorNestTask://领取小窝任务
					this.m_videoClient.GetNestClient().TakeNestTask();
					break;
				case VideoWebOperationType.VOT_GetNestGrowUp://获取成长信息
					this.m_videoClient.GetNestClient().GetNestGrowUpInfo();
					break;
				case VideoWebOperationType.VOT_GetGuardWage://领取守护工资奖励
					this.m_videoClient.GetNestClient().GetGuardWage();
					break;
				case VideoWebOperationType.VOT_GetNestList://获取旗下主播列表
					this.m_videoClient.GetNestClient().GetNestList();
					break;
				case VideoWebOperationType.VOT_TakeNestTreasureBox://领取人气宝箱奖励
					this.m_videoClient.GetNestClient().TakeNestTreasureBox();
					break;
				case VideoWebOperationType.VOT_QueryNestTreasureBoxReward://查询人气宝箱奖励
					this.m_videoClient.GetNestClient().QueryNestTreasureBox();
					break;
				case VideoWebOperationType.VOT_QueryNestTaskReward://查询团务奖励
					this.m_videoClient.GetNestClient().QueryNestTaskReward(params.index);
					break;
				case VideoWebOperationType.VOT_QuerySurpriseBoxReward://查询惊喜宝箱奖励
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadPreviewTreasureBoxDataNewRole(params.box_id,params.activity_id);
					break;
				case VideoWebOperationType.VOT_OpenQuerySurpriseBox://打开惊喜宝箱
					this.m_videoClient.GetSurpriseBoxMng().OpenSurpriseBox();
					break;
				case VideoWebOperationType.VOT_TakeRoomGuardSeat://守护抢座
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().TakeRoomGuardSeat(params.seatIndex,Int64.fromJsonNode(params.owner),params.cost);
					break;
				case VideoWebOperationType.VOT_GetAllTags://
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetAllTags(params.is_home);
					break;
				case VideoWebOperationType.VOT_GetRandNick://
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetRandNick(params.last_nick_pool,params.gender);
					break;
				case VideoWebOperationType.VOT_GetVideoRoomPicUrl://
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetVideoRoomPicUrl();
					break;
				case VideoWebOperationType.VOT_ForbidFreeGift:
					this.m_videoClient.GetCX5VideoClient().ForbiFreeGift(params.forbid);
					break;
				case VideoWebOperationType.VOT_GrabRedEnvelope://抢红包
					this.m_videoClient.GetCRedEnvelopeClient().GrapRedEnvelope(Int64.fromJsonNode(params.red_id));
					break;
				case VideoWebOperationType.VOT_LoadRedEnvelope://查看红包记录
					this.m_videoClient.GetCRedEnvelopeClient().LoadRedEnvelope(Int64.fromJsonNode(params.red_id));
					break;
				case VideoWebOperationType.VOT_RefreshAnchorLevelRank://刷新主播等级榜
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().RefreshAnchorLevelRank();
					break;
				case VideoWebOperationType.VOT_VideoStarGiftRankWeb:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().VideoStarGiftRankWeb();
					break;
				case VideoWebOperationType.VOT_VideoStarGiftChampionRankWeb:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().VideoStarGiftChampionRankWeb();
					break;
				case VideoWebOperationType.VOT_LoadAnchorStarGiftInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadAnchorStarGiftInfo(Int64.fromJsonNode(params.m_anchor_id));
					break;
				case VideoWebOperationType.VOT_TakeVipSeat:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().TakeVipSeat(params.cost, params.seat_index  );
					break;
				case VideoWebOperationType.VOT_GetSeatPriceResetNotice:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetSeatPriceResetNotice();
					break;
				case VideoWebOperationType.VOT_RefreshStarGiftInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetStarGiftInfo();
					break;
				case VideoWebOperationType.VOT_GrabDreamBox:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GrabDreamBox(Int64.fromJsonNode(params.box_id));
					break;
				case VideoWebOperationType.VOT_QueryDreamBoxRec:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().QueryDreamBoxRec(Int64.fromJsonNode(params.box_id),params.index);
					break;
				case VideoWebOperationType.VOT_NotifyVideoRoomLiveInfo:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetVideoRoomLiveInfo(params.roomID);
					break;
				case VideoWebOperationType.VOT_NotifyCheckNickOnLogin:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetCheckNickOnLogin();
					break;
				case VideoWebOperationType.VOT_IgnoreFreeGift:
					var ignore:Boolean = false;
					if (Object(params).hasOwnProperty("is_ignore")) {
						ignore = params["is_ignore"];
					}
					m_videoClient.GetCX5VideoClient().RequestIgnoreFreeGift(ignore);
					break;
				
				case VideoWebOperationType.VOT_VideoClientSigVerify:
					//m_videoClient.GetCX5VideoClient().GetInterfacesForUI().VideoClientSigVerify(params.appid,params.key);
//					Globals.sVersionCallCenter.connect(params.appid,params.key);
					m_videoClient.GetCX5VideoClient().GetCallCenter().ClientSigVerify(params.appid, params.key);
					break;

				case VideoWebOperationType.VOT_OpenLuckyDrawWindow:
					var begin_time:int = -1;
					if (params.hasOwnProperty("begin_time")) {
						begin_time = params["begin_time"];
					}
					var config_refresh_time:int = -1;
					if (params.hasOwnProperty("config_refresh_time")) {
						config_refresh_time = params["config_refresh_time"];
					}
					m_videoClient.GetCX5VideoClient().OpenLuckyDrawWindow(begin_time, config_refresh_time);
					break;
				case VideoWebOperationType.VOT_CloseLuckyDrawWindow:
					m_videoClient.GetCX5VideoClient().CloseLuckyDrawWindow();
					break;
				case VideoWebOperationType.VOT_LuckyDraw:
					var ld_begin_time:int = -1;
					if (params.hasOwnProperty("begin_time")) {
						ld_begin_time = params["begin_time"];
					}
					var ld_refresh_time:int = -1;
					if (params.hasOwnProperty("config_refresh_time")) {
						ld_refresh_time = params["config_refresh_time"];
					}
					m_videoClient.GetCX5VideoClient().LuckyDraw(
						params["is_free"], params["is_continuous"], ld_begin_time, ld_refresh_time);
					break;
				
				case VideoWebOperationType.VOT_GetPunchInInfo:
					m_videoClient.GetCX5VideoClient().GetPunchInInfo();
					break;
				case VideoWebOperationType.VOT_PunchIn:
					var punch_in_id:int= params["punch_in_id"];
					var today_index:int= params["today_index"];
					var day_index:int= params["day_index"]; 
					var retrieve:Boolean= params["retrieve"]; 
					var retrieve_price:int= params["retrieve_price"];
					m_videoClient.GetCX5VideoClient().PunchIn(punch_in_id, today_index, day_index, retrieve, retrieve_price);
					break;
				
				case VideoWebOperationType.VOT_RefreshRoomCharmRank:
					Globals.roomCharmRankBeginIndex = params.begin_index;
					m_videoClient.GetCX5VideoClient().LoadVideoRoomCharmRank(params.begin_index,params.end_index,params.timedimension);
					break;
				case VideoWebOperationType.VOT_QuerySkinGift:
					m_videoClient.GetCX5VideoClient().QuerySkinGift();
					break;
				case VideoWebOperationType.VOT_GET_SYSTEM_TIME:
					onGetSystemTime();
					break;
				case VideoWebOperationType.VOT_ViderRoomADClick:
					m_videoClient.GetCX5VideoClient().ADClick(params.ad_type, params.ad_site);
					break;
				case VideoWebOperationType.VOT_MISSION_GUIDE_OVER:
					m_videoClient.GetCX5VideoClient().sendMissionGuideOver();
					break;
				
				case VideoWebOperationType.VOT_RefreshPkGift:
					if(giftPKManage)
					{
						onRefreshPkGiftForUI(giftPKManage.videoPKGiftInfoListForUI);
					}
					break;
				case VideoWebOperationType.VOT_FinishEducation:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().handleFinishEducation(params.flag);
					break;
				case VideoWebOperationType.VOT_PlayerDrawSecretHeatBoxReward:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().sendPlayerDrawSecretHeatBoxReward(params.is_forbid_talk);
					break;
				case VideoWebOperationType.VOT_ConcertPlaybackRoomGetRoomList:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().concertPlaybackRoomGetRoomList(params.from, params.req_count);
					break;
				case VideoWebOperationType.VOT_StartConcertPlayback:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().startConcertPlayback(params.concert_id);
					break;
				case VideoWebOperationType.VOT_WeekStarNotifySucc:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().getWeekStarNotifySucc(params.flag);
					break;
				case VideoWebOperationType.VOT_WeekStarURLConfig:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().WeekStarConfigReq();
					break;
				case VideoWebOperationType.VOT_GetWeekStarRankList:
					m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetWeekStarRankList(params.sub_rank_name, params.begin_index, params.end_index);
					break;
			}
		}
		
		
		private function onLoadComplete(e:Event):void
		{
			var loader:Loader = (e.currentTarget as LoaderInfo).loader ;
			var _imageData:BitmapData = new BitmapData(stage.stageWidth, stage.stageHeight, true, 0xFFFFFFFF);
			_imageData.draw(loader);
			var m_image:Bitmap = new Bitmap(_imageData);
			this.addChild(m_image);
		}
		
		public function requestSendChatMsg(params:Object):void
		{		
			var tmpstr:String = ChatFormatUtil.IsAllSpace(params.msg);
			Globals.s_logger.debug("requestSendChatMsg: " + JSON.stringify(params));
			if(tmpstr == "")
			{
				return;
			}			
			var msg:String = ChatFormatUtil.WebChatFormatToX5ChatFormatV2(tmpstr);	
			var msg_trim:String = ChatFormatUtil.trimMsg(msg);
			m_videoClient.GetCX5VideoClient().GetInterfacesForUI().SendChatMsg(msg_trim, params.channelID, Int64.fromJsonNode(params.recver_id),params.receiverName,params.receiverZoneName);		
		}
		// 收到聊天信息 
		public function OnReceiveChatMsg(msg:VideoRoomMsgData):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OnReceiveChatMsg;
			tojson.msg = msg;
			tojson.chatnodes = ChatFormatUtil.X5ChatFormatToWebChatFormat(msg.msg);
			var self :Boolean = false;
			if(msg.senderName == m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetVideoNick() ) 
				self = true;//我发的
			tojson.isSelf = self;
			if( msg.receiverName == m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetVideoNick())
				self = true;//别人发给我的
			tojson.msg.senderName = msg.senderName.replace(/\\/g,"\\\\");
			tojson.msg.receiverName = msg.receiverName.replace(/\\/g,"\\\\");
			Globals.s_logger.debug("OnReceiveChatMsg page tojson = " + JSON.stringify(tojson));
			chatMsg.PushOpreCall(tojson,self);
		}
		//获得惊喜宝箱ui回调
		public function GetSurpriseBoxCallBack():IUISurpriseBox
		{
			return this;
		}
		
		private function QuerryCookie(params:Object):void
		{
		
			Globals.s_logger.debug("QuerryCookie()  params.qq = " + params.qq + "  params.zoonid =  "  + params.zoonid);
			
			Globals.guest_zoon_id = params.zoonid;
			
			var cookie:Cookie = new Cookie("x51web");
//			cookie.print();
			var zoneid:int = cookie.getData(AccountCookieConst.ZONE_ID);
				//cookie.getData("room_proxy_zoneid"+params.qq + "_" +params.zoonid);
			var qq:uint = cookie.getData(AccountCookieConst.QQ);
				//cookie.getData("qq"+params.qq + "_" +params.zoonid);
			Globals.s_logger.debug("QuerryCookie()  qq = " + qq);
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SetCookie;
			//tojson.channel = cookie.getData("channel"+params.qq + "_" +params.zoonid);
//			cookie.clearData(null);
			var hasAccountData:Boolean = cookie.getData(AccountCookieConst.HAS_ACCOUNT) != null;
			var hasAccount:Boolean = Boolean(cookie.getData(AccountCookieConst.HAS_ACCOUNT));
//			if(hasAccountData == false){
//				hasAccountData = cookie.getData("hasAccount" + params.qq + "0") != null;
//				hasAccount = cookie.getData("hasAccount" + params.qq + "0");
//			}else{
//				hasAccount = cookie.getData("hasAccount" + params.qq + "_" + params.zoonid);
//			}
			
			if(qq > 0 && (hasAccountData && hasAccount == false)){
				tojson.hasCookie = false;
				tojson.sameQQ = false;
				tojson.zoneid = 0;
			}
			else if(qq == 0)
			{
				tojson.hasCookie = false;
				tojson.sameQQ = false;
				tojson.zoneid = 0;
			}
			else if(params.qq != qq || params.zoonid != zoneid) 
			{
				tojson.hasCookie = true;
				tojson.sameQQ = false;
				tojson.zoneid = zoneid;
			}
			else 
			{
				tojson.hasCookie = true;
				tojson.sameQQ = true;
				tojson.zoneid = zoneid;
			}

			if(qq == 0)
			{
//				Globals.s_logger.localLog("ClearCookieData: 查询缓存，缓存内QQ=0");
//				this.m_videoClient.GetCX5VideoClient().GetCallCenter().ClearCookieData(0);
			}
			
			Globals.s_logger.debug("QuerryCookie.hasCookie:" + tojson.hasCookie);
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		public function OnRoomIsClosing():void
		{
			return ;
		}
		
		private function requestloadRoomlist(params:Object):void
		{
			m_videoClient.GetCX5VideoClient().GetInterfacesForUI().LoadRoomList(params.type, params.category, params.beginIndex, params.requestNum,params.module_type,params.tag,params.position,params.source);
		}
		
		private function ConnectProxyServer(params:Object):void
		{
			if(!params.hasOwnProperty("m_skey") ||  !params.m_skey || params.m_skey.length == 0)
				params.m_skey = "";
			
			Globals.deviceType = params.m_device_type;
			Globals.cookieQQ = params.qq;
			Globals.cookieZoonID = params.zoneid;
			Globals.zoonId = params.zoneid;
//			Globals.s_logger.test("ConnectProxyServer() Globals.deviceType = " + Globals.deviceType  + "   Globals.cookieQQ  = " + Globals.cookieQQ );
			if(params.qq != null && params.qq != "0" && params.qq != "" && params.qq != 0)
			{
				m_videoClient.GetCX5VideoClient().ConnectRoomProxy(Int64.fromJsonNode(params.qq),params.vertify_info,params.zoneid,true,params.channel,params.m_appid,params.m_skey);
			}
			else 
			{
				m_videoClient.GetCX5VideoClient().ConnectRoomProxy(Int64.fromJsonNode(params.qq),params.vertify_info,params.zoneid,false,params.channel,params.m_appid,params.m_skey);
			}
		}
		
		private function requestVideoAdUrl(params:Object):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetVideoADUrl;
			tojson.ret = VideoResultType.VREST_Normal;
			tojson.adurl = m_videoClient.GetCX5VideoClient().GetInterfacesForUI().GetVideoAdUrl();
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		private function requestPlayerCharInfo(params:Object):void {
			if (m_videoClient != null) {
				m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().SyncVideoClientPlayerInfo(true, params.reqtype);
			}
		}
		
		public function OnCreateRole(type:int,res:int,recommend_nick:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_CreateRole;
			tojson.res = res;
			tojson.recommend_nick = recommend_nick;
			if(tojson.res == 0 && Globals.cookieQQ != 0)
			{
				var cookie:Cookie = new Cookie("x51web");
				cookie.flushData(AccountCookieConst.HAS_ACCOUNT, true);
				//("hasAccount" + Globals.cookieQQ + "_" + Globals.cookieZoonID, true);
			}
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		public function OnLoadRoomList(type:int, category:int, rooms:Array, totalCount:int, room_id_name:Dictionary, nests:Array, tag:int, super_module_room_count:int, module_room_count:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadRoomList;
			tojson.ret = type;
			tojson.category = category;
			tojson.totalCount = totalCount;
			tojson.rooms = rooms;
			tojson.nests = nests;
			tojson.tag = tag;
			tojson.super_module_room_count = super_module_room_count;
			tojson.module_room_count = module_room_count;
			Globals.s_logger.debug("39786 page = " + JSON.stringify(tojson));
			//拉取房间信息的特殊处理
			jscallback.Apply(category +1000,tojson,false);
		}
		// 获得房间信息回调
		public function OnLoadRoomInfo(info:RoomInfoForUI):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadRoomInfo;
			tojson.info = info;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 刷新房间信息，通知房间内玩家
		public function RefreshRoomInfo(data:VideoRoomData):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshRoomInfo;
			tojson.data = data;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 刷新房间在线人数
		public function RefreshRoomPlayerCount(roomID:int , count:int , capacity:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshRoomPlayerCount;
			tojson.roomID = roomID;
			tojson.count = count;
			tojson.capacity = capacity;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//开通VIP通知 c++无任何调用
		public function NotifyPlayerStartVip(player_id:Int64, vip_level:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_PlayerStartVip;
			tojson.player_id = player_id.toString();
			tojson.vip_level = vip_level;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//VIP即将到期提醒
		public function NotifyVipLeftDay(level:int,left_day:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyVipLeftDay;
			tojson.level = level;
			tojson.left_day = left_day;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//VIP过期提醒
		public function NotifyVipExpired(level:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_VipExpired;
			tojson.level = level;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 进入房间回调
		public function NotifyEnterRoomRes(type:int, res:int , info:UIEnterVideoRoomInfo):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_EnterRoom;
			tojson.ret = type;
			tojson.res = res;
			tojson.info = info;
			Globals.s_logger.debug("NotifyEnterRoomRes duc_flag = " + tojson.info.concert_id);
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 退出房间回调
		public function NotifyLeaveRoomRes(status:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LeaveRoom;
			tojson.status = status;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取主播名片信息
		public function OnLoadAnchorInfocard(type:int,succ:Boolean,data:AnchorInfocard,guardRuleUrl:String,isFollow:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorInfocard;
			tojson.succ = succ;
			tojson.data = data;
			tojson.guardRuleUrl = guardRuleUrl;
			tojson.isFollow = isFollow;
			Globals.s_logger.debug("OnLoadAnchorInfocard page tojson =  " + JSON.stringify(tojson));
			//使用新接口
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		// 获得玩家列表 param: pageCount为总页数
		public function OnLoadPlayerList(type:int,roomID:int,players:Array, pageCount:int,playerid:Int64):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadPlayerList;
			tojson.ret = type;
			tojson.roomID = roomID;
			tojson.players = players;
			tojson.pageCount = pageCount;
			tojson.playerid = playerid.toString();
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取宝箱数据回调
		public function OnLoadTreasureBoxData(type:int,res:int, roomID:int,boxid:int, data:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadTreasureBoxData;
			tojson.type = type;
			tojson.res = res;
			tojson.roomID = roomID;
			tojson.boxid = boxid;
			tojson.data = data;
			giftpoolhigh17.PushOpreCall(tojson);
		}
		
		// 开启宝箱回调
		public function OnOpenTreasureBoxRes(res:int, roomID:int,boxIndex:int,index:int, box_items:Array,reward:VideoRoomBoxReward):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OpenTreasureBox;
			tojson.res = res;
			tojson.roomID = roomID;
			tojson.boxIndex = boxIndex;
			tojson.index = index;
			tojson.box_items = box_items;
			tojson.reward = reward;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		// 获取主播亲密度排行榜
		public function OnLoadAnchorAffinityRank(type:int, rank:Array,timedimension:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorAffinityRank;
			tojson.rank = rank;
			tojson.timedimension = timedimension;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 送礼结果回调
		public function OnSendGiftRes(type:int, result:SendVideoGiftResultInfo, qq:Int64,xuandou:int,video_money:int,gift_id:int,gift_cnt:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SendGift;
			tojson.ret = type;
			tojson.result = result;
			tojson.xuandou = xuandou;
			tojson.video_money = video_money;
			tojson.qq = qq.toString();
			tojson.gift_id = gift_id;
			tojson.gift_cnt = gift_cnt;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 礼物消息广播
		public function OnReceiveGift(gift:GiftData,isSelf:Boolean = false):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ReceiveGift;
			tojson.gift = gift;
			tojson.isSelf = isSelf;
			jscallback.Apply(tojson.op_type,tojson,false);
//			giftopt.PushOpreCall(tojson,isSelf);
		}
		// 有人送礼后刷新主播的星耀等值
		public function RefreshAnchorStarLightAndPopular(star:Int64, popular:Int64):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshAnchorStarLightAndPopular;
			tojson.star = star.toString();
			tojson.popular = popular.toString();
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnGiftMsgBatch(giftMsgs:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GiftMsgBatch;
			tojson.giftMsgs = giftMsgs;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 免费礼物获得通知
		// giftNum 当前拥有的免费礼物数量
		// leftTime 下次获得剩余时间，单位 ms, -1代表不再送
		public function RefreshFreeGiftInfo(giftNum:int, leftTime:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshFreeGiftInfo;
			tojson.giftNum = giftNum;
			tojson.leftTime = leftTime;
			
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		// 送礼超过一定数量通知全部房间滚动播出
		public function ShowSendGiftScreenScrollMsg(info:VideoRoomScreenScrollInfo):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ShowSendGiftScreenScrollMsg;
			tojson.info = info;
			giftnptify.PushOpreCall(tojson);
		}
		// 一定级别的贵族(皇帝)进入房间消息全部房间滚动播出
		public function ShowVipEnterRoomScreenScrollMsg(player_name:String,room_name:String,room_id:int,viplevel:int,guard_level:int,zone_name:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ShowVipEnterRoomScreenScrollMsg;//40
			tojson.player_name = player_name;
			tojson.room_name = room_name;
			tojson.room_id = room_id;
			tojson.viplevel = viplevel;
			tojson.guard_level = guard_level;
			tojson.zone_name = zone_name;
			vipenter.PushOpreCall(tojson);		
		}

		/**
		 * 守护进房间提示
		 * 	没有引用，已弃用，使用VOT_VipEnterRoom消息。
		 * @param player_name
		 * @param player_zone
		 * @param guard_level
		 * @param invisible
		 * 
		 */		
		public function GuardEnterRoomNotify(player_name:String,player_zone:String,guard_level:int, invisible:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GuardEnterRoom;
			tojson.player_name = player_name;
			tojson.player_zone = player_zone;
			tojson.guard_level = guard_level;
			tojson.invisible = invisible;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//梦工厂VIP入场公告
		public function NotifyVipEnterRoom(player_name:String,player_zone:String,vip_level:int,sex_male:Boolean,invisible:Boolean,isSelf:Boolean,guard_level:int,wealth_level:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_VipEnterRoom;
			tojson.player_name = player_name;
			tojson.player_zone = player_zone;
			tojson.vip_level = vip_level;
			tojson.sex_male = sex_male;
			tojson.invisible = invisible;
			tojson.guard_level = guard_level;
			tojson.wealth_level = wealth_level;
			tojson.isSelf = isSelf;//是否是自己进房
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获得在线列表搜索结果
		public function OnSearchOnlinePlayerRes(type:int, search_res:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SearchOnlinePlayer;
			tojson.ret = type;
			tojson.search_res = search_res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 投票的结果
		public function OnTakeVoteRes(type:int, errcode:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeVote;
			tojson.ret = type;
			tojson.errcode = errcode;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 返回房间的投票内容、自己的选择
		public function OnGetVideoStartInfo(type:int, errcode:int, vote_info:VideoVoteInfoForUI, select:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetVoteStartInfo;
			tojson.ret = type;
			tojson.errcode = errcode;
			tojson.vote_info = vote_info;
			tojson.select = select;
			
			jscallback.Apply(tojson.op_type,tojson,false);	
		}
		// 获得推荐房间结果
		public function OnLoadRecommendVideoRoomResult(type:int , res_type:int , recommend_info:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadRecommendVideoRoomResult;
			tojson.ret = type;
			tojson.res_type = res_type;
			tojson.recommend_info = recommend_info;
			
			jscallback.Apply(tojson.op_type,tojson,false);	
		}
		// 发送聊天消息结果回调，set_cd_time:聊天间隔时间 wait_time：需等待时间，两者单位均为毫秒，一般失败时会调用到
		public function OnSendChatMsgRes(type:int, result:VideoChatErrorInfo, set_cd_time:int, wait_time:int,xuandou:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SendChatMsg;
			tojson.ret = type;
			tojson.result = result;
			tojson.set_cd_time = set_cd_time;
			tojson.wait_time = wait_time;
			tojson.xuandou = xuandou;			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//请求vip价格结果回调
		public function OnGetVipPrice(info:VipPriceInfoForUI, rebate_info:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetVipPrice;
			var objInfo:Object = new Object;
			objInfo.start_price_list = new Object;
			for (var itr:Object in info.start_price_list) {
				objInfo.start_price_list[itr] = info.start_price_list[itr];
			}

			objInfo.renewal_price_list = new Object;
			for (var itr1:Object in info.renewal_price_list) {
				objInfo.renewal_price_list[itr1] = info.renewal_price_list[itr1];
			}
			tojson.info = objInfo;
			tojson.rebate_info = rebate_info;

			jscallback.Apply(tojson.op_type, tojson, false);
		}
		//刷新免费飞屏数量
		public function OnQueryFreeWhistleLeft(count:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryFreeWhistleLeft;
			tojson.count = count;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//踢人回调
		public function OnKickPlayer(res:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_KickPlayer;
			tojson.res = res;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 被踢出房间通知，reason枚举类型为VideoRoomBeKickedReason
		public function NotifyBeKicked(reason:int,device_type:int):void
		{
			m_BeKicked = true;
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_BeKicked;
			tojson.reason = reason;
			tojson.device_type = device_type;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 刷新房间节目表,
		public function RefreshRoomSchedule(schedule:String):void
		{
			//var tojson:Object = new Object;
			//tojson.op_type = VideoWebOperationType.VOT_RefreshRoomSchedule;
			//tojson.schedule = schedule;
					
			//jscallback.Apply(tojson.op_type,str);
		}
		//获取免费超新星数量回调
		public function OnQueryFreeSuperStarHornLeft(count:int ):void
		{
			
		}

		//开通VIP结果回调
		public function OnStartVip(type:int, errcode:int, videomoney:int, xuandou:int,
			cost_type:int, anchor_name:String, rebate:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_StartVip;
			tojson.type = type;
			tojson.errcode = errcode;
			tojson.videomoney = videomoney;
			tojson.xuandou = xuandou;
			tojson.cost_type = cost_type;
			tojson.anchor_name = anchor_name;
			tojson.rebate = rebate;

			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//续费VIP结果回调
		public function OnRenewalVip(type:int, errcode:int, videomoney:int, xuandou:int,
			cost_type:int, anchor_name:String, rebate:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RenewalVip;
			tojson.type = type;
			tojson.errcode = errcode;
			tojson.videomoney = videomoney;
			tojson.xuandou = xuandou;
			tojson.cost_type = cost_type;
			tojson.anchor_name = anchor_name;
			tojson.rebate = rebate;

			jscallback.Apply(tojson.op_type, tojson, false);
		}
		//加载梦工厂名片回调 
		public function OnGetPlayerVideoCardInfo(type:int, card_info:VideoVipPlayerCardInfoForUI,result:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetPlayerVideoCardInfo;
			tojson.type = type;
			tojson.card_info = card_info;
			tojson.result = result;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//上传梦工厂头像回调
		public function OnUploadPlayerVideoCardPortrait(errcode:int ,pUrl:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_UploadPlayerVideoCardInfo;
			tojson.errcode = errcode;
			tojson.pUrl = pUrl;		
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//修改梦工厂名片个人签名回调
		public function OnModifyPlayerVideoCardSignature(errcode:int , signature:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifyPlayerVideoCardInfo;
			tojson.errcode = errcode;
			tojson.signature = signature;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//领取VIP每日福利回调
		public function OnTakeVipDailyReward(type:int, errcode:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeVipDailyReward;
			tojson.type = type;
			tojson.errcode = errcode;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 禁言回调
		public function OnForbidTalk(res:int):void
		{
			
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ForbidTalk;
			tojson.res = res;
			Globals.s_logger.debug("OnForbidTalk res = " + res);
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 全房间禁言系统消息
		public function OnForbidTalkAllRoom(success:Boolean,nick:String,zone:String,ban:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ForbidTalkAllRoom;
			tojson.success = success;
			tojson.nick = nick;
			tojson.zone = zone;
			tojson.ban = ban;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//玩家被禁言/取消禁言的通知
		public function NotifyPlayerForbiddenTalk(
			playerID:Int64, 
			targetName:String, 
			targetZoneName:String, 
			perpetual:Boolean, 
			forbid:Boolean,
			opName:String,
			opZoneName:String,
			opGuardLevel:int,
			targetGuardLevel:int,
			opVipLevel:int,
			targetVipLevel:int
		):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_PlayerForbiddenTalk;
			tojson.playerID = playerID.toString();
			tojson.targetName = targetName;
			tojson.targetZoneName = targetZoneName;
			tojson.perpetual = perpetual;
			tojson.forbid = forbid;
			tojson.opName = opName;
			tojson.opZoneName = opZoneName;
			tojson.opGuardLevel = opGuardLevel;
			tojson.targetGuardLevel = targetGuardLevel;
			tojson.opVipLevel = opVipLevel;
			tojson.targetVipLevel = targetVipLevel;
					
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//设置或取消评委回调
		public function OnSetTalentShowJudgeResult(result:int):void
		{
			
		}
		//打分广播
		public function OnScoreTalentShowBroadcast(scores:Array,guard_levels:Array,vip_levels:Array):void
		{
			
		}
		//加载当前打分情况回调
		public function OnLoadTalentShowScore(type:int, res:int,scores:Array,vote_cnt:int ):void
		{
			
		}
		//开始比赛回调
		public function OnStartTalentShow(result:int ):void
		{
			
		}
		//停止比赛回调
		public function OnStopTalentShow(result:int):void
		{
			
		}
		//舞团争霸 点赞回调
		public function OnDianZanResult(type:int, res:int ,anchor_name:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_DianZan;
			tojson.type = type;
			tojson.res = res;
			tojson.anchor_name = anchor_name;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取主播星耀值排行榜
		public function OnLoadAnchorStarlightRank(res:int,rank:AnchorStarlightRankData,timedimension:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorStarlightRank;
			tojson.res = res;
			tojson.rank = rank;
			tojson.timedimension = timedimension;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取主播人气值排行榜
		public function OnLoadAnchorPopularityRank(type:int , res:int ,rank : AnchorStarlightRankData):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoRoomAnchorPopularityRank;
			tojson.ret = type;
			tojson.res = res;
			tojson.rank = rank;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//加载小屋主播积分排行榜回调
		public function OnLoadStarAnchorScoreRank(type:int, res:int, rank:Array,url:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadStarAnchorScoreRank;
			tojson.ret = type;
			tojson.res = res;
			tojson.rank = rank;
			tojson.url = url;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//舞团争霸排行榜
		public function OnLoadGuildChampionRank(type:int, res:int,rank:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadGuildChampionRank;
			tojson.ret = type;
			tojson.res = res;
			tojson.rank = rank;
						
			jscallback.Apply(tojson.op_type,tojson,false);			
		}
		
		// (video guild)主播积分榜返回
		public function OnLoadAnchorScoreRank(type:int,rank:Array,timedimension:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorScoreRank;
			tojson.ret = type;
			tojson.rank = rank;
			tojson.timedimension = timedimension;			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// (video guild)后援团排行榜返回
		public function  OnLoadVideoGuildRank(type:int,rank:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoGuildRank;
			tojson.ret = type;
			tojson.rank = rank;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取优胜主播排行榜
		public function OnLoadAnchorPKWinnerRank(type:int, rank:Array, show_end_time:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorPKWinnerRank;
			tojson.ret = type;
			tojson.rank = rank;
			tojson.show_end_time = show_end_time;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取英豪排行榜
		public function OnLoadAnchorPKRichManRank(type:int, rank:Array, show_end_time:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorPKRichManRank;
			tojson.ret = type;
			tojson.rank = rank;
			tojson.show_end_time = show_end_time;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//贵族排行榜
		public function OnLoadVideoVIPRank(type:int , rank:Array, total_size:int,  my_rank:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoVIPRank;
			tojson.type = type;
			tojson.rank = rank;
			tojson.total_size = total_size;
			tojson.my_rank = my_rank;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//双周星耀值排行榜
		public function OnLoadAnchorTwoweekStarlightRank(type:int ,res:int, rank:AnchorStarlightRankData ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorTwoweekStarlightRank;
			tojson.type = type;
			tojson.res = res;
			tojson.rank = rank;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//财富排行榜回调
		public function OnLoadVideoRichRank(type:int, rank:Array, total_size:int , my_rank:int,timedimension:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoRichRank;
			tojson.type = type;
			tojson.rank = rank;
			tojson.total_size = total_size;
			tojson.my_rank = my_rank;
			tojson.timedimension = timedimension;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 视频等级排行榜回调
		public function OnLoadVideoLevelRank(type:int, rank:Array, total_size:int , my_rank:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoLevelRank;
			tojson.type = type;
			tojson.rank = rank;
			tojson.total_size = total_size;
			tojson.my_rank = my_rank;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 刷新贵宾席回调
		public function OnLoadVipSeats( res:int,data:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVipSeat;
			tojson.ret = VideoResultType.VREST_Normal;
			tojson.data = data;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 刷新超级粉丝回调
		public function OnLoadSuperFans(fanstype:int, res:int,  data:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadSuperFans;
			tojson.ret = VideoResultType.VREST_Normal;
			tojson.fanstype = fanstype;
			tojson.data = data;
			superfans.PushOpreCall(tojson);
		}
		
		private var clientAnchorData:ClientAnchorData = new ClientAnchorData();

		/**
		 * 更新主播信息
		 * 注意：CVideoRoomClient.HandleCEventVideoRoomRefreshCurrentAnchorDetail方法中也有更新缓存本地数据问题。注意同步。
		 * @param data
		 * @param isFollow
		 * @param roomName
		 *
		 */
		public function RefreshAnchorInfoByData(data:ClientAnchorData,isFollow:Boolean, roomName:String):void
		{
			var bRefresh:Boolean = false;
			Globals.s_logger.debug("RefreshAnchorInfoByData()  data.popularity = " + data.popularity + "   clientAnchorData.popularity =  " + clientAnchorData.popularity  + "  data.startlight" + data.starlight + " clientAnchorData.startlight = " +clientAnchorData.starlight);
			if(data.anchorID != clientAnchorData.anchorID)
			{
				bRefresh = true;
			}
			//XW79794 去除头像随机数  主播头像变化更新数据
			else if (data.photoUrl != clientAnchorData.photoUrl) {
				bRefresh = true;
			}
			else if(data.anchor_badge != clientAnchorData.anchor_badge)
			{
				bRefresh = true;
			}
			//XW79541 人气的时候只刷大的不刷小
			else if(data.popularity > clientAnchorData.popularity)
			{
				bRefresh = true;
			}
			else if(data.starlight > clientAnchorData.starlight)
			{
				bRefresh = true;
			}
			else if(data.followedAudiences != clientAnchorData.followedAudiences){
				bRefresh = true;
			}
			else if(data.anchor_level != clientAnchorData.anchor_level)
			{
				if(data.anchor_level > clientAnchorData.anchor_level) {
					bRefresh = true;
				}
			}
			else if(data.followedAudiences != clientAnchorData.followedAudiences){
				bRefresh = true;
			}
			else if(data.lucky_draw_rest_exp_today != clientAnchorData.lucky_draw_rest_exp_today){
				bRefresh = true;
			}
			else if (data.anchor_level == clientAnchorData.anchor_level)
			{
				//主播达到瓶颈后exp会归0，瓶颈属性会有新的赋值。
				//非瓶颈状态bottleneck_count=-1、bottleneck_need_count=0
				//优先判断是否是瓶颈
				if (data.is_bottleneck != clientAnchorData.is_bottleneck) {
					//如果新数据是进入瓶颈期，则刷新数据
					if (data.is_bottleneck) {
						bRefresh = true;
					}
				} else {
					if (data.anchor_exp > clientAnchorData.anchor_exp) {
						bRefresh = true;
					} else if (data.anchor_exp == clientAnchorData.anchor_exp) {
						if ((data.bottleneck_count > clientAnchorData.bottleneck_count) || (int(data.starlight) > int(clientAnchorData.starlight))) {
							bRefresh = true;
						} else if (clientAnchorData.anchor_levelup_exp <= 0 && data.anchor_levelup_exp > clientAnchorData.anchor_levelup_exp) {
							bRefresh = true;
						}
					} else {
						//防坑判断
						if (data.bottleneck_count >= 0 && data.bottleneck_need_count > 0
							&& clientAnchorData.bottleneck_need_count <= 0) {
							bRefresh = true;
						}
					}
				}

//				if(clientAnchorData.anchor_levelup_exp <= 0 && data.anchor_levelup_exp > clientAnchorData.anchor_levelup_exp){
//					bRefresh = true;
//				}
			}
			
			//修复切换主播会不刷新问题，注释掉下面的代码。
			//等级变小不刷新
//			if(data.anchor_level < clientAnchorData.anchor_level)
//			{
//				bRefresh = false;
//			}
			
			if(bRefresh || clientAnchorData.is_basic_info)
			{
				updateData(data);
			}
			
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshAnchorInfo;
			tojson.ret = VideoResultType.VREST_Normal;
			tojson.data = clientAnchorData;
			tojson.isFollow = isFollow;
			tojson.roomName = roomName;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function updateData(data:ClientAnchorData):void
		{
			clientAnchorData.male = data.male;//性别
			clientAnchorData.followedAudiences = data.followedAudiences;
			clientAnchorData.anchorID = data.anchorID;// 主播ID，不同于游戏内角色ID
			clientAnchorData.anchorQQ = data.anchorQQ; // 主播QQ号
			clientAnchorData.gameID = data.gameID; //游戏内对应的gameID
			clientAnchorData.popularity = data.popularity;// 人气值
			clientAnchorData.starlight = data.starlight;// 星耀值
			clientAnchorData.twoweek_starlight = data.twoweek_starlight;// 双周星耀值
			clientAnchorData.intro = data.intro;
			clientAnchorData.name = data.name;
			clientAnchorData.from = data.from; // 籍贯
			clientAnchorData.photoUrl = data.photoUrl; // 头像url
			clientAnchorData.imageUrl = data.imageUrl; // 照片url
			clientAnchorData.deputy_name = data.deputy_name;  //副麦名字
			clientAnchorData.deputy_zone_name = data.deputy_zone_name;  //副麦大区名字	
			clientAnchorData.talent_show_rank = data.talent_show_rank;     //全民选秀主播的名次
			clientAnchorData.star_anchor = data.star_anchor; //是否是星级主播
			clientAnchorData.anchor_score = data.anchor_score;     //主播积分。后援团系统中的那个
			clientAnchorData.m_pk_anchor_winner_order = data.m_pk_anchor_winner_order;	//优胜主播排名 AnchorPKOrder
			clientAnchorData.m_starlight_today_needed = data.m_starlight_today_needed;	//当天还需要的星耀值
			clientAnchorData.m_impression_data = data.m_impression_data;//主播印象数据
			clientAnchorData.status = data.status;
			clientAnchorData.room_id = data.room_id;
			clientAnchorData.anchor_gender =  data.anchor_gender;//主播性别 0女1男
			clientAnchorData.is_nest = data.is_nest;//是否是小窝房间
			clientAnchorData.is_anchor_with_dance_mark = data.is_anchor_with_dance_mark;
			clientAnchorData.order_change = data.order_change;//名次变化0 无变化，大于零表示上升，小于0表示下降
			clientAnchorData.anchor_level = data.anchor_level;//主播等级
			clientAnchorData.anchor_exp = data.anchor_exp;//主播经验值
			clientAnchorData.anchor_levelup_exp = data.anchor_levelup_exp;//主播升级所需经验
			clientAnchorData.is_bottleneck = data.is_bottleneck;//是否是瓶颈期
			clientAnchorData.bottleneck_count = data.bottleneck_count;//已送数量
			clientAnchorData.bottleneck_need_count = data.bottleneck_need_count;//突破需要的礼物数量
			clientAnchorData.bottleneck_gift_id = data.bottleneck_gift_id;//突破评价需要的礼物id
			clientAnchorData.starlight_rest_exp_today = data.starlight_rest_exp_today;//通过涨星耀值还可增加的主播经验
			clientAnchorData.dream_gift_rest_exp_today = data.dream_gift_rest_exp_today;//收梦幻币礼物还可增加的主播经验
			clientAnchorData.anchor_badge = data.anchor_badge;
			clientAnchorData.lucky_draw_rest_exp_today = data.lucky_draw_rest_exp_today;
		}
		
		// 刷新房间内礼物池高度(即热度值)
		public function RefreshGiftPoolHeight(curHeight:int, maxHeight:int,vip_addition:int,vip_cnt_info:Array,box_data_buf:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshGiftPoolHeight;
			tojson.curHeight = curHeight;
			tojson.maxHeight = maxHeight;
			tojson.vip_addition = vip_addition;
			tojson.vip_cnt_info = vip_cnt_info;
			tojson.box_data_buf = box_data_buf;
			Globals.s_logger.debug("RefreshGiftPoolHeight page res = " + JSON.stringify(tojson));
			giftpoolhigh.PushOpreCall(tojson);
//			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 刷新房间状态
		public function RefreshRoomStatus(status:int,isConcert:Boolean,isHasTicket:Boolean,isSpecialRoom:Boolean,width:int,height:int,anchor_device_type:int,vertical_live:Boolean):void 
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshRoomStatus;
			tojson.status = status;
			tojson.isConcert = isConcert;
			tojson.isHasTicket = isHasTicket;
			tojson.isSpecialRoom = isSpecialRoom;
			tojson.width = width;
			tojson.height = height;
			tojson.anchor_device_type = anchor_device_type;
			tojson.vertical_live = vertical_live;
			Globals.s_logger.debug("RefreshRoomStatus tojson.status = " + JSON.stringify(tojson.status));
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		private function RefreshRoomStatus1():void
		{
			jscallback.Apply(arguments[0],arguments[1],arguments[2]);
		}
		
		// 刷新房间名
		public function RefreshRoomName(room_name:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshRoomName;
			tojson.room_name = room_name;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//开始直播
		public function OnStartVideoLive(cdnUrls:Array,res:int,isConcert:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_StartVideoLive;
			tojson.ret = VideoResultType.VREST_Normal;
			tojson.cdnUrls = cdnUrls;
			tojson.res = res;
			tojson.isConcert = isConcert;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		
		//停止直播
		public function OnStopVideoLive():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_StopVideoLive;
			tojson.ret = VideoResultType.VREST_Normal;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function GetVideoGuildCallback():IUIVideoGuild
		{
			return this;
		}
		//主播获取印象信息
		public function OnLoadAnchorImpressionForAnchor(type:int,data:Array,total_count:int,player_count:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorImpressionForAnchor;
			tojson.ret = type;
			tojson.data = data;
			tojson.total_count = total_count;
			tojson.player_count = player_count;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//玩家获取主播印象信息
		public function OnLoadAnchorImpressionForPlayer(type:int,data:Array,anchorid:Number,status:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorImpressionForPlayer;
			tojson.ret = type;
			tojson.data = data;
			tojson.anchorid = anchorid;
			tojson.status = status;	
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//编辑主播印象
		public function OnEditAnchorImpressionForPlayer(res:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_EditAnchorImpressionForPlayer;
			tojson.res = res;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//通知客户端播放宝箱特效
		public function PlayOpenTreasureBoxEffect(index:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_PlayOpenTreasureBoxEffect;
			tojson.index = index;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//关注收到发布任务通知
		public function ListenerRecvNestTaskPublish():void
		{
			
		}
		
		//发布主播任务，玩家在房间的回调, is_show表示显示或者隐藏，need_show_special表示显示的时候是否需要显示特效
		public function AudienceOnPublishAnchorTask(is_show:Boolean, need_show_special:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_PublishAnchorTask;
			tojson.is_show = is_show;
			tojson.need_show_special = need_show_special;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//接收主播任务返回
		public function OnTakeAnchorTaskRes(res:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeAnchorTask;
			tojson.res = res;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//放弃主播任务返回
		public function OnDropAnchorTaskRes(res:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_DropAnchorTask;
			tojson.res = res;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//主播离开房间或者下麦导致主播任务消失
		public function OnAnchorStopLive():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_AnchorStopLive;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//凌晨两点清理任务
		public function OnRemoveAnchorTask():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RemoveAnchorTask;
						
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//IVideoClientPlayerOPCallback================================================================
		public function OnFollowAnchorRes(type:int, res:int, anchorID:Int64, anchor_nick:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_FollowAnchor;
			tojson.ret = type;
			tojson.res = res;
			tojson.anchorID = anchorID.toString();
			tojson.anchor_nick = anchor_nick.replace(/\\/g,"\\\\");
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnCancelFollowAnchor(type:int, res:int, anchorID:Int64, anchor_nick:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_CancelFollowAnchor;
			tojson.ret = type;
			tojson.res = res;
			tojson.anchorID = anchorID.toString();
			tojson.anchor_nick = anchor_nick.replace(/\\/g,"\\\\");
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//获取玩家关注的主播信息
		public function OnLoadFollowingAnchorsInfo(type:int, infos:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadFollowingAnchorsInfo;
			tojson.ret = type;
			tojson.infos = infos;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//刷新玩家角色信息
		public function OnRefreshVideoClientCharInfo(type:int, sync_res:Boolean, charinfo:VideoClientCharInfo):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshPlayerCharInfo;
			tojson.ret = type;
			tojson.sync_res = sync_res;
			tojson.charinfo = charinfo;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 设置隐身状态
		public function OnSetVisibleRes(type:int, res:int, invisble:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SetInvisible;
			tojson.type = type;
			tojson.res = res;
			tojson.invisble = invisble;
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		//IUISurpriseBox============================================================================
		//更新惊喜宝箱数据
		public function OnUpdateSurpriseBoxStatus(activity_id:int,active:Boolean, percent:int, left_open_box_times:int, cd_seconds:int, need_flower_count:int,total_cd_seconds:int,nest_left_open_times:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_UpdateSurpriseBoxStatus;
			tojson.active = active;
			tojson.percent = percent;
			tojson.left_open_box_times = left_open_box_times;
			tojson.cd_seconds = cd_seconds;
			tojson.need_flower_count = need_flower_count;
			tojson.activity_id = activity_id;
			tojson.total_cd_seconds = total_cd_seconds;nest_left_open_times
			tojson.nest_left_open_times = nest_left_open_times;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//查询惊喜宝箱奖励
		public function OnQuerySurpriseBoxReward(reward:Array,buff_percent:int,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QuerySurpriseBoxReward;
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for ( var index:int =0 ; index < reward.length; index ++)
			{
				var rew:BoxRewardDataForUI = reward[index];
				if( VideoChannelType.IsQueryReaward( rew.channel ))
					newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.rewardType,rew.rewardId,rew.rewardCount));
			}
			tojson.reward = newRewards;
			tojson.buff_percent = buff_percent;
			tojson.hasgame = gameindex>0 ?true:false;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//打开惊喜宝箱奖励
		public function OnOpenSurpriseBoxResult(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OpenQuerySurpriseBox;
			tojson.result= result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//发放惊喜宝箱奖励
		public function OnGetSurpriseBoxReard(reward:Array,buff_percent:int,is_reissue:Boolean,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetSurpriseBoxRewadr;
			tojson.buff_percent = buff_percent;
			tojson.is_reissue = is_reissue;
			
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for ( var index:int =0 ; index < reward.length; index ++)
			{
				var rew:BoxRewardForUI = reward[index];
				if( VideoChannelType.IsQueryReaward(rew.channel))
					newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.reward_type,rew.reward_id,rew.reward_cnt));
			}
			tojson.reward = newRewards;
			tojson.hasgame = gameindex>0 ?true:false;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//IUIVideoGuild=============================================================================
		
		//加载舞团列表LoadVideoGuildList的回调
		public function OnLoadVideoGuildList(video_guilds:Array,total_count:int ,page:int,result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoGuildList;
			tojson.video_guilds = video_guilds;
			tojson.total_count = total_count;
			tojson.page = page;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//查看我的后援团界面
		public function OnLoadMyVideoGuild(result:int, info:VideoGuildInfoForUI ,self_info:VideoGuildMemberInfoForUI ,anchor_score:int ,anchor_rank:int ,members:Array ,url:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadMyVideoGuild;
			tojson.result = result;
			tojson.info = info;
			tojson.self_info = self_info;
			tojson.anchor_score = anchor_score;
			tojson.anchor_rank = anchor_rank;
			
			//职位从大到小  贵族从大到小排序
			members.sortOn(["m_position","m_member_vip"],[Array.NUMERIC,Array.NUMERIC|Array.DESCENDING]);
			tojson.members = members;
			
			tojson.url = url;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//打开“成员管理”标签页LoadVideoGuildMemberList的回调
		public function OnLoadVideoGuildMemberList(members:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoGuildMemberList;
			
			//职位从大到小  资产贡献从大到小排序
			members.sortOn(["m_position","m_ctrbt"],[Array.NUMERIC,Array.NUMERIC|Array.DESCENDING]);
			tojson.members = members;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//开除成员KickVideoGuildMember的回调
		public function OnKickVideoGuildMember(result:int,target_id:String ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_KickVideoGuildMember;
			tojson.result = result;
			tojson.target_id = target_id;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//退出后援团ExitVideoGuild的回调
		public function OnExitVideoGuild(result:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ExitVideoGuild;
			tojson.result = result;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//修改成员职位ModifyVideoGuildMemberPosition的回调
		public function OnModifyVideoGuildMemberPosition(result:int,target_id:String,position_id:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifyVideoGuildMemberPosition;
			tojson.result = result;
			tojson.target_id = target_id;
			tojson.position_id = position_id;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//修改职位信息ModifyVideoGuildPositionInfo的回调
		public function OnModifyVideoGuildPositionInfo(result:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifyVideoGuildPositionInfo;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//解散DisbandVideoGuild的回调
		public function OnDisbandVideoGuild(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_DisbandVideoGuild;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//取消解散CancelDisbandVideoGuild的回调
		public function OnCancelDisbandVideoGuild(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_CancelDisbandVideoGuild;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//满足被传位条件的成员列表
		public function OnGetMembersCanBeDismissed(members:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetMembersCanBeDismissed;
			tojson.members = members;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//传位DismissVideoGuild的回调
		public function OnDesmissVideoGuild(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_DesmissVideoGuild;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//取消传位CancelDemiseVideoGuild的回调
		public function OnCancelDemiseVideoGuild(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_CancelDemiseVideoGuild;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//加载职位信息LoadVideoGuildPositions的回调
		public function OnLoadVideoGuildPositions(positions:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadVideoGuildPositions;
			tojson.positions = positions;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//创建后援团回调
		public function OnCreateVideoGuild(result:int,vg_name:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_CreateVideoGuild;
			tojson.result = result;
			tojson.vg_name = vg_name;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//发送入团申请后，申请人收到的回调
		public function OnSendVideoGuildJoinApply(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SendVideoGuildJoinApply;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//获取加入后援团入团申请的回调		
		public function OnGetVideoGuildJoinApplyList(applys:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetVideoGuildJoinApplyList;
			tojson.applys = applys;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//批准或者拒绝某个入团申请的回调
		public function OnOperateJoinApply(result:int , is_approve:Boolean,player_id:String,player_name:String,player_zone:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OperateJoinApply;
			tojson.result = result;
			tojson.is_approve = is_approve;
			tojson.player_id = player_id;
			tojson.player_name = player_name;
			tojson.player_zone = player_zone;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//入团申请者收到的提示
		public function OperateJoinApplyNotify(is_approve:Boolean , vgname:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OperateJoinApplyNotify;
			tojson.is_approve = is_approve;
			tojson.vgname = vgname;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//收到某人发出的加入后援团邀请
		public function JoinInvitationNotify(player_name:String,zone_name:String, vgname:String, vgid:Int64):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_JoinInvitationNotify;
			tojson.player_name = player_name;
			tojson.zone_name = zone_name;
			tojson.vgname = vgname;
			tojson.vgid = vgid.toString();
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//邀请某人加入后援团回调
		public function OnInvitePlayerJoinVideoGuild(result:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_InvitePlayerJoinVideoGuild;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//邀请某人加入后援团,对方是同意，还是拒绝的回调函数。对方如果忽略，不会触发次函数
		public function OnInvitePlayerJoinVideoGuildResult(accept:Boolean ,player_name:String,zone_name:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_InvitePlayerJoinVideoGuildResult;
			tojson.accept = accept;
			tojson.player_name = player_name;
			tojson.zone_name = zone_name;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//同意加入后援团邀请回调（拒绝没有回调）
		public function OnOperateJoinInvitation(result:int ,vgname:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OperateJoinInvitation;
			tojson.result = result;
			tojson.vgname = vgname;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//更换支持的主播回调
		public function OnChangeSupportAnchor(type:int, result:int) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ChangeSupportAnchor;
			tojson.ret = type;
			tojson.result = result;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//查看后援团名片回调
		public function OnGetVideoGuildInfo(info:VideoGuildInfoForUI,myvgid:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetVideoGuildInfo;
			tojson.info = info;
			tojson.myvgid = myvgid;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//修改自己后援团描述回调
		public function OnModifySelfVideoGuildDesc(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifySelfVideoGuildDesc;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//修改自己后援团公告回调
		public function OnModifySelfVideoGuildNotice(result:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifySelfVideoGuildNotice;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//修改自己后援团名字回调
		public function OnModifySelfVideoGuildName(result:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifySelfVideoGuildName;
			tojson.result = result;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//当日签到回调 slef_score_add个人积分增加，vg_wealth_add团资产增加
		public function OnSendDailySignIn(result:int , slef_score_add:int , vg_wealth_add:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SendDailySignIn;
			tojson.result = result;
			tojson.slef_score_add = slef_score_add;
			tojson.vg_wealth_add = vg_wealth_add;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//献月票回调 result献月票结果：score_add主播增加积分数
		public function OnSendVideoGuildMonthTicket(result:int, score_add:int,cur_ticket_acc:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SendVideoGuildMonthTicket;
			tojson.result = result;
			tojson.score_add = score_add;
			tojson.cur_ticket_acc = cur_ticket_acc;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//购买粉丝牌回调
		public function OnBuyVideoGuildBoard(type:int, result:int, boardtype:int , time:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_BuyVideoGuildBoard;
			tojson.type = type;
			tojson.result = result;
			tojson.boardtype = boardtype;
			tojson.time = time;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//收到被传位消息
		public function BeDismissed(old_chief_name:String,old_chief_zone:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_BeDismissed;
			tojson.old_chief_name = old_chief_name;
			tojson.old_chief_zone = old_chief_zone;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//收到传位成功消息
		public function DemiseSuccess(new_chief_name:String,new_chief_zone:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_DemiseSuccess;
			tojson.new_chief_name = new_chief_name;
			tojson.new_chief_zone = new_chief_zone;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//后援团最终解散的时候 通知UI
		public function NotifyVideoGuildDisband():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_VideoGuildDisband;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//被开除后援团，通知被开除的玩家
		public function BeKicked(name:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_PlayerBeKicked;
			tojson.name = name;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//更新后援团日志的回调
		public function NotifyUpdateVideoGuildLog():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_UpdateVideoGuildLog;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//后援团支持的主播变化
		public function NotifySurportAnchorChange(anchor:Int64):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SurportAnchorChange;
			tojson.anchor = anchor.toString();
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//请求福利积分分屏
		public function requestWelfareDistributionRes(errCode:int , anchorid:Int64 , welfare:Int64 , guilds:Array ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RequestWelfareDistribution;
			tojson.errCode = errCode;
			tojson.anchorid = anchorid.toString();
			tojson.welfare = welfare.toString();
			tojson.guilds = guilds;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// (video guild)分配一次福利积分结果
		public function welfareDistributeRes(errcode:int , anchorid:Int64 , welfare:Int64 , guildID:Int64, guildCurrWelfare:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_WelfareDistributeRes;
			tojson.errcode = errcode;
			tojson.anchorid = anchorid.toString();
			tojson.welfare = welfare.toString();
			tojson.guildID = guildID.toString();
			tojson.guildCurrWelfare = guildCurrWelfare;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//获取后援团日志回调
		public function OnGetLogRecordOfVideoGuild(recordInfo:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetLogRecordOfVideoGuild;
			tojson.recordInfo = recordInfo;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//修改粉丝牌回调
		public function OnModifyFansBoardName( type:int, result:int, new_name:String, first:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifyFansBoardName;
			tojson.ret = type;
			tojson.result = result;
			tojson.new_name = new_name;
			tojson.first = first;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//获取后援团重命名价格回调
		public function OnGetRenameVideoGuildCost(renameCost:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetRenameVideoGuildCost;
			tojson.renameCost = renameCost;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//获取更改支持主播价格的回调
		public function OnGetChangeAnchorCost(changeAnchorCost:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetChangeAnchorCost;
			tojson.changeAnchorCost = changeAnchorCost;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		//从服务器得到玩家角色列表
		public function OnLoadServerListFromVersion(type:int, succ:Boolean, room_proxy_infos:Array, account_infos:Array, lastAccount:Object):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ConnectVideoVersion;
			tojson.err_code = type;
			tojson.succ = succ;
			tojson.room_proxy_infos = room_proxy_infos;
			tojson.account_infos = account_infos;
			tojson.lastAccount = lastAccount;
			if (Globals.isReconnection) {
				Globals.isReconnection = false;

				if (_params.callbackfunc != null) {
					var type:int = int(_params.jsonparam.op_type);

					if (type == VideoWebOperationType.VOT_LoadRoomList) // 拉取房间信息的特殊处理+1000 
						jscallback.RegisterFunc(1000 + _params.jsonparam.category, _params.jsonparam, _params.callbackfunc, _params.args);
					else
						jscallback.RegisterFunc(type, _params.jsonparam, _params.callbackfunc, _params.args);
				}

//				Globals.s_logger.debug("_params.jsonparam =  " + JSON.stringify(_params.jsonparam));
				ConnectProxyServer(_params.jsonparam);
			} else {
				jscallback.Apply(tojson.op_type, tojson, false, true);
			}
		}

		//关注主播开播提醒
		public function OnFollowingAnchorLiveStartNotify(anchor:String, room_id:int, logo_url:String):void 
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_AnchorLiveStartNotify;
			tojson.anchor = anchor;
			tojson.room_id = room_id;
			tojson.logo_url = logo_url;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		
		//私聊列表
		public function OnGetPrivateInfoList(data:Array) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetPrivateInfoList;
			tojson.data = data;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//加密头像url
		public function OnEncryptPortraitUrlRes(res:int,  encrypturl :String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_EncryptPortraitUrl;
			tojson.encrypturl =encrypturl;
			tojson.res =res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//成员操作列表中的信息请求回调
		public function OnMemberOperationRes(res:int, MemInfo:CMemberOperationInfo):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_MemberOperationInfo;
			tojson.res = res;
			tojson.mem_info = MemInfo;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//查询余额
		public function OnQueryBalanceRes(type:int,res:Boolean, balance:int):void//1
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryBalance;
			tojson.type = type;
			tojson.res=res;
			tojson.balance=balance;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnQueryVideoMoneyRes(res:int, videomoney:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryVideoMoney;
			tojson.res=res;
			tojson.videomoney=videomoney;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//主播发起新投票的通知
		public function OnAnchorStartVote(res:int,data:VideoVoteInfoForUI ):void//1
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyAnchorStartVote;
			tojson.res = res;
			tojson.data = data;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//主播停止投票的通知
		public function OnAnchorStopVote():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_AnchorStopVote;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		public function OnGetVipAdditionRes(data:VipAddtionInfo):void //1
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetVipAddition;
			var info:Object = new Object;
			info.m_vip_addition = data.m_vip_addition;
			info.vipinfo = new Object;
			for (var itr:Object in data.m_vip_cnt_info)
				info.vipinfo[itr] = data.m_vip_cnt_info[itr];
			tojson.data = info;

			jscallback.Apply(tojson.op_type, tojson, false);
		}
		
		public function OnCheckNickRes( type:int, res:int, recommend_nick:String):void//1
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_CheckNick;
			tojson.type= type;
			tojson.res = res;
			tojson.recommend_nick = recommend_nick;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnHasVotedRes(res:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_HasVoted;
			tojson.res = res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		public function OnIsStartVoteRes(res:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_IsStartedVote;
			tojson.res = res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnIsFollowedAnchorRes(res:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_IsFollowedAnchor;
			tojson.res = res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//预览宝箱奖励回调
		public function OnLoadTreasureBoxPreviewNewRole(box_id:int,reward:Array,buff_percent:int,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadPreviewTreasureBoxData;
			tojson.box_id = box_id;
			tojson.buff_percent = buff_percent;
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for ( var index:int =0 ; index < reward.length; index ++)
			{
				var rew:BoxRewardDataForUI = new BoxRewardDataForUI ;
				rew = reward[index];
				if( VideoChannelType.IsQueryReaward(rew.channel))
				{
				 	newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				}
				else
				{
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.rewardType,rew.rewardId,rew.rewardCount));
				}
			}
			tojson.reward = newRewards;
			tojson.hasgame = gameindex>0 ?true:false;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//热度宝箱新角色奖池奖励发放通知
		public function OnOpenTreasuerBoxResultNewRoleWeb(res:int,boxid:int,chooseidx:int,truelyReward:Array,buff_percent:int,anchor_level:int,online:Boolean,is_reissue:Boolean, last_hit_player_name:String, last_hit_player_id:Int64, last_hit_player_invisible:Boolean, last_hit_player_ids:Array, last_hit_player_invisibles:Array, game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OpenTreasuerBoxResult;
			tojson.res = res;
			tojson.boxid = boxid;
			tojson.chooseidx = chooseidx;
			tojson.buff_percent = buff_percent;
			tojson.anchor_level = anchor_level;
			tojson.online = online;
			tojson.is_reissue = is_reissue;
			Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb page to page:" + last_hit_player_ids);
			if(last_hit_player_ids){
				tojson.last_hit_player_id = [];
				Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb: for start");
				for(var i:int=0,n:int=last_hit_player_ids.length; i<n; i++){
					Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb: for n = "+n);
					tojson.last_hit_player_id[i] = last_hit_player_ids[i].toString();
					Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb: for last_hit_player_id = "+tojson.last_hit_player_id);
				}
				Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb: for end");
				tojson.last_hit_player_invisible = last_hit_player_invisibles;
			} else{
				tojson.last_hit_player_id = last_hit_player_id.toString();
				tojson.last_hit_player_invisible = last_hit_player_invisible;
			}
			Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb page to page: end");
			if(last_hit_player_name){
				tojson.last_hit_player_name = last_hit_player_name.split("&&");
			} else{
				tojson.last_hit_player_name = last_hit_player_name;
			}
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb page truelyReward:"+JSON.stringify(truelyReward));
			Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb page game_rewards:"+JSON.stringify(game_rewards));
			for ( var index:int =0 ; index < truelyReward.length; index ++)
			{
				var rew:BoxRewardForUI = truelyReward[index];
				if( VideoChannelType.IsQueryReaward(rew.channel))
					newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.reward_type,rew.reward_id,rew.reward_cnt));
			}
			tojson.truelyReward = newRewards;
			tojson.hasgame = gameindex>0 ?true:false;
			Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb page res:"+JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//查询主播任务回调
		public function OnQueryClientAnchorTaskResNewRole(type:int,task:AnchorTaskInfoUI,adv_guard_ratio:int,buff_percent:int,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryAnchorTask;
			tojson.task = task;
			tojson.adv_guard_ratio = adv_guard_ratio;
			tojson.buff_percent = buff_percent;
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for ( var index:int =0 ; index < task.rewards.length; index ++)
			{
				var rew:RewardDataForUI = task.rewards[index];
				if( VideoChannelType.IsQueryReaward(rew.channel))
					newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.type ,rew.rewardId,rew.count));
			}
			tojson.task.rewards = newRewards;
			tojson.hasgame = gameindex>0 ?true:false;
			

			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//完成主播任务时的奖励通知
		public function OnFinishAnchorTaskNewRole(type:int,rewardlist:Array,adv_guard_ratio:int,buff_percent:int,is_reissue:Boolean,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_FinishAnchorTask;
			tojson.type = type;
			tojson.adv_guard_ratio = adv_guard_ratio;
			tojson.buff_percent = buff_percent;
			tojson.is_reissue = is_reissue;
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for ( var index:int =0 ; index < rewardlist.length; index ++)
			{
				var rew:RewardDataForUI = rewardlist[index];
				if( VideoChannelType.IsQueryReaward(rew.channel))
				{
					newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				}
				else
				{
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.type,rew.rewardId,rew.count));
				}
			}
			tojson.rewardlist = newRewards;
			tojson.hasgame = gameindex>0 ?true:false;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnGetImpressionIDAndName(impression:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetImpressionIDName;
			tojson.impression = impression;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		
		public function OnIgnorePlayerRes(bAdd:Boolean,res:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_IgnorePlayer;
			tojson.bAdd = bAdd;
			tojson.res = res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnIsInIgnoreListRes(res:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_IsInIgnoreList;
			tojson.res = res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//首页的个人信息
		public function OnLoadPlayerInfoForHomePage(res:int, playerinfo:VideoClientCharInfo):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadPlayerInfoForHomePage;
			tojson.res = res;
			tojson.playerinfo = playerinfo;			
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		public function OnModifyNickRes(type:int,res:int,recommend_nick:String,source_type:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ModifyNick;
			tojson.res = res;
			tojson.recommend_nick = recommend_nick;
			tojson.source_type = source_type;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//演唱会相关//////////////////////////////////////////////////////////////////////////////////////////////////////begin
		// 设置用户保存的默认清晰度，需要在初始化视频dll后立刻调用一次，每次选择清晰度成功后也要设置
		public function OnSetDefaultDefinition(res:Boolean) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SetDefaultDefinition;
			tojson.res = res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取当前直播支持的清晰度
		public function OnGetCurrentAvailableDefinition(def:Array) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetCurrentAvailableDefinition;
			tojson.def = def;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 获取当前播放的清晰度
		public function OnGetCurrentDefinition(def:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetCurrentDefinition;
			tojson.def = def;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 选择清晰度，返回成功、失败
		public function  OnChooseDefinition( res:Boolean) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ChooseDefinition;
			tojson.res = res;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function  OnGetBuyTicketAndPicURL(ticketurl:String,picurl:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetBuyTicketAndPicURL;
			tojson.ticketurl = ticketurl;
			tojson.picurl = picurl;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 演唱会房间状态改变，演唱会是否开启
		public function OnConcertStatusChange(hasticket:Boolean , is_open:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ConcertStatusChange;
			tojson.is_open = is_open;
			tojson.hasticket = hasticket;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 通知正在播放的清晰度
		public function NotifyCurrentDefinition(definition:int) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyCurrentDefinition;
			tojson.definition = definition;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 展示奖品、开始抽奖的回调，countdown分别是两个倒计时，从回调开始就要倒计时而不是打开界面才倒计时
		public function OnRaffleStateNotify(state:int , rwds:Array, countdown:int) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyRaffleState;
			tojson.state = state;
			tojson.rwds = rwds;
			tojson.countdown = countdown;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 显示结果回调
		public function OnShowResult(state:int, result:Array, rwds:Array, countdown:int,playerid:String) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryRaffle;
			tojson.state = state;
			tojson.rwds = rwds;
			tojson.countdown = countdown;
			tojson.result = result;
			tojson.playerid = playerid;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//玩家抽奖结果
		public function OnDoRaffleRes(res:int , reward:RaffleRewardForUI,is_lucky:Boolean = false) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_DoRaffle;
			tojson.res = res;
			tojson.reward = reward;
			tojson.is_lucky = is_lucky;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 开启/关闭飞屏开关广播结果（所有玩家）
		public function OnSwitchWhistleBroadcast(type:int , is_open:Boolean) :void    // is_open表示当前飞屏开关状态
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OnSwitchWhistleBroadcast;
			tojson.is_open = is_open;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 刷新现场任务数据
		public function RefreshLiveTaskInfo( info:Array ) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshLiveTaskInfo;
			tojson.info = info;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 新现场任务通知
		public function NotifyNewLiveTask( res:Boolean ) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyNewLiveTask;
			tojson.res = res;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 通知分流信息
		public function NotifyDivertInfo( rooms:Array ,remcnt:int) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyDivertInfo;
			tojson.rooms = rooms;
			tojson.remcnt = remcnt;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//获取演唱会当前状态现在剩余的时间
		public function OnGetConcertCurLeftTime( time:int,state:int ) :void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetConcertCurLeftTime;
			tojson.time = time;
			tojson.state= state;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//演唱会相关 ////////////////////////////////////////////end//////////////////////////////////////////////////////////end
		
		// 获取活动中心信息回调
		public function OnGetAcitivityCenterInfosRes(type:int,succ:int,info:ActivityCenterInfosForUI,dev_activity_cnt:int,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetAcitivityCenterInfos;
			tojson.type = type;
			tojson.succ = succ;
			tojson.dev_activity_cnt = dev_activity_cnt;
			tojson.info = info;
//			tojson.game_rewards = game_rewards;
			var gameindex:int = 0;
			
			for ( var i:int =0 ; i < info.activity_info.length; i ++)
			{
				var activity:ActivityInfoForUI =  info.activity_info[i];
				var newRewards:Array = new Array;
				for ( var index:int =0 ; index < activity.rewards.length; index ++)
				{
					var rew:ActivityRewardForUI = activity.rewards[index];
					if( VideoChannelType.IsQueryReaward(rew.channel))
						newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
					else
						newRewards.push( rewardmanager.RewardToRewardForUI(rew.giftType,rew.giftId,rew.giftCount));
				}
				tojson.info.activity_info[i].rewards = newRewards;
				index = 0;
			}
			
			for ( var j:int =0 ; j < info.daily_activity_info.length; j ++)
			{
				var activity_daily:DailyActivityInfoForUI =  info.daily_activity_info[j];
				var newRewards1:Array = new Array;
				for ( var index1:int =0 ; index1 < activity_daily.rewards.length; index1 ++)
				{
					var rew1:ActivityRewardForUI = activity_daily.rewards[index1];
					if( VideoChannelType.IsQueryReaward(rew1.channel))
						newRewards1.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
					else
						newRewards1.push( rewardmanager.RewardToRewardForUI(rew1.giftType,rew1.giftId,rew1.giftCount));
				}
				tojson.info.daily_activity_info[j].rewards = newRewards1;
			}
			
			for ( var k:int =0 ; k < info.activity_info_web.length; k ++)
			{
				var activity_web:ActivityInfoForUI =  info.activity_info_web[k];
				var newRewards2:Array = new Array;
				for ( var index2:int =0 ; index2 < activity_web.rewards.length; index2 ++)
				{
					var rew2:ActivityRewardForUI = activity_web.rewards[index2];
					if( VideoChannelType.IsQueryReaward(rew2.channel))
						newRewards2.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
					else
						newRewards2.push( rewardmanager.RewardToRewardForUI(rew2.giftType,rew2.giftId,rew2.giftCount));
				}
				tojson.info.activity_info_web[k].rewards = newRewards2;
			}
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		// 领取活动中心奖励回调
		public function OnTakeVideoActivityRewardsRes(type:int, res:int, activity_id:int, activity_category:int, rewards:Array,is_reissue:Boolean,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeVideoActivityRewards;
			tojson.type = type;
			tojson.res = res;
			tojson.activity_id = activity_id;
			tojson.is_daily = activity_category;
			tojson.is_reissue = is_reissue;
			
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for ( var index:int =0 ; index < rewards.length; index ++)
			{
				var rew:CReward = rewards[index];
				if( VideoChannelType.IsQueryReaward(rew.channel))
					newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.type, rew.male_data,rew.count));
			}
			tojson.rewards = newRewards;
			tojson.hasgame = gameindex>0 ?true:false;

			jscallback.Apply(tojson.op_type,tojson,false);
		}
		// 领取每日工资回调 attached_wage附加工资
		public function OnTakeDailyWageRes(type:int, res:int , wage:int, attached_wage:int ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeDailyWageRes;
			tojson.res = res;
			tojson.wage = wage;
			tojson.attached_wage = attached_wage;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		// 活动完成数量通知
		public function NotifyActivityCompletedCount(count:int, has_taken_wage_today:Boolean, status:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ActivityCompletedCount;
			tojson.count = count;
			tojson.has_taken_wage_today = has_taken_wage_today;
			tojson.status = status;
			tojson.is_act_guide_over = m_videoClient.GetVideoClientPlayer().IsTipsNoticed();
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		//IUIAnchorPK================================================
		
		//频闭私聊除了管理员和主播以外
		public function onForbiePrivateChat(forbid:int,res:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ForbidPrivateChat;
			tojson.forbid = forbid;
			tojson.res = res;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		//查询是否可以进入某房间的回调
		public function OnCanEnterRoom(roomId:int, result:int,
			roomType:int, ticketRoom:Boolean, isLiving:Boolean, isSuperRoom:Boolean,
			isNestRoom:Boolean, isSpecialRoom:Boolean, skinId:int, skinLevel:int, isPK:Boolean):void {
			
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_CheckCanEnterRoom;
			tojson.roomId = roomId;
			tojson.result = result;
			tojson.roomType = roomType;
			tojson.ticketRoom = ticketRoom;
			tojson.isLiving = isLiving;
			tojson.isSuperRoom = isSuperRoom;
			tojson.isNestRoom = isNestRoom;
			tojson.isSpecialRoom = isSpecialRoom;
			tojson.skinId = skinId;
			tojson.skinLevel = skinLevel;
			tojson.isPK = isPK;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//获取玩家自身的贵族等级和剩余时间
		private function GetSelfVipLevelAndRemainTime():void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetSelfVipLevelAndRemainTime;
			tojson.vipLevel = m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetVipLevel();
			tojson.vipName = m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetVipName();
			tojson.remainTime = m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetVipRemainTime();
			tojson.attachedAnchor = m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetAttachedAnchorName();
			tojson.attachedAnchorID = m_videoClient.GetCX5VideoClient().GetVideoClientPlayer().GetAttachedAnchorID();
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnGetConnectStatus():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetConnectStatus;
			//遨游浏览器，在地址栏直接输入小窝网址如：http://trunck.qq.com/caveolaeroom.shtml?roomId=88895&source=0
			//m_videoClient和jscallback存在为null的情况
			if (m_videoClient != null) {
				tojson.res = this.m_videoClient.GetCX5VideoClient().GetCallCenter().GetConnected();
			} else {
				tojson.res = false;
			}
			if (jscallback != null) {
				jscallback.Apply(tojson.op_type, tojson, false);
			}
		}
		
		//是否需要进行新手教学回调
		public function OnIsNoviceGuided(need:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NoviceGuided;
			tojson.need = need;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//举报主播
		public function OnReportAnchor():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ReportAnchor;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		//三次拉取首页信息147失败
		public function OnGetHomePageFail(res:int):void {
			//判断roomproxy是否断开
			if (!m_videoClient.GetCX5VideoClient().GetCallCenter().GetConnected()) {
				//ConnectProxyServer(connectRoomProxyParam);
				return;
			}
			if (Globals.isLogoutState) {
				return;
			}
			Globals.isLogoutState = true;

			var op:Object = {"op_type": VideoWebOperationType.Change_Login, "res": VideoWebCode.CHANGE_LOGIN_HOME_PAGE_FAIL};
			op["msg"] = res == 0 ? "三次拉取homePage没有及时返回。" : ("获取homepage信息错误（错误码=" + res + "）。");
			Globals.s_logger.localLog(op["msg"]);
			if (x51VideoWeb.isOldFrame) {
				ExternalInterface.call("MGC_Comm.ChangeLogin", op);
				Globals.s_logger.debug("OnGetHomePageFail()    MGC_Comm.ChangeLogin");
			} else {
				ExternalInterface.call("mgc.network.recvMsg", op);
				Globals.s_logger.debug("OnGetHomePageFail()    mgc.network.recvMsg   ChangeLogin");
			}
		}

		public function NotifyMoneyChange(dream_money:int, balance:int):void 
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyMoneyChange;
			tojson.dream_money = dream_money;
			tojson.balance = balance;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//请求梦幻币礼物回调
		public function OnQueryDreamGift(videoGift:Array, onlySkin:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryDreamGift;
			tojson.videoGift = videoGift;
			tojson.onlySkin = onlySkin;
			jscallback.Apply(tojson.op_type,tojson,false);				
		}
		
		//查询当前进入房间是不是演唱会房间
		public function OnQueryIsConcertRoom(isConcert:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryIsConcertRoom;
			tojson.isConcert = isConcert;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnMessageTimeOut():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TimeOut;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//获取好友给自己充值的信息
		public function OnGetFriendPayCashInfo(friendpays:Array):void
		{
			//数据不对，服务器起还没有改好
			
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetFriendPayCashInfo;
			tojson.friendpay = friendpays;
			jscallback.Apply(tojson.op_type, tojson, false);
		}
		
		//获取个人头像地址
		public function OnGetPortraitUrl(pUrl:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetPortraitUrl;
			tojson.pUrl = pUrl;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function OnRefreshGiftEffectCnt(obj:Dictionary):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetGiftEffectCnt;
			var gift:Object = new Object;//map
			var index:int = 0;
			for(var idx:Object in obj )//array对象
			{
				var tmpobj:Object = new Object;
				tmpobj.id  = idx;
				tmpobj.counts = obj[idx].counts;
				tmpobj.countinueCounts = obj[idx].continuous_send_gifts_counts;
				gift[index++] =tmpobj;
				
			}
			tojson.giftdata = gift;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//统计演唱会房间累计观看人数
		public function OnRefreshConcertTotalPlayers(num:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshConcertTotalPlayers;
			tojson.num = num;
			jscallback.Apply(tojson.op_type,tojson,false);
		}	
		
		//首登签到----begin
		//玩家领取首次登陆奖励
		public function OnGetFirstLoginRewardNotify(res:int,isToken:Boolean,rewards:Array,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetFirstLoginRewardNotify;
			tojson.res = res;
			tojson.isToken = isToken;
//			tojson.rewards = rewards;
//			tojson.game_rewards = game_rewards;
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for( var index:int =0 ; index < rewards.length; index ++ )
			{
				var rew:CDailySiginRewardForUI = rewards[index];
				var giftArr:Array = new Array;
				if( VideoChannelType.IsQueryReaward(rew.channel) )
					newRewards.push(rewardmanager.GameRewardToSignRewardForUI( game_rewards[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToSignRewardForUI(rew.type, rew.id,rew.count,rew.level,rew.multiply ));
			}
			tojson.rewards = newRewards;
			tojson.hasgame = gameindex>0?true:false;
			Globals.s_logger.debug( " OnGetFirstLoginRewardNotify end" );
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		//领取首登奖励
		public function OnGetFirstLoginReward(res:int, rewards:Array, game_rewards:Array, isReissue:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetFirstLoginReward;
			tojson.res = res;
			tojson.is_reissue = isReissue;
			
			//组织奖励信息数据。
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for ( var index:int =0 ; index < rewards.length; index ++)
			{
				var rew:CReward = rewards[index];
				if( rew.channel == VideoChannelType.VCT_X5)
					newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.type, rew.male_data, rew.count));
			}
			tojson.rewards = newRewards;
			tojson.hasgame = gameindex > 0 ? true : false;
			
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//每日签到提醒
		public function OnSignDaliyNotify(status:int,is_Daily:Boolean,is_Acc:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SignDaliyNotify;
			tojson.status = status;
			tojson.is_Daily = is_Daily;
			tojson.is_Acc = is_Acc;
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		//获取每日签到信息
		public function OnGetSignDailyInfo(res:int,info:DailySigninRewardContentForUI,is_reissue:Boolean,reward_list:Array,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetSignDailyInfo;
			tojson.info = info;
			tojson.is_reissue = is_reissue;
			
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			for( var index:int =0 ; index < info.daily_rewards.length; index ++ )
			{
				var rew:CDailySiginRewardForUI = info.daily_rewards[index];
				var giftArr:Array = new Array;
				if( VideoChannelType.IsQueryReaward(rew.channel) )
				{
					var souinfo:SignRewardForUI = rewardmanager.GameRewardToSignRewardForUI( game_rewards[gameindex++] );
					souinfo.level = rew.level;
					souinfo.multiply = rew.multiply;
					newRewards.push(souinfo);
				}
				else
				{
					newRewards.push( rewardmanager.RewardToSignRewardForUI(rew.type, rew.id,rew.count,rew.level,rew.multiply ));
				}
					
			}
			
			tojson.info.daily_rewards = newRewards;
			
			for( var idx:int =0; idx< info.accumulate_rewards.length; idx++)
			{
				var ainfo:AccumulateRewards = info.accumulate_rewards[idx];
				var rewards:Array = new Array;
				for( var i:int=0;i<ainfo.rewards.length; i ++)
				{
					var rew_daily:CDailySiginRewardForUI = ainfo.rewards[i];
					if( VideoChannelType.IsQueryReaward(rew_daily.channel) )
						rewards.push(rewardmanager.GameRewardToSignRewardForUI( game_rewards[gameindex++]));
					else
						rewards.push( rewardmanager.RewardToSignRewardForUI(rew_daily.type, rew_daily.id,rew_daily.count,rew_daily.level,rew_daily.multiply ));
				}
				tojson.info.accumulate_rewards[idx].rewards = rewards;
			}

			if (tojson.info.accumulate_rewards is Array) {
				(tojson.info.accumulate_rewards as Array).sortOn("days", Array.NUMERIC);
			}

			var dsrUI:CDailySiginRewardForUI;
			var reward_list:Array = new Array();
			for (var ii:int = 0; ii < reward_list.length; ii++)
			{

				dsrUI = reward_list[ii] as CDailySiginRewardForUI;
				if (VideoChannelType.IsQueryReaward(dsrUI.channel))
				{
				}
				else
				{
					reward_list.push(rewardmanager.RewardToSignRewardForUI(dsrUI.type, dsrUI.id, dsrUI.count, dsrUI.level, dsrUI.multiply));
				}
			}
			tojson.reward_list = reward_list;
			
			tojson.res = res;
//			tojson.game_rewards = game_rewards;i
			jscallback.Apply(tojson.op_type,tojson,false,true);
		}
		
		//领取每日签到奖励
		public function OnSignInDaily(res:int, rws:CDailySiginRewardForUI, is_reissue:Boolean, reward_list:Array, game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SignInDaily;
			tojson.res = res;
			tojson.is_reissue = is_reissue;
			var gameindex:int = 0;
			var giftArr:Array = new Array;
			if (VideoChannelType.IsQueryReaward(rws.channel))
			{
				var souinfo:SignRewardForUI = rewardmanager.GameRewardToSignRewardForUI(game_rewards[gameindex++]);
				souinfo.level = rws.level;
				souinfo.multiply = rws.multiply;
				tojson.rws = souinfo;
			}
			else
			{
				tojson.rws = rewardmanager.RewardToSignRewardForUI(rws.type, rws.id, rws.count, rws.level, rws.multiply);
			}
//			tojson.game_rewards = game_rewards;
			tojson.hasgame = gameindex > 0 ? true : false;

//			Globals.s_logger.debug("返回页面串：" + JSON.stringify(reward_list));
			if (reward_list.length > 0)
			{
				var dsrUI:CDailySiginRewardForUI = reward_list[0] as CDailySiginRewardForUI;
				if (VideoChannelType.IsQueryReaward(dsrUI.channel))
				{
					tojson.reward_list = [];
				}
				else
				{
					tojson.reward_list = [rewardmanager.RewardToSignRewardForUI(dsrUI.type, dsrUI.id, dsrUI.count, dsrUI.level, dsrUI.multiply)];
				}
			}
			else
			{
				tojson.reward_list = [];
			}

			jscallback.Apply(tojson.op_type, tojson, false, true);
		}

		//领取累计奖励
		public function OnGetCumulativeReward(res:int, rws:Array, is_reissue:Boolean, reward_list:Array, game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetCumulativeReward;
			tojson.is_reissue = is_reissue;
			var newRewards:Array = new Array;
			var gameindex:int    = 0;
			for (var i:int = 0; i < rws.length; i++)
			{
				var rew_daily:CDailySiginRewardForUI = rws[i];
				if (VideoChannelType.IsQueryReaward(rew_daily.channel))
					newRewards.push(rewardmanager.GameRewardToSignRewardForUI(game_rewards[gameindex++]));
				else
					newRewards.push(rewardmanager.RewardToSignRewardForUI(rew_daily.type, rew_daily.id, rew_daily.count, rew_daily.level, rew_daily.multiply));
			}
			tojson.rws = newRewards;

			var reward_list_UI:Array = new Array;
			for (var ii:int = 0; ii < reward_list.length; ii++)
			{
				var c:CDailySiginRewardForUI = reward_list[ii] as CDailySiginRewardForUI;
				if (VideoChannelType.IsQueryReaward(c.channel))
				{

				}
				else
				{
					reward_list_UI.push(rewardmanager.RewardToSignRewardForUI(c.type, c.id, c.count, c.level, c.multiply));
				}
			}
			tojson.reward_list = reward_list_UI;

			tojson.res = res;
//			tojson.game_rewards = game_rewards;
			tojson.hasgame = gameindex > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		//首登签到----end
		
		public function OnDailyRoomActivity(activity:VideoActivityInfoToClient,activity_category:int,game_rewards:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_DailyRoomActivity;

			tojson.activity = activity;
			if( activity !=  null && activity.rewards != null )
			{
				var newRewards:Array = new Array;
				var gameindex:int = 0;
				for( var index:int =0 ; index < activity.rewards.length; index ++ )
				{
					var res:CReward = activity.rewards[index];
					var giftArr:Array = new Array;
					if( VideoChannelType.IsQueryReaward(res.channel))
						newRewards.push(rewardmanager.GameRewardToRewardForUI( game_rewards[gameindex++]));
					else
						newRewards.push( rewardmanager.RewardToRewardForUI(res.type, res.male_data,res.count));
				}
				tojson.activity.rewards = newRewards;
				tojson.hasgame = gameindex>0 ?true:false;
			}
			
			tojson.is_daily = activity_category;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		public function RefreshConcertFreeGiftInfo(giftinfo:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshConcertFreeGiftInfo;

			tojson.giftinfo = giftinfo;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnGiftIDArray(arr:Array):void {
//			Globals.s_logger.debug("GiftIDArray" + JSON.stringify(arr));
			giftIdArray = arr;
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_Gift_ID_Array;

			tojson.giftIdArray = arr;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnGetGuestInfo(res:int, id:int, encrypt_identity:String):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetGuestInfo;
			tojson.res = res;
			tojson.id = id;
			tojson.encrypt_identity = encrypt_identity;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//刷新分屏信息
		public function RefreshSplitScreenInfo(status:int,anchorId:String,anchorName:String,is_follow:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshSplitScreenInfo;
			tojson.status = status;
			tojson.anchorId = anchorId;
			tojson.anchorName = anchorName;
			tojson.is_follow = is_follow;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		public function OnStarSplitScreenLive(cdnUrls:Array, isConcert:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_OnStarSplitScreenLive;
			tojson.cdnUrls = cdnUrls;
			tojson.isConcert = isConcert;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//停止分屏直播
		public function OnStopWatchInvitedAnchorLive():void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_StopWatchInvitedAnchorLive;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//是否为游客登录状态
		public function OnQueryIsGuest(IsGuest:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_IsGuest;
			tojson.isVisitor = IsGuest;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//查询缓存的游客账号
		public function OnQueryGuestCookie(hasCookie:Boolean, id:int, encrypt_identity:String):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryGuestCookie;
			tojson.hasCookie = hasCookie;
			tojson.id = id;
			tojson.encrypt_identity = encrypt_identity;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}

		//玩家是否有后援团，以及后援团支持的直播是不是当前主播
		public function OnHaveJoinGuild(vgid:String, canInvite:Boolean, isSupport:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_HaveJoinGuildAndPosition;
			tojson.vgid = vgid;
			tojson.canInvite = canInvite;
			tojson.isSupport = isSupport;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//小窝二期 捧场 成长 人气相关接口 
		//捧场界面打开回调
		public function OnLoadSupportInfo(result:int, info:AnchorNestSupportInfo, task_info:Array, is_anchor_publish_task:Boolean, is_inGuild:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadSupportInfo;
			tojson.result = result;
			tojson.info = info;
			tojson.task_info = task_info;
			tojson.is_anchor_publish_task = is_anchor_publish_task;
			tojson.is_inGuild = is_inGuild;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//普通捧场回调
		public function OnSendNormalSupport(result:int, add_popularity:int, nest_star:String):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SendNormalSupport;
			tojson.result = result;
			tojson.add_popularity = add_popularity;
			tojson.nest_star = nest_star;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//高级捧场触发特效及文字提示
		public function NotifyAdvancedSupportSuccess(info:AnchorNestAdvSupportLogInfo, logs:Array, add_popularity:int, nest_star:String):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyAdvancedSupport;
			tojson.info = info;
			tojson.logs = logs;
			tojson.add_popularity = add_popularity;
			tojson.nest_star = nest_star;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//领取小窝任务回调
		public function OnTakeAnchorNestTaskRes(result:int, nest_tasks:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeAnchorNestTask;
			tojson.result = result;
			tojson.nest_tasks = nest_tasks;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//刷新主播信息(星耀、人气、关注数、印象等)
		public function RefreshAnchorData(anchor_data:ClientAnchorData):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshAnchorData;
			tojson.anchor_data = anchor_data;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnNotifyNestTaskFinished(nest_tasks:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyNestTaskFinished;
			tojson.nest_tasks = nest_tasks;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnAddNestPopularity(add_value:int, is_free_pop_limit:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_AddNestPopularity;
			tojson.add_value = add_value;
			tojson.is_free_pop_limit = is_free_pop_limit;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//收到小窝成长信息回调
		public function OnGetNestGrowUpRes(credits:int, credits_level:int, rank:int, credits_distance_of_prev_or_1000:int,
			rank_need_promote:int, credits_need_promote:int, honor_num_need_promote:int, is_get_guard_wage:Boolean, is_guard:Boolean,
			nest_credits_level_info_vec_ui:Array, guard_wage_info:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetNestGrowUp;
			tojson.credits = credits;
			tojson.credits_level = credits_level;
			tojson.rank = rank;
			tojson.credits_distance_of_prev_or_1000 = credits_distance_of_prev_or_1000;
			tojson.rank_need_promote = rank_need_promote;
			tojson.credits_need_promote = credits_need_promote;
			tojson.honor_num_need_promote = honor_num_need_promote;
			tojson.is_get_guard_wage = is_get_guard_wage;
			tojson.is_guard = is_guard;
			tojson.nest_credits_level_info_vec_ui = nest_credits_level_info_vec_ui;
			tojson.guard_wage_info = guard_wage_info;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//增加小窝人气、小窝积分结果回调
		public function OnAddNestPopularityCreditsRes(free_popularity:Boolean, is_need_hint:Boolean, add_popularity:int, add_credits:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_AddNestPopularityCredits;
			tojson.free_popularity = free_popularity;
			tojson.is_need_hint = is_need_hint;
			tojson.add_popularity = add_popularity;
			tojson.add_credits = add_credits;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//守护领取守护工资结果回调
		public function OnGetGuardWageRes(credits:int, credits_level:int, rank:int, credits_distance_of_prev_or_1000:int,
			rank_need_promote:int, credits_need_promote:int, honor_num_need_promote:int, is_get_guard_wage:Boolean, get_guard_wage_credits:int,
			nest_credits_level_info_vec_ui:Array, guard_wage_info:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetGuardWage;
			tojson.credits = credits;
			tojson.credits_level = credits_level;
			tojson.rank = rank;
			tojson.credits_distance_of_prev_or_1000 = credits_distance_of_prev_or_1000;
			tojson.rank_need_promote = rank_need_promote;
			tojson.credits_need_promote = credits_need_promote;
			tojson.honor_num_need_promote = honor_num_need_promote;
			tojson.is_get_guard_wage = is_get_guard_wage;
			tojson.get_guard_wage_credits = get_guard_wage_credits;
			tojson.nest_credits_level_info_vec_ui = nest_credits_level_info_vec_ui;
			tojson.guard_wage_info = guard_wage_info;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function RefreshAnchorNestPopularityInfo(info:AnchorNestPopularityInfo):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshAnchorNestPopularity;
			tojson.info = info;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnRefreshNestCreditsPanel(credits:int, credits_level:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshNestCreditsPanel;
			tojson.credits = credits;
			tojson.credits_level = credits_level;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnGetNestListRes(result:Boolean, nest_info:Array, attached_room_id:int = 0, attached_room_name:String = ""):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetNestList;
			tojson.result = result;
			tojson.nest_info = nest_info;
			tojson.attached_room_id = attached_room_id;
			tojson.attached_room_name = attached_room_name;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//收到宝箱状态回调
		public function OnTreasureBoxStatus(stat:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyNestTaskBoxStatus;
			tojson.status = stat;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//领取小窝宝箱错误码返回
		public function OnTakeNestTreasureBoxErrRes(res:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeNestTreasureBox;
			tojson.res = res;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//查询人气宝箱奖励
		public function OnQueryNestTreasureBox(rewards:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryNestTreasureBoxReward;
//			tojson.rewards = rewards;
			var newRewards:Array = new Array;
			var gameindex:int    = 0;
			for (var index:int = 0; index < rewards.length; index++) {
				var res:RewardDataForUI = rewards[index];
				newRewards.push(rewardmanager.RewardToRewardForUI(res.type, res.rewardId, res.count));
			}
			tojson.rewards = newRewards;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//查询团务奖励
		public function OnQueryNestTaskReward(rewards:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryNestTaskReward;
//			tojson.rewards = rewards;
			var newRewards:Array = new Array;
			var gameindex:int    = 0;
			for (var index:int = 0; index < rewards.length; index++) {
				var res:RewardDataForUI = rewards[index];
				newRewards.push(rewardmanager.RewardToRewardForUI(res.type, res.rewardId, res.count));
			}
			tojson.rewards = newRewards;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//高级守护抢座回调
		public function OnTakeRoomGuardSeat(roomId:int, seatIndex:int, res:int,
			seatInfoUI:VideoGuardSeatInfoUI, cost:int, player_id:String, charm:int):void {

			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeRoomGuardSeat;
			tojson.roomId = roomId;
			tojson.seatIndex = seatIndex;
			tojson.res = res;
			tojson.seatInfoUI = seatInfoUI;
			tojson.cost = cost;
			tojson.charm = charm;
			tojson.player_id = player_id;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//座位被抢的通知
		public function OnRoomGuardSeatLostNotify(roomId:int, seatIndex:int, nick:String, zone:String, cost:int, playerId:String, last_cost:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RoomGuardSeatLostNotify;
			tojson.roomId = roomId;
			tojson.seatIndex = seatIndex;
			tojson.nick = nick;
			tojson.zone = zone;
			tojson.cost = cost;
			tojson.last_cost = last_cost;
			tojson.playerId = playerId;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		//刷新守护宝座
		public function OnRefreshRoomGuardSeats(roomId:int, seats:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshRoomGuardSeats;
			tojson.roomId = roomId;
			tojson.seats = seats;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//星耀榜变化时的走马灯消息。
		public function OnVideoRankChangeBroadcastAllPlayer(anchor_name:String, timedimension:int, enScrollType:int, rank_move:int, video_rank_type:int, gift_name:String, level:int, gift_id:int, stargift_player_nick:String):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_StarlightRankChangeBroadcastAllPlayer;
			tojson.anchor_name = anchor_name;
			tojson.timedimension = timedimension;
			tojson.enScrollType = enScrollType;
			tojson.rank_move = rank_move;
			tojson.video_rank_type = video_rank_type;
			tojson.gift_name = gift_name;
			tojson.level = level;
			tojson.gift_id = gift_id;
			tojson.stargift_player_nick = stargift_player_nick;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//房间内刷新对当前直播的守护等级
		public function OnVideoRoomRefreshGuardLevel(guard_level:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshPlayerGuardLevelToLiveAnchor;
			tojson.guard_level = guard_level;
			jscallback.Apply(tojson.op_type, tojson, false);
		}


		public function OnGetAllTags(statur:int, tags:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetAllTags;
			tojson.status = statur;
			tojson.tags = tags;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnGetRandNick(nick:String, nick_pool:int, nick_record_id:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetRandNick;
			tojson.nick = nick;
			tojson.nick_pool = nick_pool;
			tojson.nick_record_id = nick_record_id;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnGetVideoRoomPicUrl(urls:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetVideoRoomPicUrl;
			tojson.urls = urls;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnGuardLevelChangeNotify(nickName:String, zoneName:String, anchorName:String, oldGuardLevel:int, newGuardLevel:int, vipLevel:int, isSelf:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GuardLevelChangeNotify;
			tojson.nickName = nickName;
			tojson.zoneName = zoneName;
			tojson.anchorName = anchorName;
			tojson.oldGuardLevel = oldGuardLevel;
			tojson.newGuardLevel = newGuardLevel;
			tojson.vipLevel = vipLevel;
			tojson.isSelf = isSelf;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnPublishNestTask(is_published:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyPublishNestTask;
			tojson.is_published = is_published;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//发出红包
		public function OnPublishRedEnvelope(red_id:String, nick:String, zone:String, total_money:int, divide_count:int, red_envelope_duration:int, small_red_envelope_duration:int):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_PublishRedEnvelope;
			tojson.red_id = red_id;
			tojson.nick = nick;
			tojson.zone = zone;
			tojson.total_money = total_money;
			tojson.divide_count = divide_count;
			tojson.red_envelope_duration = red_envelope_duration;
			tojson.small_red_envelope_duration = small_red_envelope_duration;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		// 抢红包结果：red_id:红包id; grab_count:抢到的数量
		public function OnGrabRedEnvelopeRes(res:int, red_id:String, grab_count:int, grab_count_value:int):void {
			var cookie:Cookie = new Cookie("x51web");
			var zone_id:int   = cookie.getData(AccountCookieConst.ZONE_ID);
			//("room_proxy_zoneid"+Globals.cookieQQ + "_" +Globals.cookieZoonID);

			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_GrabRedEnvelope;
			tojson.res = res;
			tojson.red_id = red_id;
			tojson.grab_count = grab_count;
			tojson.grab_count_value = grab_count_value;
			tojson.zone_id = zone_id;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//查看红包：red_id:红包id; nick/zone:发红包人的昵称; total_money:红包总额; divide_count:红包分发数量; grabbers抢红包记录
		public function OnLoadRedEnvelopeRes(res:int, red_id:String, nick:String, zone:String, total_money:int, divide_count:int, grabbers:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadRedEnvelope;
			tojson.res = res;
			tojson.red_id = red_id;
			tojson.nick = nick;
			tojson.zone = zone;
			tojson.total_money = total_money;
			tojson.divide_count = divide_count;
			tojson.grabbers = grabbers;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		// 红包被抢光了
		public function OnRedEnvelopeGrabFinish(red_id:String):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RedEnvelopeGrabFinish;
			tojson.red_id = red_id;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		//刷新主播等级榜
		public function OnRefreshAnchorLevelRank(anchorRank:Array):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshAnchorLevelRank;
			tojson.anchorRank = anchorRank;
			jscallback.Apply(tojson.op_type, tojson, false);
		}
		
		//刷新我对当前主播贡献的经验值已经当日上限
		public function RefreshPlayerDreamGiftAnchorExp(total_anchor_exp:int,max_anchor_exp:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_SyncPlayerDreamGiftAnchorExp;
			tojson.total_anchor_exp = total_anchor_exp;
			tojson.max_anchor_exp = max_anchor_exp;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//主播下线时 主动开启宝箱
		public function BatchVideoTreasureBoxRewardNewRoleWeb(res:int,rewards:Array,buff_percent:int,is_reissue:Boolean, last_hit_player_names:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_BatchVideoTreasureBoxRewardNewRoleWeb;
			tojson.res = res;
			tojson.rewards = rewards;
			tojson.is_reissue = is_reissue;
			tojson.buff_percent = buff_percent;
			tojson.last_hit_player_names = last_hit_player_names;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//加载周星榜返回
		public function LoadStarGiftRankRes( rank_ui:Array,next_star_gifts:Array, next_time:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_VideoStarGiftRankWeb;
			tojson.rank_ui = rank_ui;
			tojson.next_star_gifts = next_star_gifts;
			tojson.next_time = next_time;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//冠军榜返回
		public function LoadStarGiftChampionRankRes(ran_anchor:Array,rank_player:Array,none_config:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_VideoStarGiftChampionRankWeb;
			tojson.rank_anchor = ran_anchor;
			tojson.rank_player = rank_player;
			tojson.none_config = none_config;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//冠军通知
		public function StarGiftChampionNotify(gift_ids:Array,anchor_id:Int64):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_StarGiftChampionNotify;
			tojson.gift_ids = gift_ids;
			tojson.anchor_id = anchor_id.toString();
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		//主播周星礼物数据返回
		public function LoadAnchorStarGiftInfoRes(anchor_id:Int64,star_gifts:Array,match_info:AnchorWeekStarMatchInfo,sex:int,url:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_LoadAnchorStarGiftInfo;
			tojson.anchor_id = anchor_id.toString();
			tojson.star_gifts = star_gifts;
			tojson.match_info = match_info;
			tojson.sex = sex;
			tojson.url = url;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		//刷新主播周星礼物返回
		public function RefreshStarGiftInfo(cur_star_gifts:Array, star_gifts:Dictionary):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshStarGiftInfo;
			tojson.cur_star_gifts = cur_star_gifts;
			var arr:Array = new Array;
			for (var idx:String in star_gifts) {
				var obj:Object = new Object;
				obj.gift_id = idx;
				var giftdata:Object = CGiftConfig.getInstance().GetGiftData(parseInt(idx));
				if (giftdata != null) {
					obj.gift_name = giftdata.name;
					obj.gift_price = giftdata.price;
					obj.gift_icon = giftdata.icon;
				} else {
					obj.gift_name = "";
					obj.gift_price = "";
					obj.gift_icon = "";
				}
				obj.anchor_name = star_gifts[idx].anchor_name;
				obj.player_name = star_gifts[idx].player_name;
				arr.push(obj);
			}
			tojson.star_gifts = arr;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function NotifyLostVipSeat(seat_index:int, cost:int, player_nick:String, player_zone:String):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyLostVipSeat;
			tojson.seat_index = seat_index;
			tojson.cost = cost;
			tojson.player_nick = player_nick;
			tojson.player_zone = player_zone;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		public function TakeVipSeatRes(res:int, seat_index:int, balance:int,
			cost:int, pstid:Int64, seatinfo:VipSeatInfoForUI, free_times:int, charm:int):void {
			
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_TakeVipSeat;
			tojson.res = res;
			tojson.seat_index = seat_index;
			tojson.balance = balance;
			tojson.cost = cost;
			tojson.pstid = pstid.toString();
			tojson.seatinfo = seatinfo;
			tojson.free_times = free_times;
			tojson.charm = charm;
			jscallback.Apply(tojson.op_type, tojson, false);
		}
		
		public function RefreshVipSeats( list:Array ):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshVipSeats;
			tojson.list = list;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function NotifyVipTakeSeatProtectTime(seat_protect_time:Dictionary):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyVipTakeSeatProtectTime;
			// map转 array
			var seat_time:Array = new Array();
			for ( var key:Object in seat_protect_time )
			{
				var obj:Object = new Object;
				obj.seat = key;
				obj.time = seat_protect_time[key] / 60;//页面需要的是时间
				seat_time.push( obj );
			}
			tojson.seat_time = seat_time;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		/**
		 * 满座滚屏
		 * 注：xw81899取消该消息下发。
		 * @param msg
		 *
		 */
		public function NotifyVipTakeSeatFull(msg:String):void {
//			var tojson:Object = new Object;
//			tojson.op_type = VideoWebOperationType.VOT_NotifyVipTakeSeatFull;
//			tojson.msg = msg;
//			jscallback.Apply(tojson.op_type,tojson,false);
		}

		public function OnSeatPriceResetNotice(notice:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetSeatPriceResetNotice;
			tojson.notice = notice;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		
		public function NotifyVipFreeSeatLeft(free_times:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyVipFreeSeatLeft;
			tojson.free_times = free_times;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//抢梦幻宝箱
		public function OnGrabDreamBox(res:int,box_id:String,money_type:int,money_count:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GrabDreamBox;
			tojson.res = res;
			tojson.box_id = box_id;
			tojson.money_type = money_type;
			tojson.money_count = money_count;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//查看梦幻宝箱抢夺记录
		public function OnQueryDreamBoxRec(res:int,box_id:String,tolcnt:int,player_name:String,
										   total_money:int,grab_count:int,video_money_rate:int,vecs:Array):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_QueryDreamBoxRec;
			tojson.res = res;
			tojson.box_id = box_id;
			tojson.tolcnt = tolcnt;
			tojson.player_name = player_name;
			tojson.total_money = total_money;
			tojson.grab_count = grab_count;
			tojson.video_money_rate = video_money_rate;
			tojson.vecs = vecs;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//发布梦幻宝箱
		public function PublishDreamBox(box_count:int,info:DreamBoxForUI):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_PublishDreamBox;
			tojson.box_count = box_count;
			tojson.info = info;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//刷新梦幻宝箱数量
		public function RefreshDreamBoxCnt(box_count:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_RefreshDreamBoxCnt;
			tojson.box_count = box_count;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//火箭礼物飞屏
		public function ShowRocketGiftWhistle(player_name:String,anchor_name:String,player_zone:String,wealth_level:int,guard_level:int,
											  vip_level:int,rocket_cnt:int,room_id:int,is_nest:Boolean,player_id:Int64, invisible:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_ShowRocketGiftWhistle;
			tojson.player_name = player_name;
			tojson.anchor_name = anchor_name;
			tojson.player_zone = player_zone;
			tojson.wealth_level = wealth_level;
			tojson.guard_level = guard_level;
			tojson.vip_level = vip_level;
			tojson.rocket_cnt = rocket_cnt;
			tojson.room_id = room_id;
			tojson.is_nest = is_nest;
			tojson.player_id = player_id.toString();
			tojson.invisible = invisible;
			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//通知梦幻宝箱抢空
		public function NotifyDreamBoxGrabbedOut():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyDreamBoxGrabbedOut;

			jscallback.Apply(tojson.op_type,tojson,false);
		}
		//通知清空梦幻宝箱
		public function NotifyClearDreamBox():void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyClearDreamBox;
			
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		public function NotifyWebActivityGuide(is_act_guide_over:Boolean):void {
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyWebActivityGuide;
			tojson.is_act_guide_over = is_act_guide_over;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		public function GetVideoRoomLiveInfo():void
		{
			Globals.s_logger.log("resquestVideoRoomLiveInfo() : Globals.iframeRoomID = " + Globals.iframeRoomID + "  getFrameVid = " +getFrameVid);
			if(Globals.iframeRoomID != 0 && !getFrameVid)
			{
				getFrameVid = new TimerBase(5000,resquestVideoRoomLiveInfo);
				getFrameVid.StartTimer();
			}
		}
		
		private function resquestVideoRoomLiveInfo():void
		{
			Globals.s_logger.log("resquestVideoRoomLiveInfo() : Globals.iframeRoomID = " + Globals.iframeRoomID);
			m_videoClient.GetCX5VideoClient().GetInterfacesForUI().RequestGetVideoRoomLiveInfo();
		}
		
		public function OnCheckNickOnLoginRes(status:int,nick:String):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_NotifyCheckNickOnLogin;
			tojson.status = status;
			tojson.nick = nick;
			jscallback.Apply(tojson.op_type,tojson,false);
		}

		public function onIgnoreFreeGiftRes(ret:int, ignore:Boolean):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_IgnoreFreeGift;
			tojson.ret = ret;
			tojson.is_ignore = ignore;
			jscallback.Apply(tojson.op_type, tojson, false,true);
		}
		
		public function OnVideoClientSigVerifyRes(res:int):void
		{
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_VideoClientSigVerify;
			tojson.res = res;
			jscallback.Apply(tojson.op_type, tojson, false);//, true);
		}

		public function OnNotifyLastFreeLuckyDrawTime(last_free_lucky_draw_time:int, free_lucky_draw_interval:int, activity_begin_time:int, config_refresh_time:int):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_NotifyLastFreeLuckyDrawTime;
			tojson.last_free_lucky_draw_time = last_free_lucky_draw_time;
			tojson.free_lucky_draw_interval = free_lucky_draw_interval;
			tojson.activity_begin_time = activity_begin_time;
			tojson.config_refresh_time = config_refresh_time;
			tojson.server_time = m_videoClient.GetCX5VideoClient().GetServerTime();
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}

		/**
		 *
		 * @param res
		 * @param freeDrawTime
		 * @param configRefreshTime
		 * @param info
		 * @param notices
		 * @param queryRewards
		 *
		 */
		public function OnOpenLuckyDrawWindowRes(res:int, freeDrawTime:int, configRefreshTime:int, info:Object, notices:Array, queryRewards:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_OpenLuckyDrawWindow;
			tojson.res = res;
			tojson.last_free_lucky_draw_time = freeDrawTime;
			tojson.config_refresh_time = configRefreshTime;
			tojson.server_time = m_videoClient.GetCX5VideoClient().GetServerTime();
//			tojson.lucky_draw_price = CGiftConfig.getInstance().getLuckyDrawPrice();

			Globals.s_logger.debug("OnOpenLuckyDrawWindowRes info:"+JSON.stringify(info));
			var rewards:Array         = [];
			var rewards_x51:Array     = [];
			var sub_rewards:Array     = [];
			var sub_rewards_x51:Array = [];
			var rewards_x52:Array     = [];
			var sub_rewards_x52:Array = [];

			var gameindex:int         = 0;
			gameindex = parseRewardDataForUIList(info["rewards"], rewards, queryRewards, gameindex);
			info["rewards"] = rewards;
			
			gameindex = parseRewardDataForUIList(info["rewards_x51"], rewards_x51, queryRewards, gameindex);
			info["rewards_x51"] = rewards_x51;

			gameindex = parseRewardDataForUIList(info["sub_rewards"], sub_rewards, queryRewards, gameindex);
			info["sub_rewards"] = sub_rewards;
			Globals.s_logger.debug("OnOpenLuckyDrawWindowRes sub_rewards:"+JSON.stringify(info["sub_rewards"] ));

			gameindex = parseRewardDataForUIList(info["sub_rewards_x51"], sub_rewards_x51, queryRewards, gameindex);
			info["sub_rewards_x51"] = sub_rewards_x51;

			gameindex = parseRewardDataForUIList(info["rewards_x52"], rewards_x52, queryRewards, gameindex);
			info["rewards_x52"] = rewards_x52;
			
			gameindex = parseRewardDataForUIList(info["sub_rewards_x52"], sub_rewards_x52, queryRewards, gameindex);
			info["sub_rewards_x52"] = sub_rewards_x52;

			for each (var noticeObj:Object in notices) {
				var ntc_RewardData:RewardDataForUI = noticeObj["reward"];
				if (VideoChannelType.IsQueryReaward(ntc_RewardData.channel)) {
					noticeObj["reward"] = rewardmanager.GameRewardToRewardForUI(queryRewards[gameindex++]);
				} else {
					if (ntc_RewardData.type == ERewardType.R_Game || ntc_RewardData.type == ERewardType.R_Skin) {
						var noticeReward:RewardForUI = new RewardForUI();
						var noticeGiftData:Object    = CGiftConfig.getInstance().GetGiftData(ntc_RewardData.rewardId);
						if (noticeGiftData != null) {
							noticeReward.id = noticeGiftData.id;
							noticeReward.name = noticeGiftData.name;
							if (noticeGiftData.css_url != null) {
								noticeReward.url = noticeGiftData.css_url;
							} else {
								noticeReward.url = noticeGiftData.icon;
							}
							noticeReward.tips = noticeGiftData.intro;
						}
						noticeReward.price = noticeGiftData.price;
						noticeReward.CCY = rewardmanager.getCCY(ntc_RewardData.type);
						noticeReward.count_desc = "" + ntc_RewardData.count;
						noticeReward.rare = ntc_RewardData.rare;
//						rewardForUI.star_gift = ntc_RewardData.star_gift;
						noticeObj["reward"] = noticeReward;
						
						
						Globals.s_logger.debug("go VideoChannelType if" + JSON.stringify(noticeObj["reward"]));
					} else if(ntc_RewardData.type == ERewardType.R_VideoFreeBarrage){
						var rewardForUI:RewardForUI = new RewardForUI();
						rewardForUI.name = "弹幕";
						rewardForUI.type = ntc_RewardData.type;
						rewardForUI.count_desc = "" + ntc_RewardData.count;
						rewardForUI.url = "/items/item_danmu.png";
						rewardForUI.rare = ntc_RewardData.rare;
//						rewardForUI.star_gift = ntc_RewardData.star_gift;
						
						noticeObj["reward"] = rewardForUI;
						Globals.s_logger.debug("go VideoChannelType R_VideoFreeBarrage" + JSON.stringify(noticeObj["reward"]));
					} else {
						var rewardForUI:RewardForUI = rewardmanager.RewardToRewardForUI(ntc_RewardData.type, ntc_RewardData.rewardId, ntc_RewardData.count);
						if(ntc_RewardData.type == ERewardType.R_DreamGift){
							var dreamGiftData:Object = CGiftConfig.getInstance().GetGiftData(ntc_RewardData.rewardId);
							if (dreamGiftData != null) {
								rewardForUI.price = dreamGiftData.price;
								rewardForUI.CCY = rewardmanager.getCCY(ntc_RewardData.type);
//								rewardForUI.star_gift = ntc_RewardData.star_gift;
							}
						}
						rewardForUI.rare = ntc_RewardData.rare;
						noticeObj["reward"] = rewardForUI;
						
						Globals.s_logger.debug("go VideoChannelType else" + JSON.stringify(noticeObj["reward"]));
					}
				}
			}

			tojson.info = info;
			tojson.notices = notices;
			tojson.hasgame = gameindex > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		/**
		 * 解析RewardDataForU类型奖励，下面所有参数必传，返回当前game奖励的索引值。
		 * @param srcRewards
		 * @param outRewards
		 * @param queryRewards
		 * @param queryIndex
		 * @return 
		 * 
		 */		
		private function parseRewardDataForUIList(srcRewards:Array, outRewards:Array, queryRewards:Array, queryIndex:int):int{
			for each (var rewardDataUI:RewardDataForUI in srcRewards) {
				if (VideoChannelType.IsQueryReaward(rewardDataUI.channel)) {
//					var gameReward:RewardForUI = rewardmanager.GameRewardToRewardForUI(queryRewards[queryIndex++]);
//					gameReward.rare = rewardDataUI.rare;
//					outRewards.push(gameReward);
					outRewards.push(rewardmanager.GameRewardToRewardForUI(queryRewards[queryIndex++]));
					Globals.s_logger.debug("GameRewardToRewardForUI: "+JSON.stringify(outRewards));
					
				} else {
					Globals.s_logger.debug("GameRewardToRewardForUI else: "+JSON.stringify(srcRewards));
					if (rewardDataUI.type == ERewardType.R_Game || rewardDataUI.type == ERewardType.R_Skin) {
						var gameReward:RewardForUI = new RewardForUI();
						var giftData:Object        = CGiftConfig.getInstance().GetGiftData(rewardDataUI.rewardId);
						if (giftData != null) {
							gameReward.id = giftData.id;
							gameReward.name = giftData.name;
							if (giftData.css_url != null) {
								gameReward.url = giftData.css_url;
							} else {
								gameReward.url = giftData.icon;
							}
							gameReward.tips = giftData.intro;
						}
						gameReward.type = rewardDataUI.type;
						gameReward.price = giftData.price;
						gameReward.CCY = rewardmanager.getCCY(rewardDataUI.type);
						gameReward.count_desc = "" + rewardDataUI.count;
						gameReward.rare = rewardDataUI.rare;
//						gameReward.star_gift = rewardDataUI.star_gift;
						
						outRewards.push(gameReward);
						
						Globals.s_logger.debug("rewardDataUI.type == ERewardType.R_Game: "+JSON.stringify(outRewards));
					}else if(rewardDataUI.type == ERewardType.R_VideoFreeBarrage){
						var gameReward:RewardForUI = new RewardForUI();
						gameReward.name = "弹幕";
						gameReward.type = rewardDataUI.type;
						gameReward.count_desc = "" + rewardDataUI.count;
						gameReward.url = "/items/item_danmu.png";
						gameReward.rare = rewardDataUI.rare;
//						gameReward.star_gift = rewardDataUI.star_gift;
						outRewards.push(gameReward);
						
						Globals.s_logger.debug("rewardDataUI.type == ERewardType.R_VideoFreeBarrage: "+JSON.stringify(outRewards));
					}else {
						var gameReward2:RewardForUI = rewardmanager.RewardToRewardForUI(rewardDataUI.type, rewardDataUI.rewardId, rewardDataUI.count);
						if(rewardDataUI.type == ERewardType.R_DreamGift){
							var dreamGiftData:Object = CGiftConfig.getInstance().GetGiftData(rewardDataUI.rewardId);
							if (dreamGiftData != null) {
								gameReward2.price = dreamGiftData.price;
								gameReward2.CCY = rewardmanager.getCCY(rewardDataUI.type);
//								gameReward2.star_gift = rewardDataUI.star_gift;
							}
						}
						gameReward2.rare = rewardDataUI.rare;
						outRewards.push(gameReward2);
					}
				}
			}
			return queryIndex;
		}

		public function OnLuckyDrawRes(res:int, freeDrawTime:int, balance:int, star_gifts:Array, rewards:Array, queryRewards:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_LuckyDraw;
			tojson.res = res;
			tojson.last_free_lucky_draw_time = freeDrawTime;
			tojson.server_time = m_videoClient.GetCX5VideoClient().GetServerTime();
			tojson.balance = balance;
			tojson.star_gifts = star_gifts;

			var rewardUIList:Array = [];
			var gameindex:int      = 0;
			gameindex = parseRewardDataForUIList(rewards, rewardUIList, queryRewards, gameindex);
			tojson.rewards = rewardUIList;
			tojson.hasgame = gameindex > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function OnNoticeLuckyDraw(nick:String, reward:RewardDataForUI, queryRewards:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_NoticeLuckyDraw;
			var notice:Object = {};
			notice.nick = nick;
			if (VideoChannelType.IsQueryReaward(reward.channel)) {
				notice.reward = rewardmanager.GameRewardToRewardForUI(queryRewards[0]);
			} else {
				if (reward.type == ERewardType.R_Game || reward.type == ERewardType.R_Skin) {
					var gameReward:RewardForUI = new RewardForUI();
					var giftData:Object        = CGiftConfig.getInstance().GetGiftData(reward.rewardId);
					if (giftData != null) {
						gameReward.id = giftData.id;
						gameReward.name = giftData.name;
						if (giftData.css_url != null) {
							gameReward.url = giftData.css_url;
						} else {
							gameReward.url = giftData.icon;
						}
						gameReward.tips = giftData.intro;
					}
					gameReward.count_desc = "" + reward.count;
					notice.reward = gameReward;
				}else if(reward.type == ERewardType.R_VideoFreeBarrage){
					var gameReward:RewardForUI = new RewardForUI();
					gameReward.name = "弹幕";
					gameReward.type = reward.type;
					gameReward.url = "/items/item_danmu.png";
					gameReward.count_desc =""+ reward.count;
					notice.reward = gameReward;
				}else {
					notice.reward = rewardmanager.RewardToRewardForUI(reward.type, reward.rewardId, reward.count);
				}
			}
			notice.reward.rare = reward.rare;
//			notice.reward.star_gift = reward.star_gift;
			
			tojson.notice = notice;
			tojson.hasgame = queryRewards.length > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}

		public function OnUpdateLuckyDrawInfo(config_refresh_time:int, info:Object, queryRewards:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_UpdateLuckyDrawInfo;
			tojson.config_refresh_time = config_refresh_time;
			tojson.server_time = m_videoClient.GetCX5VideoClient().GetServerTime();

			var rewards:Array         = [];
			var rewards_x51:Array     = [];
			var sub_rewards:Array     = [];
			var sub_rewards_x51:Array = [];
			var rewards_x52:Array     = [];
			var sub_rewards_x52:Array = [];

			var gameindex:int         = 0;
			gameindex = parseRewardDataForUIList(info["rewards"], rewards, queryRewards, gameindex);
			info["rewards"] = rewards;

			gameindex = parseRewardDataForUIList(info["rewards_x51"], rewards_x51, queryRewards, gameindex);
			info["rewards_x51"] = rewards_x51;

			gameindex = parseRewardDataForUIList(info["sub_rewards"], sub_rewards, queryRewards, gameindex);
			info["sub_rewards"] = sub_rewards;

			gameindex = parseRewardDataForUIList(info["sub_rewards_x51"], sub_rewards_x51, queryRewards, gameindex);
			info["sub_rewards_x51"] = sub_rewards_x51;

			gameindex = parseRewardDataForUIList(info["rewards_x52"], rewards_x52, queryRewards, gameindex);
			info["rewards_x52"] = rewards_x52;

			gameindex = parseRewardDataForUIList(info["sub_rewards_x52"], sub_rewards_x52, queryRewards, gameindex);
			info["sub_rewards_x52"] = sub_rewards_x52;

			tojson.info = info;
			tojson.hasgame = gameindex > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}

		public function OnGetPunchInInfo(info:Object, queryRewards:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_GetPunchInInfo;

			var gameindex:int = 0;
			for (var idx:int = 0; idx < info["accumulate_rewards"].length; idx++) {
				var ainfo:AccumulateRewards = info["accumulate_rewards"][idx];
				var rewards:Array           = [];
				for each (var rewardDataUI:RewardDataForUI in ainfo.rewards) {
					if (VideoChannelType.IsQueryReaward(rewardDataUI.channel)) {
						rewards.push(rewardmanager.GameRewardToRewardForUI(queryRewards[gameindex++]));
					} else {
						if (rewardDataUI.type == ERewardType.R_Game || rewardDataUI.type == ERewardType.R_Skin) {
							var giftReward:RewardForUI = new RewardForUI();
							var giftData:Object        = CGiftConfig.getInstance().GetGiftData(rewardDataUI.rewardId);
							if (giftData != null) {
								giftReward.id = giftData.id;
								giftReward.name = giftData.name;
								if (giftData.css_url != null) {
									giftReward.url = giftData.css_url;
								} else {
									giftReward.url = giftData.icon;
								}
								giftReward.tips = giftData.intro;
							}
							giftReward.count_desc = "" + rewardDataUI.count;
							rewards.push(giftReward);
						} else if(rewardDataUI.type == ERewardType.R_VideoFreeBarrage){
							var giftReward:RewardForUI = new RewardForUI();
							giftReward.name = "弹幕";
							giftReward.type = rewardDataUI.type;
							giftReward.url="/items/item_danmu.png";
							giftReward.count_desc = rewardDataUI.count+"";
							rewards.push(giftReward);
						}else {
							rewards.push(rewardmanager.RewardToRewardForUI(rewardDataUI.type, rewardDataUI.rewardId, rewardDataUI.count));
						}
					}
				}
				ainfo.rewards = rewards;
			}
			tojson.info = info;
			tojson.hasgame = gameindex > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		public function OnPunchIn(info:Object, queryRewards:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_PunchIn;
			
			var gameindex:int = 0;
			var rewards:Array = [];
			for each (var rewardDataUI:RewardDataForUI in info["rewards"]) {
				if (VideoChannelType.IsQueryReaward(rewardDataUI.channel)) {
					rewards.push(rewardmanager.GameRewardToRewardForUI(queryRewards[gameindex++]));
				} else {
					if (rewardDataUI.type == ERewardType.R_Game || rewardDataUI.type == ERewardType.R_Skin) {
						var giftReward:RewardForUI = new RewardForUI();
						var giftData:Object        = CGiftConfig.getInstance().GetGiftData(rewardDataUI.rewardId);
						if (giftData != null) {
							giftReward.id = giftData.id;
							giftReward.name = giftData.name;
							if (giftData.css_url != null) {
								giftReward.url = giftData.css_url;
							} else {
								giftReward.url = giftData.icon;
							}
							giftReward.tips = giftData.intro;
						}
						giftReward.count_desc = "" + rewardDataUI.count;
						rewards.push(giftReward);
					}else if(rewardDataUI.type == ERewardType.R_VideoFreeBarrage){
						var giftReward:RewardForUI = new RewardForUI();
						giftReward.name = "弹幕";
						giftReward.type = rewardDataUI.type;
						giftReward.url="/items/item_danmu.png";
						giftReward.count_desc = rewardDataUI.count+"";
						rewards.push(giftReward);
					} else {
						rewards.push(rewardmanager.RewardToRewardForUI(rewardDataUI.type, rewardDataUI.rewardId, rewardDataUI.count));
					}
				}
			}
			info["rewards"] = rewards;
			tojson.info = info;
			tojson.hasgame = gameindex > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false);
		}
		
		//弃用：主播端消息
		public function OnNotifyPunchIn(nick:String, zone:String, charm:int):void{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_NotifyPunchIn;
			tojson.nick = nick;
			tojson.zone = zone;
			tojson.charm = charm;
//			jscallback.Apply(tojson.op_type, tojson, false, true);
		}

		public function OnNotifyUnlockRoomSkinTaskInfo(room_id:int, skin_id:int, task_list:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_UnlockRoomSkinTaskInfo;
			tojson["room_id"] = room_id;
			tojson["skin_id"] = skin_id;
			tojson["task_list"] = task_list;
			jscallback.Apply(tojson.op_type, tojson, false);
		}
		public function OnNewRoomSkinBroadcastAllPlayer(broadInfo:Object):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_NewRoomSkinBroadcastAllPlayer;
			tojson["info"] = broadInfo;
			jscallback.Apply(tojson.op_type, tojson, false);
		}
		public function OnNotifyRoomSkinLevelUpTaskInfo(taskInfo:Object):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RoomSkinLevelUpTaskInfo;
			tojson["info"] = taskInfo;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function OnNotifyRoomSkinDailyTaskInfo(taskInfo:Object):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RoomSkinDailyTaskInfo;
			tojson["info"] = taskInfo;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function OnNotifyRoomSkinLevelUp(info:Object):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RoomSkinLevelUpNotify;
			tojson["info"] = info;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function OnNotifyRoomDailyTaskRewards(room_id:int, rewards:Array, queryRewards:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RoomDailyTaskRewards;
			tojson["room_id"] = room_id;
			var newRewards:Array = new Array();
			var gameindex:int    = 0;
			
			gameindex = parseRewardDataForUIList(rewards, newRewards, queryRewards, gameindex);
//			for (var index:int = 0; index < rewards.length; index++) {
//				var rew:RewardDataForUI = rewards[index];
//				if (VideoChannelType.IsQueryReaward(rew.channel))
//					newRewards.push(rewardmanager.GameRewardToRewardForUI(queryRewards[gameindex++]));
//				else
//					newRewards.push(rewardmanager.RewardToRewardForUI(rew.type, rew.rewardId, rew.count));
//			}
			tojson["rewards"] = newRewards;
			tojson["hasgame"] = gameindex > 0 ? true : false;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function OnNotifyRoomCharmBroadcastAllRoom(broadInfo:Object):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_VideoRoomCharmBroadcastAllRoom;
			tojson["info"] = broadInfo;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function OnLoadRoomCharmRank(res:int, ranks:Array, timedimension:int, totalSize:int):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshRoomCharmRank;
			tojson.res = res;
			tojson.ranks = ranks;
			tojson.timedimension = timedimension;
			tojson.total_size = totalSize;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		public function OnQuerySkinGift(res:int, skin_gifts:Array):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_QuerySkinGift;
			tojson["res"] = res;
			tojson["skin_gifts"] = skin_gifts;
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function onGetSystemTime():void {
			if (m_videoClient != null && m_videoClient.GetCX5VideoClient()) {
				var tojson:Object = new Object();
				tojson.op_type = VideoWebOperationType.VOT_GET_SYSTEM_TIME;
				tojson.server_time = m_videoClient.GetCX5VideoClient().GetServerTime();
				jscallback.Apply(tojson.op_type, tojson, false, true);
			}
		}

		public function OnNotifyVideoAD(adInfo:Object):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_AD;
			tojson.ad = adInfo;
			tojson.server_time = m_videoClient.GetCX5VideoClient().GetServerTime();
			jscallback.Apply(tojson.op_type, tojson, false);
		}

		public function NoticeBuyVip(player_name:String, weath_level:int, vip_level:int, anchor_name:String):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_NoticeBuyVip;
			tojson.player_name = player_name;
			tojson.weath_level = weath_level;
			tojson.vip_level = vip_level;
			tojson.anchor_name = anchor_name;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}

		public function NoticeConnectMsg(res:int):void {
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_CONNECT_MSG;
			tojson.res = res;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//主播PK总榜
		public function onRefreshAnchorPKRank(e:CEventRefreshAnchorPKRank):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshAnchorPKRank;
			tojson.m_anchor_pk_value = e.m_anchor_pk_value.toString();
			
			var m_rank:Array = [];
			
			for each(var videoAnchorPKRank:VideoAnchorPKRank in e.m_rank)
			{
				var o:Object = {};
				o.m_anchor_id = videoAnchorPKRank.m_anchor_id.toString();
				o.m_anchor_level = videoAnchorPKRank.m_anchor_level;
				o.m_anchor_name = videoAnchorPKRank.m_anchor_name;
				o.m_anchor_starlight = videoAnchorPKRank.m_anchor_starlight.toString();
				o.m_pk_value = videoAnchorPKRank.m_pk_value.toString();
				o.m_record_id = videoAnchorPKRank.m_record_id;
				o.m_session = videoAnchorPKRank.m_session;
				o.m_onboard_time = videoAnchorPKRank.m_onboard_time;
				
				m_rank.push(o);
			}
			
			tojson.m_rank = m_rank;
			
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//玩家贡献榜
		public function onRefreshPlayerContributePKRank(e:CEventRefreshPlayerContributePKRank):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshPlayerContributePKRank;
			
			var m_rank:Array = [];
			
			for each(var playerContributePKRank:PlayerContributePKRank in e.m_rank)
			{
				var o:Object = {};
				o.m_player_id = playerContributePKRank.m_player_id.toString();
				o.m_pk_score = playerContributePKRank.m_pk_score.toString();
				o.m_wealth = playerContributePKRank.m_wealth.toString();
				o.m_level = playerContributePKRank.m_level;
				o.m_onboard_time = playerContributePKRank.m_onboard_time;
				o.m_nick = playerContributePKRank.m_nick;
				
				m_rank.push(o);
			}
			
			tojson.m_rank = m_rank;
			
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//刷新火箭buff 主动下发
		public function onRefreshRocketBuff(e:CEventRefreshRocketBuff):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshRocketBuff;
			tojson.room_id = e.room_id;
			tojson.buff_end_time = e.buff_end_time;
			tojson.buff_left_time = e.buff_left_time;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//刷新pk赛进度条信息，10s一次
		public function onRefreshPkProgressInfo(e:CEventRefreshPkProgressInfo):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshPkProgressInfo;
			tojson.m_first_anchor_id = e.m_first_anchor_id.toString();
			if (e.m_first_anchor_url != "") {
				//XW79794 去除头像随机数
				tojson.m_first_anchor_url = Globals.m_pic_download_url + "/qdancersec/" + e.m_first_anchor_url; //+ "/0" + URLSuffix.CreateVersionString();
			}else{
				tojson.m_first_anchor_url = "";
			}
			tojson.m_first_anchor_name = e.m_first_anchor_name;
			tojson.m_first_anchor_pk_value = e.m_first_anchor_pk_value.toString();
			tojson.m_second_anchor_id = e.m_second_anchor_id.toString();
			if (e.m_second_anchor_url != "") {
				//XW79794 去除头像随机数
				tojson.m_second_anchor_url = Globals.m_pic_download_url + "/qdancersec/" + e.m_second_anchor_url; //+ "/0" + URLSuffix.CreateVersionString();
			}else{
				tojson.m_second_anchor_url = "";
			}
			tojson.m_second_anchor_name = e.m_second_anchor_name;
			tojson.m_second_anchor_pk_value = e.m_second_anchor_pk_value.toString();
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//刷新pk比赛信息，包括比赛开始倒计时，开始比赛，比赛结束的结果通知
		public function onNotifyPkMatchInfo(e:CEventNotifyPkMatchInfo):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_NotifyPkMatchInfo;
			tojson.m_pk_status = e.m_pk_status;
			tojson.m_begin_time = e.m_begin_time;
			tojson.m_end_time = e.m_end_time;
			tojson.m_pk_status = e.m_pk_status;
			tojson.m_first_anchor_id = e.m_first_anchor_id.toString();
			tojson.m_second_anchor_id = e.m_second_anchor_id.toString();
			tojson.m_first_pk_value = e.m_first_pk_value.toString();
			tojson.m_second_pk_value = e.m_second_pk_value.toString();
			tojson.m_left_time = e.m_left_time;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//刷新pk值信息，1s一次
		public function onRefreshPkValue(e:CEventRefreshPkValue):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshPkValue;
			tojson.m_first_anchor_id = e.m_first_anchor_id.toString();
			tojson.m_first_anchor_pk_value = e.m_first_anchor_pk_value.toString();
			tojson.m_second_anchor_id = e.m_second_anchor_id.toString();
			tojson.m_second_anchor_pk_value = e.m_second_anchor_pk_value.toString();
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		//刷新pk礼物，pk的角标
		public function onRefreshPkGift(e:CEventRefreshPkGift):void
		{
			giftPKManage.videoPKGiftInfoList = e.gift_list;
			onRefreshPkGiftForUI(giftPKManage.videoPKGiftInfoListForUI);
		}
		
		//刷新pk礼物，pk的角标
		public function onRefreshPkGiftForUI(arr:Array):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshPkGift;
			tojson.gift_list = arr;
			jscallback.Apply(tojson.op_type, tojson, false);
		}
		//向客户端发送通用活动开始信息
		public function onCommonActivityInfoBegin(e:CEventCommonActivityInfoBegin):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_CommonActivityInfoBegin;
			tojson.m_activity_id = e.m_activity_id.toString();
			tojson.m_end_time = e.m_end_time.toString();
			tojson.m_gift_id = e.m_gift_id.toString();
			tojson.m_max_send_num =  e.m_max_send_num.toString();
			tojson.m_more_detail_url = e.m_more_detail_url.toString();
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		//向客户端发送通用活动结束信息
		public function onCommonActivityInfoEnd(e:CEventCommonActivityInfoEnd):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_CommonActivityInfoEnd;
			tojson.m_activity_id = e.m_activity_id.toString();			
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		//向客户端发送通用活动配置更新信息
		public function onCommonActivityInfoRefresh(e:CEventCommonActivityInfoRefresh):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_CommonActivityInfoRefresh;
			tojson.m_activity_id = e.m_activity_id.toString();
			tojson.m_end_time = e.m_end_time.toString();
			tojson.m_gift_id = e.m_gift_id.toString();
			tojson.m_max_send_num = e.m_max_send_num.toString();
			tojson.m_more_detail_url = e.m_more_detail_url.toString();			
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		//向客户端发送通用活动地板数据信息（包括主播排名，主播收到的礼物数，底板等级）
		public function onRefreshCommonActivityData(e:CEventRefreshCommonActivityData):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_RefreshCommonActivityData;
			tojson.m_activity_id = e.m_activity_id.toString();
			tojson.m_anchor_rank = e.m_anchor_rank.toString();
			tojson.m_pannel_level = e.m_pannel_level.toString();
			tojson.m_recv_gift_count = e.m_recv_gift_count.toString();		
			tojson.m_is_level_up = e.m_is_level_up.toString();
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		//向客户端发送的玩家贡献榜信息
		public function onCommonActivityPlayerRank(e:CEventCommonActivityPlayerRank):void
		{
			var tojson:Object = new Object();
			tojson.op_type = VideoWebOperationType.VOT_CommonActivityPlayerRank;
			var m_rank:Array = [];			
			for each(var ActivityPlayerRank:CEventCommonActivityPlayerRankModel in e.m_rank)
			{
				var o:Object = {};
				o.m_player_nick = ActivityPlayerRank.m_player_nick.toString();
				o.m_score = ActivityPlayerRank.m_score.toString();
				o.m_video_wealth_level = ActivityPlayerRank.m_video_wealth_level.toString();
				m_rank.push(o);
			}
			tojson.m_rank = m_rank;			 
			
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		//通知所有移动管理员的pstid:信息 新消息接口
		public function PushAllUserAdminList(res:Array):void
		{
			Globals.s_logger.debug("PushAllUserAdminList res = " + res.length);
			var tojson:Object = new Object;
			tojson.op_type = VideoWebOperationType.VOT_GetAllUserAdminList;
			var resList:Array = new Array();
			for (var idx:int; idx<res.length; idx++ )
			{
				resList[idx] = res[idx].toString();
			}
			tojson.res = resList;
			Globals.s_logger.debug("PushAllUserAdminList tojson.res = " + tojson.res);
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function PushRoomBanNotice(m_room_id:int,m_banned:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.m_room_id = m_room_id;
			tojson.m_banned = m_banned;
			tojson.op_type = VideoWebOperationType.VOT_PushRoomBanNotice;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function HandleNotifySecretHeatBoxInfo(diff_value:Array, title:String, content:String):void
		{
			var tojson:Object = new Object;
			tojson.diffValue = diff_value;
			tojson.title = title;
			tojson.content = content;
			tojson.op_type = VideoWebOperationType.VOT_NotifySecretHeatBoxInfo;
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleNotifyAnchorSecretCode(secret_code:String):void
		{
			var tojson:Object = new Object;
			tojson.secretCode = secret_code;
			tojson.op_type = VideoWebOperationType.VOT_NotifyAnchorSecretCode;
			Globals.s_logger.debug("handleNotifyAnchorSecretCode page msg =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleNotifyPlayerSecretHeatBox(last_seconds:int, end_time:int, box_id:int):void
		{
			var tojson:Object = new Object;
			tojson.lastSeconds = last_seconds;
			tojson.endTime = end_time;
			tojson.boxId = box_id;
			tojson.op_type = VideoWebOperationType.VOT_NotifyPlayerSecretHeatBox;
			Globals.s_logger.debug("handleNotifyPlayerSecretHeatBox page msg =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleNotifyLastHitPlayerReward(rewards:Array, gift:Array):void
		{
			var tojson:Object = new Object;
			var newRewards:Array = new Array;
			var gameindex:int = 0;
			
			tojson.op_type = VideoWebOperationType.VOT_NotifyLastHitPlayerReward;
			Globals.s_logger.debug("handleNotifyLastHitPlayerReward1 page msg =  " + JSON.stringify(rewards)  + "@@@@@@@@@@@@@@" + JSON.stringify(gift));
			for ( var index:int =0 ; index < rewards.length; index ++)
			{
				var rew:BoxRewardForUI = rewards[index];
				if( VideoChannelType.IsQueryReaward(rew.channel))
					newRewards.push(rewardmanager.GameRewardToRewardForUI( gift[gameindex++]));
				else
					newRewards.push( rewardmanager.RewardToRewardForUI(rew.reward_type,rew.reward_id,rew.reward_cnt));
			}
			tojson.truelyReward = newRewards;
			tojson.hasgame = gameindex>0 ?true:false;
			Globals.s_logger.debug("handleNotifyLastHitPlayerReward page msg =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
		public function handleWhistleLastHitPlayer(guard_level:int, wealth_level:int, vip_level:int, zone_name:String, nick_name:String, text:String, has_portrait:int, player_pstid:Int64, invisible:Boolean):void
		{
			var tojson:Object = new Object;
			tojson.guardLevel = guard_level;
			tojson.wealthLevel = wealth_level;
			tojson.vipLevel = vip_level;
			tojson.zoneName = zone_name;
			tojson.nickName = nick_name;
			tojson.text = text;
			tojson.hasPortrait = has_portrait;
			tojson.playerPstid = player_pstid.toString();
			tojson.invisible = invisible;
			tojson.op_type = VideoWebOperationType.VOT_WhistleLastHitPlayer;
			Globals.s_logger.debug("handleWhistleLastHitPlayer page tojson =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleConcertPlaybackRoomGetRoomListRes(total_cnt:int, rooms:Array):void
		{
			var tojson:Object = new Object;
			tojson.totalCnt = total_cnt;
			tojson.rooms = rooms;
			tojson.op_type = VideoWebOperationType.VOT_ConcertPlaybackRoomGetRoomList;
			Globals.s_logger.debug("handleConcertPlaybackRoomGetRoomListRes page tojson =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleStartConcertPlaybackRes(error_code:int, concert_id:int, video_url:String):void
		{
			var tojson:Object = new Object;
			tojson.error_code = error_code;
			tojson.concert_id = concert_id;
			tojson.video_url = video_url;
			tojson.op_type = VideoWebOperationType.VOT_StartConcertPlayback;
			Globals.s_logger.debug("handleStartConcertPlaybackRes page tojson =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleWeekStarConfigRsp(player_url:String):void
		{
			var tojson:Object = new Object;
			tojson.player_url = player_url;
			tojson.op_type = VideoWebOperationType.VOT_WeekStarURLConfig;
			Globals.s_logger.debug("handleWeekStarConfigRsp page tojson =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleAnchorWeekStarLevelUpNotify(grade:int, sub_level:int, grade_name:String, posing_url:String):void
		{
			var tojson:Object = new Object;
			tojson.grade = grade;
			tojson.sub_level = sub_level;
			tojson.grade_name = grade_name;
			tojson.posing_url = posing_url;
			tojson.op_type = VideoWebOperationType.VOT_AnchorWeekStarLevelUpNotify;
			Globals.s_logger.debug("handleAnchorWeekStarLevelUpNotify page tojson =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleAnchorWeekStarMatchSettleNotify(last_week_score:int, total_score:int, total_rank:int, group_name:String, sub_rank:int, previous_diff:int):void
		{
			var tojson:Object = new Object;
			tojson.last_week_score = last_week_score;
			tojson.total_score = total_score;
			tojson.total_rank = total_rank;
			tojson.group_name = group_name;
			tojson.sub_rank = sub_rank;
			tojson.previous_diff = previous_diff;
			tojson.op_type = VideoWebOperationType.VOT_AnchorWeekStarMatchSettleNotify;
			Globals.s_logger.debug("handleAnchorWeekStarMatchSettleNotify page tojson =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		public function handleRefreshWeekStarRankRes(res:int, rank:Array, contribute_player:Object, groups:Array, total_size:int, settle_time:int):void
		{
			var tojson:Object = new Object;
			tojson.res = res;
			tojson.rank = rank;
			tojson.contribute_player = contribute_player;
			tojson.groups = groups;
			tojson.total_size = total_size;
			tojson.settle_time = settle_time;
			tojson.op_type = VideoWebOperationType.VOT_GetWeekStarRankList;
			Globals.s_logger.debug("handleRefreshWeekStarRankRes page tojson =  " + JSON.stringify(tojson));
			jscallback.Apply(tojson.op_type, tojson, false, true);
		}
		
	}
}