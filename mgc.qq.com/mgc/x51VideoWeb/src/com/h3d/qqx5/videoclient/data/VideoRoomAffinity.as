package com.h3d.qqx5.videoclient.data
{
	public class VideoRoomAffinity
	{
		public var male:Boolean = false;
		public var playerID:String = "";
		public var playerZoneID:int = 0;
		public var affinity:String = "0";	// 亲密度值
		public var total_affinity:String = "0";
		public var wealth:String = "";	// 玩家财富值
		public var anchorID:String = "";
		public var anchorName:String;
		public var playerName:String;
		public var zoneName:String;	// 玩家所在的大区名字
		public var jacket:int = 0;
		public var baned:Boolean;
		public var perpentralBaned:Boolean = false;
		public var guardlevel:int = 0;
		public var guardIcon:String = "";//守护图标
		public var viplevel:int = 0;
		public var credits_level:int = 0;
		
		public var vipIcon:String = "";//贵族图标
		public var vipName:String = "";//贵族名称
		public var nickColor:String = "";//贵族昵称颜色
		public var m_pk_richman_order:int = 0; //英豪榜排名
		public var video_level:int ;//梦工厂等级
		public var portraitUrl:String ="";//头像
		public var wealth_level:int = 0;//财富等级
	}
}