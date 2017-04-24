package com.h3d.qqx5.common
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.util.Logger;

	/**
	 * @author liuchui
	 */
	public class Globals
	{
		public static var SwfFolderURL:String = "";

		//房间是否所有人禁言
		public static var room_banned:Boolean = false;
		public static var room_forbid_all:Boolean = false;//房间下发禁言状态
		public static var room_ban_notice:Boolean = false;//是否收到CEventVideoRoomBanNotice接口消息
		
		//房间id
		public static var roomID:int = 0;
		
		//房间id
		private static var _SelfRoomID:int = 0;
		public static function get SelfRoomID():int {
			return _SelfRoomID;
		}
		public static function set SelfRoomID(value:int):void {
			_SelfRoomID = value;
		}

		//进房前临时存放RoomID和引流是使用的ID
		public static var tmpRoomID:int = 0;
		public static var addindex:int = -1;
//		public static var sVersionCallCenter:VersionCallCenter = null;
		public static var VideoGroupID:int = 1;//
		//针对服务器主播任务可以反复完成的临时处理		by zhangqing
		public static var needShowAnchorTask:Boolean = false;
		
		//定时刷新在线列表玩家
		public static var timer:TimerBase = null;
		public static var pageIndex:int = 0;
		public static var intervalTime:int = 5*60*1000;//间隔时间
				
		public static var isForbidPrivateChat:Boolean = false;//屏蔽私聊，除了主播和管理员
		public static var isCancelOpeLog:Boolean = false;//是否取消掉优化项的log
		public static var s_logger:Logger = null;
		
		public static var m_pic_download_url:String = "";
		public static var rpArr:Array = null;//用于没角色的玩家，保存roomproxy信息
		public static var forbidFreeGift:Boolean = false;//是否屏蔽免费礼物
		
		public static var richRankRequestBeginIndex:int = 0;//请求财富排行榜的开始名次
		public static var roomCharmRankBeginIndex:int = 0;//请求魅力排行榜的开始名次
		
		public static var appid:int = 0;
		public static var skey:String = "";
		public static var zoonId:int = 0;
		public static var channel:int = 0;
		public static var deviceType:int = 0;
		
		public static var vkey:String = "";
//		public static var m_appid:int = 0;

		private static var _iframeRoomID:int;
		/**
		 * 引流页面使用
		 *
		 */
		public static function get iframeRoomID():int {
			return _iframeRoomID;
		}
		/**
		 * @private
		 */
		public static function set iframeRoomID(value:int):void {
			_iframeRoomID = value;
		}

		public static var video_buname:String = "";

		/**
		 * 登录时使用的qq（页面传过来的）
		 */
		public static var cookieQQ:Number = 0;
		public static var cookieZoonID:int = 0;
		
		public static var isReady:Boolean = false;
		
		public static var isReconnection:Boolean = false;
		
		public static var isLogoutState:Boolean = false;
		public static var connectTime:Number = 0;
		
		public static var login_opt:int;
		public static var guest_zoon_id:int = 888;

		/**
		 *是否开启debug日志输出
		 */
		public static var isDubug:Boolean = false;

		/**
		 * IP类型
		 * 是否内网  0等于内网，1等于腾讯测试服，2等于外网
		 */
		public static var ipType:uint = 0;
		public static var IP_INNER_230:uint = 0;
		public static var IP_INNER_233:uint = 1;
		public static var IP_INNER_30:uint = 6;
		public static var IP_INNER_RANDOM:uint = 3;
		public static var IP_INNER_INTRANET_RANDOM:uint = 7;
		public static var IP_OUTER_TEST:uint = 4;
		public static var IP_OUTER:uint = 5;

		public static var useLoadConfig:Boolean = false;
		
		public static var room_name:String = "";
		
		public static function toJSon():String {
			return "Global->{SelfRoomID:" + SelfRoomID + ", tmpRoomID:" + tmpRoomID + ", iframeRoomID:" + iframeRoomID
				 + ", isLogutState:" + isLogoutState + ", appid:" + appid + ", skey:" + skey + ", zoonId:" + zoonId +
				", channel:" + channel + ", deviceType:" + deviceType + "}";
		}
	}	
}