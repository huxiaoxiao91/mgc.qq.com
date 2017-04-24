package com.h3d.qqx5.modules.anchor_nest.client
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.AnchorImpressionData;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoBegin;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoEnd;
	import com.h3d.qqx5.common.event.CEventCommonActivityInfoRefresh;
	import com.h3d.qqx5.common.event.CEventCommonActivityPlayerRank;
	import com.h3d.qqx5.common.event.CEventLoadNestList;
	import com.h3d.qqx5.common.event.CEventNotifyPkMatchInfo;
	import com.h3d.qqx5.common.event.CEventRefreshAnchorPKRank;
	import com.h3d.qqx5.common.event.CEventRefreshCommonActivityData;
	import com.h3d.qqx5.common.event.CEventRefreshPkGift;
	import com.h3d.qqx5.common.event.CEventRefreshPkProgressInfo;
	import com.h3d.qqx5.common.event.CEventRefreshPkValue;
	import com.h3d.qqx5.common.event.CEventRefreshPlayerContributePKRank;
	import com.h3d.qqx5.common.event.CEventRefreshRocketBuff;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.anchor_nest.CAnchorNestConfig;
	import com.h3d.qqx5.modules.anchor_nest.events.AnchorNestEventID;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAddNestPopularityCreditsRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestGetAdvSupport;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestGetSupportUIInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestGetSupportUIInfoRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestNormalSupport;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestNormalSupportRes;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestNotifyAdvSupport;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestRefreshAnchorData;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventAnchorNestRefreshPopularityInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventGetGuardWage;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventGetNestGrowUpInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventNestGrowUpInfo;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventRefreshAddPopularityToClient;
	import com.h3d.qqx5.modules.anchor_nest.events.CEventRefreshNestCreditsLevel;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAdvSupport;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAdvSupportLogInfo;
	import com.h3d.qqx5.modules.anchor_nest.share.AnchorNestAdvSupportRankInfo;
	import com.h3d.qqx5.modules.anchor_nest.share.GuardWageInfo;
	import com.h3d.qqx5.modules.anchor_nest.share.NestCredtisLevelConfigInfo;
	import com.h3d.qqx5.modules.anchor_nest.share.NestCredtisLevelConfigInfoForUI;
	import com.h3d.qqx5.modules.nest_task.event.AnchorNestTaskEventID;
	import com.h3d.qqx5.modules.nest_task.event.CEventNotifyAnchorPublishNestTask;
	import com.h3d.qqx5.modules.nest_task.event.CEventNotifyAudienceTreasureBoxStatus;
	import com.h3d.qqx5.modules.nest_task.event.CEventNotifyNestTaskFinished;
	import com.h3d.qqx5.modules.nest_task.event.CEventQueryNestTaskRewardNewRole;
	import com.h3d.qqx5.modules.nest_task.event.CEventQueryNestTaskRewardNewRoleRes;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTask;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTaskRes;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTreasureBox;
	import com.h3d.qqx5.modules.nest_task.event.CEventTakeNestTreasureBoxErrRes;
	import com.h3d.qqx5.modules.nest_task.shared.NestTaskInfo;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.AnchorImpressionDataServer;
	import com.h3d.qqx5.videoclient.data.AnchorImpressionDataForUI;
	import com.h3d.qqx5.videoclient.data.AnchorNestPopularityInfo;
	import com.h3d.qqx5.videoclient.data.AnchorNestSupportInfo;
	import com.h3d.qqx5.videoclient.data.CReward;
	import com.h3d.qqx5.videoclient.data.ChatChannel;
	import com.h3d.qqx5.videoclient.data.ClientAnchorData;
	import com.h3d.qqx5.videoclient.data.NestTaskInfoForUI;
	import com.h3d.qqx5.videoclient.data.RewardDataForUI;
	import com.h3d.qqx5.videoclient.data.TakeAnchorTaskRes;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import com.h3d.qqx5.videoclient.data.WebColor;
	import com.h3d.qqx5.videoclient.interfaces.IAnchorNestClient;
	import com.h3d.qqx5.videoclient.interfaces.IUIAnchorNest;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.main.CVideoClientBase;
	
	import flash.utils.Dictionary;
	
	import flashx.textLayout.elements.BreakElement;

	public class AnchorNestClient implements IAnchorNestClient
	{
		private var m_base :CVideoClientBase;
		public var m_client :IVideoClientInternal ;
		private var m_callback:IUIAnchorNest;
		public var m_adv_support_map:Dictionary = new Dictionary ;
		public var m_is_nest :Boolean = false;
		public var m_is_assistant:Boolean = false;
		public var m_assistant_count : int = 0;
		public var m_local_star_rank :Array = new Array;
		public var m_config:CAnchorNestConfig;
		public var m_last_load_adv_rank :int = 0 ;
		
		public function AnchorNestClient(vc:IVideoClientInternal , base:CVideoClientBase)
		{
			m_base = base;
			m_client = vc;
			m_is_nest = false;
			m_is_assistant = false;
			m_local_star_rank = new Array;
			m_last_load_adv_rank = 0;
			m_adv_support_map = new Dictionary;
		}
		
		public function  GetUI():IUIAnchorNest
		{
			if(m_client == null)
				return null;
			if(m_client.GetUICallback()==null)
				return null;
			
			return m_client.GetUICallback().GetUIAnchorNest();
		}

		
		
		//获得捧场界面信息
		 public function LoadSupportInfo(player_id:Int64) :void
		 {
			 var ev:CEventAnchorNestGetSupportUIInfo = new CEventAnchorNestGetSupportUIInfo ;
//			 var nowt:int = 0;
//			 if(nowt - m_last_load_adv_rank >= 60)
				 ev.load_adv_rank = true;
//			 else
//				 ev.load_adv_rank = false;
			 m_client.SendEvent(ev,Globals.SelfRoomID);
			 return;
		 }
		//普通捧场
		 public function SendNormalSupport(player_id:Int64) :void
		 {
			 var ev:CEventAnchorNestNormalSupport = new CEventAnchorNestNormalSupport ;
			 ev.player_id = player_id;
			 m_client.SendEvent(ev,Globals.SelfRoomID);
			 return;
		 }
		//获得小窝的人气和排名及差值,在捧场界面中显示的是高级捧场每次的文字提示
		 public function LoadAnchorNestSimpleInfo() :void
		 {
			 var evt:CEventAnchorNestGetAdvSupport = new CEventAnchorNestGetAdvSupport ;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }

		//获取主播小窝中高级捧场记录
		 public function LoadAnchorNestAdvSupportRank() :void
		 {
			 var evt:CEventAnchorNestGetAdvSupport = new CEventAnchorNestGetAdvSupport ;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }
		//领取小窝任务
		 public function TakeNestTask() :void
		 {
			 var evt:CEventTakeNestTask = new CEventTakeNestTask ;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }
		
		//领取小窝宝箱奖励
		 public function TakeNestTreasureBox() :void
		 {
			 var evt:CEventTakeNestTreasureBox = new CEventTakeNestTreasureBox ;
			 evt.nest_id = Globals.SelfRoomID;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }

		 //查询人气宝箱奖励
		 public function QueryNestTreasureBox():void
		 {
			 var evt:CEventQueryNestTaskRewardNewRole = new CEventQueryNestTaskRewardNewRole ;
			 evt.index = 0;
			 evt.is_treasure_box = true;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }
		 //查询团务奖励
		 public function QueryNestTaskReward(index:int ):void
		 {
			 var evt:CEventQueryNestTaskRewardNewRole = new CEventQueryNestTaskRewardNewRole ;
			 evt.index = index;
			 evt.is_treasure_box = false;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }
		 
		 public function  IsAnchorPublishNestTask():Boolean
		 {
			 return false;
		 }
		//我是否领取了任务
		 public function   AmITakeNestTask():Boolean
		 {
			 return false;
		 }


		 public function   HandleServerEvent(evt:INetMessage):Boolean
		 {
			 var clsid:int = evt.CLSID();
			 Globals.s_logger.info("AnchorNestClient::HandleServerEvent"+clsid);
			 m_callback = GetUI();
			 if( m_callback ==null )
				 return true;
			 switch (clsid)
			 {				 
				 case AnchorNestEventID.CLSID_CEventAnchorNestNormalSupportRes:
					 HandleCEventAnchorNestNormalSupportRes(evt);
					 break;

				 case AnchorNestEventID.CLSID_CEventAnchorNestNotifyAdvSupport:
					 HandleCEventAnchorNestNotifyAdvSupport(evt);
					 break;
				 case AnchorNestTaskEventID.CLSID_CEventTakeNestTaskRes:
					 HandleCEventTakeNestTaskRes(evt);
					 break;

				 case AnchorNestEventID.CLSID_CEventAnchorNestRefreshPopularityInfo:
					 HandleCEventAnchorNestRefreshPopularityInfo(evt);
					 break;
				 case AnchorNestEventID.CLSID_CEventAnchorNestGetSupportUIInfoRes:
					 HandleCEventAnchorNestGetSupportUIInfoRes(evt);
					 break;
				 case AnchorNestEventID.CLSID_CEventAnchorNestRefreshAnchorData:
					 HandleCEventAnchorNestRefreshAnchorData(evt);
					 break;
				 case AnchorNestTaskEventID.CLSID_CEventNotifyNestTaskFinished:
					 HandleCEventNestTaskFinished(evt);
					 break;
				 case AnchorNestEventID.CLSID_CEventRefreshAddPopularityToClient:
					 HandleCEventRefreshAddPopularityToClient(evt);
				 case AnchorNestEventID.CLSID_CEventNestGrowUpInfo:
					 HandleCEventNestGrowUpInfo(evt);
					 break;
				 case AnchorNestEventID.CLSID_CEventAddNestPopularityCreditsRes:
					 HandleCEventAddNestPopularityCreditsRes(evt);
					 break;
				 case AnchorNestEventID.CLSID_CEventRefreshNestCreditsLevel:
					 HandleCEventRefreshNestCreditsLevel(evt);
					 break;
				 case AnchorNestTaskEventID.CLSID_CEventQueryNestTaskRewardNewRoleRes:
					 HandleQueryNestTaskRewardNewRoleRes(evt);
					 break;
				 case AnchorNestTaskEventID.CLSID_CEventTakeNestTreasureBoxErrRes:
					 HandleCEventTakeNestTreasureBoxErrRes(evt);
					 break;
				 case AnchorNestTaskEventID.CLSID_CEventNotifyAudienceTreasureBoxStatus:
					 HandleNotifyAudienceTreasureBoxStatus(evt);
					 break;
				 case AnchorNestTaskEventID.CLSID_CEventNotifyAnchorPublishNestTask:
					 HandleCEventNotifyAnchorPublishNestTask(evt);
					 break;
				 case AnchorPKEventID.CLSID_CEventRefreshAnchorPKRank:
					 HandleCEventRefreshAnchorPKRank(evt);
					 break;
				 case AnchorPKEventID.CLSID_CEventRefreshPlayerContributePKRank:
					 HandleCEventRefreshPlayerContributePKRank(evt);
					 break;
				 case AnchorPKEventID.CLSID_CEventRefreshRocketBuff:
					 HandleCEventRefreshRocketBuff(evt);
					 break;
				 case AnchorPKEventID.CLSID_CEventRefreshPkProgressInfo:
					 HandleCEventRefreshPkProgressInfo(evt);
					 break;
				 case AnchorPKEventID.CLSID_CEventNotifyPkMatchInfo:
					 HandleCEventNotifyPkMatchInfo(evt);
					 break;
				 case AnchorPKEventID.CLSID_CEventRefreshPkValue:
					 HandleCEventRefreshPkValue(evt);
					 break;
				 case AnchorPKEventID.CLSID_CEventRefreshPkGift:
					 HandleCEventRefreshPkGift(evt);
					 break;
				 case CommonActivityEventID.CLSID_CEventCommonActivityInfoBegin:
					 HandleCEventCommonActivityInfoBegin(evt);
					 break;	
				 case CommonActivityEventID.CLSID_CEventCommonActivityInfoEnd:
					 HandleCEventCommonActivityInfoEnd(evt);
					 break;	
				 case CommonActivityEventID.CLSID_CEventCommonActivityInfoRefresh:
					 HandleCEventCommonActivityInfoRefresh(evt);
					 break;	
				 case CommonActivityEventID.CLSID_CEventCommonActivityPlayerRank:
					 HandleCEventCommonActivityPlayerRank(evt);
					 break;	
				 case CommonActivityEventID.CLSID_CEventRefreshCommonActivityData:
					 HandleCEventRefreshCommonActivityData(evt);
					 break;	
				 default:
					 break;
			 }
			 return false;
		 }
		 public function OnLeaveRoom():void
		 {
			 m_last_load_adv_rank = 0;
			 return ;
		 }
		 public function ReadConfig(path:String):void
		 {
			 return ;
		 }
		
		//是否为小窝
		 public function  IsAnchorNestRoom():Boolean
		 {
			 return m_is_nest;
		 }
		 public function ToAnchorNestRoom( is_nest:Boolean):void 
		 {
			 m_is_nest = is_nest;
		 }
		//是否为小窝助手
		 public function  IsNestAssistant():Boolean  
		 {
			 return m_is_assistant;
		 }
		//置为小窝助手
		 public function SetNestAssistant(is_assistant:Boolean):void
		 {
			 m_is_assistant = is_assistant;
		 }
		 public function  GetAssistantCount():int
		 { 
			 return m_assistant_count; 
		 }
		 public function  GetMaxPicCount() :int 
		 { 
			 return m_config.GetMaxPic(); 
		 }
		 
		 public function GetNestCreditsLevel():int
		 {
			 return m_client.GetVideoClientPlayer().GetNestCreditsLevel();
		 }
		 
		 public function GetNestCredits():int
		 {
			 return m_client.GetVideoClientPlayer().GetNestCredits();
		 }
		 
		 
		 public function GetNestGrowUpInfo():void
		 {
			 var evt:CEventGetNestGrowUpInfo  = new CEventGetNestGrowUpInfo;
			 evt.nest_id = Globals.SelfRoomID;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }
		 
		 public function GetGuardWage():void
		 {
			 var evt:CEventGetGuardWage  = new CEventGetGuardWage;
			 m_client.SendEvent(evt,Globals.SelfRoomID);
		 }
		 
		 public function  GetNestList(roomid:int = 0):void
		 {
			 var evt:CEventLoadNestList  = new CEventLoadNestList;
			 if(roomid == 0)
				  roomid = Globals.SelfRoomID;
			 m_client.SendEvent(evt,roomid);
		 }
		 
		public function ConvertNestTaskInfoForUI(source_info:Array,  target_info:Array ):void
		{
			for(var  idx :int=0; idx< source_info.length; idx++)
			{
				var info:NestTaskInfoForUI = new NestTaskInfoForUI ;
				var sinfo:NestTaskInfo = source_info[idx];
				info.task_id =sinfo.task_id;
				info.description = sinfo.description ;
				info.need_finish_times = sinfo.need_finish_times;
				
				info.first_player_zone_name = sinfo.first_finish_zone_name;
				info.first_finish_player = sinfo.first_finish_player.replace(/\\/g,"\\\\");
				if( sinfo.first_finish_player == "" )
					info.status = 0;//没有人点亮
				else if( sinfo.is_self_finished )
				{
					info.status = 1;//我点亮了
				}
				else
					info.status = 2;//别人点亮了
				target_info.push(info);
			}
		} 
		
		private function GetAnchorImpressionForUI(data:Array, server_data:AnchorImpressionDataServer):void
		{
			var impression_list:Array = server_data.impressions;
			for each(var da:AnchorImpressionData in impression_list)
			{
				var tmp:AnchorImpressionDataForUI = new AnchorImpressionDataForUI;
				tmp.m_impression_id = da.impression_id;
				tmp.m_count = da.count;
				data.push(tmp);
			}
		}
		
		private function GetPromoteLevel(credits:int,precent:int):String
		{
//			precent = 100- precent;
			var expression:String = "";
			if(credits < 0 )
				expression=  "无";
			else if(credits >=0 && precent == 0)
				expression=  "成长积分>" + credits;
			else
				expression = "成长积分>" + credits + "且击败" + precent + "%小伙伴";
			return expression;
		}
		
		
		private function GetExpressinPrivilege(privilege:int):String
		{
			var expression:String = "";
			if(privilege == 0)
					expression=  "无";
			else
					expression=  "解锁表情包" + privilege;
			return expression;
		}
		
		
		private function GetLevelName(level:int):String
		{
			var name:String = "";
			 switch( level)
			 {
				 case 0:
					 name = "游客";
					 break;
				 case 1:
					 name = "初级公民";
					 break;
				 case 2:
					 name = "中级公民";
					 break;
				 case 3:
					 name = "高级公民";
					 break;
				 case 4:
					 name = "顶级公民";
					 break;
				 case 5:
					 name = "至尊公民";
					 break;
				 default:
					 break;
			 }
			 return name;
		}
		
		private function NestCredtisLevel( nest1:NestCredtisLevelConfigInfo,nest2:NestCredtisLevelConfigInfo):int
		{
			if(nest1.level > nest2.level)
				return 1;
			else if(nest1.level < nest2.level)
				return -1;
			else
				return 0;
		}
		
		private function SupportRankSort( nest1:AnchorNestAdvSupportRankInfo,nest2:AnchorNestAdvSupportRankInfo):int
		{
			if(nest1.times > nest2.times)
				return -1;
			else if(nest1.times < nest2.times)
				return 1;
			else if( nest1.times == nest2.times && nest1.player_id > nest2.player_id)
				return 1;
			else if( nest1.times == nest2.times && nest1.player_id < nest2.player_id)
				return -1;
			else
				return 0;
				
		}
		
		 private function HandleCEventTakeNestTaskRes(evt:INetMessage):void
		 {
			 var ev:CEventTakeNestTaskRes= evt as CEventTakeNestTaskRes;
			 if(!ev)
				 return;
			 var  info_list:Array = new Array;
			 ConvertNestTaskInfoForUI(ev.task_info_list , info_list);
			 
			 if(m_callback != null )
			 {
				 m_callback.OnTakeAnchorNestTaskRes(ev.result, info_list);
			 }
		 }
		 
		 private function HandleQueryNestTaskRewardNewRoleRes(evt:INetMessage):void
		 {
			 var ev:CEventQueryNestTaskRewardNewRoleRes = evt as CEventQueryNestTaskRewardNewRoleRes;
			 if(ev == null)
				 return;
			 var rewards:Array = new Array;
			 for( var i:int=0; i<ev.rewards_web.length; i++)
			 {
				 var web_rew:CReward = ev.rewards_web[i];
				 var rew:RewardDataForUI = new RewardDataForUI;
				 rew.rewardId = m_client.IsSelfMale()?web_rew.male_data:web_rew.female_data;
				 rew.count = web_rew.count;
				 rew.type = web_rew.type;
				 rewards.push(rew);
			 }
			 
			 if(m_callback != null )
			 {
				 if( ev.is_treasure_box )
					 m_callback.OnQueryNestTreasureBox(rewards);
				 else
					 m_callback.OnQueryNestTaskReward(rewards);
			 }
		 }

		 private function HandleCEventTakeNestTreasureBoxErrRes(evt:INetMessage ):void
		 {
			 var ev:CEventTakeNestTreasureBoxErrRes = evt as CEventTakeNestTreasureBoxErrRes;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.OnTakeNestTreasureBoxErrRes(ev.result);
			 }
		 }

		 private function HandleNotifyAudienceTreasureBoxStatus(evt:INetMessage ):void
		 {
			 var ev:CEventNotifyAudienceTreasureBoxStatus = evt as CEventNotifyAudienceTreasureBoxStatus;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.OnTreasureBoxStatus(ev.status);
			 }
		 }
		 
		 private function HandleCEventNotifyAnchorPublishNestTask(evt:INetMessage ):void
		 {
			 var ev:CEventNotifyAnchorPublishNestTask = evt as CEventNotifyAnchorPublishNestTask;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.OnPublishNestTask(ev.is_published);
			 }
		 }
		 
		 private function HandleCEventRefreshAnchorPKRank(evt:INetMessage ):void
		 {
			 var ev:CEventRefreshAnchorPKRank = evt as CEventRefreshAnchorPKRank;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onRefreshAnchorPKRank(ev);
			 }
		 }
		 
		 private function HandleCEventRefreshPlayerContributePKRank(evt:INetMessage ):void
		 {
			 var ev:CEventRefreshPlayerContributePKRank = evt as CEventRefreshPlayerContributePKRank;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onRefreshPlayerContributePKRank(ev);
			 }
		 }
		 
		 private function HandleCEventRefreshRocketBuff(evt:INetMessage ):void
		 {
			 var ev:CEventRefreshRocketBuff = evt as CEventRefreshRocketBuff;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onRefreshRocketBuff(ev);
			 }
		 }
		 
		 private function HandleCEventRefreshPkProgressInfo(evt:INetMessage ):void
		 {
			 var ev:CEventRefreshPkProgressInfo = evt as CEventRefreshPkProgressInfo;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onRefreshPkProgressInfo(ev);
			 }
		 }
		 
		 private function HandleCEventNotifyPkMatchInfo(evt:INetMessage ):void
		 {
			 var ev:CEventNotifyPkMatchInfo = evt as CEventNotifyPkMatchInfo;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onNotifyPkMatchInfo(ev);
			 }			 
		 }
		 
		 private function HandleCEventRefreshPkValue(evt:INetMessage ):void
		 {
			 var ev:CEventRefreshPkValue = evt as CEventRefreshPkValue;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onRefreshPkValue(ev);
			 }
		 }
		 
		 private function HandleCEventRefreshPkGift(evt:INetMessage ):void
		 {
			 var ev:CEventRefreshPkGift = evt as CEventRefreshPkGift;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onRefreshPkGift(ev);
			 }
		 }
		 private function HandleCEventCommonActivityInfoBegin(evt:INetMessage ):void
		 {
			 var ev:CEventCommonActivityInfoBegin = evt as CEventCommonActivityInfoBegin;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onCommonActivityInfoBegin(ev);
			 }
		 }
		 private function HandleCEventCommonActivityInfoEnd(evt:INetMessage ):void
		 {
			 var ev:CEventCommonActivityInfoEnd = evt as CEventCommonActivityInfoEnd;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onCommonActivityInfoEnd(ev);
			 }
		 }
		 private function HandleCEventCommonActivityInfoRefresh(evt:INetMessage ):void
		 {
			 var ev:CEventCommonActivityInfoRefresh = evt as CEventCommonActivityInfoRefresh;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onCommonActivityInfoRefresh(ev);
			 }
		 }
		 private function HandleCEventRefreshCommonActivityData(evt:INetMessage ):void
		 {
			 var ev:CEventRefreshCommonActivityData = evt as CEventRefreshCommonActivityData;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onRefreshCommonActivityData(ev);
			 }
		 }
		 private function HandleCEventCommonActivityPlayerRank(evt:INetMessage ):void
		 {
			 var ev:CEventCommonActivityPlayerRank = evt as CEventCommonActivityPlayerRank;
			 if(ev == null)
				 return;
			 if(m_callback != null )
			 {
				 m_callback.onCommonActivityPlayerRank(ev);
			 }
		 }
		 private function HandleCEventAnchorNestGetSupportUIInfoRes(evt:INetMessage):void
		 {
			 var ev:CEventAnchorNestGetSupportUIInfoRes = evt as CEventAnchorNestGetSupportUIInfoRes;
			 if(ev == null)
				 return;
			 m_last_load_adv_rank = 0;
			 if(m_callback != null )
			 {
				 var info:AnchorNestSupportInfo = new AnchorNestSupportInfo;
				 info.m_popularity_info.daily_reduce = ev.daily_reduce;
				 info.m_popularity_info.gap = ev.gap.toString();
				 info.m_popularity_info.popularity = ev.popularity.toString();
				 info.m_popularity_info.owner_qq = ev.owner_qq.toString();
				 info.m_player_info.star = ev.star.toString();
				 info.m_popularity_info.num = ev.num;
				 
				 if(ev.load_adv_rank)
				 {
					 m_adv_support_map = ev.adv_logs;
				 }

				 var ui_rank:Array = new Array;
				 for(var iter:Object in m_adv_support_map )
				 {
					 var rank_info:AnchorNestAdvSupportRankInfo = new AnchorNestAdvSupportRankInfo ;
					 var support:AnchorNestAdvSupport = m_adv_support_map[iter];
					 rank_info.player_id = support.player_id.toString();
					 rank_info.player_name = support.player_info.name.replace(/\\/g,"\\\\");
					 rank_info.zone_name =  support.player_info.zone_name;
					 rank_info.times = support.count;
					 if( support.player_id.equal( m_client.GetSelfPersistID() ) )
						 info.m_popularity_info.adv_num = support.count;
					 ui_rank.push(rank_info);
				 }
				 ui_rank.sort(SupportRankSort);
				 //只显示十条。。。。
				 if(ui_rank.length >= 10 )
				 	ui_rank.splice(10);
				 
				 info.m_normal_support_today = ev.normal_support_today;
				 info.m_adv_support_logs = ui_rank;

				 
				 var task_info:Array = new Array;
				 ConvertNestTaskInfoForUI(ev.task_list, task_info);
				 
				 var is_inGuild:Boolean = false;
				 var pstid:String = m_client.GetVideoClientBase().GetVideoGuildClient().GetVideoGuildSurportAnchor().toString();
				 if( pstid== info.m_popularity_info.owner_qq )
					 is_inGuild = true;
				 
				 if( ev.is_publish_nest_task == true)
					 TakeNestTask();//发布了团务就自动领取团务
				 m_callback.OnLoadSupportInfo(ev.result, info, task_info, ev.is_publish_nest_task,is_inGuild);
			 }
		 }
		 
		 private function HandleCEventAnchorNestRefreshAnchorData(evt:INetMessage):void
		 {
			 var ev:CEventAnchorNestRefreshAnchorData = evt as CEventAnchorNestRefreshAnchorData;
			 if(ev == null)
			 {
				 return;
			 }
			 
			 if(m_callback != null )
			 {
				 var ui_data:ClientAnchorData = new ClientAnchorData ;
				 ui_data.anchorID = ev.anchor_data.pstid.toString();
				 ui_data.anchorQQ = ev.anchor_data.pstid.toString();
				 ui_data.followedAudiences = ev.anchor_data.followed;
				 ui_data.starlight = ev.anchor_data.starlight.toString();
				 ui_data.popularity = ev.anchor_data.popularity.toString();
				 ui_data.name = ev.anchor_name.replace(/\\/g,"\\\\");
				 ui_data.intro = ev.anchor_intro;
				 ui_data.m_impression_data.m_total_count = ev.anchor_ipr.total_count;
				 ui_data.m_impression_data.m_player_count = ev.anchor_ipr.player_count;
				 ui_data.is_anchor_with_dance_mark = ev.is_with_dance_mark;
				 ui_data.bottleneck_gift_id = ev.botteneck_gift_id;
				 ui_data.bottleneck_need_count = ev.bottleneck_need_count;
				 ui_data.anchor_level = ev.anchor_data.level;
				 ui_data.anchor_exp = ev.anchor_data.exp;
				 ui_data.anchor_levelup_exp = ev.levelup_need_exp;
				 ui_data.starlight_rest_exp_today = ev.starlight_rest_exp_today;
				 ui_data.dream_gift_rest_exp_today = ev.dream_gift_rest_exp_today;
				 ui_data.anchor_badge = ev.anchor_badge;
				 ui_data.lucky_draw_rest_exp_today = ev.lucky_draw_rest_exp_today;
				 if(ev.anchor_data.stGrowth_data.bottleneck_count < 0)//表示没有到瓶颈期
				 {
					 ui_data.is_bottleneck = false;
				 }
				 else
				 {
					 ui_data.is_bottleneck = true;
					 ui_data.bottleneck_count = ev.anchor_data.stGrowth_data.bottleneck_count;
				 }
					
				 GetAnchorImpressionForUI(ui_data.m_impression_data.m_impressions, ev.anchor_ipr);

				if (ev.anchor_data.anchor_portrait_url != "") {
					//XW79794 去除头像随机数
					ui_data.photoUrl = Globals.m_pic_download_url + "/qdancersec/" + ev.anchor_data.anchor_portrait_url; //+ "/0" + URLSuffix.CreateVersionString();
				}
				//使用老方法拼接头像
				else if (ui_data.anchorQQ != "") {
					m_client.GetVideoClientBase().FillAnchorPortraitUrl(ui_data);
//					m_client.GetVideoClientBase().FillAnchorImageUrl(ui_data);
				}
				
				if (ui_data.anchorQQ != "") {
					m_client.GetVideoClientBase().FillAnchorImageUrl(ui_data);
				}
				 
				 m_callback.RefreshAnchorData(ui_data);
				 
				 var isFollow:Boolean = m_client.GetVideoClientPlayer().IsFollowingAnchor(ev.anchor_data.pstid);
				 m_client.GetUICallback().RefreshAnchorInfoByData(ui_data,isFollow,Globals.room_name);
				 m_base.GetVideoGuildClient().SetCurrLivingAnchorPstid(ev.anchor_data.pstid.toString());
			 }
		 }
		 
		 private function HandleCEventNestTaskFinished(evt:INetMessage):void
		 {
			 var ev:CEventNotifyNestTaskFinished = evt as CEventNotifyNestTaskFinished;
			 
			 if(ev == null)
				 return;
			 var orginal_list:Array = new Array;
			 orginal_list.push(ev.nest_task_info);
			 
			 var info_list:Array = new Array;
			 ConvertNestTaskInfoForUI(orginal_list, info_list);
			 
			 if(m_callback != null )
			 {
				 m_callback.OnNotifyNestTaskFinished(info_list);
			 }
		 }
		 
		 private var isHint:Boolean = false;//免费人气值是否达到上限
		 
		 private function HandleCEventRefreshAddPopularityToClient(evt:INetMessage):void
		 {
			 var ev:CEventRefreshAddPopularityToClient = evt as CEventRefreshAddPopularityToClient;
			 if( ev == null)
				 return ;
			 
			 var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			 msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
			 msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			 msg_data.systemType = 0;
			 
			 if( m_callback != null)
			 {
				 if(!ev.is_hint && ev.is_free_pop_limit)
				 {		
				 	msg_data.msg = "$t$今天已不能通过免费方式送增加房间人气了，请给主播献付费礼物吧！$z";
					m_client.GetUICallback().OnReceiveChatMsg(msg_data);	
				 }
				 else if(!ev.is_free_pop_limit)
				 {
					 msg_data.msg = "$t$您为当前房间贡献了" + ev.add_popularity + "人气！$z";
					 m_client.GetUICallback().OnReceiveChatMsg(msg_data);
				 }
					
				 m_callback.OnAddNestPopularity(ev.add_popularity,ev.is_free_pop_limit);
			 }
		 }
		 
		 private function HandleCEventAddNestPopularityCreditsRes(evt:INetMessage):void
		 {
			 var ev:CEventAddNestPopularityCreditsRes = evt as CEventAddNestPopularityCreditsRes;
			 if(ev == null )
				 return ;
			 m_client.GetVideoClientPlayer().SetNestCreditsLevel(Globals.SelfRoomID,ev.cur_credits, ev.cur_credits_level);
			 if(m_callback != null )
			 {
				 m_callback.OnAddNestPopularityCreditsRes(ev.free_popularity_limit, ev.is_need_hint, ev.add_popularity, ev.add_credits);
			 }
		 }
		 
		 private function HandleCEventRefreshNestCreditsLevel(evt:INetMessage):void
		 {
			 var ev:CEventRefreshNestCreditsLevel = evt as CEventRefreshNestCreditsLevel;
			 if(ev == null )
				 return ;
			 m_client.GetVideoClientPlayer().SetNestCreditsLevel(ev.nest_id, ev.credits, ev.credits_level);
			 if(ev.nest_id == Globals.SelfRoomID)
			 {
				 if(m_callback != null )
				 {
					 m_callback.OnRefreshNestCreditsPanel( ev.credits, ev.credits_level);
				 }
			 }
		 }
		 
		private function HandleCEventAnchorNestNormalSupportRes(evt:INetMessage):void
		{
			var ev:CEventAnchorNestNormalSupportRes = evt as CEventAnchorNestNormalSupportRes;
			if(m_callback != null)
			{
				m_callback.OnSendNormalSupport(ev.result, ev.add_popularity, ev.star.toString() );
			}
		}
		
		private function HandleCEventAnchorNestNotifyAdvSupport(evt:INetMessage):void
		{
			var ev:CEventAnchorNestNotifyAdvSupport = evt as CEventAnchorNestNotifyAdvSupport;
			if(ev == null)
				return;
			//需求要求别人捧场的时候 不需要刷新超级捧场记录，所以判断下 不是自己就不会通知页面
			if( ev.player_name != m_client.GetVideoClientPlayer().GetVideoNick() || ev.zone_name != m_client.GetVideoClientPlayer().GetZoneName() )
			{
				//别人捧场刷新人气
				m_callback.OnAddNestPopularity(ev.add_popularity,false);
				return ;
			}
			if(m_callback != null )
			{
				var info:AnchorNestAdvSupportLogInfo = new AnchorNestAdvSupportLogInfo ;
				info.name = ev.player_name.replace(/\\/g,"\\\\");
				info.zone_name = ev.zone_name;
				//AnchorNestAdvSupportLogs logs;
				var adv_support_map:Dictionary = ev.adv_support;
				m_adv_support_map = ev.adv_support;

				var ui_rank:Array = new Array;
				for(var iter:Object in adv_support_map )
				{
					var supinfo: AnchorNestAdvSupportRankInfo = new AnchorNestAdvSupportRankInfo ;
					var advinfo:AnchorNestAdvSupport = adv_support_map[iter]
					supinfo.player_id = advinfo.player_id.toString();
					supinfo.player_name = advinfo.player_info.name.replace(/\\/g,"\\\\");
					supinfo.zone_name = advinfo.player_info.zone_name;
					supinfo.times = advinfo.count;
					ui_rank.push(supinfo);
				}
				ui_rank.sort(SupportRankSort  );//按次数由高到低排序,次数相同按id排序
				
				//
				var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
				msg_data.channel = ChatChannel.VIDEOCHNL_System;//系统消息
				msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
				msg_data.systemType = 0;
				msg_data.msg = "$t$您为当前房间贡献了" + ev.add_popularity + "人气！$z";
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);	
				
				m_callback.NotifyAdvancedSupportSuccess(info, ui_rank, ev.add_popularity, ev.nest_star.toString());
			}
		}
		
		 private function HandleCEventAnchorNestRefreshPopularityInfo(evt:INetMessage):void
		 {
			 var ev:CEventAnchorNestRefreshPopularityInfo = evt as CEventAnchorNestRefreshPopularityInfo;
			 
			 if(ev == null)
				 return;
			 
			 if(m_callback != null)
			 {
				 var info:AnchorNestPopularityInfo = new AnchorNestPopularityInfo ;
				 info.daily_reduce = ev.daily_reduce;
				 info.gap = ev.gap.toString();
				 info.popularity = ev.popularity.toString();
				 info.owner_qq = ev.owner_qq.toString();
				 info.num = ev.num;
				 m_callback.RefreshAnchorNestPopularityInfo(info);
			 }
		 }
		 
		 private function HandleCEventNestGrowUpInfo(evt:INetMessage):void
		 {
			 var ev:CEventNestGrowUpInfo = evt as CEventNestGrowUpInfo;
			 if(!ev)
				 return ;
			 
			 if(m_callback != null )
			 {
				 var nest_credits_level_info_vec_ui:Array = new Array;
				 ev.nest_credits_level_config_vec.sort(NestCredtisLevel);//按等级排序
				 for(var idx:int = 0 ; idx< ev.nest_credits_level_config_vec.length; idx ++)
				 {
					 var it:NestCredtisLevelConfigInfo = ev.nest_credits_level_config_vec[idx];
					 var  nest_credits_level_info:NestCredtisLevelConfigInfoForUI = new NestCredtisLevelConfigInfoForUI;
					 nest_credits_level_info.level = "LV" + it.level;
					 nest_credits_level_info.promoteLevel = GetPromoteLevel( it.credits, it.percent);
					 nest_credits_level_info.expression_privilege = GetExpressinPrivilege(it.expression_privilege);
					 nest_credits_level_info.levelname = GetLevelName(it.level);
					 nest_credits_level_info_vec_ui.push(nest_credits_level_info);
				 }

				 var guardinfo:Array = new Array;
				 for(var index:Object in ev.guard_wage_info )
				 {
//					 var wageinfo :GuardWageInfo = new GuardWageInfo;
//					 wageinfo.Level = index;
//					 wageinfo.wage = ev.guard_wage_info[index];
					 guardinfo.push(ev.guard_wage_info[index]);
				 }
				 guardinfo.sort(Array.NUMERIC);//按等级排序
				 
//				 Globals.s_logger.debug( "get_guard_wage_credits :" + ev.get_guard_wage_credits);
				 if(ev.get_guard_wage == false)//成长信息的回调
				 {
					 var is_guard:Boolean = false;
					if (m_client.GetVideoClientBase().GetPlayerGuardLevel() > 0 )
						is_guard = true;
					 m_callback.OnGetNestGrowUpRes( ev.credits, ev.credits_level, ev.rank, ev.credits_distance_of_prev_or_1000,
						 ev.rank_need_promote, ev.credits_need_promote, ev.honor_num_need_promote, ev.is_get_guard_wage,is_guard,
						 nest_credits_level_info_vec_ui, guardinfo);
				 }
				 else
				 {
					 m_callback.OnGetGuardWageRes( ev.credits, ev.credits_level, ev.rank, ev.credits_distance_of_prev_or_1000,
						 ev.rank_need_promote, ev.credits_need_promote, ev.honor_num_need_promote, ev.is_get_guard_wage,
						 ev.get_guard_wage_credits, nest_credits_level_info_vec_ui,guardinfo );
				 }
			 }
			 m_client.GetVideoClientPlayer().SetNestCreditsLevel(Globals.SelfRoomID,ev.credits, ev.credits_level);
		 }
	}
}