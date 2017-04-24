package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventRefreshAnchorPKRichmanRank;
	import com.h3d.qqx5.modules.anchor_pk.event.CEventRefreshAnchorPKWinnerRank;
	import com.h3d.qqx5.modules.anchor_pk.event.VideoAnchorPKEventID;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.PersistIDUtil;
	import com.h3d.qqx5.util.URLSuffix;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorPKRichmanRank;
	import com.h3d.qqx5.video_rank_server.shared.VideoAnchorPKWinnerRank;
	import com.h3d.qqx5.videoclient.OlinePictureDef;
	import com.h3d.qqx5.videoclient.data.AnchorPKFansAvatar;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	import com.h3d.qqx5.videoclient.data.VideoAnchorPKRichManRankForUI;
	import com.h3d.qqx5.videoclient.data.VideoAnchorPKWinnerRankForUI;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorPKClient;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.junkbyte.console.Cc;
	
	import flash.utils.Dictionary;

	public class AnchorPKClient implements IAnchorPKClient
	{
		//private var m_video_client_player:VideoClientPlayer;
		private var m_base:CVideoClientBase;
		private var m_client:IVideoClientInternal;
		
		private var m_anchor_data:Dictionary =new Dictionary;
		public function AnchorPKClient(vc:IVideoClientInternal, base:CVideoClientBase)
		{
			m_base = base;
			//m_video_client_player = new VideoClientPlayer(this, m_base);
			m_client = vc;
		}
		public function GetRoomID():int
		{
			return Globals.SelfRoomID;
		}
		private function IsInVideoRoomEvent(clsid:int):Boolean
		{
			switch(clsid)
			{
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshLiveStatus:
				case EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshCurrentAnchorDetail:
				case EEventIDVideoRoom.CLSID_CEventNotifySendLotsOfGifts:
				case EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomBroadcastAllRoom:
					// TODO
			  //case VideoAnchorPKEventID.CLSID_CEventAnchorPKForecast:
			  //case VideoAnchorPKEventID.CLSID_CEventAnchorPKMatchEndBroadcast:
					return true;
				default:
					break;
			}
			
			return false;
		}
		private function ShouldProcessEvent(clsid:int):Boolean
		{
			var room_id:int = GetRoomID();
			
			if(room_id == 0 && IsInVideoRoomEvent(clsid))
				return false;
			
			return true;
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			if(ev == null)
			{
				return false;
			}
			//m_video_client_player.HandleVideoServerEvent(ev);
			//var res:Boolean = m_base.HandleServerEvent(ev);
//			if(res)
//			{
//				return res;
//			}
			// TODO 其余特化的处理
			var clsid:int = ev.CLSID();
			Globals.s_logger.log("AnchorPKClient::HandleServerEvent clsid:" + clsid);
			switch(clsid)
			{							
				case VideoAnchorPKEventID.CLSID_CEventRefreshAnchorPKWinnerRank:
					HandleCEventRefreshAnchorPKWinnerRank(ev);
					break;
				case VideoAnchorPKEventID.CLSID_CEventRefreshAnchorPKRichmanRank:
					HandleCEventRefreshAnchorPKRichmanRank(ev);
					break;
				default:
					break;
			}		
			return true;
		}
		private var Pattern:RegExp = /\\/g;
		private function HandleCEventRefreshAnchorPKWinnerRank(ev:INetMessage):void
		{
			var evt:CEventRefreshAnchorPKWinnerRank = ev as CEventRefreshAnchorPKWinnerRank;
			var rank:Array = new Array;
			for each(var tmp:VideoAnchorPKWinnerRank in evt.rank)
			{
				var data:VideoAnchorPKWinnerRankForUI = new VideoAnchorPKWinnerRankForUI;
				data.m_anchor_id = tmp.anchor_id.toString();
				data.m_anchor_nick = tmp.anchor_nick.replace(Pattern,"\\\\");
				data.m_guild_name = tmp.guild_name;
				data.m_anchor_status = tmp.anchor_status;
				data.m_room_id = tmp.room_id;
				data.m_is_nest = tmp.is_nest;
				//添加主播头像数据
				if (tmp.m_anchor_url != "") {
					data.m_anchor_portraiturl = Globals.m_pic_download_url + "/qdancersec/" + tmp.m_anchor_url + "/0" + URLSuffix.CreateVersionString();
				}
				rank.push(data);
			}
			m_client.GetUICallback().OnLoadAnchorPKWinnerRank(VideoResultType.VREST_Normal, rank, evt.show_end_time);
		}
		private function HandleCEventRefreshAnchorPKRichmanRank(ev:INetMessage):void
		{
			var evt:CEventRefreshAnchorPKRichmanRank = ev as CEventRefreshAnchorPKRichmanRank;
			var rank:Array = new Array;
			for each(var tmp:VideoAnchorPKRichmanRank in evt.rank)
			{
				var data:VideoAnchorPKRichManRankForUI = new VideoAnchorPKRichManRankForUI;
				data.m_player_id = tmp.player_id.toString();
				data.m_player_nick = tmp.player_nick.replace(Pattern,"\\\\");
				data.m_contribution = tmp.contribution.toString();
				data.player_gender = tmp.player_gender;
				data.player_portrait = tmp.player_portrait;
				if (tmp.m_player_url != "" && data.player_portrait != 0) {
					data.playerPhotoUrl = Globals.m_pic_download_url + "/qdancersec/" + tmp.m_player_url + "/0" + URLSuffix.CreateVersionString();
				}
				rank.push(data);
			}
			m_client.GetUICallback().OnLoadAnchorPKRichManRank(VideoResultType.VREST_Normal, rank, evt.show_end_time);
		}
		//活动状态(无活动 pk阶段 展示结果阶段)
		public function GetAnchorPKActivityStatus():int
		{
			return 0;
		}
		//客户端当前是否在活动房间中
		public function InActivityRoom():Boolean
		{
			return false;
		}
		//		//比赛状态（准备阶段 缓冲阶段 进攻阶段等等）
		public function GetAnchorPKMatchStatus():int
		{
			return 0;
		}
		//		//土豪形象
		public function GetTopFansAvatar(anchor_id:String, buff:AnchorPKFansAvatar):void
		{
			
		}
		//		//比分详情
		public function GetAnchorPKScoreInfo(player_id:Int64):void
		{
			
		}
		//		//获得参赛直播信息
		public function GetPKAnchorDataForUI(anchor_qq:Int64, data:ClientAnchorData):void
		{
			
		}
		//		function bool HandleServerEvent(IEvent* evt) = 0;
		public function RefreshMatchAnchorStarLightAndPopular(anchor_id:Int64, star:Int64,popular:Int64):void
		{
			
		}
		public function RefreshAnchorInfoByData(data:ClientAnchorData):void
		{
			if(data.anchorID == "")
				return;
			
			if(m_anchor_data[data.anchorID] != null )
			{
				var info:ClientAnchorData  = m_anchor_data[data.anchorID];
				info = data;
			}
		}
		public function RefreshAnchorInfo(anchor_id:Int64, name:String, intro:String) :void
		{
			if(anchor_id.isZero())
				return;
			
			if( m_anchor_data[anchor_id] !=null )
			{
				var info:ClientAnchorData  = m_anchor_data[anchor_id];
				info.name = name;
				info.intro = intro;
			}
		}
		public function RefreshAnchorFollowedNum(anchor_id:Int64, followed:int ):void
		{
			
		}
		public function RefreshAnchorImage(anchor_id:Int64 ):void
		{
			
		}
		public function ShowActivityButton():Boolean
		{
			return false;
		}
		//		//获取在本次PK阶段玩家的贡献值
		public function GetPlayerContributionInCurPK(player_id:Int64 ):void
		{
			
		}
		public function SetPKRooms(rooms:Array):void
		{
			
		}
		public function ClearAvatarCathe():void
		{
			
		}
		
	}
}