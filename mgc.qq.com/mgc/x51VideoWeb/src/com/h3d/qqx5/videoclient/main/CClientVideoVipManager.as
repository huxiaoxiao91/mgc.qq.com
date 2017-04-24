package com.h3d.qqx5.videoclient.main
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.common.event.CEventNotifyFreeTakeSeatLeft;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_vip.shared.VideoVipBuyType;
	import com.h3d.qqx5.modules.video_vip.shared.VideoVipOperationResult;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventBuyVideoVipRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventBuyVipNotice;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventGetVideoPlayerCardInfoRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventModifyVideoPlayerCardSignatureRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryBuyVideoVipPriceRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeSuperStarHornLeft;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeWhistleLeft;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventQueryFreeWhistleLeftRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventTakeVideoVipDailyRewardsRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.CEventUploadVideoPlayerCardPortraitRes;
	import com.h3d.qqx5.modules.video_vip.shared.event.VideoVipEventID;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.util.URLSuffix;
	import com.h3d.qqx5.video_service.serviceinf.FollowAnchorAffinityInfo;
	import com.h3d.qqx5.video_service.serviceinf.FollowAnchorAffinityInfoForUI;
	import com.h3d.qqx5.video_service.serviceinf.SingleVipPrice;
	import com.h3d.qqx5.video_service.serviceinf.VideoVipPlayerCardInfo;
	import com.h3d.qqx5.video_service.serviceinf.VipPrice;
	import com.h3d.qqx5.video_service.serviceinf.VipPriceInfo;
	import com.h3d.qqx5.videoclient.OlinePictureDef;
	import com.h3d.qqx5.videoclient.data.ChangeCostType;
	import com.h3d.qqx5.videoclient.data.LoveNestInfo;
	import com.h3d.qqx5.videoclient.data.LoveNestInfoForUI;
	import com.h3d.qqx5.videoclient.data.SingleVipPriceForUI;
	import com.h3d.qqx5.videoclient.data.VideoVipPlayerCardInfoForUI;
	import com.h3d.qqx5.videoclient.data.VipPriceInfoForUI;
	import com.h3d.qqx5.videoclient.interfaces.IClientVideoVipManager;
	import com.h3d.qqx5.videoclient.interfaces.IFansGuardConfig;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallback;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicCallbackInternal;
	import com.h3d.qqx5.videoclient.xmlconfig.CVideoVipConfig;
	import com.junkbyte.console.Cc;
	
	import flash.media.Video;
	import flash.utils.Dictionary;
	
	public class CClientVideoVipManager implements IClientVideoVipManager
	{
		private var m_vct:int;
		private var m_client:IVideoClientInternal;
		private var m_room:CVideoRoomClient;
		private var guardConfig:IFansGuardConfig = null;
		private var vipConfig:CVideoVipConfig = null;
		
		public function CClientVideoVipManager( vct:int, client:IVideoClientInternal, room:CVideoRoomClient)
		{
			m_client = client;
			vipConfig = CVideoVipConfig.getInstance();
			m_vct = vct;
			m_room = room;
		}
		public function Update() :void
		{
			
		}
		public function OnEnterRoom() :void
		{
			
		}
		public function OnLeaveRoom() :void
		{
			
		}
		public function OnEventLimit(clsid:int) :void
		{
			
		}
		
		private function FollowAnchorAffinityInfoComp( lhs:FollowAnchorAffinityInfo ,rhs:FollowAnchorAffinityInfo):int
		{
			if( lhs.guard_level != rhs.guard_level)
			{
				if ( lhs.guard_level > rhs.guard_level)
					return -1;
				else 	return 1;
			}
			else	
			{
				if( lhs.affinity > rhs.affinity)
					return -1;
				else if( lhs.affinity < rhs.affinity)
					return 1;
				else return 0;
			}
		};
		
		private function  ToFollowAnchorAffinityInfoForUI( info:FollowAnchorAffinityInfo):FollowAnchorAffinityInfoForUI
		{
			var t_info:FollowAnchorAffinityInfoForUI = new FollowAnchorAffinityInfoForUI;
			t_info.affinity = info.affinity;
			t_info.anchor_name = info.anchor_name.replace(Pattern,"\\\\");
			t_info.anchor_pstid = info.anchor_pstid.toString();
			t_info.guard_level = info.guard_level;
			t_info.anchor_level = info.anchor_level;
			
			if(guardConfig != null)
			{
				t_info.guardIcon = guardConfig.GetIcon(info.guard_level);
			}
			
			t_info.anchor_status = info.anchor_status;
			t_info.room_id = info.room_id;
			t_info.nest_id = info.nest_id;
			t_info.is_nest = info.is_nest;
			return t_info;
		}
		private var Pattern:RegExp = /\\/g;
		private function  ToVideoVipPlayerCardInfoForUI(info:VideoVipPlayerCardInfo):VideoVipPlayerCardInfoForUI
		{
			var t_info:VideoVipPlayerCardInfoForUI =new VideoVipPlayerCardInfoForUI;
			t_info.zone_id = info.zone_id;
			t_info.player_id = info.player_id.toString();
			t_info.wealth = info.wealth.toString();
			t_info.signature = info.signature.replace(Pattern,"\\\\");
			t_info.vip_level = info.vip_level;
			t_info.vipIcon = vipConfig.GetVipIcon(info.vip_level);
			t_info.vipCardParttern = vipConfig.GetCardPattern(info.vip_level);
			t_info.wealth_level = info.wealth_level;
			t_info.wealth_exp = info.wealth_exp;
			t_info.wealth_levelup_exp = info.wealth_levelup_exp;
			if(info.m_player_url != "")
			{
				//XW79794 去除头像随机数
				t_info.portrait_url = Globals.m_pic_download_url + "/qdancersec/" +  info.m_player_url;// + "/0" + URLSuffix.CreateVersionString();
			}
			t_info.videoLevel = info.level;
			t_info.exp = info.exp;
			t_info.levelup_exp = info.levelup_exp;
			for(var i:int = 0; i < info.followed_anchors.length ; ++i)
			{
				t_info.followed_anchors.push(ToFollowAnchorAffinityInfoForUI(info.followed_anchors[i]));
			}
			
			t_info.followed_anchors.sort(followedAnchorSortByAffinity);
			
			t_info.player_sex = info.player_sex;
			t_info.player_name = info.player_name.replace(Pattern,"\\\\");
			t_info.zone_name = info.zone_name;
			t_info.vg_name = info.vg_name;
			t_info.vgid = info.vgid.toString();
			t_info.m_pk_richman_order = info.pk_richman_order;
			t_info.vipIcon = CVideoVipConfig.getInstance().GetVipIcon(info.vip_level);
//			t_info.love_nest_info_vec = info.love_nest_info_vec;
			for(var idx:int=0; idx< info.love_nest_info_vec.length; idx++)
			{
				var love:LoveNestInfoForUI = new LoveNestInfoForUI;
				var slove:LoveNestInfo = info.love_nest_info_vec[idx];
				love.anchor_id = slove.anchor_id.toString();
				love.credits = slove.credits;
				love.credits_level = slove.credits_level;
				love.is_live = slove.is_live;
				love.nest_id = slove.nest_id;
				love.nest_name = slove.nest_name;
				t_info.love_nest_info_vec.push( love);
			}
			return t_info;
		}
		
		private function followedAnchorSortByAffinity(left:FollowAnchorAffinityInfoForUI,right:FollowAnchorAffinityInfoForUI):int
		{
			if(left.affinity > right.affinity)
			{
				return -1;
			}
			else if(left.affinity < right.affinity)
			{
				return 1;
			}
			else
			{
				return 0;
			}
		}
		
		public function HandleCEventGetVideoPlayerCardInfoRes( ev:INetMessage ):void
		{
			var res_ev:CEventGetVideoPlayerCardInfoRes = ev as CEventGetVideoPlayerCardInfoRes;
			guardConfig = m_client.GetGuardConfig();
			
			var ui_data:VideoVipPlayerCardInfoForUI  = ToVideoVipPlayerCardInfoForUI(res_ev.card_info);
			
			for(var i:uint = 0; i < ui_data.followed_anchors.length; ++i)
			{
				ui_data.followed_anchors[i].anchor_photo_url = OlinePictureDef.GetVideoAnchorPortraitDownloadUrl(m_client.GetVideoClientBase().GetPicDownloadUrl(), Globals.VideoGroupID,
					ui_data.followed_anchors[i].anchor_pstid);
			}
			
			m_client.GetUICallback().OnGetPlayerVideoCardInfo(VideoResultType.VREST_Normal,ui_data,res_ev.ret);
		}
		
		public function  HandleCEventUploadVideoPlayerCardPortraitRes( ev:INetMessage ):void
		{
			var res_ev :CEventUploadVideoPlayerCardPortraitRes = ev as CEventUploadVideoPlayerCardPortraitRes;
			if(res_ev.ret == 0)
			{
				m_client.GetVideoClientPlayer().ForceUpdate();
			}
			var pUrl:String = m_client.GetVideoClientPlayer().GetPhotoUrl();
			m_client.GetUICallback().OnUploadPlayerVideoCardPortrait(res_ev.ret,pUrl);
		}
		
		public function  HandleCEventModifyVideoPlayerCardSignatureRes(ev :INetMessage):void
		{
			var res_ev:CEventModifyVideoPlayerCardSignatureRes = ev as CEventModifyVideoPlayerCardSignatureRes;
			if(res_ev.ret == 0)
			{
				m_client.GetVideoClientPlayer().ForceUpdate();
			}
			m_client.GetUICallback().OnModifyPlayerVideoCardSignature(res_ev.ret, res_ev.signature);
		}
		
		
		public function  HandleCEventBuyVideoVipRes(ev:INetMessage ):void
		{
			var res_ev:CEventBuyVideoVipRes = ev as CEventBuyVideoVipRes;
			//购买成功之后，刷新自己vip信息
			if(res_ev.ret == VideoVipOperationResult.VVOR_Success)
			{
				m_room.SetVipInfo(res_ev.vip_level, res_ev.vip_expire);
				//如果重新开通，则可以重新领取福利
				if(res_ev.buy_type == VideoVipBuyType.VVBT_Start)
				{
					m_room.SetTakenVipWeeklyRewardTime(0);
					//查询免费飞屏数目
					var req_ev:CEventQueryFreeWhistleLeft = new CEventQueryFreeWhistleLeft ;
					m_client.SendEvent(req_ev,Globals.SelfRoomID);
					//查询免费超新星数目
					var req_super_star_ev:CEventQueryFreeSuperStarHornLeft = new CEventQueryFreeSuperStarHornLeft ;
					m_client.SendEvent(req_super_star_ev,Globals.SelfRoomID);
				}
				m_client.GetVideoClientPlayer().ForceUpdate();
			}
			//改变货比类型兼容服务器和页面
			res_ev.cost_type = ChangeCostType.ChangeServerCostType(res_ev.cost_type);
			
			if(res_ev.buy_type == VideoVipBuyType.VVBT_Start)
			{
				m_client.GetUICallback().OnStartVip(
					VideoResultType.VREST_Normal, 
					res_ev.ret, res_ev.video_money, 
					res_ev.balance, res_ev.cost_type,
					res_ev.vip_attached_anchor_name, res_ev.rebate);
			}
			else if(res_ev.buy_type == VideoVipBuyType.VVBT_Renewal)
			{
				m_client.GetUICallback().OnRenewalVip(
					VideoResultType.VREST_Normal,
					res_ev.ret, res_ev.video_money,
					res_ev.balance, res_ev.cost_type,
					res_ev.vip_attached_anchor_name, res_ev.rebate);
			}
			if(res_ev.ret == VideoVipOperationResult.VVOR_Success)
			{
				//设置本地状态信息
				m_client.GetVideoClientBase().SetVideoVipInfo(res_ev.vip_level, res_ev.vip_expire);
				if (res_ev.balance != -1) {
					//xw79996 添加对返利数据处理
					m_client.GetVideoClientPlayer().SetVideoMoney(res_ev.video_money, Int64.fromNumber(res_ev.balance + res_ev.rebate));
				} else {
					m_client.GetVideoClientPlayer().SetVideoMoney(res_ev.video_money, null);
				}
			}
		}

		public function HandleCEventTakeVideoVipDailyRewardsRes( ev:INetMessage ):void
		{
			var evt:CEventTakeVideoVipDailyRewardsRes = ev as CEventTakeVideoVipDailyRewardsRes;
			
			if ( evt.result == VideoVipOperationResult.VVOR_Success )
				m_room.SetTakenVipWeeklyRewardTime(m_client.GetLogicInternal().GetServerTime());
			m_client.GetUICallback().OnTakeVipDailyReward(VideoResultType.VREST_Normal, evt.result);
		}

		public function HandleCEventQueryBuyVideoVipPriceRes(ev:INetMessage):void {
			var evt:CEventQueryBuyVideoVipPriceRes = ev as CEventQueryBuyVideoVipPriceRes;
			var rebateInfo:Array = new Array(6);
			rebateInfo[0] = 0;
			for (var vipKey:String in evt.vip_rebate_info) {
				rebateInfo[int(vipKey)] = evt.vip_rebate_info[vipKey];
			}
			m_client.GetUICallback().OnGetVipPrice(ToVipPriceInfoForUI(evt.vip_price_info), rebateInfo);
		}
		
		public function  ToVipPriceInfoForUI(info:VipPriceInfo):VipPriceInfoForUI
		{
			var t_info:VipPriceInfoForUI = new VipPriceInfoForUI;
			t_info.start_price_list = ToVIPPriceForUIList(info.start_price_list);
			t_info.renewal_price_list = ToVIPPriceForUIList(info.renewal_price_list);
			return t_info;
		}
		
		private function ToVIPPriceForUIList(info:Dictionary):Dictionary
		{
			var t_info:Dictionary = new Dictionary ;
			for ( var key:String in info)
			{
				t_info[key] = ToVipPriceForUI(info[key].price_list,int(key));
			}
			
			return t_info;
		}
		private function ToVipPriceForUI(info:Array,viplevel:int):Array
		{
			var t_info:Array = new Array ;
			for(var i:uint = 0; i < info.length; i++)
			{
				t_info.push(ToSingleVipPriceForUI(info[i],viplevel));
			}			
			return t_info;
		}
		private function  ToSingleVipPriceForUI(info:SingleVipPrice,viplevel:int):SingleVipPriceForUI
		{
			var t_info:SingleVipPriceForUI = new SingleVipPriceForUI;
			t_info.cost = info.cost;
			t_info.duration = info.duartion;
			t_info.fullcost = info.fullcost;
			//兼容服务器和页面
			info.cost_type =  ChangeCostType.ChangeServerCostType(info.cost_type);
			t_info.cost_type = info.cost_type;
			t_info.vip_name = vipConfig.GetVipName(viplevel);
			return t_info;
		}
		public function HandleCEventQueryFreeWhistleLeftRes( ev:INetMessage ):void
		{
			var res_ev:CEventQueryFreeWhistleLeftRes= ev as CEventQueryFreeWhistleLeftRes;
			m_client.GetLogicInternal().SetVipFreeWhistleLeft(res_ev.left_count);
			
			var uicb:IVideoClientLogicCallback =  m_client.GetUICallback();
			if(uicb != null)
			{
				uicb.OnQueryFreeWhistleLeft(res_ev.left_count);
			}
		}
		
		public function HandleCEventNotifyFreeTakeSeatLeft( ev:INetMessage ):void
		{
			var res_ev:CEventNotifyFreeTakeSeatLeft= ev as CEventNotifyFreeTakeSeatLeft;
			m_client.GetUICallback().NotifyVipFreeSeatLeft(res_ev.free_take_seat_left);
		}

		public function HandleCEventBuyVipNotice(ev:INetMessage):void {
			var res_ev:CEventBuyVipNotice = ev as CEventBuyVipNotice;
			m_client.GetUICallback().NoticeBuyVip(
				res_ev.player_name, res_ev.weath_level, res_ev.vip_level, res_ev.anchor_name);
		}
		
		public function HandleServerEvent( ev:INetMessage ):Boolean
		{
			var clsid:int = ev.CLSID();
			Globals.s_logger.log("CClientVdeoVipManager::HandleServerEvent clsid:" + clsid);
			switch(clsid)
			{
				case VideoVipEventID.CLSID_CEventTakeVideoVipDailyRewardsRes:
					HandleCEventTakeVideoVipDailyRewardsRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventQueryBuyVideoVipPriceRes:
					HandleCEventQueryBuyVideoVipPriceRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventBuyVideoVipRes:
					HandleCEventBuyVideoVipRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventGetVideoPlayerCardInfoRes:
					HandleCEventGetVideoPlayerCardInfoRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventUploadVideoPlayerCardPortraitRes:
					HandleCEventUploadVideoPlayerCardPortraitRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventModifyVideoPlayerCardSignatureRes:
					HandleCEventModifyVideoPlayerCardSignatureRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventCancelFollowAnchorFromPlayerCardRes:
					//HandleCEventCancelFollowAnchorFromPlayerCardRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventQueryFreeWhistleLeftRes:
					HandleCEventQueryFreeWhistleLeftRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventVideoVipExpireNotify:
					//HandleCEventVideoVipExpireNotify(ev);
					break;
				case VideoVipEventID.CLSID_CEventQueryFreeSuperStarHornLeftRes:
					//HandleCEventQueryFreeSuperStarHornLeftRes(ev);
					break;
				case VideoVipEventID.CLSID_CEventNotifyFreeTakeSeatLeft:
					HandleCEventNotifyFreeTakeSeatLeft(ev);
					break;
				
				case VideoVipEventID.CLSID_CEventBuyVipNotice:
					HandleCEventBuyVipNotice(ev);
					break;
				
				default:
					break;
			}
			return true;
		}
		
		
	}
}