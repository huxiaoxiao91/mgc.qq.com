package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;

	public class CMemberOperationInfo extends INetMessage
	{	
		private var Pattern:RegExp = /\\/g;
		public function FillWithVideoRoomPlayerInfo(info:VideoRoomPlayerInfo):void
		{
			//这里没有处理头像
			player_name = info.playerNick.replace(Pattern,"\\\\");
			zone_name = info.zoneName;
			m_sex_male = (info.sex == 1)?true:false;
			playerType = info.playerType;
			
			psid = info.pstid.toString();
			
			guardlevel = info.guardLevel;
			vip_level = info.video_vip_level;
			Online = info.online;
			talkForbidden = info.IsNormalChatBan();
			perpetualTalkForbidden = info.IsPerpetualChatBan();
			zoneid = info.uid.zoneid;
			//这里涉及到我们不能给页面传递QQ号的问题，考虑在as模块中转一下。by Zhangqing 20150516
			anchorId = (uint)(info.uid.account.toNumber());	
			wealth_level = info.wealth_level;
		}
		
		public var portrait_url:String = ""; 
		public var player_name:String = "";
		public var zone_name:String = "";
		public var psid: String ;
		public var m_sex_male:Boolean;
		public var playerType:int; // 玩家身份类别，对应enum RoomPlayerType
		public var guardlevel:int;
		public var guardIcon:String ="";//守护图标
		public var vip_level:int;
		public var vipIcon:String = ""//贵族图标
		public var Online:Boolean;
		public var talkForbidden:Boolean; // 是否被禁言
		public var perpetualTalkForbidden:Boolean; //永久禁言
		public var zoneid:int;
		public var anchorId:uint;
		public var isIgnore:Boolean= false;
		
		public var banable:Boolean = true;
		public var unbanable:Boolean = true;
		public var isSelf:Boolean = false;
		
		public var wealth_level:int;
		public var server_time:Number;
	}
}