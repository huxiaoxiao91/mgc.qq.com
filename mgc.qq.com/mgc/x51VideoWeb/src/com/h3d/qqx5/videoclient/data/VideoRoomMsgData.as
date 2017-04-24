package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoRoomMsgData
	{	
		public var flag:int = 0; // 标志，同ToClientChatMessage::m_flag
		public var m_in_vip_seat:Boolean = false; // 发送者是否在贵宾席
		public var m_is_purple:Boolean = false;   // 发送者是否紫钻
		public var m_senderPlayerType:int = 2;	// 发送者身份，对应enum RoomPlayerType
		public var isOnLive:Boolean = false;//如果发送者身份是主播，为true表示在直播，fals表示没有直播
		public var senderIcon:String = "";//发送者图标，主要针对主播和管理员
		public var channel:int = 0;
		public var senderPlayerID:String = "";
		public var senderPlayerZoneID:int = 0;
		public var msg:String = "";
		public var senderName:String = "";
		public var receiverName:String = "";
		public var senderZoneName:String = "";	// 发送者所在的大区名字
		public var receiverZoneName:String = ""; // 接收者所在的大区名字
		public var sender_jacket:int = 0;
		public var sender_defend:int = 0;//守护身份
		public var viplevel:int;//贵族等级
		public var vipCardPattern:String;//贵族对应底板
		public var judge_type:int = -1;//TalentShowJudgeType.TSJT_Invalid
		public var video_guild_id:String = "";
		public var receiverPlayerID:String = "";
		public var receiverPlayerType:int;
		public var senderDeviceType:int = 2;//ClientDeviceType.CDT_Web
		public var m_is_free_whistle:Boolean = false;
		public var invisible:Boolean = false;
		public var forbid_talk_all_room:Boolean = false;
		public var nest_assistant:Boolean = false;
		public var NickColor:String = "";
		public var TextColor:String = "";
		public var isSelf:int;//0是公聊，1是发给我的私聊。2是我发给别人的公聊,3我发的飞屏，4别人发的飞屏
		public var systemType:int = 0;//系统消息类型 0 默认，1 禁言和取消禁言
		public var targetVipLevel:int = 0;
		public var targetGuardLevel:int = 0;
		public var ban:Boolean;//true禁言false取消禁言
		public var perpetual:Boolean;//true永久禁言,false取消永久禁言
		public var wealth_level:int;//财富等级
		public var add_anchor_exp:int;//主播增加的经验
		public var isTakeVip:Boolean = false;
		public var is_vip_with_anchor:Boolean = false;
		public var res_forbid_public_chat:Boolean = false;
	}
}