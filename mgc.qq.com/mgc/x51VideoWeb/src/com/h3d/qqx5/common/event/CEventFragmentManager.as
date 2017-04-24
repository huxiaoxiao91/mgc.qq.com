package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.SingletonMgr;
	import com.h3d.qqx5.common.comdata.CFragFunResult;
	import com.h3d.qqx5.common.event.eventid.ConcertEventID;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.common.event.eventid.RaffleEventID;
	import com.h3d.qqx5.framework.network.CEventRoomProxyWrapEvent;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.MessageID;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.framework.network.ProtoBufSerializer;
	import com.h3d.qqx5.modules.video_guild.share.event.VideoGuildEventID;
	import com.h3d.qqx5.modules.video_vip.shared.event.VideoVipEventID;
	import com.h3d.qqx5.share.game_event.CEventFragment;
	import com.h3d.qqx5.share.game_event.EventFragmentID;
	import com.h3d.qqx5.video_server.event.VideoServerEventID;
	
	public class CEventFragmentManager
	{
		public static const FRAG_COUNT_LIMIT:int = 2000;
		public static const FRAGMENTSIZE:int = 1000;
		public static const TIMEOUT_MS:int =  60000 // 1分钟
			
		public function CEventFragmentManager(frag:int = FRAG_COUNT_LIMIT)
		{
			m_max_frag = frag;
		}
		
		//分片
		public function SliceEvent(event:INetMessage):Array
		{
			var fragments:Array = new Array;
			var clsid:int = event.CLSID();
			
			if (    clsid == VideoServerEventID.CLSID_CEventVideoRoomUploadSnapshot
				||	clsid == EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorPortrait
				||  clsid == EEventIDVideoRoom.CLSID_CEventVideoRoomUploadAnchorImage
				||	clsid == EEventIDVideoRoom.CLSID_CEventVideoRoomUploadRoomPic
				||  clsid == EEventIDVideoRoom.CLSID_CEventReportAnchor
				||  clsid == EEventIDVideoRoom.CLSID_CEventUploadVideoProgrammeLogo
				||  clsid == VideoVipEventID.CLSID_CEventUploadVideoPlayerCardPortrait
				||	clsid == VideoGuildEventID.CLSID_CEventLoadMyVideoGuildResult
				||	clsid == VideoGuildEventID.CLSID_CEventLoadVideoGuildListResult
				||  clsid == VideoGuildEventID.CLSID_CEventLoadVideoGuildLogRecordResult
				||  clsid == VideoGuildEventID.CLSID_CEventVideoGuildCreateRes
				||  clsid == VideoGuildEventID.CLSID_CEventGetVideoGuildInfoRes
				||  clsid == VideoGuildEventID.CLSID_CEventOperateVideoGuildInviteRes
				||  clsid == VideoGuildEventID.CLSID_CEventAcceptJoinApplyTargetOnlineNotify
				||  clsid == VideoGuildEventID.CLSID_CEventGetVideoGuildJoinApplyListRes
				||	clsid == MessageID.CLSID_CEventRoomProxyWrapEvent
				||  clsid == ConcertEventID.CLSID_CEventLoadOnePageWhistleRes
				||  clsid == ConcertEventID.CLSID_CEventPassDelALLWhistleRes
				||  clsid == RaffleEventID.CLSID_CEventUploadRewardImage
			)
			{
				if(clsid == MessageID.CLSID_CEventRoomProxyWrapEvent)
				{
					var realev:CEventRoomProxyWrapEvent = event as CEventRoomProxyWrapEvent;
					//BUG XW78742 获取奖励描述需要分包处理。
					if (realev
						&& realev.clsid != VideoVipEventID.CLSID_CEventUploadVideoPlayerCardPortrait
						&& realev.clsid != EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardDesc) 
					{
						return fragments; //外部直接发送,不切片
					}
				}
				var buf:NetBuffer = new NetBuffer ;
//				var os :NetBuffer  = new NetBuffer;
//				os = buf;
				var index:int = 0;
				var frag_count:int;
				var put_size:uint;
				
				//序列化
				//buf.putInt(event.CLSID() );
				ProtoBufSerializer.ToStream(event,buf);
				
				frag_count = (buf.length()+FRAGMENTSIZE-1)/FRAGMENTSIZE;
				buf.buffer().position = 0;
				
				while (frag_count>index)
				{
					var ev:INetMessage = SingletonMgr.Instance().GetMsgFactory().CreateMessage(EventFragmentID.CLSID_CEventFragment);
					if(ev)
					{
						//var frag_ev:CEventFragment  = ev as CEventFragment;
						var frag_ev:CEventFragment  = new CEventFragment;
						frag_ev.clsid = clsid;
						frag_ev.frag_count = frag_count;
						frag_ev.index = index;
						put_size = (frag_count==index+1?buf.length()-index*FRAGMENTSIZE:FRAGMENTSIZE);
						
						// 读出指定长度字节流
						// byteArray都是从byteArray.position开始(不论读写), bytes都是从offset开始(不论读写).
						buf.buffer().readBytes(frag_ev.buf.buffer(),0,put_size);
						
						fragments.push(frag_ev);
						index++;
					}
					else
					{
						break;
					}
				}
				return fragments;
			} 
			else
			{
				return fragments;
			}
		}
		
		//合片
		public function SpliceEvent(event:INetMessage):CFragFunResult
		{
			var pev:INetMessage = new INetMessage;
			var fragres :CFragFunResult = new CFragFunResult;
			if (event.CLSID()==EventFragmentID.CLSID_CEventFragment)
			{
				var  ev:CEventFragment = event as CEventFragment;
				
				if ( (ev.index==ev.frag_count-1 || ev.buf.length()==FRAGMENTSIZE)				
					//&& ev->m_frag_count<=FRAG_COUNT_LIMIT
					&& (ev.frag_count <= m_max_frag)
					&& ev.index<ev.frag_count)
				{
					var build:CBuildingEvent = new CBuildingEvent(ev.clsid,ev.frag_count);
					var isFind:Boolean = false;
					for (var idx:int; idx<m_frag_map.length; idx++ )
					{
						if (m_frag_map[idx] == build)
						{
								isFind= true;
								break;
						}
					}
					if(isFind == false )
					{
						m_frag_map.push(build);
						idx = m_frag_map.length-1;
					}
					
					ev.buf.putBytes( m_frag_map[idx].PutFrag(ev.index,ev.buf.length() )  );
					
					if (m_frag_map[idx].FinishBuild())
					{
						pev = m_frag_map[idx].CreateOriginalEvent();
						if( pev==null )
							trace("fragment build NULL event");
						m_frag_map.splice(idx,1);
					}
					fragres.result = true;
					fragres.fragevt = pev;
					return fragres ;
				}
			}
			fragres.result = false;
			fragres.fragevt = null;
			return fragres;
		}
		
		public function Update():void
		{		
			for (var idx:int; idx<m_frag_map.length; idx++ )
			{
				if (m_frag_map[idx].IsTimeOut())
				{
					m_frag_map[idx].splice(idx,1);
				}
			}
		}
		
		private var m_frag_map:Array = new Array;
		private var  m_max_frag:int;
	}
}