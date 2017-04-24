package com.h3d.qqx5.videoclient.xmlconfig
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.AnchorPlayerAffinityStatstics;
	import com.h3d.qqx5.videoclient.data.GuardLevelEnum;
	import com.h3d.qqx5.videoclient.data.VideoGuardConditionType;
	import com.h3d.qqx5.videoclient.data.VideoGuardPrivilegeData;
	import com.h3d.qqx5.videoclient.data.VideoRoomErrorCode;
	import com.h3d.qqx5.videoclient.interfaces.IFansGuardConfig;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientAdapter;
	
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	

	public class CFansGuardConfig implements IFansGuardConfig
	{

		private var IFansGuardConfig:Array = new Array;
		private var m_chat_img:Array = new Array;
		private var m_guard_rule_url:String = "";
		private var m_guardData:Dictionary = new Dictionary;
		private var m_video_client_adapter:IVideoClientAdapter = null;
		private var externalXML:XML;   
		private var loader:URLLoader;
		
		private const VIDEO_NEST_CREDITS_RANK_AFTER_N:int = -1;
		private const VIDEO_GUARD_LEVEL_INVALID:int = 0;
		private const VIDEO_SUPER_GUARD_LEVEL:int = 100;//天使守护级别，在这里写死了
		private const VIDEO_ADVANCE_GUARD_LEVEL:int= 50;//高级守护级别，在这里写死了
		private const VIDEO_SUPER_GUARD_LIST_SIZE:int = 10;//守护榜显示数量

	
		public function CFansGuardConfig(adapter:IVideoClientAdapter,path:String)
		{
			m_video_client_adapter = adapter;
			Parse(path);
		}
		
		
		//读取解析xml
		
		private function Parse(path:String):Boolean
		{			
			var request:URLRequest = new URLRequest(path);
			loader = new URLLoader();
			
			try
			{
				loader.load(request);
			} 
			catch(error:Error) 
			{
				Globals.s_logger.error("read xml fail!");
				return false;
			}
			loader.addEventListener(IOErrorEvent.IO_ERROR, errorHandler);
			
			loader.addEventListener(Event.COMPLETE, loaderCompleteHandler);
									
			return true;
		}
		
		private function errorHandler(e:IOErrorEvent):void
		{
			Globals.s_logger.error("open fans guard xml file faile");
		}
		
		private function loaderCompleteHandler(event:Event):void 
		{			
			try
			{
				externalXML = new XML(loader.data);
				readNodes(externalXML);    
			}
			catch (e:TypeError)
			{
				Globals.s_logger.error("parse the XML file fail!");
			}
		}
		private function readNodes(node:XML):void
		{			
			var i:int = 0;
			var j:int = 0;
			
			//读取level
			for ( i = 0;i<node.level.length();i++)
			{
				var data:VideoGuardPrivilegeData = new VideoGuardPrivilegeData;
				var id:int = node.level[i].@id;
				var valid:int = node.level[i].@valid;
				
				data.guardName = node.level[i].name;
				data.chatFont = node.level[i].ChatFont;
				data.chatFace = (node.level[i].ChatFace == "0"?false:true);
				data.wordnum = node.level[i].WordNum;
				data.joinBroadcast = (node.level[i].JoinBroadcast == "0"?false:true);
				data.chatCDTime = (node.level[i].ChatCdTime == "0"?false:true);
				data.joinFullRoom = (node.level[i].JoinFullRoom == "0"?false:true);
				data.playerListFont = node.level[i].PlayerListFont;
				data.guardIcon = node.level[i].GuardIcon;
				data.privilegeChatBoard = (node.level[i].PrivilegeChatBoard == "0"?false:true);
				data.banChat = (node.level[i].BanChat == "0"? false:true);
				data.maxNumCount = node.level[i].MaxNumCount;
				data.requireFollower = node.level[i].RequireFollower;
				data.requireAffinity = node.level[i].RequireAffinity;
				data.ingore_public_chat_on_enter = (node.level[i].IngorePublicChatCoolDownOnEnter == "0"?false:true);
				data.showInSuperGuardList = (node.level[i].ShowInSuperGuardList == "0" ? false:true);
				data.requireMonthlyAffinity = node.level[i].RequireMonthlyAffinity;
				
				if(node.level[i].DisableRooms !=null)
				{
					for ( j = 0;j<node.level[i].DisableRooms.room.length();j++)
					{
						var rid:int = node.level[i].DisableRooms.room[j].@value;
						data.disableJoinFullRoom.push(rid);
					}
				}
				m_guardData[id] = data;
				
			}
			//读取chatfaces
			for ( i = 0;i<node.ChatFaces.face_str.length();i++)
			{
				var str:String = node.ChatFaces.face_str[i].@value;
				m_chat_img.push(str);
			}
			//读取RuleURL
			m_guard_rule_url = node.RuleURL.@value;
		}
		
		public function GetGuardNameByLevel(level:int):String
		{
			var name:String = "";
			switch (level)
			{
				case GuardLevelEnum.primaryGuard:
					name = "初级守护";
					break;
				case GuardLevelEnum.middleGuard:
					name = "中级守护";
					break;
				case GuardLevelEnum.highGuard:
					name = "高级守护";
					break;
				case GuardLevelEnum.angelGuard:
					name = "天使守护";
					break;
				case GuardLevelEnum.soalGuard:
					name = "灵魂守护";
					break;
				case GuardLevelEnum.unNormalGuard:
					name = "非凡守护";
					break;
				case GuardLevelEnum.extremeGuard:
					name = "至尊守护";
					break;
				case GuardLevelEnum.tianZHunGuard:
					name = "天尊守护";
					break;
				case GuardLevelEnum.caoFanGuard:
					name = "超凡守护";
					break;									
			}
			
			return name;
		}
		
		public function GetChatFont(level:int):String
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return "";
			else
				return data.chatFont;
			
		}
		
		public function ShowChatFace(level:int):Boolean
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return false;
			else
				return data.chatFace;
		}
		public function GetSWordNum(level:int):int
		{
			var num:int = 63;
			if(level >= 100)
				num = 199;
			return num;
		}
		
		public function GetPlayerListFont(level:int):String
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return "";
			else
				return data.playerListFont;
		}
		
		public function ShowJoinBroadcast(level:int):Boolean
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return false;
			else
				return data.joinBroadcast;
			return false;
		}
		public function GetChatCdTime(level:int):Boolean
		{
			
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return false;
			else
				return data.chatCDTime;
			return false;
		}
		public function IsJoinFullRoom(level:int):Boolean
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return false;
			else
				return data.joinFullRoom;
			return false;
		}
		
		public function GetIcon(level:int):String
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return "";
			else
				return data.guardIcon;
		}
		
		public function GetGuardName(level:int):String
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
			{
				return "";
			}
			else
			{
				return data.guardName;	
			}
		}
		public function GetPrivilegeChatBoard( level:int):int
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return 0;
			else
				return (int)(data.privilegeChatBoard);	
		}
		public function GetMaxNumCount( level:int):int
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return 0;
			else
				return data.maxNumCount;	
			return 0;
		}
		public function GetRequireAffinity(level:int):int
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
			{
				return 0;
			}
			else
			{
				return data.requireAffinity;	
			}
			return 0;
		}
		
		//public function GetGuardLevel(affinity:int,follower:Int64,int* condition_type=NULL):int
		public function GetGuardLevel(affinity:int,follower:Int64 = null,condition_type:int = 0):int
		{			
			var level:Array = new Array;
			for(var key:String in m_guardData)
			{
				level.push(int(key));
			}
			
			level.sort(Array.NUMERIC);
			
			var maxindex:int = level.length -1;
			
			var a:int = 0;
			var b:int = 0;
			var c:int = 0;
			var d:int = 0;
			var r:int = 0;
			
			for(var i:int = 0; i< level.length-1;i++)
			{
				a = level[i];
				b = level[i+1];
				c =  m_guardData[a].requireAffinity;
				d = m_guardData[b].requireAffinity;			
				if(affinity >= c && affinity < d)
				{
					r = level[i];
					break;
				}
			}
			
			if(affinity >= m_guardData[level[maxindex]].requireAffinity)
				r = level[maxindex];
		
			return r;
			
		}
				
		public function GetSuperGuardLevel():int
		{
			return VIDEO_SUPER_GUARD_LEVEL;
		}
		public function CanUseChatImg(guard_level:int,img:String):Boolean
		{
			return false;
		}
		public function GetGuardRuleURL():String
		{
			return m_guard_rule_url;
		}
		public function CanJoinFullVideoRoom(guard_level:int,video_room_id:int):int
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(guard_level);
			if ( data == null )
			{
				// 没有守护特权，特殊提示
				return VideoRoomErrorCode.VIDEO_ROOM_FAIL_AUDIENCE_FULL;
			}
						
			for each(var rid:int in data.disableJoinFullRoom)
			{
				if(rid == video_room_id)					
					return VideoRoomErrorCode.VIDEO_ROOM_FAIL_AUDIENCE_FULL_FOR_SUPERGUARD;// 房间无视特权，普通提示
			}
			
			if (!data.joinFullRoom )
			{
				// 没有守护特权，特殊提示
				return VideoRoomErrorCode.VIDEO_ROOM_FAIL_AUDIENCE_FULL;
			}
			
			return VideoRoomErrorCode.VIDEO_ROOM_SUCCESS;
		}
		public function CanBanChat(level:int):Boolean
		{
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data == null)
				return false;
			else
				return data.banChat;	
			return 0;
		}
		
		public function GetNextGuardLevel(guard_level:int):int
		{
			var result:int = VIDEO_GUARD_LEVEL_INVALID;
			
			var lv:Array = new Array;
			var i:int = 0;
			for (var key:String in m_guardData)
			{
				lv.push(int(key));
			}
			lv.sort(Array.NUMERIC);
			
			for (i = 0; i < lv.length; i++)
			{
				if(lv[i] == guard_level)
					break;
			}
			
			if(i<lv.length -1)
			{
				result = lv[i+1];
			}
			return result;
		}
		public function GetMaxUnSuperLevel():int//手动赋予的守护级别之外的最高级守护
		{
			return 0;
		}
		
		public function CanIngorePublicChatCoolDownOnEnter(level:int):Boolean
		{
			if(VIDEO_GUARD_LEVEL_INVALID == level)
			{
				return false;
			}
			
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(data != null)
				return data.ingore_public_chat_on_enter;
			else
				return false;
		}
		
		//对于天尊和超凡来  查询需要的月亲密度
		public function getRequireMonthlyAffinity(guard_level:int):int
		{
			var affinity:int = 0;
			for (var key:String in m_guardData)
			{
				if(int(key) == guard_level)
				{
					affinity = m_guardData[key].requireMonthlyAffinity;
				}
			}			
			return affinity;
		}
		
		public function CanShowInSuperGuardList(level:int):Boolean//是否可以显示在UI的守护榜上
		{
			if (VIDEO_GUARD_LEVEL_INVALID == level)
			{
				return false;
			}
			var data:VideoGuardPrivilegeData = GetVideoGuardPrivilegeData(level);
			if(null != data)
				return  data.showInSuperGuardList;
			else
				return false;
		}
		public function GetVideoGuardPrivilegeData(guard_level:int):VideoGuardPrivilegeData
		{
			
			for(var level:String in m_guardData)
			{
				if(guard_level == int(level))
					return m_guardData[level];
			}
			return null;
		}		
	}
}