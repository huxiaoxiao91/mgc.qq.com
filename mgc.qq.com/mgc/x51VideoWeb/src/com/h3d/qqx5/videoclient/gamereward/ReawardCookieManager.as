package com.h3d.qqx5.videoclient.gamereward
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.CEventVideoGetExternalRewardDesc;
	import com.h3d.qqx5.common.event.CEventVideoGetExternalRewardDescRes;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Cookie;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.data.ERewardType;
	
	import flash.utils.Dictionary;

	public class ReawardCookieManager
	{
		private var m_client:IVideoClientInternal = null;
		private var m_query_cnt:int = 0;//记录下第多少次向服务器查询
		private var m_query_info:Dictionary = new Dictionary();//key：m_query_cnt , value：QueryGameInfoItem，key值一直累加，value用完=null防止占内存
		
		public function ReawardCookieManager(client:IVideoClientInternal)
		{
			m_client = client;
		}
		
		//查缓存数据
		private function GetRewordsInfoFromCookie(giftid:int,channel:int,cnt:int, rare:int=0):GameRewardInfoForUI
		{
			var cookie:Cookie = new Cookie("x51ReawardCookie");
			var info:GameRewardInfoForUI = new GameRewardInfoForUI;
			info.id = giftid;
			info.channel = channel;
			var obj:Object = cookie.getData("gift:" + giftid + "&" +channel); 
			if(obj != null)
			{
				info.name = obj.name; 
				info.url = obj.url; 
				info.tips =  obj.tips; 
			}
			
			var desc:String = cookie.getData(giftid + "&" +channel + "&" +cnt);
			if( desc != null )
				info.count_desc = desc;
			
			info.rare = rare;
			return info;	
		}
		
		//去服务器请求数据
		private function GetRewordsTipsFromServer(gift_tips:Array,gift_cnts:Array,index:int):void
		{
			var evt:CEventVideoGetExternalRewardDesc = new CEventVideoGetExternalRewardDesc;
			evt.index = index;
			evt.item_tips = gift_tips;
			evt.item_cnts = gift_cnts;
			Globals.s_logger.debug("GetRewordsTipsFromServer:" + JSON.stringify(evt));
			m_client.SendEvent(evt,Globals.SelfRoomID);
		}
		
		//处理服务器返回的url和描述数据
		private function HandleGetRewordsTipsFromServer(ev:INetMessage):void
		{
			var evt:CEventVideoGetExternalRewardDescRes = ev as  CEventVideoGetExternalRewardDescRes;
			var infos:QueryGameInfoItem = m_query_info[evt.index]; 
			
			Globals.s_logger.debug("HandleGetRewordsTipsFromServer :" + JSON.stringify(evt));
			
			if(infos == null || infos.tips_index.length != evt.item_tips.length || infos.cnt_index.length != evt.item_cnts.length  )
			{
				Globals.s_logger.debug("HandleGetRewordsTipsFromServer.error");
				return;//不是我查询的信息  直接返回
			}
			var cookie:Cookie = new Cookie("x51ReawardCookie");
			Globals.s_logger.debug( " server evt.item_tips.length:"+JSON.stringify(evt.item_tips));
			for(var i:int = 0; i < evt.item_tips.length; i ++)
			{
				var evinfo:RewardReqestWebRes = evt.item_tips[i];
				var index:int = infos.tips_index[i];//拿到该条数据所在的索引，用于修改原始数据
				//存在本地
				var obj:Object = new Object; 
				obj.name = evinfo.name; 
				obj.url = evinfo.url; 
				obj.tips = evinfo.tips; 
				obj.channel = evinfo.channel;
				
				cookie.flushData("gift:"+infos.rewards[index].id +"&"+ infos.rewards[index].channel,obj );
				//修改原有数据
				infos.rewards[index].name = evinfo.name;
				infos.rewards[index].url = evinfo.url;
				infos.rewards[index].tips = evinfo.tips;
			}
//			Globals.s_logger.debug( " server evt.item_cnts.length:"+evt.item_cnts.length );
			for(var i_cnt:int = 0; i_cnt < evt.item_cnts.length; i_cnt ++)
			{
				var evinfo_cnt:RewardReqestWebRes = evt.item_cnts[i_cnt];
				var index_cnt:int = infos.cnt_index[i_cnt];//拿到该条数据所在的索引，用于修改原始数据
				//数量描述存在本地
				cookie.flushData(infos.rewards[index_cnt].id + "&" +infos.rewards[index_cnt].channel + "&" + evinfo_cnt.amount, evinfo_cnt.amount_desc );
				//修改原有数据
				infos.rewards[index_cnt].count_desc = evinfo_cnt.amount_desc;
			}
//			Globals.s_logger.debug( " GetRewordsInfosCallback begin" );
//			Globals.s_logger.debug( " GetRewordsInfosCallback infos.func"+infos.func );
//			Globals.s_logger.debug( " GetRewordsInfosCallback infos.rewards" +infos.rewards);
//			Globals.s_logger.debug( " GetRewordsInfosCallback infos.argsArr:" +infos.argsArr );
			GetRewordsInfosCallback(infos.func,infos.rewards,infos.argsArr);
//			Globals.s_logger.debug( " GetRewordsInfosCallback end" );
			//清空处理【需要吗 会不会出错】
			infos.rewards = new Array();
			infos.cnt_index = new Array();
			infos.tips_index = new Array();
			infos.argsArr = new Array();
		}
		

		public function   HandleServerEvent(evt:INetMessage):void
		{
			var clsid:int = evt.CLSID();
			Globals.s_logger.info("ReawardCookieManager::HandleServerEvent"+clsid);
			switch (clsid)
			{				 
				case EEventIDVideoRoomExt.CLSID_CEventVideoGetExternalRewardDescRes:
					HandleGetRewordsTipsFromServer(evt);
					break;
			}
		}
		//对外接口
		public function GetRewordsInfos(gifts:Array,func:Function,...args):void
		{
			Globals.s_logger.debug("OnOpenTreasuerBoxResultNewRoleWeb res GetRewordsInfos func:"+JSON.stringify(gifts));
			var record:QueryGameInfoItem = new QueryGameInfoItem();
			var query_tips:Array = new Array();
			var query_cnts:Array = new Array();
			for( var index:int = 0; index < gifts.length; index ++)
			{
				//先去缓存里找相应的奖励信息，
				 var info :GameRewardInfoForUI = GetRewordsInfoFromCookie(gifts[index].id,gifts[index].channel,gifts[index].amount,gifts[index].rare);
				 record.rewards.push(info);//统一存下来
				 Globals.s_logger.debug("record.rewards: " + JSON.stringify(record.rewards));
				 
				 var giftcnt:RewardReqestWeb = gifts[index];
				 if( info.count_desc == ""  )//没有数量描述
				 {
					 Globals.s_logger.debug("有数量描述");
					 query_cnts.push( giftcnt);
					 record.cnt_index.push(index);//把当前索引记录下来，用于收到服务器的消息后 修改到本地
				 }
				 
				 if( info.name == ""  || info.url == "" )//没有name,tips
				 {
					 Globals.s_logger.debug("没name没URL");
					 query_tips.push(giftcnt );
					 record.tips_index.push(index);//把当前索引记录下来，用于收到服务器的消息后 修改到本地
				 }
			}
			
			if( query_tips.length ==0 && query_cnts.length ==0 )
			{
				Globals.s_logger.debug("query_tips.length ==0 && query_cnts.length ==0");
				GetRewordsInfosCallback( func,record.rewards,args);//没有需要请求的 直接回给回调函数
				return ;
			}
			
			record.func = func;//记录回调函数
			record.argsArr = args;//记录回调函数的参数

			Globals.s_logger.debug("GetRewordsInfos args " + JSON.stringify(record.argsArr));
			m_query_cnt++;//请求的记录加一
			
			m_query_info[m_query_cnt]  = record;//先存下记录的信息
			
			if( query_tips.length > 0 || query_cnts.length >0 )
			{
				Globals.s_logger.debug("query_tips.length > 0 || query_cnts.length >0");
				GetRewordsTipsFromServer(query_tips,query_cnts,m_query_cnt);
			}
			
		}
		// 回调 外部接口
		public function GetRewordsInfosCallback(func:Function,rews:Array,args:Array):void
		{
				args.push(rews);//把奖励合并到原有奖励中
				func.apply(null,args);		
		}
		
	}
}