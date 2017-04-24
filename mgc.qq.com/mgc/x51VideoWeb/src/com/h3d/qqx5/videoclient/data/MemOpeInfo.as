package com.h3d.qqx5.videoclient.data
{
	public class MemOpeInfo
	{
		public function MemOpeInfo()
		{
		}
		
		public var portrait_url:String = ""; 
		public var player_name:String = "";
		public var zone_name:String = "";
		public var m_sex_male:Boolean;
		public var playerType:int; // 玩家身份类别，对应enum RoomPlayerType
		public var guardlevel:int;
		public var vip_level:int;
		public var Online:Boolean;
		public var talkForbidden:Boolean; // 是否被禁言
		public var perpetualTalkForbidden:Boolean; //永久禁言
	}
}