package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.comdata.LuckyPlayer;
	import com.h3d.qqx5.common.comdata.RaffleRewardInfo;
	import com.h3d.qqx5.common.event.CEventLuckPlayerListIncrement;
	import com.h3d.qqx5.common.event.CEventNotifyRaffleState;
	import com.h3d.qqx5.common.event.CEventVideoRaffle;
	import com.h3d.qqx5.common.event.CEventVideoRaffleRes;
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.RaffleResult;
	import com.h3d.qqx5.videoclient.data.RaffleResultForUI;
	import com.h3d.qqx5.videoclient.data.RaffleRewardForUI;
	import com.h3d.qqx5.videoclient.data.RaffleState;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientAdapter;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	
	import flashx.textLayout.elements.BreakElement;
	
	public class CRaffleClientManager
	{
		public function CRaffleClientManager( pClient:IVideoClientInternal)
		{
			m_x5_client = pClient;
			m_state = 0;
			
		}
		
		private var OLINE_PICTURE_BUSINESS_ID:String =       "qdancer"   //业务ID
		private var OLINE_GIF_PICTURE_BUSINESS_ID:String =   "qqdance_gif"   //业务ID
		private var OriginalPicSizeSubpath:String =  "0";
		private var m_x5_client:IVideoClientInternal;
		private var m_exclude:Array=new Array;
		private var m_state:int ;//= new RaffleState;
		private var m_rewards:Array = new Array;//RaffleRewardForUIList
		private var m_lucky_player_list:Array = new Array;//RaffleResultForUIList
		private var m_room_raffle_id:Dictionary = new Dictionary;//std::map<int, int64>
		private var m_current_raffle_id:Int64 = new Int64;;
		private var m_cur_anchor_qq:String = "";
		private var m_timer:TimerBase = new TimerBase(1000,MinusTime);
		private var m_minustime:int ;
		private var m_isDelSelf:Boolean = false;
		public function DoRaffle():void
		{
			var pAdapter:IVideoClientAdapter = m_x5_client.GetVideoClientAdapter();
			if(pAdapter)
			{
				var res:Boolean = false;
				for each(var index:String in  m_room_raffle_id)
				{
					res = true;
					break;
				}
				if( res == true )
					pAdapter.GetRaffleID(m_room_raffle_id);//hss to do
			}
			m_x5_client.GetVideoClientAdapter().GetRaffleID(m_room_raffle_id);
			var result:RaffleRewardForUI = new RaffleRewardForUI ;
			if(IsRaffled())
			{
				if(m_x5_client.GetUICallback() != null)
					m_x5_client.GetUICallback().OnDoRaffleRes(RaffleResult.RR_Fail_Already_Raffled, result);
				return;
			}
			else if(m_state != RaffleState.RS_Raffling)
			{
				if(m_x5_client.GetUICallback())
					m_x5_client.GetUICallback().OnDoRaffleRes(RaffleResult.RR_Fail_State_Error, result);
				return;
			}
			
			//如果在exclude中直接返回
			var last_number:int = m_x5_client.GetLocalAccountID().toNumber() - m_x5_client.GetLocalAccountID().toNumber() / 10 * 10;
			var tmp : Boolean = false;
			for( var idx:int = 0; idx< m_exclude.length; idx++ )
			{
				if(m_exclude[idx] == last_number )
				{
					tmp= true;
					break;
				}
			}
			if( tmp ==true )
			{
				m_state = RaffleState.RS_TakenRaffle;
				m_room_raffle_id[m_x5_client.GetRoomID()] = m_current_raffle_id;
				//保存到本地
				m_x5_client.GetVideoClientAdapter().SaveRaffleID(m_x5_client.GetRoomID(), m_current_raffle_id);
				// callback
				if(m_rewards.length() > 0)
					result = m_rewards[m_rewards.length-1];
				if(m_x5_client.GetUICallback())
					m_x5_client.GetUICallback().OnDoRaffleRes(RaffleResult.RR_Success, result);
				return;
			}
			var event:CEventVideoRaffle = new CEventVideoRaffle ;
			
			m_x5_client.SendEvent(event,Globals.SelfRoomID);
		}
		
		public function IsRaffled():Boolean
		{
			if(m_state == RaffleState.RS_TakenRaffle)
			{
				return true;
			}
			
			for (var idx:String in m_current_raffle_id )
			{
				if(int(idx) == m_x5_client.GetRoomID() &&  m_current_raffle_id[idx] == m_current_raffle_id)
					return true;
			}
			return false;
		}
		
		public function HandleCEventNotifyRaffleState(  event:INetMessage ):void
		{
			var pEvent:CEventNotifyRaffleState = event as CEventNotifyRaffleState;

			if( pEvent == null )
			{
				return;
			}
			m_exclude = pEvent.exclude_number;
			
			//先关掉
			m_timer.StopTimer();
			//开始抽奖和显示奖励状态时候 开启倒计时
			if(  pEvent.state == RaffleState.RS_Raffling ||  pEvent.state == RaffleState.RS_ShowReward )
			{	
				m_minustime = pEvent.time_to_count_down;
				m_timer.StartTimer();
			}
			if(m_current_raffle_id.equal( pEvent.raffle_id) || m_state != RaffleState.RS_TakenRaffle || pEvent.state == RaffleState.RS_EndRaffle)
			{
				m_state = pEvent.state;
			}
			m_current_raffle_id = pEvent.raffle_id;
			m_cur_anchor_qq = pEvent.anchor_qq.toString();
			if(pEvent.state != RaffleState.RS_EndRaffle)
			{
				ChangeRewardToLocal(pEvent.reward_list,pEvent.anchor_qq);
			}
			else
			{
				m_rewards.splice(0);
				m_lucky_player_list.splice(0);
			}
			if(m_x5_client.GetUICallback() != null )
			{
				m_x5_client.GetUICallback().OnRaffleStateNotify(m_state, m_rewards, pEvent.time_to_count_down);
			}
		}
		
		public function HandleSuperRoomServerEvent(event:INetMessage ):void
		{
			var clsid:int = event.CLSID();
			switch(clsid)
			{
				case RaffleEventID.CLSID_CEventNotifyRaffleState:
					HandleCEventNotifyRaffleState(event);
					break;
				case RaffleEventID.CLSID_CEventVideoRaffleRes:
					HandleCEventVideoRaffleRes(event);
					break;
				case RaffleEventID.CLSID_CEventLuckPlayerListIncrement:
					HandleCEventLuckPlayerListIncrement(event);
					break;
				default:
					break;
			}
		}
		private var Pattern:RegExp = /\\/g;
		public function ChangeRewardToLocal( rewards :Array,qq:Int64):void
		{
			m_rewards.splice(0);
			for each(var idx:RaffleRewardInfo in rewards)
			{
				var info:RaffleRewardForUI = new RaffleRewardForUI;
				info.desc = idx.desc.replace(Pattern,"\\\\");
				if(idx.url != "" )
					info.pic_url =m_x5_client.GetPicDownloadUrl()+"/" +OLINE_PICTURE_BUSINESS_ID +"/" + qq.toString()+"/" + idx.url +"/" +OriginalPicSizeSubpath;
				else
					info.pic_url = "";
				
				m_rewards.push(info);
			}
		}
		
		public function HandleCEventVideoRaffleRes( event:INetMessage ):void
		{
			var pEvent:CEventVideoRaffleRes = event as CEventVideoRaffleRes;
			if(pEvent == null )
				return;
			m_state = RaffleState.RS_TakenRaffle;
			var info:RaffleRewardForUI = new RaffleRewardForUI;
			info.desc = pEvent.reward.desc;
			//info.pic_url = pEvent.reward.url;
			
			for(var i:int=0; i <m_rewards.length;i++)
			{
				if(info.desc == m_rewards[i].desc )
				{
					info.pic_url = m_rewards[i].pic_url;
					break;
				}
			}
			if(pEvent.res == RaffleResult.RR_Success && pEvent.is_lucky == true )
			{
				var resultinfo:RaffleResultForUI = new RaffleResultForUI ;
				resultinfo.nick = m_x5_client.GetVideoClientPlayer().GetVideoNick().replace(Pattern,"\\\\");
				resultinfo.gender = m_x5_client.GetVideoClientPlayer().Gender();
				resultinfo.reward_desc = pEvent.reward.desc;
				resultinfo.vip_level = m_x5_client.GetVideoClientPlayer().GetVipLevel();
				resultinfo.zone_name = m_x5_client.GetVideoClientPlayer().GetZoneName();
				resultinfo.player_id = m_x5_client.GetSelfPersistID().toString();
				//			resultinfo.get_reward_time = it.get_time;
				m_lucky_player_list.unshift(resultinfo);
				m_isDelSelf = true;
			}
			
			if(m_x5_client.GetUICallback() !=null )
				m_x5_client.GetUICallback().OnDoRaffleRes(pEvent.res, info, pEvent.is_lucky);
		}
		
		public function HandleCEventLuckPlayerListIncrement(  event:INetMessage):void
		{
			var pEvent:CEventLuckPlayerListIncrement = event as CEventLuckPlayerListIncrement;
			if( pEvent == null )
				return;
			if( pEvent.is_all )
				m_lucky_player_list.splice(0);
			//排序
			pEvent.player_list.sort(Compare);
			
			for each(var it:LuckyPlayer in pEvent.player_list )
			{
				if( m_isDelSelf == true && it.player_id.equal(m_x5_client.GetSelfPersistID() ) )
					continue;
				var info:RaffleResultForUI = new RaffleResultForUI ;
				info.nick = it.nick.replace(Pattern,"\\\\");
				info.gender = it.gender;
				info.reward_desc = it.reward_desc;
				info.vip_level = it.vip_level;
				info.zone_name = it.zone_name;
				info.player_id = it.player_id.toString();
				info.get_reward_time = it.get_time;
				m_lucky_player_list.unshift(info);//头部插入，最先抽到的肯定在最后
			}
		}
		
		//从小到大排序
		private function Compare(obj1:LuckyPlayer, obj2:LuckyPlayer ):int
		{
			if(obj1.get_time > obj2.get_time)
				return 1;
			if(obj1.get_time < obj2.get_time)
				return -1;
			else
				return 0;
		}
		
		public function QueryRaffle():void
		{
			if(IsRaffled() || m_state == RaffleState.RS_ShowResult)
			{
				var tmp:Array = new Array;
				if(m_x5_client.GetUICallback() !=null )
				{
					m_x5_client.GetUICallback().OnShowResult(m_state, m_lucky_player_list,tmp,m_minustime,m_x5_client.GetSelfPersistID().toString() );
				}
			}
			else
			{
				if(m_x5_client.GetUICallback() !=null )
				{
					//m_x5_client.GetUICallback().OnRaffleStateNotify(m_state, m_rewards, -1);
					var atmp:Array = new Array;
					m_x5_client.GetUICallback().OnShowResult(m_state, atmp,m_rewards,m_minustime,m_x5_client.GetSelfPersistID().toString());
				}
			}
		}
		public function  GetConcertCurLeftTime():void
		{		
			m_x5_client.GetUICallback().OnGetConcertCurLeftTime(m_minustime,m_state);
		}
		
		public function  MinusTime():int
		{
			if( m_minustime == 1)
				m_timer.StopTimer();
			return --m_minustime;
		}
		
	}
}