package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.TimerBase;
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.red_envelope.share.CEventChatIgnoreListOperate;
	import com.h3d.qqx5.modules.red_envelope.share.CEventGrabRedEnvelope;
	import com.h3d.qqx5.modules.red_envelope.share.CEventGrabRedEnvelopeRes;
	import com.h3d.qqx5.modules.red_envelope.share.CEventLoadRedEnvelope;
	import com.h3d.qqx5.modules.red_envelope.share.CEventLoadRedEnvelopeRes;
	import com.h3d.qqx5.modules.red_envelope.share.CEventPublishRedEnvelope;
	import com.h3d.qqx5.modules.red_envelope.share.RedEnvelopeInfo;
	import com.h3d.qqx5.modules.red_envelope.share.VideoRedEnvelopeError;
	import com.h3d.qqx5.modules.red_envelope.share.VideoRedEnvelopeEventId;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.ClientRedEnvelope;
	import com.h3d.qqx5.videoclient.data.UIVideoRedEnvelopeGrabberInfo;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientPlayer;
	
	public class CRedEnvelopeClient
	{
		private var m_client:IVideoClientInternal = null;
		private var m_base:CVideoClientBase = null;
		private var m_redenvelopes:Array = new Array();
		
		// 已抢完的红包缓存在客户端，每次查看的时候，从本地取
		private var m_finish_redenvelope_cache:Array = new Array();
		private var m_cd:int = 0;
		
		// 抢红包5秒CD
		private static const CD_COUNT:int = 5; 
		// 红包有效3分钟
		private static const DURATION:int = 180;
		
		private var updateRedEnvelope:TimerBase = null;
		
		public function CRedEnvelopeClient(client:IVideoClientInternal,base:CVideoClientBase)
		{
			m_client = client;
			m_base = base;			
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			var clsid:int = ev.CLSID();
			switch(clsid)
			{
				case VideoRedEnvelopeEventId.CLSID_CEventPublishRedEnvelope:
					HandleCEventPublishRedEnvelope(ev);
					break;
				case VideoRedEnvelopeEventId.CLSID_CEventGrabRedEnvelopeRes:
					HandleCEventGrabRedEnvelopeRes(ev);
					break;
				case VideoRedEnvelopeEventId.CLSID_CEventLoadRedEnvelopeRes:
					HandleCEventLoadRedEnvelopeRes(ev);
					break;
				default:
					break;
			}
			
			return true;
		}
		
		//发布红包结果
		private function HandleCEventPublishRedEnvelope(ev:INetMessage):void
		{
			var evt:CEventPublishRedEnvelope = ev as CEventPublishRedEnvelope;
			if(evt == null)
			{
				return;
			}
			
			var delay_time:int = 0;
			if(evt.room_audience_count > evt.delay_audience_count)
			{
				delay_time = Math.ceil(Math.random()*5);
			}
			
			if(delay_time == 0)
			{
				m_client.GetUICallback().OnPublishRedEnvelope(evt.red_id.toString(),evt.nick.replace(/\\/g,"\\\\"),
					evt.zone,evt.total_money,
					evt.divide_count,evt.red_envelope_duration,
					evt.small_red_envelope_duration
				);
			}
			else
			{
				var red:ClientRedEnvelope = new ClientRedEnvelope();
				var nowDate:Date = new Date();
				
				red.m_publish_time = nowDate.time /1000 + delay_time;
				red.m_red_id = evt.red_id.toString();
				red.m_nick = evt.nick;
				red.m_zone = evt.zone;
				red.m_total_money = evt.total_money;
				red.m_divide_count = evt.divide_count;
				red.m_red_envelope_duration = evt.red_envelope_duration;
				red.m_small_red_envelope_duration = evt.small_red_envelope_duration;
				m_redenvelopes.push(red);
				if(updateRedEnvelope == null)
				{
					updateRedEnvelope = new TimerBase(1000,Update);
					updateRedEnvelope.StartTimer();
				}
			}
		}
		
		// 随机0~5秒发出红包
		public function Update():void
		{
			var nowDate:Date = new Date();
			var i:int = 0;
			
			for (i = 0; i < m_redenvelopes.length; i++)
			{
				if(m_redenvelopes[i].m_publish_time <= nowDate.time /1000)
				{
					m_client.GetUICallback().OnPublishRedEnvelope(m_redenvelopes[i].m_red_id.toString(),
						m_redenvelopes[i].m_nick.replace(/\\/g,"\\\\"),
						m_redenvelopes[i].m_zone,
						m_redenvelopes[i].m_total_money,
						m_redenvelopes[i].m_divide_count,
						m_redenvelopes[i].m_red_envelope_duration,
						m_redenvelopes[i].m_small_red_envelope_duration
					);
					m_redenvelopes.splice(i,1);
				}
			}
			
			//清理过期红包缓存
			var serverTime:int = m_client.GetLogicInternal().GetServerTime();
			for (i = 0; i < m_finish_redenvelope_cache.length; i++)
			{
				if(m_finish_redenvelope_cache[i].m_publish_time +  DURATION <= serverTime)
				{
					m_finish_redenvelope_cache.splice(i,1);
				}
			}
		}
		
		//抢红包结果
		private function HandleCEventGrabRedEnvelopeRes(ev:INetMessage):void
		{
			var evt:CEventGrabRedEnvelopeRes = ev as CEventGrabRedEnvelopeRes;
			if(evt == null)
			{
				return;
			}
			
			if(evt.grabber.equal(m_client.GetSelfPersistID()))
			{
				var isGrabSuccess:Boolean = false;
				if(evt.result == VideoRedEnvelopeError.VREE_Success)
				{
					isGrabSuccess = true;
				}
				else if(evt.grab_count > 0 && evt.result == VideoRedEnvelopeError.VREE_GrabFinish)
				{
					isGrabSuccess = true;
					m_finish_redenvelope_cache.push(evt.redenvelope_info);
				}
				
				//抢成功了，则设置cd时间
				if(isGrabSuccess)
				{
					var nowDate:Date = new Date();
					m_cd = nowDate.time /1000 + CD_COUNT;
					//新角色更新梦幻币数量
					if(evt.grab_count_value > 0)
					{
						var videoplayer:IVideoClientPlayer = m_client.GetVideoClientPlayer();
						videoplayer.SetVideoMoney(videoplayer.GetDreamMoneyNum()+ evt.grab_count_value ,null);
					}
				}
				
				m_client.GetUICallback().OnGrabRedEnvelopeRes(evt.result,evt.red_id.toString(),evt.grab_count,evt.grab_count_value);
			}
			else if(evt.result == VideoRedEnvelopeError.VREE_GrabFinish)
			{
				m_finish_redenvelope_cache.push(evt.redenvelope_info);
				m_client.GetUICallback().OnRedEnvelopeGrabFinish(evt.red_id.toString());
			}
		}
		
		//查看红包记录回调
		private function HandleCEventLoadRedEnvelopeRes(ev:INetMessage):void
		{
			var evt:CEventLoadRedEnvelopeRes = ev as CEventLoadRedEnvelopeRes;
			if(evt == null)
			{
				return;
			}
			var ui_grabbers:Array = FillUIGrabbers(evt.redenvelope_info.grabbers);
			m_client.GetUICallback().OnLoadRedEnvelopeRes(evt.result,
				evt.redenvelope_info.red_id.toString(),
				evt.redenvelope_info.nick.replace(/\\/g,"\\\\"),
				evt.redenvelope_info.zone,
				evt.redenvelope_info.total_money,
				evt.redenvelope_info.divide_count,
				ui_grabbers);
		}
		
		//填充ui数据
		private function FillUIGrabbers(grabbers:Array):Array
		{
			var ui_grabbers:Array = new Array();
			for ( var i:int = 0; i < grabbers.length; ++i)
			{
				var item:UIVideoRedEnvelopeGrabberInfo = new UIVideoRedEnvelopeGrabberInfo();
				item.grabber = grabbers[i].grabber.toString();
				item.nick = grabbers[i].nick.replace(/\\/g,"\\\\");
				item.zone = grabbers[i].zone;
				item.grab_count = grabbers[i].grab_count;
				ui_grabbers.push(item);
			}
			return ui_grabbers;
		}
		
		
		//抢红包主动请求事件
		public function GrapRedEnvelope(red_id:Int64):void
		{
			var nowDate:Date = new Date();
			if(m_cd > nowDate.time /1000)
			{
				m_client.GetUICallback().OnGrabRedEnvelopeRes(VideoRedEnvelopeError.VREE_CD,red_id.toString(),0,0);
				return;
			}
			var ev:CEventGrabRedEnvelope = new CEventGrabRedEnvelope();
			ev.red_id = red_id;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		
		//土豪屏蔽或取消屏蔽玩家
		public function changeChatIngoreList(player_id:Int64,addOrDel:int):void
		{
			var ev:CEventChatIgnoreListOperate = new CEventChatIgnoreListOperate();
			ev.operate = addOrDel;//0屏蔽，1 取消屏蔽
//			ev.nick = nick;
//			ev.zone = zone;
			ev.player_id =player_id;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		//请求红包记录
		public function LoadRedEnvelope(red_id:Int64):void
		{
			var redinfo:RedEnvelopeInfo = GetFinisheRedEnvelope(red_id);
			
			if(redinfo != null)
			{
				var ui_grabbers:Array = FillUIGrabbers(redinfo.grabbers);
				
				m_client.GetUICallback().OnLoadRedEnvelopeRes(VideoRedEnvelopeError.VREE_Success,
					redinfo.red_id.toString(),
					redinfo.nick.replace(/\\/g,"\\\\"),
					redinfo.zone,
					redinfo.total_money,
					redinfo.divide_count,
					ui_grabbers);
			}
			else
			{
				var ev:CEventLoadRedEnvelope = new CEventLoadRedEnvelope();
				ev.red_id = red_id;
				m_client.SendEvent(ev,Globals.SelfRoomID);
			}
		}
		
		private function GetFinisheRedEnvelope(red_id:Int64):RedEnvelopeInfo
		{
			for each(var item:RedEnvelopeInfo in m_finish_redenvelope_cache)
			{
				if(item.red_id.equal(red_id))
				{
					return item;
				}
			}
			return null;
		}			
	}
}