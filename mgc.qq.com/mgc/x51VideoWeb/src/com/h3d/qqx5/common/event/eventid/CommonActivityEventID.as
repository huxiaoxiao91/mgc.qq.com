package com.h3d.qqx5.common.event.eventid
{
	public class CommonActivityEventID
	{
		/**
		 *  向客户端发送通用活动开始信息
		 */
		public static const CLSID_CEventCommonActivityInfoBegin : int = 41399;
		/**
		 *  向客户端发送通用活动结束信息
		 */
		public static const CLSID_CEventCommonActivityInfoEnd : int = 41400;
		/**
		 *  向客户端发送通用活动配置更新信息
		 */
		public static const CLSID_CEventCommonActivityInfoRefresh : int = 41401;
		/**
		 *  向客户端发送通用活动地板数据信息（包括主播排名，主播收到的礼物数，底板等级）
		 */
		public static const CLSID_CEventRefreshCommonActivityData : int = 41402;	
		/**
		 *  向客户端发送的玩家贡献榜信息
		 */
		public static const CLSID_CEventCommonActivityPlayerRank: int = 41403;
	}
}