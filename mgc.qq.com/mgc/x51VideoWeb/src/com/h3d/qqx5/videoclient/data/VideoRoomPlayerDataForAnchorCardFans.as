package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoRoomPlayerDataForAnchorCardFans
	{
		public var online:Boolean = true;// 是否在线
		public var male:Boolean = false;	// 性别
		public var talkForbidden:Boolean = false; // 是否被禁言
		public var tempBannedIcon:String = "";//临时禁言图标
		public var purpleNF:Boolean = false;	// 是否为年费紫钻
		public var purpleLevel:int = 0;// 紫钻等级
		public var playerType:int = RoomPlayerType.RPT_audience; // 玩家身份类别，对应enum RoomPlayerType
		public var isOnLive:Boolean = false;//若playerType是主播，为true表示是当前正在直播，fals表示	当前没有直播
		public var playerIcon:String = "";//根据playerType来显示图标
		public var zoneID:int = 0;		// 所在的大区ID
//		public var playerID:Int64;	// 玩家在游戏内角色ID
//		public var playerQQ:Int64; // 玩家QQ号
//		public var wealth:Int64;	// 财富值
		public var playerID:String = "";	// 玩家在游戏内角色ID
		public var playerQQ:String = ""; // 玩家QQ号
		public var wealth:String = "0";	// 财富值
		public var name:String;
		public var zoneName:String;	// 所在的大区名字
		public var portrait_info:int = 0;	//名片头像信息,含义同charinfo_ext::m_portrait_info
		public var perpetualTalkForbidden:Boolean; //永久禁言
		public var perpetualTalkForbiddenIcon:String = "";//永久禁言图标
		public var jacket:int = 0;
		public var guardLevel:int = 0;//守护身份
		public var guardIcon:String = "";//守护图标
		public var viplevel:int = 0;//vip等级
		public var vipIcon:String = "";//vip图标
		public var nickColor:String = "";//贵族昵称颜色
		public var judgeType:int = TalentShowJudgeType.TSJT_Invalid; //评委类型
		public var talentshowRank:int = 0;  //梦想星主播的名次
		public var starAnchor:Boolean = false;     //是否是星级主播
		public var starAnchorIcon:String = ""//星级主播图标
		public var anchorTitle:int = AnchorTitle.E_AT_None;// 年度最佳星主播或年度最佳人气主播 2014.11
		public var invisible:Boolean = false; // 隐身
		public var forbidTalkAllRoom:Boolean = false; //永久全房间禁言
		public var nest_assistant:Boolean = false;//小窝助手
		public var videoLevel:int;//梦工厂等级
//		public var affinity:Int64;//亲密度
		public var affinity:String = "0";//亲密度
		public var psid: String;
		public var hasPortrait: Boolean;
	}
}