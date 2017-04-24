package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.VideoCharInfo;
	import com.h3d.qqx5.common.event.CEventFollowAnchorOp;
	import com.h3d.qqx5.common.event.CEventFollowAnchorOpRes;
	import com.h3d.qqx5.common.event.CEventLoadFollowingAnchorInfoRes;
	import com.h3d.qqx5.common.event.CEventLoadPlayerInfoForHomePage;
	import com.h3d.qqx5.common.event.CEventLoadPlayerInfoForHomePageRes;
	import com.h3d.qqx5.common.event.CEventSetInvisibleOp;
	import com.h3d.qqx5.common.event.CEventSetInvisibleOpRes;
	import com.h3d.qqx5.common.event.CEventVideoRoomModifyNick;
	import com.h3d.qqx5.common.event.CEventVideoRoomModifyNickRes;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.enum.ClientDeviceType;
	import com.h3d.qqx5.enum.PlayerSex;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_vip.shared.VideoVipOperationResult;
	import com.h3d.qqx5.tqos.TQOSFollowAnchor;
	import com.h3d.qqx5.util.AccountCookieConst;
	import com.h3d.qqx5.util.ClientClock;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.URLSuffix;
	import com.h3d.qqx5.video_service.serviceinf.FollowAnchorType;
	import com.h3d.qqx5.videoclient.data.CFollowedAnchorInfoForHomePage;
	import com.h3d.qqx5.videoclient.data.CVideoPlayerInfo;
	import com.h3d.qqx5.videoclient.data.ChatChannel;
	import com.h3d.qqx5.videoclient.data.CreditsLevel;
	import com.h3d.qqx5.videoclient.data.DreamGiftForUI;
	import com.h3d.qqx5.videoclient.data.FollowedAnchorInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoClientCharInfo;
	import com.h3d.qqx5.videoclient.data.VideoRoomFollowErrorNo;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import com.h3d.qqx5.videoclient.data.WebColor;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientPlayer;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientPlayerOPCallback;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoVipConfig;
	
	import flash.utils.Dictionary;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;

	/**
	 * @author liuchui
	 */
	
	public class VideoClientPlayer implements IVideoClientPlayer
	{
		private var m_video_client_internal:IVideoClientInternal;
		private var m_client_base:CVideoClientBase;
		private var m_callback:IVideoClientPlayerOPCallback;
		private var _serverClock:ClientClock = new ClientClock;
		//web端用的新个人信息数据缓存。
		private var m_video_char_info :CVideoPlayerInfo = null;
		private var m_follow_anchors:Array = new Array;
		private var m_charnfo:VideoCharInfo;
		private static var s_nCharInfoCacheExpireTime:int = 15;
		private var m_nCharInfoCacheExpireTime:int = 0;
		private var m_CharInfoTimer:TimerBase = null;
		private var m_bNeedCallback:Boolean = false;
		public function VideoClientPlayer(client_internal:IVideoClientInternal , client_base:CVideoClientBase)
		{
			m_video_client_internal = client_internal;
			m_client_base = client_base;
			m_CharInfoTimer = new TimerBase(1000,ChangeTime);
			m_charnfo = new VideoCharInfo;
		}	
		public function ClearClientData():void
		{
			m_video_char_info = null;
		}
		public function SetPlayerOpCallback(call_back:IVideoClientPlayerOPCallback):void
		{
			m_callback = call_back;
		}
		
		public function GetVideoLevel():int
		{
			if(m_video_char_info == null)
			{
				return 0;
			}
			return m_video_char_info.video_level;
		}
		
		public function GetPhotoUrl():String
		{
			if(m_video_char_info == null)
			{
				return "";
			}
//			return m_video_char_info.photo_url;
			if( m_video_char_info.m_player_url != "" && m_video_char_info.photo_url != "")
			{
				return Globals.m_pic_download_url + "/qdancersec/" +  m_video_char_info.m_player_url + "/0" + URLSuffix.CreateVersionString();
			}
			return ""
		}
	
		public function SetVipInfo( vip_level:int , vip_expire :int):void
		{
			if(m_video_char_info != null)
			{
				m_video_char_info.vip_level = vip_level;
				m_video_char_info.vip_remaining_time = vip_expire;
			}
			return ;
		}
		
		public function GetVipLevel():int
		{
			if(m_video_char_info == null)
			{
				return 0;
			}
			return m_video_char_info.vip_level;
		}		
		
		public function GetVipRemainTime():int
		{
			if(m_video_char_info == null)
			{
				return 0;
			}
			return m_video_char_info.vip_remaining_time;
		}
		
		//获取vip的名称(近卫，骑士等)
		public function GetVipName():String
		{
			if(m_video_char_info == null)
			{
				return "";
			}
			else
			{
				return CVideoVipConfig.getInstance().GetVipName(m_video_char_info.vip_level);
			}
		}

		public function GetAttachedAnchorName():String {
			if (m_video_char_info == null) {
				return "";
			} else {
				return m_video_char_info.vip_attached_anchor_name;
			}
		}
		
		public function GetAttachedAnchorID():String {
			if (m_video_char_info == null) {
				return "0";
			} else {
				return m_video_char_info.vip_attached_anchor_id.toString();
			}
		}

		//设置当前拥有的钱数
		public function SetVideoMoney(dream_money:int, balance:Int64):void
		{
			if(m_video_char_info != null)
			{
				if(dream_money != -1 )
				{
					m_video_char_info.video_dream_money = dream_money;		
				}
				if( balance !=null)
				{
					m_video_char_info.video_money_balance = balance;
				}
				
				m_callback.NotifyMoneyChange(m_video_char_info.video_dream_money,m_video_char_info.video_money_balance.toNumber() );
			}
		}
		
		private function ChangeTime():void
		{
			if(m_nCharInfoCacheExpireTime <= 0)
			{
				m_CharInfoTimer.StopTimer();
				return;
			}
			m_nCharInfoCacheExpireTime -= 1;
		}

		private var sorttype:int = 0; //默认是首页
		private var requestHomePageTimer:TimerBase = new TimerBase(5 * 1000, sendRequestHomePageEvent); //2秒

		public function SyncVideoClientPlayerInfo(requestFromUI:Boolean = false, reqtype:int = 0):void {
			sorttype = reqtype;
			Globals.s_logger.debug("SyncVideoClientPlayerInfo()  reqtype = " + reqtype);
			if (requestFromUI && m_video_char_info == null) {
				//从界面请求时还没有数据，需要从返回消息中callback给界面
				this.m_bNeedCallback = true;
			} else {
				//其他情况服务器回复消息都不需要回调给界面
				if (requestFromUI && m_video_char_info != null) {
					//如果到了可更新状态，等待更新后下发页面。
					if (m_nCharInfoCacheExpireTime <= 0) {
						this.m_bNeedCallback = true;
					} else {
						m_callback.OnLoadPlayerInfoForHomePage(0, this.GetVideoClientCharInfo(sorttype));
						this.m_bNeedCallback = false;
					}
				} else {
					this.m_bNeedCallback = false;
				}
			}

			if (m_video_char_info == null || m_nCharInfoCacheExpireTime <= 0) {
				//向服务器请求
				var ev:CEventLoadPlayerInfoForHomePage = new CEventLoadPlayerInfoForHomePage;
				m_video_client_internal.SendEvent(ev, Globals.SelfRoomID);
				requestHomePageTimer.StartTimer();
				requestPlayerInfoForHomePageTimes = 3;
			}
		}

		//主动发送请求个人信息的消息
		private function sendRequestHomePageEvent():void {
//			if(Globals.isLogutState){
//				requestPlayerInfoForHomePageTimes = 3;
//				return;
//			}

			if (m_video_client_internal.GetCallCenter().GetConnected()) {
				requestPlayerInfoForHomePageTimes--;
			} else {
				requestPlayerInfoForHomePageTimes = 3;
				return;
			}
			var ev:CEventLoadPlayerInfoForHomePage = new CEventLoadPlayerInfoForHomePage;
			m_video_client_internal.SendEvent(ev, Globals.SelfRoomID);
			Globals.s_logger.debug("定时获取HomePage消息。times=" + requestPlayerInfoForHomePageTimes);

			if (requestPlayerInfoForHomePageTimes < 0) { //<= 0) {
				requestHomePageTimer.StopTimer();

				Globals.s_logger.debug("三次获取HomePage消息暂无返回，延时检测。");
				clearTimeout(delayCheckHomePageCount);
				delayCheckHomePageCount = setTimeout(delayCheckHomePageState, 5000);

				//延时检测
//				if (!isCallBackHomePageFail) {
//					isCallBackHomePageFail = true;
//					//超时回调页面QQ登录异常接口  
//					Globals.s_logger.error("homePage三次超时回调页面QQ登录异常接口");
//					m_callback.OnGetHomePageFail(0);
//				}
			}
		}

		private var delayCheckHomePageCount:uint;
		/**
		 * 延迟检测获取homepage状态。
		 *
		 */
		private function delayCheckHomePageState():void {
			Globals.s_logger.debug("延时检测HomePage状态：times=" + requestPlayerInfoForHomePageTimes);
			if (requestPlayerInfoForHomePageTimes < 0) {
				requestHomePageTimer.StopTimer();

				if (!isCallBackHomePageFail) {
					isCallBackHomePageFail = true;
					//超时回调页面QQ登录异常接口  
					Globals.s_logger.error("homePage三次超时回调页面QQ登录异常接口");
					m_callback.OnGetHomePageFail(0);
				}
			}
		}

		public function GetVideoNick():String 
		{
			if(m_video_char_info == null)
			{
				return "default";
			}
			return m_video_char_info.nick;
		}

		public function GetVideoID():Int64 {
			if (m_video_char_info == null) {
				return Int64.fromNumber(0);
			}
			return m_video_char_info.pstid;
		}

		public function GetZoneName():String
		{
			if(m_video_char_info == null)
			{
				return "default";
			}
			return m_video_char_info.zone_name;
		}
		public 	function IsMale() : Boolean
		{
			if(m_video_char_info == null)
			{
				return false;
			}
			return m_video_char_info.sex_male == PlayerSex.SEX_Male;
		}
		
		public function Gender() :int
		{
			if(m_video_char_info == null)
			{
				return 0;
			}
			return m_video_char_info.sex_male;
		}
		
		public function GetWealth() : Int64
		{
			if(m_video_char_info == null)
			{
				return Int64.fromNumber(0);
			}
			return m_video_char_info.video_wealth;
		}
		public function IsFollowingAnchor(anchor:Int64) : Boolean
		{
			if(m_video_char_info == null)
			{
				return false;
			}
			var find:Boolean = false;

			for(var i:int = 0; i < m_follow_anchors.length; ++i)
			{
				if(anchor.equal(m_follow_anchors[i]))
				{
					find = true;
					break;
				}
			}			
			return find;
		}
		
		public function ForceUpdate():void
		{
			m_nCharInfoCacheExpireTime = 0;
			this.SyncVideoClientPlayerInfo();
		}
		
		public function ModifyNick(nick:String,source_type:int,rand_nick_pool:int,nick_record_id:int):void
		{
			var ev:CEventVideoRoomModifyNick = new CEventVideoRoomModifyNick;
			ev.m_nick = nick;
			ev.m_source_type = source_type;
			ev.m_rand_nick_pool = rand_nick_pool;
			ev.m_nick_record_id = nick_record_id;
			this.m_video_client_internal.SendEvent(ev,Globals.SelfRoomID);
		}
		
		public function GetDreamMoneyNum() : int
		{
			if(m_video_char_info == null)
			{
				return 0;
			}
			return m_video_char_info.video_dream_money;	
		}
		
		public function GetVideoServerTime():Number
		{
			return _serverClock.GetTime().time;
		}
		
		public function FollowAnchor(anchor_id:Int64, anchor_nick:String) : Boolean
		{
			var ev:CEventFollowAnchorOp = new CEventFollowAnchorOp;
			ev.anchor_nick = anchor_nick;
			ev.anchor = anchor_id;
			ev.room_id = Globals.SelfRoomID;
			ev.op_type = FollowAnchorType.FAT_Follow;
			ev.from = 0;
			
			m_video_client_internal.SendEvent(ev, Globals.SelfRoomID);
			return true;	
		}
		
		public function CancelFollowAnchor(anchor_id:Int64, anchor_nick:String) : Boolean
		{
			var ev:CEventFollowAnchorOp = new CEventFollowAnchorOp;
			ev.anchor_nick = anchor_nick;
			ev.anchor = anchor_id;
			ev.room_id = Globals.SelfRoomID;
			ev.op_type = FollowAnchorType.FAT_UnFollow;
			ev.from = 0;
			
			m_video_client_internal.SendEvent(ev, Globals.SelfRoomID);
			return true;
		}
		
		//获取玩家关注的主播列表，按照亲密度高低排序
		private var isForGetFollow:Boolean = false;//标识是否是后援团界面请求的玩家关注列表
		public function LoadFollowingAnchorInfos() : void
		{
			var ev:CEventLoadPlayerInfoForHomePage = new CEventLoadPlayerInfoForHomePage;
			m_video_client_internal.SendEvent(ev, Globals.SelfRoomID);
			isForGetFollow = true;
		}
		
		private function OnLoadFollowingAnchorInfos():void
		{
			var followAnchors:Array = new Array;
			if(m_video_char_info != null)
			{
				//填充关注的主播数据。
				for each(var follower:CFollowedAnchorInfoForHomePage in m_video_char_info.followinfo_vec)
				{
					var followedAnchorInfo:FollowedAnchorInfoForUI = new FollowedAnchorInfoForUI;
					followedAnchorInfo.affinity = follower.affinity;
					followedAnchorInfo.m_anchor = follower.m_anchor.toString();
					followedAnchorInfo.m_anchor_type = follower.m_anchor_type;
					followedAnchorInfo.m_anchor_nick = follower.m_anchor_nick.replace(Pattern,"\\\\");
					followedAnchorInfo.m_starlight = follower.m_starlight;
					followedAnchorInfo.m_videoroom_id = follower.m_videoroom_id;
					followedAnchorInfo.m_status = follower.m_status;
					followedAnchorInfo.m_nest_id = follower.m_nest_id;
					followedAnchorInfo.guard_level = follower.guard_level;
					followedAnchorInfo.guardIcon = this.m_video_client_internal.GetGuardConfig().GetIcon(follower.guard_level);
					followedAnchorInfo.is_nest = follower.is_nest;
					
					if(follower.m_anchor_url != "")
					{
						followedAnchorInfo.m_photo_url =Globals.m_pic_download_url + "/qdancersec/" +  follower.m_anchor_url + "/0" + URLSuffix.CreateVersionString();
					}
					followAnchors.push(followedAnchorInfo);
				}
				followAnchors.sort(FollowingAnchorCompSelfCenter);
			}
			m_callback.OnLoadFollowingAnchorsInfo(VideoResultType.VREST_Normal, followAnchors);
		}

		public function GetFreeGiftCount():int {
			if (m_video_char_info == null) {
				return 0;
			}
			return m_video_char_info.free_gift_count;
		}

		public function GetVideoPersistID():Int64 {
			if (m_video_char_info == null) {
				return Int64.fromNumber(0);
			}
			return m_video_char_info.pstid;
		}

		public function GetVideoClientCharInfo(reqType:int):VideoClientCharInfo {
			return FillVideoClientCharInfo(reqType);
		}

		public function InitServerTime(server_time:int):void {
			_serverClock.InitClock(server_time);
		}

		public function SetInvisible(invisible:Boolean, only_client:Boolean):void {
			if (only_client) {
				if (m_video_char_info != null) {
					m_video_char_info.SetInvisible(invisible);
				}
			} else {
				var ev:CEventSetInvisibleOp = new CEventSetInvisibleOp;
				ev.invisible = invisible;
				ev.room_id = Globals.SelfRoomID;
				m_video_client_internal.SendEvent(ev, Globals.SelfRoomID);
			}
		}

		public function IsInvisible():Boolean {
			if (m_video_char_info == null) {
				return false;
			}
			return m_video_char_info.IsInvisible();
		}

		/**
		 * 是否提示过任务引导
		 * @return
		 *
		 */
		public function IsTipsNoticed():Boolean {
			//1.首先从cookie里面查询，cookie里面的值会在更新玩家信息是刷新，在通知服务已经提示过的引导的消息是也会更改（预防在不同页面上数据不统一）。
			var cookie:Cookie     = new Cookie(AccountCookieConst.ACCOUNT_NAME);
			var cookieData:Object = cookie.getData(AccountCookieConst.MISSION_GUIDE_OVER);
			if (cookieData != null && cookieData is Boolean) {
				return cookieData as Boolean;
			}
			//2.使用玩家信息里面的数据
			//XW83949 低级错误-。-
			if (m_video_char_info != null) {
				return m_video_char_info.tips_notice;
			}
			//3.默认返回false
			return false;
		}

		/**
		 * 这是任务引导提示是否提示过。
		 * 1.更新玩家数据时，会更新。
		 * 2.向服务器发送提示过的消息时，会更改本地cookie数据。
		 * @param noticed
		 *
		 */
		public function SetTipsNotice(noticed:Boolean):void {
			if (m_video_char_info == null) {
				m_video_char_info.tips_notice = noticed;
			}
			var cookie:Cookie = new Cookie(AccountCookieConst.ACCOUNT_NAME);
			cookie.flushData(AccountCookieConst.MISSION_GUIDE_OVER, noticed);
		}

		public function HandleVideoServerEvent(evt:INetMessage):Boolean 
		{
			switch (evt.CLSID()) {
				//关注/取消关注主播操作
				case EEventIDVideoRoom.CLSID_CEventFollowAnchorOpRes:
					HandleCEventFollowAnchorRes(evt);
					break;
				//获取主播详细信息操作。现在不需要了。
				case EEventIDVideoRoom.CLSID_CEventLoadFollowingAnchorInfoRes:
					HandleCEventLoadFollowingAnchorInfoRes(evt);
					break;
				//设置隐身操作。
				case EEventIDVideoRoomExt.CLSID_CEventSetInvisibleOpRes:
					HandleCEventSetInvisibleOpRes(evt);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventLoadPlayerInfoForHomePageRes:
					HandleCEventLoadPlayerInfoForHomePageRes(evt);
					break;
				case EEventIDVideoRoomExt.CLSID_CEventVideoRoomModifyNickRes:
					HandleCEventVideoRoomModifyNickRes(evt);
					break;
				default:
					break;
			}
			return true;
		}
		
		//实时加载关注的主播
		private function HandleCEventLoadFollowingAnchorInfoRes(evt:INetMessage):void
		{
			var ev:CEventLoadFollowingAnchorInfoRes = evt as CEventLoadFollowingAnchorInfoRes;
			
			var len:int = ev.anchors_info.length;
			return;
		}
		
		private function HandleCEventVideoRoomModifyNickRes(ev:INetMessage):void
		{
			var evt:CEventVideoRoomModifyNickRes = ev as CEventVideoRoomModifyNickRes;
			m_callback.OnModifyNickRes(VideoResultType.VREST_Normal, evt.res,evt.m_recommend_nick,evt.m_source_type);
		}
		
		private var requestPlayerInfoForHomePageTimes:int = 3;
		private var isCallBackHomePageFail:Boolean = false;

		private function HandleCEventLoadPlayerInfoForHomePageRes(ev:INetMessage):void {
			var evt:CEventLoadPlayerInfoForHomePageRes = ev as CEventLoadPlayerInfoForHomePageRes;
			if (evt == null) {
				Globals.s_logger.error("HandleCEventLoadPlayerInfoForHomePageRes CEventLoadPlayerInfoForHomePageRes is null!");
				return;
			}
			if (evt.res != 0) {
				Globals.s_logger.error("HandleCEventLoadPlayerInfoForHomePageRes,errorcode" + evt.res);
				if (requestPlayerInfoForHomePageTimes <= 0 && isCallBackHomePageFail) {
					isCallBackHomePageFail = true;
					//停止定时器
					requestHomePageTimer.StopTimer();
					//回调页面QQ登录异常接口  
					m_callback.OnGetHomePageFail(evt.res);
					//返回3的时候 回调页面通知去pc进一下视频房间
					if (evt.res == VideoVipOperationResult.VVOR_Interanl) {
						var info:VideoClientCharInfo = new VideoClientCharInfo;
						m_callback.OnLoadPlayerInfoForHomePage(evt.res, info);
					}
					return;
				}
			}
			if (evt.res == 0) {
				requestPlayerInfoForHomePageTimes = 3;
				//停止定时器
				requestHomePageTimer.StopTimer();

				this.SetVideoCharInfo(evt.player);
				if (m_bNeedCallback) {
					m_callback.OnLoadPlayerInfoForHomePage(0, this.GetVideoClientCharInfo(sorttype));
				}
				if (isForGetFollow) {
					isForGetFollow = false;
					OnLoadFollowingAnchorInfos();
				}
			}
		}

		private var m_followed_anchors_start_time:Dictionary = new Dictionary();

		//web端不需要主播开播提醒
		public function UpdateFollowedAnchorStartTime(id:Int64, start_time:uint):void {
			m_followed_anchors_start_time[id] = start_time;
		}
		// 是否需要开播提醒
		public function NeedNotifyLiveStart(id:Int64,start_time:uint):Boolean
		{
			return false;
		}

		//执行关注/取消关注后的处理。
		private function HandleCEventFollowAnchorRes(p:INetMessage):void {
			if (p == null || m_video_char_info == null) {
				return;
			}

			var ev:CEventFollowAnchorOpRes = p as CEventFollowAnchorOpRes;

			//关注主播和取消主播发送46号消息，显示在聊天框上
			var msg_data:VideoRoomMsgData  = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_System; //系统消息
			msg_data.TextColor = WebColor.systemInfoTextColor; //系统消息颜色
			msg_data.systemType = 0;
			msg_data.receiverName = GetVideoNick();

			if (ev.op_type == FollowAnchorType.FAT_Follow) {
				var res_type:int = ev.res;
				if (ev.res == VideoRoomFollowErrorNo.VRFEN_OK || ev.res == VideoRoomFollowErrorNo.VRFEN_ALREADY) {
					var find:Boolean = false;

					for (var i:int = 0; i < m_follow_anchors.length; ++i) {
						if (ev.anchor.equal(m_follow_anchors[i])) {
							find = true;
							break;
						}
					}
					if (!find) {
						//新添加的关注数据不足,需要下次重新从服务器拉取
						m_follow_anchors.push(ev.anchor);
						m_nCharInfoCacheExpireTime = 0;
					}
					//关注和已关注都认为是成功操作。
					res_type = VideoRoomFollowErrorNo.VRFEN_OK;
				}

				m_callback.OnFollowAnchorRes(VideoResultType.VREST_Normal, res_type, ev.anchor, ev.anchor_nick);

				if (ev.res == VideoRoomFollowErrorNo.VRFEN_OK) {
					msg_data.msg = "$t$您关注了[" + ev.anchor_nick.replace(Pattern, "\\\\") + "]$z";
					m_callback.OnReceiveChatMsg(msg_data);
				}
				//您的关注列表已达到上限
				else if (ev.res == VideoRoomFollowErrorNo.VRFEN_FULL) {
					msg_data.msg = "$t$您的关注列表已达到上限$z";
					m_callback.OnReceiveChatMsg(msg_data);
				}
			} else {
				if (ev.res == VideoRoomFollowErrorNo.VRFEN_OK) {
					for (var j:int = 0; j < this.m_follow_anchors.length; ++j) {
						if (ev.anchor.equal(m_follow_anchors[j])) {
							m_follow_anchors.splice(j, 1);
							break;
						}
					}
				}

				m_callback.OnCancelFollowAnchor(VideoResultType.VREST_Normal, ev.res, ev.anchor, ev.anchor_nick);

				if (ev.res == VideoRoomFollowErrorNo.VRFEN_OK) {
					msg_data.msg = "$t$您取消了关注[" + ev.anchor_nick.replace(Pattern, "\\\\") + "]$z";
					m_callback.OnReceiveChatMsg(msg_data);
				}
			}

			//tqos上报 begin
			var tqos:TQOSFollowAnchor = new TQOSFollowAnchor();
			tqos.nQQ = m_video_client_internal.GetCallCenter().GetQQ();
			tqos.nDeviceType = ClientDeviceType.CDT_WEB;
			tqos.nAnchorQQ = ev.anchor.toNumber();
			tqos.nErrorCode = ev.res;
			tqos.Response();
			//tqos上报 end

			ForceUpdate();
		}

		//个人中心的关注主播的排序
		private function FollowingAnchorCompSelfCenter(lhs:FollowedAnchorInfoForUI, rhs:FollowedAnchorInfoForUI):int 
		{
			var laffinity:Number = lhs.affinity;
			var raffinity:Number = rhs.affinity;
			//先根据亲密度从高到低排序
			if(laffinity != raffinity)
			{
				if( laffinity > raffinity)
					return -1;
				else if( laffinity < raffinity)
					return 1;
			}
			
			var lstarlight:Number = lhs.m_starlight;
			var rstarlight:Number = rhs.m_starlight;
			//同样亲密度的主播按照邢窑址的高低排序，高在上，低在下
			if(lstarlight != raffinity)
			{
				if( lstarlight > rstarlight)
					return -1;
				else if( lstarlight < rstarlight)
					return 1;
			}

			return 0;
		}
		//首页的关注主播的排序
		private function FollowingAnchorCompHomePage( lhs:FollowedAnchorInfoForUI, rhs:FollowedAnchorInfoForUI):int
		{
			//正在直播的主播排在最上
			//在线但尚未开播的主播排在中间
			//离线的主播排列在最下方
			//每一种状态之中，按照房间ID从小到大排列			
			var status1:int = lhs.m_status;
			var status2:int = rhs.m_status;
			var roomid1:int = lhs.m_videoroom_id;
			var roomid2:int = rhs.m_videoroom_id
			var res:int = 0;
			if(status1 > status2)
				res = -1;
			else if(status1 < status2)
				res = 1;
			else if(status1 == status2)
			{
				if(roomid1 < roomid2)
					res = -1;
				else
					res = 1;
			}	
			return res;
		}

		//设置隐身/在线后的处理。
		private function HandleCEventSetInvisibleOpRes(p:INetMessage):void
		{
			if(p == null)
			{
				return;
			}
			var ev:CEventSetInvisibleOpRes = p as CEventSetInvisibleOpRes;
			
			if(ev.res == 0)
			{
				if(m_video_char_info !=null)
				{
					m_video_char_info.SetInvisible(!m_video_char_info.invisible);	
				}
				
			}
			m_callback.OnSetVisibleRes(VideoResultType.VREST_Normal, ev.res, m_video_char_info.invisible);
		}	
		
		
		public function SetVideoCharInfo(info:CVideoPlayerInfo):void
		{
			m_video_char_info = info;
			//设置我的贵族状态，用于显示签到奖励
			m_client_base.SetVideoVipInfo(info.vip_level,info.vip_remaining_time);
			
			//保存关注的主播id
			m_follow_anchors = new Array;
			for each(var follow:CFollowedAnchorInfoForHomePage in m_video_char_info.followinfo_vec)
			{
				m_follow_anchors.push(follow.m_anchor);
			}
			
			m_nCharInfoCacheExpireTime = s_nCharInfoCacheExpireTime;
			m_CharInfoTimer.StartTimer();
			
			SetTipsNotice(info.tips_notice);
		}
		private var Pattern:RegExp = /\\/g;
		//填充UI数据
		private function FillVideoClientCharInfo(reqType:int):VideoClientCharInfo
		{								
			var charInfoForUI:VideoClientCharInfo = new VideoClientCharInfo;
			if(m_video_char_info == null)
			{
				return charInfoForUI;
			}
			charInfoForUI.pstid = m_video_char_info.pstid.toString();
			charInfoForUI.nick = m_video_char_info.nick.replace(Pattern,"\\\\");
			charInfoForUI.signature = m_video_char_info.signature;
			charInfoForUI.wealth_exp = m_video_char_info.wealth_exp;
			charInfoForUI.wealth_level = m_video_char_info.wealth_level;
			charInfoForUI.wealth_levelup_exp = m_video_char_info.wealth_levelup_exp;
			
			
			if( m_video_char_info.m_player_url != "" && m_video_char_info.photo_url != "")
			{
				//XW79794 去除头像随机数。 /0由服务器拼接
				charInfoForUI.photo_url =Globals.m_pic_download_url + "/qdancersec/" +  m_video_char_info.m_player_url; //+ "/0" + URLSuffix.CreateVersionString();
			}
			
			charInfoForUI.sex_male = m_video_char_info.sex_male;
			charInfoForUI.video_wealth = m_video_char_info.video_wealth.toString();
			charInfoForUI.video_money_balance = m_video_char_info.video_money_balance.toString();
			charInfoForUI.free_gift_count = m_video_char_info.free_gift_count;
			charInfoForUI.vip_level = m_video_char_info.vip_level;		
			charInfoForUI.vip_remaining_time = m_video_char_info.vip_remaining_time;			
			charInfoForUI.block_public_chat = m_video_char_info.block_public_chat;
			charInfoForUI.zone_name = m_video_char_info.zone_name;
			charInfoForUI.video_dream_money = m_video_char_info.video_dream_money;
			charInfoForUI.video_level = m_video_char_info.video_level;
			charInfoForUI.invisible = m_video_char_info.invisible;
			charInfoForUI.zone_id = m_video_char_info.zone_id;
			charInfoForUI.video_exp = m_video_char_info.video_exp;
			charInfoForUI.video_levelup_exp = m_video_char_info.video_levelup_exp;
			charInfoForUI.vipIcon = this.m_video_client_internal.GetVipConfig().GetVipIcon(m_video_char_info.vip_level);
			charInfoForUI.vipName = this.m_video_client_internal.GetVipConfig().GetVipName(m_video_char_info.vip_level);
			charInfoForUI.vip_anchor_name = GetAttachedAnchorName();
			charInfoForUI.vip_anchor_id = GetAttachedAnchorID();
			charInfoForUI.is_show_week_star_url = m_video_char_info.is_show_week_star_url;
			
			var cookie:Cookie = new Cookie("x51web");
			charInfoForUI.forbidAllPrivate = cookie.getData("isForbidPrivateChat");
			//填充关注的主播数据。
			for each(var follower:CFollowedAnchorInfoForHomePage in m_video_char_info.followinfo_vec)
			{
				var followedAnchorInfo:FollowedAnchorInfoForUI = new FollowedAnchorInfoForUI;
				followedAnchorInfo.affinity = follower.affinity;
				followedAnchorInfo.m_anchor = follower.m_anchor.toString();
				followedAnchorInfo.m_anchor_type = follower.m_anchor_type;
				followedAnchorInfo.m_anchor_nick = follower.m_anchor_nick.replace(Pattern,"\\\\");
				followedAnchorInfo.m_starlight = follower.m_starlight;
				followedAnchorInfo.m_videoroom_id = follower.m_videoroom_id;
				followedAnchorInfo.m_status = follower.m_status;
				followedAnchorInfo.m_nest_id = follower.m_nest_id;
				followedAnchorInfo.guard_level = follower.guard_level;
				followedAnchorInfo.guardIcon = this.m_video_client_internal.GetGuardConfig().GetIcon(follower.guard_level);
				followedAnchorInfo.is_nest = follower.is_nest;
				followedAnchorInfo.anchor_level = follower.anchor_level;
				
				if(follower.m_anchor_url != "")
				{
					followedAnchorInfo.m_photo_url =Globals.m_pic_download_url + "/qdancersec/" +  follower.m_anchor_url + "/0" + URLSuffix.CreateVersionString();
				}
				
				charInfoForUI.followinfo_vec.push(followedAnchorInfo);
			}
			
			//在此处进行关注的主播列表排序
			if(reqType == 0)//首页要求的关注主播的排序规则排序
			{
				charInfoForUI.followinfo_vec.sort(FollowingAnchorCompHomePage);
			}
			else if(reqType == 1)//个人中心关注的主播排序
			{
				charInfoForUI.followinfo_vec.sort(FollowingAnchorCompSelfCenter);
			}
						
			return charInfoForUI;
		}
		
		public function SetCharInfo( charinfo:VideoCharInfo):void
		{
			m_charnfo = charinfo;
			pushGiftChange();
		}

		private function pushGiftChange():void {
			var dreamGift:Array       = [];
			var skin_gifts:Dictionary = getSkinGiftList();
			for (var sgId:String in skin_gifts) {
				var find:Boolean             = false;
				var skin_gift:DreamGiftForUI = new DreamGiftForUI();
				skin_gift.giftId = int(sgId);
				skin_gift.giftCount = skin_gifts[sgId];
				dreamGift.push(skin_gift);
			}
			var videoGift:Dictionary = getVideoGiftList();
			
			for (var id:String in videoGift)
			{
				var gift:DreamGiftForUI = new DreamGiftForUI;
				gift.giftId = int(id);
				gift.giftCount = videoGift[id];
				dreamGift.push(gift);
			}
			
			Globals.s_logger.debug("CLSID_CEventRefreshVideoCharInfoToClient:" + JSON.stringify(dreamGift));
			m_video_client_internal.GetUICallback().OnQueryDreamGift(dreamGift, true);
		}
		
		public function GetNestCreditsLevel():int
		{
			if(m_charnfo == null )
				return 0;
			var levelpair:CreditsLevel =  m_charnfo.nest_credits_levels[Globals.SelfRoomID];
			
			if( levelpair == null )
				return 0;
			Globals.s_logger.debug("get CreditsLevel "+ "room."+Globals.SelfRoomID+ "level."+levelpair.level );
			return levelpair.level;
		}
		
		public function  GetNestCredits():int
		{
			if(m_charnfo == null )
				return 0;
			var levelpair:CreditsLevel =  m_charnfo.nest_credits_levels[Globals.SelfRoomID];
			
			if( levelpair == null )
				return 0;
			
			return levelpair.ceatit;
		}
		
		public function SetNestCreditsLevel(roomid:int,credits:int, level:int):void
		{
			
			var levelpair:CreditsLevel = new CreditsLevel;
			levelpair.ceatit = credits;
			levelpair.level = level;
			Globals.s_logger.debug("set CreditsLevel roomid:" + roomid + " level" + level);
			if(m_charnfo != null )
				m_charnfo.nest_credits_levels[roomid] = levelpair;
		}

		public function getSkinGiftList():Dictionary {
			if (m_charnfo != null) {
				return m_charnfo.skin_gifts.skin_gift_map;
			}
			return null;
		}
		
		public function getVideoGiftList():Dictionary {
			if (m_charnfo != null) {
				return m_charnfo.video_gifts;
			}
			return null;
		}
	}
	
}