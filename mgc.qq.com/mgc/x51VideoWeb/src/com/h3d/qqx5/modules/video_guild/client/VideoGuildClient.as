package com.h3d.qqx5.modules.video_guild.client
{
	import com.h3d.qqx5.common.Globals;
	import com.h3d.qqx5.enum.VideoResultType;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_guild.VideoGuildBriefInfo;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfo;
	import com.h3d.qqx5.modules.video_guild.VideoGuildInfoUpdateType;
	import com.h3d.qqx5.modules.video_guild.VideoGuildJoinApply;
	import com.h3d.qqx5.modules.video_guild.VideoGuildLogRecord;
	import com.h3d.qqx5.modules.video_guild.VideoGuildMemberBriefInfo;
	import com.h3d.qqx5.modules.video_guild.VideoGuildMemberInfo;
	import com.h3d.qqx5.modules.video_guild.VideoGuildPositionInfo;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventAcceptJoinApplyTargetOnlineNotify;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventAnchorDoWelfareDistribution;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventAnchorDoWelfareDistributionRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventAnchorRequestWelfareDistribution;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventAnchorRequestWelfareDistributionRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventForbidVideoGuildJoinApply;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventGetVideoGuildInfo;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventGetVideoGuildInfoRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventGetVideoGuildJoinApplyList;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventGetVideoGuildJoinApplyListRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventInviteToJoinVideoGuild;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventInviteToJoinVideoGuildNotify;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventInviteToJoinVideoGuildRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventLoadMyVideoGuild;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventLoadMyVideoGuildResult;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventLoadVideoGuildList;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventLoadVideoGuildListResult;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventLoadVideoGuildLogRecord;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventLoadVideoGuildLogRecordResult;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventModifyFansBoardName;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventModifyFansBoardNameRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventOperateVideoGuildInvite;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventOperateVideoGuildInviteNotify;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventOperateVideoGuildInviteRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventOperateVideoGuildJoinApply;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventOperateVideoGuildJoinApplyRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventRefuseVideoGuildJoinApplyNotify;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventSendVideoGuildJoinApply;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventSendVideoGuildJoinApplyRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventSendVideoGuildMonthTicket;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventSendVideoGuildMonthTicketRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventSendVideoGuildSignIn;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventUpdateMyVideoGuildInfo;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventUpdateMyVideoGuildInfoRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventUpdateVideoGuildLogRecordResult;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildBroadcast;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildBuyFansBoard;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildBuyFansBoardRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildChange;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildChangeAnchor;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildChangeAnchorRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildCreate;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildCreateRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildDemiseNotify;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildDisband;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildDisbandNotify;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildDismiss;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildExit;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildKickMember;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildModifyMemberPosition;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildModifyPosition;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildRename;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildRenameRes;
	import com.h3d.qqx5.modules.video_guild.share.event.CEventVideoGuildReqSimpleInfoRes;
	import com.h3d.qqx5.modules.video_guild.share.event.VideoGuildEventID;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.OlinePictureDef;
	import com.h3d.qqx5.videoclient.data.AnchorGuildForUI;
	import com.h3d.qqx5.videoclient.data.ChatChannel;
	import com.h3d.qqx5.videoclient.data.VideoGuildBriefInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildBroadCastType;
	import com.h3d.qqx5.videoclient.data.VideoGuildInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildJoinApplyForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildLogRecordForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildMemberBriefInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildMemberInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildPositionInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildResultCode;
	import com.h3d.qqx5.videoclient.data.VideoRoomMsgData;
	import com.h3d.qqx5.videoclient.data.WebColor;
	import com.h3d.qqx5.videoclient.interfaces.IUIVideoGuild;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoClientLogicInternal;
	import com.h3d.qqx5.videoclient.interfaces.IVideoGuildClient;
	import com.h3d.qqx5.videoclient.main.CVideoClientBase;
	import com.junkbyte.console.Cc;
	
	import flash.utils.Dictionary;
	
	import flashx.textLayout.elements.BreakElement;

	/**
	 * @author liuchui
	 */
	public class VideoGuildClient implements IVideoGuildClient
	{
		private var m_client:IVideoClientInternal;
		private var m_base:CVideoClientBase;
		private var m_rename_vg_cost:int = 0;
		private var m_change_anchor_cost:int = 0;
		private var m_dismiss_require:int = 7 * 86400;//��λҪ��Է�����ʱ�� ��,һ�ܵ�����
		private var m_video_guild_info:VideoGuildInfo = new VideoGuildInfo;	
		private var m_vg_members:Array = new Array();
		private var m_vg_positions:Dictionary = new Dictionary;
		private var m_vg_positions_forUI:Array = new Array;
		private var m_self_member_info:VideoGuildMemberInfo = new VideoGuildMemberInfo;	//�Լ�����Ϣ
		private var m_videoGuildLogRecords:Array = new Array;//后援团日志记录
		private var ui:IUIVideoGuild = null;
		private var curr_living_anchor_pstid:String = "-1";
		private var anchor_pstidToChange:Int64 = null;
		
		public function VideoGuildClient(vc:IVideoClientInternal,base:CVideoClientBase)
		{
			m_client = vc;
			m_base = base;
		}
		
		public function HandleServerEvent(ev:INetMessage):Boolean
		{
			var clsid:int = ev.CLSID();
			if(ui == null)
			{
				ui = GetUI();
				if(ui == null)
				{
					return false;
				}
			}
						
			switch (clsid)
			{
				case VideoGuildEventID.CLSID_CEventLoadVideoGuildListResult:
					HandleCEventLoadVideoGuildListResult(ev);
					break;
				case VideoGuildEventID.CLSID_CEventLoadMyVideoGuildResult:
					HandleCEventLoadMyVideoGuildResult(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildKickMember:
					HandleCEventVideoGuildKickMember(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildExit:
					HandleCEventVideoGuildExit(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildModifyMemberPosition:
					HandleCEventVideoGuildModifyMemberPosition(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildModifyPosition:
					HandleCEventVideoGuildModifyPosition(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildDisband:
					HandleCEventVideoGuildDisband(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildDismiss:
					HandleCEventVideoGuildDismiss(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildCreateRes:
					HandleCEventVideoGuildCreateRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventGetVideoGuildJoinApplyListRes:
					HandleCEventGetVideoGuildJoinApplyListRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventOperateVideoGuildJoinApplyRes:
					HandleCEventOperateVideoGuildJoinApplyRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventAcceptJoinApplyTargetOnlineNotify:
					HandleCEventAcceptJoinApplyTargetOnlineNotify(ev);
					break;
				case VideoGuildEventID.CLSID_CEventRefuseVideoGuildJoinApplyNotify:
					HandleCEventRefuseVideoGuildJoinApplyNotify(ev);
					break;
				case VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuildNotify:
					HandleCEventInviteToJoinVideoGuildNotify(ev);
					break;
				case VideoGuildEventID.CLSID_CEventInviteToJoinVideoGuildRes:
					HandleCEventInviteToJoinVideoGuildRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventOperateVideoGuildInviteNotify:
					HandleCEventOperateVideoGuildInviteNotify(ev);
					break;
				case VideoGuildEventID.CLSID_CEventOperateVideoGuildInviteRes:
					HandleCEventOperateVideoGuildInviteRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildChangeAnchorRes:
					HandleCEventVideoGuildChangeAnchorRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventGetVideoGuildInfoRes:
					HandleCEventGetVideoGuildInfoRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventUpdateMyVideoGuildInfoRes:
					HandleCEventUpdateMyVideoGuildInfoRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildRenameRes:
					HandleCEventVideoGuildRenameRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventSendVideoGuildSignIn:
					HandleCEventSendVideoGuildSignIn(ev);
					break;
				case VideoGuildEventID.CLSID_CEventSendVideoGuildMonthTicketRes:
					HandleCEventSendVideoGuildMonthTicketRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildBuyFansBoardRes:
					HandleCEventVideoGuildBuyFansBoardRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildChange:
					HandleCEventVideoGuildChange(ev);
					break;
				case VideoGuildEventID.CLSID_CEventUpdateVideoGuildLogRecordResult:
					HandleCEventUpdateVideoGuildLogRecordResult(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildReqSimpleInfoRes:
					HandleCEventVideoGuildReqSimpleInfoRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventAnchorRequestWelfareDistributionRes:
					HandleCEventAnchorRequestWelfareDistributionRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventAnchorDoWelfareDistributionRes:
					HandleCEventAnchorDoWelfareDistributionRes(ev);	
					break;
				case VideoGuildEventID.CLSID_CEventModifyFansBoardNameRes:
					HandleCEventModifyFansBoardNameRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventLoadVideoGuildLogRecordResult:
					HandleCEventLoadVideoGuildLogRecordResult(ev);
					break;
				case VideoGuildEventID.CLSID_CEventSendVideoGuildJoinApplyRes:
					HandleCEventSendVideoGuildJoinApplyRes(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildBroadcast:
					HandleCEventVideoGuildBroadcast(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildDisbandNotify:
					HandleCEventVideoGuildDisbandNotify(ev);
					break;
				case VideoGuildEventID.CLSID_CEventVideoGuildDemiseNotify:
					HandleCEventVideoGuildDemiseNotify(ev);
					break;
			}
			return true;
		}
		
		////非广播，团员每天第一次进入梦工厂的时候单发
		private function HandleCEventVideoGuildDisbandNotify(ev:INetMessage):void
		{
			var evt:CEventVideoGuildDisbandNotify = ev as CEventVideoGuildDisbandNotify;
			if(evt == null)
			{
				return;
			}
			
			var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_Guild;//系统消息
			msg_data.flag = 1;//表示是后援团的群发通知消息，
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			msg_data.systemType = 0;
			msg_data.msg = "$t$[后援]团长" + evt.chief_nick.replace(/\\/g,"\\\\") + "发起了本团的解散操作。请各位成员注意，与团长取得联系来确认操作是否由本人发起。$z";
			
			m_client.GetUICallback().OnReceiveChatMsg(msg_data);
		}
		////非广播，团员每天第一次进入梦工厂的时候单发 后援团团员每日第一次登录收到传位申请消息
		private function HandleCEventVideoGuildDemiseNotify(ev:INetMessage):void
		{
			var evt:CEventVideoGuildDemiseNotify = ev as CEventVideoGuildDemiseNotify;
			var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_Guild;//系统消息
			msg_data.flag = 1;//表示是后援团的群发通知消息，
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			msg_data.systemType = 0;
			msg_data.msg = "$t$[后援]团长" + evt.old_chief_name.replace(/\\/g,"\\\\") + "发起了传位操作。请各位成员注意，与团长取得联系来确认操作是否由本人发起。$z";
			
			m_client.GetUICallback().OnReceiveChatMsg(msg_data);
		}
		//加载后援团列表
		private function HandleCEventVideoGuildBroadcast(ev:INetMessage):void
		{
			var evt:CEventVideoGuildBroadcast = ev as CEventVideoGuildBroadcast;
			if(evt == null)
			{
				return;
			}
			
			var msg_data : VideoRoomMsgData = new VideoRoomMsgData;
			msg_data.channel = ChatChannel.VIDEOCHNL_Guild;//系统消息
			msg_data.flag = 1;//表示是后援团的群发通知消息，
			msg_data.TextColor = WebColor.systemInfoTextColor;//系统消息颜色
			msg_data.systemType = 0;
			
			var isNeedSendMsg:Boolean = true;
			switch(evt.vgbt)
			{
				case VideoGuildBroadCastType.VGBT_Join://新的团员被批准加入
					msg_data.msg = "$t$[后援]欢迎" + evt.string_1.replace(/\\/g,"\\\\") + "加入我们的后援团~$z";
					break;
				case VideoGuildBroadCastType.VGBT_Quit:// 有团员被踢出或者主动退出后援团
					LoadMyVideoGuild();
					msg_data.msg = "$t$[后援]" + evt.string_1.replace(/\\/g,"\\\\") + "离开了我们的后援团~$z";
					break;
				case VideoGuildBroadCastType.VGBT_VipMemberBringActiveScore://VIP玩家登录给予活跃积分
					msg_data.systemType = 4;
					msg_data.viplevel = evt.int_1;
					msg_data.senderName = evt.string_1.replace(/\\/g,"\\\\");
					msg_data.sender_jacket = evt.int_2;//团积分
					break;
				case VideoGuildBroadCastType.VGBT_ChiefDemise://团长将团长的职位传给了其他团员
					msg_data.msg = "$t$[后援]" + evt.string_1.replace(/\\/g,"\\\\") + "将团长之位传给了" + evt.string_3.replace(/\\/g,"\\\\") + ".恭喜" +evt.string_3.replace(/\\/g,"\\\\") + "成为了我们后援团的新团长~$z";
					break;
				case VideoGuildBroadCastType.VGBT_ChangeAnchor://更改支持的主播
					msg_data.msg = "$t$[后援]本团支持的主播，被团长更改为" + evt.string_1.replace(/\\/g,"\\\\") + "$z";
					LoadMyVideoGuild();
					break;
				case VideoGuildBroadCastType.VGBT_AnchorStartBroadcast://本团支持的主播开始直播
					msg_data.msg = "$t$[后援]主播" + evt.string_1.replace(/\\/g,"\\\\") + "已开始直播，请各位团员前去支持~$z";
					break;
				case VideoGuildBroadCastType.VGBT_AnchorDistributeScore://主播为本团分配积分
					msg_data.msg = "$t$[后援]主播" + evt.string_1.replace(/\\/g,"\\\\") + "为我们的后援团发放" + evt.int_1 + "点积分，大家快来感恩~$z";
					break;
				case VideoGuildBroadCastType.VGBT_SignInBringAsset://可获得团资产的签到操作
					msg_data.msg = "$t$[后援]" + evt.string_1.replace(/\\/g,"\\\\") + "进行了签到操作，为我们的后援团贡献了" + evt.int_1 + "点资产~$z";
					break;
				case VideoGuildBroadCastType.VGBT_ApplyDisband://团长发起了解散团的操作或者团处于解散中，每天团员
					msg_data.msg = "$t$[后援]团长" + evt.string_1.replace(/\\/g,"\\\\") + "发起了本团的解散操作。请各位成员注意，与团长取得联系来确认操作是否由本人发起。$z";
					break;
				case VideoGuildBroadCastType.VGBT_CancelDisband://团长取消了对团的解散
					msg_data.msg = "$t$[后援]本团的解散操作已被解除，请大家继续对主播支持哦~$z";
					break;
				case VideoGuildBroadCastType.VGBT_ApplyDemise://团长团长发起了传位
					msg_data.msg = "$t$[后援]团长" + evt.string_1.replace(/\\/g,"\\\\") + "发起了传位操作。请各位成员注意，与团长取得联系来确认操作是否由本人发起。$z";
					break;
				case VideoGuildBroadCastType.VGBT_CancelDemise://团长取消对传位操作  
					msg_data.msg = "$t$[后援]团长取消了传位操作!$z";
					break;
				default:
					isNeedSendMsg = false;
					break;
			}
			if(isNeedSendMsg)
			{
				m_client.GetUICallback().OnReceiveChatMsg(msg_data);
			}
		}
		
		//加载后援团列表
		private function HandleCEventLoadVideoGuildListResult(ev:INetMessage):void
		{
			var evt:CEventLoadVideoGuildListResult = ev as CEventLoadVideoGuildListResult;
			ui.OnLoadVideoGuildList(ToVideoGuildBriefInfoForUIVec(evt.guilds),evt.total_count,evt.page,evt.result);
		}
		
		private var isHaveLoadMyGuild:Boolean = false;
		//加载我的后援团
		private function HandleCEventLoadMyVideoGuildResult(ev:INetMessage):void
		{
			var evt:CEventLoadMyVideoGuildResult = ev as CEventLoadMyVideoGuildResult;
			
			if(evt == null)
			{
				return;
			}
			
			isHaveLoadMyGuild = true;
			if(evt.result == VideoGuildResultCode.VGRC_Success)
			{
				m_video_guild_info = evt.vg_info;
				SetMembers(evt.members);
				m_vg_positions = evt.positions;
				m_vg_positions_forUI = ToVideoGuildPositionInfoForUIMap(m_vg_positions);
				m_self_member_info = evt.self_info;
				m_rename_vg_cost = evt.rename_vg_cost;
				m_change_anchor_cost = evt.change_anchor_cost;
				m_dismiss_require = evt.dismiss_require;
			}


			if(evt.offline_become_member && evt.notify_vg_name != "")
			{
				//成功入团
				ui.OperateJoinApplyNotify(true, evt.notify_vg_name.replace(/\\/g,"\\\\"));
			}
			
			if(evt.notify_ui)
			{
				ui.OnLoadMyVideoGuild(evt.result, ToVideoGuildInfoForUI(evt.vg_info),ToVideoGuildMemberInfoForUI(evt.self_info),evt.anchor_score,evt.anchor_rank,ToVideoGuildMemberBriefInfoForUIVec(m_vg_members), evt.vg_url);
			}
			else
			{
				ui.OnHaveJoinGuild(m_video_guild_info.vgid.toString(),HasVideoGuildRight(1 << 1),curr_living_anchor_pstid == m_video_guild_info.anchor_pstid.toString());
			}
		}
		
		//踢出后援团成员
		private function HandleCEventVideoGuildKickMember(ev:INetMessage):void
		{
			var evt:CEventVideoGuildKickMember = ev as CEventVideoGuildKickMember;
			if(evt.result == VideoGuildResultCode.VGRC_Success)
			{
				LocalEraseMember(evt.target);
			}
			ui.OnKickVideoGuildMember(evt.result,evt.target.toString());
		}

		//加载后援团信息
		public function GetVideoGuildInfo(vgid:Int64 ):void
		{
			var get_ev:CEventGetVideoGuildInfo = new CEventGetVideoGuildInfo;
			get_ev.vgid = vgid;
			m_client.SendEvent(get_ev,Globals.SelfRoomID);
		}
		
		//加载后援团名片回调
		public function HandleCEventGetVideoGuildInfoRes(event:INetMessage ):void
		{
			var res_ev:CEventGetVideoGuildInfoRes  = event as CEventGetVideoGuildInfoRes;
			var vginfoUI:VideoGuildInfoForUI = m_base.ToVideoGuildInfoForUI(res_ev.vg_info);
			vginfoUI.anchor_level = res_ev.anchor_level;
			vginfoUI.result = res_ev.result;
			ui.OnGetVideoGuildInfo(vginfoUI,this.m_video_guild_info.vgid.toString());
		}
		
		//退出后援团
		private function HandleCEventVideoGuildExit(ev:INetMessage):void
		{
			var evt:CEventVideoGuildExit = ev as CEventVideoGuildExit;
			ui.OnExitVideoGuild(evt.result);
		}
		
		//修改成员职位
		private function HandleCEventVideoGuildModifyMemberPosition(ev:INetMessage):void
		{
			var evt:CEventVideoGuildModifyMemberPosition = ev as CEventVideoGuildModifyMemberPosition;
			if(evt.result == VideoGuildResultCode.VGRC_TargetNotInVideoGuild)
			{
				LocalEraseMember(evt.target_id);
			}
			else
			{
				var pMember:VideoGuildMemberBriefInfo = GetMember(evt.target_id);
				if(pMember != null)
					pMember.position = evt.position_id;		
			}
			ui.OnModifyVideoGuildMemberPosition(evt.result,evt.target_id.toString(),evt.position_id);
		}
		
		//修改职位信息回调
		private function HandleCEventVideoGuildModifyPosition(ev:INetMessage):void
		{
			var evt:CEventVideoGuildModifyPosition = ev as CEventVideoGuildModifyPosition;
			if(evt.result ==  VideoGuildResultCode.VGRC_Success)
			{
				m_vg_positions[evt.position_info.position_id] = evt.position_info;
				m_vg_positions_forUI = ToVideoGuildPositionInfoForUIMap(m_vg_positions);
			}
			ui.OnModifyVideoGuildPositionInfo(evt.result);
		}
		
		//解散后援团回调
		private function HandleCEventVideoGuildDisband(ev:INetMessage):void
		{
			var evt:CEventVideoGuildDisband = ev as CEventVideoGuildDisband;
			if(evt.op_type == CEventVideoGuildDisband.Disband)
				ui.OnDisbandVideoGuild(evt.result);
			else
				ui.OnCancelDisbandVideoGuild(evt.result);
		}
		
		//传位和取消传位的回调
		private function HandleCEventVideoGuildDismiss(ev:INetMessage):void
		{
			var evt:CEventVideoGuildDismiss = ev as CEventVideoGuildDismiss;
			if(evt.op_type == CEventVideoGuildDismiss.Demise)
				ui.OnDesmissVideoGuild(evt.result);
			else
				ui.OnCancelDemiseVideoGuild(evt.result);
		}
		
		//创建后援团
		private function HandleCEventVideoGuildCreateRes(ev:INetMessage):void
		{
			var evt:CEventVideoGuildCreateRes = ev as CEventVideoGuildCreateRes;
			if(evt == null)
				return;
			
			if(evt.offline_become_member && evt.notify_vg_name != "")
			{
				//成功入团
				ui.OperateJoinApplyNotify(true, evt.notify_vg_name.replace(/\\/g,"\\\\"));
			}
			else
			{
				ui.OnCreateVideoGuild(evt.result,evt.vg_info.vg_name.replace(/\\/g,"\\\\"));
			}
		}
		
		//发送加入后援团申请回调
		private function HandleCEventSendVideoGuildJoinApplyRes(ev:INetMessage):void
		{
			var evt:CEventSendVideoGuildJoinApplyRes = ev as CEventSendVideoGuildJoinApplyRes;
			ui.OnSendVideoGuildJoinApply(evt.result);
		}
		
		//获取加入后援团入团申请列表的回调
		private function HandleCEventGetVideoGuildJoinApplyListRes(ev:INetMessage):void
		{
			var res_ev:CEventGetVideoGuildJoinApplyListRes = ev as CEventGetVideoGuildJoinApplyListRes;
			if(res_ev.result == VideoGuildResultCode.VGRC_Success)
			{
				m_video_guild_info.forbid_join_apply = res_ev.forbid_join_apply ? 1 : 0;
			}
			ui.OnGetVideoGuildJoinApplyList(ToVideoGuildJoinApplyForUIVec(res_ev.join_applys));
		}
		
		//批准或者拒绝某个入团申请的回调
		private function HandleCEventOperateVideoGuildJoinApplyRes(ev:INetMessage):void
		{
			var  res_ev:CEventOperateVideoGuildJoinApplyRes = ev as CEventOperateVideoGuildJoinApplyRes;
			ui.OnOperateJoinApply(res_ev.result, res_ev.op_type == CEventOperateVideoGuildJoinApply.OVGJA_ACCEPT, res_ev.target_id.toString(),res_ev.target_name.replace(/\\/g,"\\\\"),res_ev.target_zname);
		}
		
		//入团申请者收到的提示
		private function HandleCEventAcceptJoinApplyTargetOnlineNotify(ev:INetMessage):void
		{
			var notify_ev:CEventAcceptJoinApplyTargetOnlineNotify =ev as CEventAcceptJoinApplyTargetOnlineNotify;
			m_video_guild_info = notify_ev.vg_info;
			ui.OperateJoinApplyNotify(true, notify_ev.vg_info.vg_name);
		}
		
		//拒绝加入后援团
		private function HandleCEventRefuseVideoGuildJoinApplyNotify(ev:INetMessage):void
		{
			var refuse_ev:CEventRefuseVideoGuildJoinApplyNotify =ev as CEventRefuseVideoGuildJoinApplyNotify;
			ui.OperateJoinApplyNotify(false, refuse_ev.vg_name);
		}
		
		private var m_last_invite_player_id:Int64 = new Int64;
		//收到某人发出的加入后援团邀请
		private function HandleCEventInviteToJoinVideoGuildNotify(ev:INetMessage):void
		{
			var notify_ev:CEventInviteToJoinVideoGuildNotify = ev as CEventInviteToJoinVideoGuildNotify;
			m_last_invite_player_id = notify_ev.inviter_id;
			ui.JoinInvitationNotify(notify_ev.inviter_name, notify_ev.inviter_zname, notify_ev.vg_name, notify_ev.vgid);
		}
		
		//邀请某人加入后援团
		private function HandleCEventInviteToJoinVideoGuildRes(ev:INetMessage):void
		{
			var res_ev:CEventInviteToJoinVideoGuildRes =ev as CEventInviteToJoinVideoGuildRes;
			ui.OnInvitePlayerJoinVideoGuild(res_ev.result);
		}
		
		//邀请某人加入后援团,对方是同意，还是拒绝的回调函数。对方如果忽略，不会触发次函数
		private function HandleCEventOperateVideoGuildInviteNotify(ev:INetMessage):void
		{
			var notify_ev:CEventOperateVideoGuildInviteNotify =ev as CEventOperateVideoGuildInviteNotify;
			var accept:Boolean = (notify_ev.op_type == CEventOperateVideoGuildInvite.OVGI_Accept);
			ui.OnInvitePlayerJoinVideoGuildResult(accept, notify_ev.target_name, notify_ev.target_zname);
		}
		
		//同意加入后援团邀请回调（拒绝没有回调）
		private function HandleCEventOperateVideoGuildInviteRes(ev:INetMessage):void
		{
			var res_ev:CEventOperateVideoGuildInviteRes = ev as CEventOperateVideoGuildInviteRes;
			
			if(res_ev.result == VideoGuildResultCode.VGRC_Success)
			{
//				Globals.s_logger.debug("CEventOperateVideoGuildInviteRes curr_living_anchor_pstid:" + curr_living_anchor_pstid + "--m_video_guild_info.pstd:" + m_video_guild_info.anchor_pstid.toString());
//				m_video_guild_info = res_ev.vg_info;
//				ui.OnHaveJoinGuild(m_video_guild_info.vgid.toString(),HasVideoGuildRight(1 << 1),curr_living_anchor_pstid == m_video_guild_info.anchor_pstid.toString());
				LoadMyVideoGuild();
			}
			
			if(res_ev.op_type == CEventOperateVideoGuildInvite.OVGI_Accept)
			{
				ui.OnOperateJoinInvitation(res_ev.result, res_ev.vg_name);
			}
		}
		
		//更换支持的主播回调
		private function HandleCEventVideoGuildChangeAnchorRes(ev:INetMessage):void
		{
			var res_ev:CEventVideoGuildChangeAnchorRes = ev as CEventVideoGuildChangeAnchorRes;
			
			if(res_ev.result == VideoGuildResultCode.VGRC_Success)
			{
				m_video_guild_info.anchor_pstid = anchor_pstidToChange;
				anchor_pstidToChange = null;
			}
			ui.OnChangeSupportAnchor(VideoResultType.VREST_Normal, res_ev.result);
		}
	
		//修改自己后援团公告和描述回调
		private function HandleCEventUpdateMyVideoGuildInfoRes(ev:INetMessage):void
		{
			var res_ev:CEventUpdateMyVideoGuildInfoRes = ev as CEventUpdateMyVideoGuildInfoRes;
			switch(res_ev.update_type)
			{
				case VideoGuildInfoUpdateType.VGIUT_UpdateDesc:
				{
					if (res_ev.result == VideoGuildResultCode.VGRC_Success)
					{
						m_video_guild_info.vg_desc = res_ev.update_str;
					}
					ui.OnModifySelfVideoGuildDesc(res_ev.result);
				}			
					break;
				case VideoGuildInfoUpdateType.VGIUT_UpdateNotice:
				{
					if (res_ev.result == VideoGuildResultCode.VGRC_Success)
					{
						m_video_guild_info.vg_notice = res_ev.update_str;
					}
					ui.OnModifySelfVideoGuildNotice(res_ev.result);
				}
					break;
				default:
					break;
			}
		}
		
		//修改自己后援团名字回调
		private function HandleCEventVideoGuildRenameRes(ev:INetMessage):void
		{
			var res_ev:CEventVideoGuildRenameRes = ev as CEventVideoGuildRenameRes;
			ui.OnModifySelfVideoGuildName(res_ev.result);
		}
		
		//当日签到回调
		private function HandleCEventSendVideoGuildSignIn(ev:INetMessage):void
		{
			var evt:CEventSendVideoGuildSignIn = ev as CEventSendVideoGuildSignIn;
			
			if (evt.result == VideoGuildResultCode.VGRC_Success
				&& evt.cur_vg_wealth >= 0)
			{
				m_video_guild_info.vg_wealth = evt.cur_vg_wealth;
			}
			ui.OnSendDailySignIn(evt.result, evt.slef_score_add, evt.vg_wealth_add);
		}
		
		//献月票回调 
		private function HandleCEventSendVideoGuildMonthTicketRes(ev:INetMessage):void
		{
			var evt:CEventSendVideoGuildMonthTicketRes = ev as CEventSendVideoGuildMonthTicketRes;
			
			if (evt.result == VideoGuildResultCode.VGRC_Success)
			{
				if (evt.cur_vg_wealth >= 0)
					m_video_guild_info.vg_wealth = evt.cur_vg_wealth;
				if (evt.cur_ticket_acc >= 0)
					m_video_guild_info.today_ticket_acc = evt.cur_ticket_acc;
			}
			ui.OnSendVideoGuildMonthTicket(evt.result, evt.score_add,evt.cur_ticket_acc);
		}
		//购买粉丝牌回调
		private function HandleCEventVideoGuildBuyFansBoardRes(ev:INetMessage):void
		{
			var evt:CEventVideoGuildBuyFansBoardRes = ev as CEventVideoGuildBuyFansBoardRes;
			
			if (evt.result == VideoGuildResultCode.VGRC_Success)
			{
				m_video_guild_info.fans_board_type = evt.boardtype;
				if (evt.cur_vg_wealth >= 0)
					m_video_guild_info.vg_wealth = evt.cur_vg_wealth;
				if (evt.cur_time_limit >= 0)
					m_video_guild_info.fans_board_time_limit = evt.cur_time_limit;
			}
			
			ui.OnBuyVideoGuildBoard(VideoResultType.VREST_Normal, evt.result, evt.boardtype, evt.add_time);
		}
		
		//传位相关
		private function HandleCEventVideoGuildChange(ev:INetMessage):void
		{
			var evt:CEventVideoGuildChange = ev as CEventVideoGuildChange;
			
			switch(evt.type)
			{
				case CEventVideoGuildChange.BeDismissed:
				{
					ui.BeDismissed(evt.string1,evt.string2);
					break;
				}
				case CEventVideoGuildChange.Disbanded:
				{
					ui.NotifyVideoGuildDisband();
					SetVideoGuildID(Int64.fromNumber(0));
					ui.OnHaveJoinGuild("",false,false);
					break;
				}
				case CEventVideoGuildChange.BeKicked:
				{
					ui.BeKicked(evt.string1);
					SetVideoGuildID(Int64.fromNumber(0));
					break;
				}
				case CEventVideoGuildChange.Demise:
				{
					ui.DemiseSuccess(evt.string1, evt.string2);
					break;
				}
				default:
					break;
			}
		}

		//更新后援团日志的回调
		private function HandleCEventUpdateVideoGuildLogRecordResult(ev:INetMessage):void
		{
			var evt:CEventUpdateVideoGuildLogRecordResult = ev as CEventUpdateVideoGuildLogRecordResult;			
			if (m_videoGuildLogRecords.size() < 50)//日志记录的最大数目
			{
				//添加最新日志
				m_videoGuildLogRecords.push(evt.update_log);
			}
			else if (m_videoGuildLogRecords.size() == 50)
			{
//				//替换最老日志
//				var index:Int64 = GetLogRecordOldestIndexOfVideoGuild();
				m_videoGuildLogRecords[0] = evt.update_log;
			}
			//排一下序吧，最新的在最后面
			//m_videoGuildLogRecords.sort(LessByTime);
		}
		
		//后援团支持的主播变化
		private function HandleCEventVideoGuildReqSimpleInfoRes(ev:INetMessage):void
		{
			var evt:CEventVideoGuildReqSimpleInfoRes = ev as CEventVideoGuildReqSimpleInfoRes;			
			m_video_guild_info.anchor_pstid = evt.anchor;
			m_video_guild_info.vg_name = evt.vg_name;
			ui.NotifySurportAnchorChange(evt.anchor);
		}
		
		//请求分配福利积分返回
		private function HandleCEventAnchorRequestWelfareDistributionRes(ev:INetMessage):void
		{
			var evt:CEventAnchorRequestWelfareDistributionRes = ev as CEventAnchorRequestWelfareDistributionRes;
			ui.requestWelfareDistributionRes( evt.errcode, evt.anchor_id, Int64.fromNumber(evt.welfare), ToAnchorGuildForUIs(evt.guilds));
		}
		
		//分配一次福利积分结果
		private function HandleCEventAnchorDoWelfareDistributionRes(ev:INetMessage):void
		{
			var evt:CEventAnchorDoWelfareDistributionRes = ev as CEventAnchorDoWelfareDistributionRes;
			ui.welfareDistributeRes(evt.err_code, evt.anchor_id, Int64.fromNumber(evt.welfare), evt.guild_id, evt.guild_curr_welfare);
		}
		
		//修改粉丝牌回调
		private function HandleCEventModifyFansBoardNameRes(ev:INetMessage):void
		{
			var evt:CEventModifyFansBoardNameRes = ev as CEventModifyFansBoardNameRes;			
			if (evt.result == VideoGuildResultCode.VGRC_Success)
			{
				m_video_guild_info.fans_board_name = evt.new_name;
				m_video_guild_info.custom_fans_board_name = true;
				if (evt.cur_vg_wealth >= 0)
					m_video_guild_info.vg_wealth = evt.cur_vg_wealth;
			}
			ui.OnModifyFansBoardName(VideoResultType.VREST_Normal, evt.result, evt.new_name, evt.cur_vg_wealth < 0);
		}
		
		//加载后援团日志
		private function HandleCEventLoadVideoGuildLogRecordResult(ev:INetMessage):void
		{
			var evt:CEventLoadVideoGuildLogRecordResult = ev as CEventLoadVideoGuildLogRecordResult;
			if(evt.result == VideoGuildResultCode.VGRC_Success)
			{
				m_videoGuildLogRecords = new Array();
				m_videoGuildLogRecords = evt.logRecords;				
			}
			ui.OnGetLogRecordOfVideoGuild(ToVideoGuildLogRecordForUIVec(m_videoGuildLogRecords));
		}
		
		private function ToAnchorGuildForUIs(info:Array):Array
		{
			var t_info:Array = new Array;
			for each(var itr:AnchorGuildForUI in info)
			{
				var temp:AnchorGuildForUI = new AnchorGuildForUI;
				temp.guild_id = itr.guild_id;
				temp.active_score = itr.active_score;
				temp.contribution_last_month = itr.contribution_last_month;
				temp.contribution_curr_month = itr.contribution_curr_month;
				temp.welfare_curr_month = itr.welfare_curr_month;
				temp.guild_name = itr.guild_name.replace(/\\/g,"\\\\");
				t_info.push(temp);
			}
			return t_info;
		}
		
		private function GetLogRecordOldestIndexOfVideoGuild():Int64
		{
			if (m_videoGuildLogRecords.length == 0)
			{
				return Int64.fromNumber(0);
			}			
			//m_videoGuildLogRecords.sort(LessByTime);
			return m_videoGuildLogRecords[0].record_id_db;
		}
		
		private function LessByTime(v1:VideoGuildLogRecord,v2:VideoGuildLogRecord):int
		{
			if(v1.recordTime < v2.recordTime)
				return 1;
			else if(v1.recordTime > v2.recordTime)
				return 0;
			else
				return -1;
		}
		
		private function GetMember(member:Int64):VideoGuildMemberBriefInfo
		{
			for each(var tmp:VideoGuildMemberBriefInfo in m_vg_members )
			{
				if(tmp.member_id.equal(member))
					return tmp;
			}
			return null;
		}
		
		private function LocalEraseMember(member:Int64):void
		{
			for(var i:int = 0;i<m_vg_members.length;i++)
			{
				var tmp:VideoGuildMemberBriefInfo = m_vg_members[i];
				if(tmp.member_id.equal(member))
				{
					m_vg_members.splice(i,1);
					break;
				}
			}
		}
		
		private function  ToVideoGuildJoinApplyForUIVec(info:Array):Array
		{
			var t_info:Array = new Array;
			for each(var itr:VideoGuildJoinApply in info)
			{
				var temp:VideoGuildJoinApplyForUI = new VideoGuildJoinApplyForUI;
				temp.vgid = itr.vgid.toString();
				temp.pstid = itr.pstid.toString();
				temp.apptime = itr.apptime;
				temp.nick = itr.nick;
				temp.zone_name = itr.zone_name;
				temp.vip_level = itr.vip_level;
				temp.wealth = itr.wealth.toString();
				temp.sex = itr.sex;
				temp.qq = itr.qq.toString();
				temp.wealth_level = itr.wealth_level;
				t_info.push(temp);
			}				
			return t_info;
		}
		
		private function  ToVideoGuildMemberBriefInfoForUIVec(info:Array):Array
		{
			var t_info:Array = new Array;
			for each (var itr:VideoGuildMemberBriefInfo in info)
			{
				var temp:VideoGuildMemberBriefInfoForUI = new VideoGuildMemberBriefInfoForUI;
				temp.m_member_id = itr.member_id.toString();
				temp.m_member_sex = itr.member_sex;
				temp.m_member_vip = itr.member_vip;
				temp.m_position = itr.position;
				for (var key:String in m_vg_positions)
				{
					if(int(key) == temp.m_position)
					{
						temp.m_position_name = m_vg_positions[key].position_name;//m_vg_positions
					}
				}
				
				temp.m_member_nick = itr.member_nick.replace(/\\/g,"\\\\");      
				temp.m_member_zone = itr.member_zone;
				temp.m_ctrbt = itr.ctrbt;
				temp.m_enter_time = itr.enter_time;
				temp.m_wealth_level = itr.wealth_level;
				temp.m_wealth = itr.wealth;
				t_info.push(temp);
			}
			t_info.sort(guildMemberSortByPosition);
			return t_info;
		}
		
		//后援团成员按职位高低排名
		private function guildMemberSortByPosition(left:VideoGuildMemberBriefInfoForUI,right:VideoGuildMemberBriefInfoForUI):int
		{
			if(left.m_position < right.m_position)
				return -1;
			else if(left.m_position > right.m_position)
				return 1;
			return 0;
		}
		
		//判断两个标准时间GMT（格尼尼致时间：1970年1月1日 0:00:000）是否是同一天
		private function getIsSignToday(lastSignTime:Number,nowtime:Number):Boolean
		{
			var date1:Date = new Date(lastSignTime*1000);
			var date2:Date = new Date(nowtime * 1000);
			if(date1.fullYear == date2.fullYear && date1.month == date2.month && date1.date == date2.date)
			{
				return true;
			}
			else
			{
				return false;
			}
		}
		
		private function  ToVideoGuildMemberInfoForUI(info:VideoGuildMemberInfo):VideoGuildMemberInfoForUI
		{
			var t_info:VideoGuildMemberInfoForUI = new VideoGuildMemberInfoForUI;
			var logic:IVideoClientLogicInternal =  m_client.GetLogicInternal();
			var now:int = 0;
			if ( logic != null )
				now = logic.GetServerTime();
			
			t_info.m_member_id = info.member_id.toString();
			t_info.m_member_sex = info.member_sex;
			t_info.m_member_vip = info.member_vip;
			t_info.m_position = info.position;
			t_info.m_member_sex = info.member_sex;
			t_info.m_member_nick = info.member_nick.replace(/\\/g,"\\\\");
			t_info.m_member_zone = info.member_zone;
			t_info.m_ctrbt = info.ctrbt;
			t_info.m_member_score = info.member_score;
			t_info.m_enter_time = info.enter_time;
			t_info.isSignToday = getIsSignToday(info.last_sign_in_time,now);
			t_info.m_vg_id = info.vg_id.toString();
			t_info.m_member_qq = info.member_qq.toString();
			t_info.Kick = 0;
			t_info.InviteApprove = 0;
			t_info.PositionManage = 0;
			t_info.Ticket = 0;
			t_info.Manage = 1;
			t_info.isChief = info.member_id.equal(m_video_guild_info.chief_pstid);
			t_info.wealth_level = info.wealth_level;
			
			//填充玩家在后援团中的权限
			for (var key:String in m_vg_positions)
			{
				if(int(key) == info.position)
				{
					t_info.Manage = (m_vg_positions[key].rights & 0x1) == 0 ? 0:1;
					t_info.InviteApprove = (m_vg_positions[key].rights & 0x2) == 0 ? 0:1;
					t_info.Kick = (m_vg_positions[key].rights & 0x4) == 0 ? 0:1;
					t_info.Ticket = (m_vg_positions[key].rights & 0x8) == 0 ? 0:1;
					t_info.PositionManage = (m_vg_positions[key].rights & 0x10) == 0 ? 0:1;
					t_info.m_position_name = m_vg_positions[key].position_name.replace(/\\/g,"\\\\");
					break;
				}
			}
			return t_info;
		}
		
		private function ToVideoGuildInfoForUI(info:VideoGuildInfo):VideoGuildInfoForUI
		{
			var t_info:VideoGuildInfoForUI = new VideoGuildInfoForUI;
			var logic:IVideoClientLogicInternal =  m_client.GetLogicInternal();			
			var now:int = logic.GetServerTime();
			t_info.anchor_cont_score = info.anchor_cont_score;
			t_info.anchor_give_score = info.anchor_give_score;
			t_info.anchor_name = info.anchor_name.replace(/\\/g,"\\\\");
			t_info.anchor_pstid = info.anchor_pstid.toString();
			t_info.chief_name = info.chief_name.replace(/\\/g,"\\\\");
			t_info.chief_pstid = info.chief_pstid.toString();
			t_info.chief_qq = info.chief_qq.toString();
			t_info.chief_zname = info.chief_zname;
			t_info.create_time = info.create_time;
			t_info.demised_chief_pstid = info.demised_chief_pstid.toString();
			t_info.fans_board_time_limit = info.fans_board_time_limit;
			t_info.fans_board_type = info.fans_board_type;
			t_info.forbid_join_apply= info.forbid_join_apply;
			t_info.last_cont_rank = info.last_cont_rank;
			t_info.last_month_cont = info.last_month_cont;
			t_info.last_score_rank = info.last_score_rank;
			t_info.last_send_ticket_time = info.last_send_ticket_time;
			t_info.level = info.level;
			t_info.member_count = info.member_count;
			t_info.member_limit = info.member_limit;
			t_info.system_score = info.system_score;
			t_info.system_score_clear_time = info.system_score_clear_time;
			t_info.today_ticket_acc = info.today_ticket_acc;
			t_info.total_score = info.total_score.toString();
			t_info.anchor_level = info.anchor_level;
			t_info.chief_wealth = info.chief_wealth;
			
			if( info.vg_demise_time != 0)
			{
				t_info.vg_demise_time = info.vg_demise_time - now ;
			}
			
			t_info.vg_desc = info.vg_desc.replace(/\\/g,"\\\\");
			
			if(info.vg_dismiss != 0)
			{
				t_info.vg_dismiss =  info.vg_dismiss - now;
			}
			
			t_info.vg_name = info.vg_name.replace(/\\/g,"\\\\");
			t_info.vg_notice = info.vg_notice;
			t_info.vg_score = info.vg_score;
			t_info.vg_wealth = info.vg_wealth;
			t_info.vgid = info.vgid.toString();
			t_info.m_pk_anchor_winner_order = info.pk_anchor_winner_order;
			t_info.fans_board_name = info.fans_board_name.replace(/\\/g,"\\\\");
			t_info.ban_custom_fans_board_time = info.ban_custom_fans_board_time;
			t_info.customed_fans_board_name = info.custom_fans_board_name;
			t_info.anchorAvatarUrl = OlinePictureDef.GetVideoAnchorPortraitDownloadUrl(m_client.GetVideoClientBase().GetPicDownloadUrl(), Globals.VideoGroupID,
				info.anchor_pstid.toNumber());
			
			//当后援团处于传位状态时，在后援团成员中根据要传位的团长id查找昵称和大区名
			if(info.vg_demise_time > 0)
			{
				for each(var tmp:VideoGuildMemberBriefInfo in m_vg_members )
				{
					if(tmp.member_id.equal(info.demised_chief_pstid))
					{
						t_info.demised_chief_name = tmp.member_nick.replace(/\\/g,"\\\\");
						t_info.demised_chief_zone = tmp.member_zone;
						break;
					}
				}
			}
			
			return t_info;
		}
		
		private function ToVideoGuildPositionInfoForUIMap(info:Dictionary):Array
		{
			var t_info:Array = new Array;
			for(var key:String in info)
			{
				var temp:VideoGuildPositionInfoForUI = new VideoGuildPositionInfoForUI;
				temp.m_position_id = info[key].position_id;
				temp.m_position_name = info[key].position_name.replace(/\\/g,"\\\\");
				temp.Manage = (info[key].rights & 0x1) == 0 ? 0 : 1;
				temp.InviteApprove = (info[key].rights & 0x2)  == 0 ? 0 : 1;
				temp.Kick = (info[key].rights & 0x4)  == 0 ? 0 : 1;
				temp.Ticket = (info[key].rights & 0x8)  == 0 ? 0 : 1;
				temp.PositionManage = (info[key].rights & 0x10)  == 0 ? 0 : 1;
				t_info.push(temp);
			}
			return t_info;
		}
		
		private function SetMembers(members:Array):void
		{
			m_vg_members = members;
			members.sort(isBig);
		}
		
		private function isBig(lhs:VideoGuildMemberBriefInfo,rhs:VideoGuildMemberBriefInfo):int
		{
			var result:int = 0;
			
			if(lhs.position != rhs.position)
			{
				if( lhs.position < rhs.position)		
					return 1;				
				else									
					return -1;					
			}
			
			if(lhs.member_vip != rhs.member_vip)
			{
				if( lhs.member_vip > rhs.member_vip) 
					return 1;				
				else	return -1;				
			}
			
			if( lhs.ctrbt > rhs.ctrbt)			
				return 1;			
			else						
				return -1;			
		}
		
		private function GetUI():IUIVideoGuild 
		{
			if(m_client == null)
				return null;
			if(m_client.GetUICallback()== null)
				return null;
			
			return m_client.GetUICallback().GetVideoGuildCallback();
		}
		
		private function ToVideoGuildBriefInfoForUIVec(info:Array):Array
		{
			var t_info:Array = new Array; 
			for each(var tmp:VideoGuildBriefInfo in info)
			{
				var infoui:VideoGuildBriefInfoForUI = new VideoGuildBriefInfoForUI;
				infoui.vgid = tmp.vgid.toString();
				infoui.chief_zone = tmp.chief_zone;
				infoui.chief_name = tmp.chief_name.replace(/\\/g,"\\\\");
				infoui.anchor_name = tmp.anchor_name.replace(/\\/g,"\\\\");
				infoui.vg_name = tmp.vg_name.replace(/\\/g,"\\\\");
				infoui.vg_score = tmp.vg_score;
				infoui.vg_total_score = tmp.vg_total_score.toNumber();
				infoui.member_count = tmp.member_count;
				infoui.member_limit = tmp.member_limit;
				infoui.anchor_qq = tmp.anchor_qq.toString();
				infoui.anchor_level = tmp.anchor_level;
				infoui.chief_wealth = tmp.chief_wealth.toNumber();
				infoui.chief_wealth_level = tmp.chief_wealth_level;
				
				t_info.push(infoui);
			}			
			return t_info;
		}
		
		private function ToVideoGuildPositionInfo(info:VideoGuildPositionInfoForUI):VideoGuildPositionInfo
		{
			var t_info:VideoGuildPositionInfo = new VideoGuildPositionInfo;
			t_info.position_id = info.m_position_id;
			t_info.position_name = info.m_position_name;
			t_info.rights = (info.Manage << 0) | (info.InviteApprove << 1) | (info.Kick << 2) | (info.Ticket << 3) | (info.PositionManage << 4);
			return t_info;
		}
		
		//加载后援团列表
		public function LoadVideoGuildList(page:int ,name_pattern:String="", sort_type:int = 0):void
		{
			var ev:CEventLoadVideoGuildList = new CEventLoadVideoGuildList;
			ev.name = name_pattern;
			ev.sort_type = sort_type;
			ev.page = page;
			ev.player_id = m_client.GetSelfPersistID();
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		//加载我的后援团
		public function LoadMyVideoGuild(from_ui:Boolean = false,from_home:Boolean = false):void
		{
			var ev:CEventLoadMyVideoGuild = new CEventLoadMyVideoGuild;
			ev.from_ui = from_ui;
			ev.from_home = from_home;
			m_client.SendEvent(ev,Globals.SelfRoomID);	
		}
		
		//成员列表
		public function LoadVideoGuildMemberList():void
		{
			ui.OnLoadVideoGuildMemberList(ToVideoGuildMemberBriefInfoForUIVec(m_vg_members));
		}
		
		//开除成员
		public function KickVideoGuildMember(player_id:Int64):void
		{
			var ev:CEventVideoGuildKickMember = new CEventVideoGuildKickMember;
			ev.target = player_id;
			m_client.SendEvent(ev,Globals.SelfRoomID);		
		}
		//退出后援团
		public function ExitVideoGuild():void
		{
			var ev:CEventVideoGuildExit = new CEventVideoGuildExit;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		//修改成员职位
		public function ModifyVideoGuildMemberPosition(player_id:Int64,new_position:int):void
		{
			var ev:CEventVideoGuildModifyMemberPosition = new CEventVideoGuildModifyMemberPosition;
			ev.position_id = new_position;
			ev.target_id = player_id;
			m_client.SendEvent(ev,Globals.SelfRoomID);			
		}
		
		//修改职位信息
		public function ModifyVideoGuildPositionInfo(info:VideoGuildPositionInfoForUI):void
		{
			var ev:CEventVideoGuildModifyPosition = new CEventVideoGuildModifyPosition;
			ev.position_info = ToVideoGuildPositionInfo(info);
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		//解散后援团
		public function DisbandVideoGuild(mibao:String = ""):void
		{
			var ev:CEventVideoGuildDisband = new CEventVideoGuildDisband;
			ev.op_type = CEventVideoGuildDisband.Disband;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		//取消解散后援团
		public function CancelDisbandVideoGuild():void
		{
			var ev:CEventVideoGuildDisband = new CEventVideoGuildDisband;
			ev.op_type = CEventVideoGuildDisband.CancelDisband;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		//传位
		public function DismissVideoGuild(player_id:Int64,mibao:String):void
		{
			var ev:CEventVideoGuildDismiss = new CEventVideoGuildDismiss;
			ev.target = player_id;
			ev.op_type = CEventVideoGuildDismiss.Demise;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}
		
		//取消传位
		public function CancelDemiseVideoGuild():void
		{
			var ev:CEventVideoGuildDismiss = new CEventVideoGuildDismiss;
			ev.op_type = CEventVideoGuildDismiss.CancelDemise;
			m_client.SendEvent(ev,Globals.SelfRoomID);
		}

		//查询自己是否有XX权限 1 2 4 8 16
		public function HasVideoGuildRight(check_right:int):Boolean {
			var self_position:int = m_self_member_info.position;
			var iscontain:Boolean = false;
			var key:String;
			for (key in m_vg_positions) {
				if (int(key) == self_position) {
					iscontain = true;
					break;
				}
			}

			if (!iscontain) {
				return false;
			} else {
				return (m_vg_positions[key].rights & check_right) != 0;
			}
		}

		//返回满足被传位条件的成员列表
		public function GetMembersCanBeDismissed():void {
			var members:Array = new Array();
			if (m_client == null)
				return;
			
			var logic:IVideoClientLogicInternal =  m_client.GetLogicInternal();
			if ( logic == null )
				return;
			
			var now:int = logic.GetServerTime();
			var chief:Int64 = m_video_guild_info.chief_pstid;
			for each(var it:VideoGuildMemberBriefInfo in m_vg_members )
			{
				if((it.enter_time + m_dismiss_require) < now && !it.member_id.equal(chief))
				{
					members.push(ToVideoGuildMemberBriefInfoForUI(it));
				}
			}
			ui.OnGetMembersCanBeDismissed(members);
		}
		
		private function  ToVideoGuildMemberBriefInfoForUI(info:VideoGuildMemberBriefInfo):VideoGuildMemberBriefInfoForUI
		{
			var t_info:VideoGuildMemberBriefInfoForUI = new VideoGuildMemberBriefInfoForUI;
			t_info.m_ctrbt = info.ctrbt;
			t_info.m_enter_time = info.enter_time;
			t_info.m_member_id = info.member_id.toString();
			t_info.m_member_nick = info.member_nick.replace(/\\/g,"\\\\");
			t_info.m_member_sex = info.member_sex;
			t_info.m_member_vip = info.member_vip;
			t_info.m_member_zone = info.member_zone;
			t_info.m_position = info.position;
			return t_info;
		}
		
		public function GetVideoGuildPositionMap():Array
		{
			return m_vg_positions_forUI;
		}
		
		//加载职位信息
		public function LoadVideoGuildPositions():void
		{
			ui.OnLoadVideoGuildPositions(ToVideoGuildPositionInfoForUIMap(m_vg_positions));
		}
		//创建后援团
		public function CreateVideoGuild(guild_name:String, anchor_pstid:Int64,guild_desc:String):void
		{
			var request_ev:CEventVideoGuildCreate = new CEventVideoGuildCreate;
			request_ev.anchor_id = anchor_pstid;
			request_ev.vg_name = guild_name;
			request_ev.vg_desc = guild_desc;
			m_client.SendEvent(request_ev,Globals.SelfRoomID);
		}
		
		//向某个后援团发送入团申请
		public function SendVideoGuildJoinApply(vgid:Int64):void
		{
			var join_ev:CEventSendVideoGuildJoinApply = new CEventSendVideoGuildJoinApply;
			join_ev.vgid = vgid;
			m_client.SendEvent(join_ev,Globals.SelfRoomID);
		}
		
		//打开申请审核标签页
		public function GetJoinApplyList():void
		{
			var load_ev:CEventGetVideoGuildJoinApplyList = new CEventGetVideoGuildJoinApplyList;
			m_client.SendEvent(load_ev,Globals.SelfRoomID);			
		}
		
		//获取自己所在的后援团ID，0表示没有所在的后援团
		public function GetSelfVideoGuildID():Int64
		{
			return m_video_guild_info.vgid;
		}
		
		//批准或拒绝某个入团申请
		public function OperateJoinApply(player_id:Int64, is_approve:Boolean):void
		{
			var join_ev:CEventOperateVideoGuildJoinApply = new CEventOperateVideoGuildJoinApply;
			join_ev.target_id = player_id;
			join_ev.op_type = (is_approve ? CEventOperateVideoGuildJoinApply.OVGJA_ACCEPT : CEventOperateVideoGuildJoinApply.OVGJA_REFUSE);
			join_ev.vgid = m_video_guild_info.vgid;
			m_client.SendEvent(join_ev,Globals.SelfRoomID);
		}
		//邀请某人加入后援团
		public function InvitePlayerJoinVideoGuild(target_id:Int64,inv_from:int = 0):void
		{
			var invite_ev:CEventInviteToJoinVideoGuild = new CEventInviteToJoinVideoGuild;
			invite_ev.target_id = target_id;
			invite_ev.invite_from = inv_from;
		    m_client.SendEvent(invite_ev,Globals.SelfRoomID);
		}
		
		//ͬ同意（拒绝）加入后援团邀请
		public function OperateJoinInvitation(vgid:Int64,is_agree:int):void
		{
			var op_ev:CEventOperateVideoGuildInvite = new CEventOperateVideoGuildInvite;
			op_ev.vgid = vgid;
			op_ev.trans_id.setZero();
			op_ev.inviter_id = Int64.fromJsonNode(m_last_invite_player_id.toString());
			m_last_invite_player_id.setZero();
			op_ev.op_type = is_agree;//0 忽略，1 同意  2 拒绝
			m_client.SendEvent(op_ev,Globals.SelfRoomID);
		}
		//忽略加入后援团邀请(不需要回调)
		public function IgnoreJoinInvitation(vgid:Int64):void
		{
			var op_ev:CEventOperateVideoGuildInvite = new CEventOperateVideoGuildInvite;
			op_ev.vgid = vgid;
			op_ev.trans_id.setZero();
			op_ev.inviter_id = m_last_invite_player_id;
			m_last_invite_player_id.setZero();
			op_ev.op_type = CEventOperateVideoGuildInvite.OVGI_Ignore;
			m_client.SendEvent(op_ev,Globals.SelfRoomID);
		}

		//更换支持的主播
		public function ChangeSupportAnchor(anchor_pstid:Int64,anchor_nick:String):void
		{
			if(anchor_pstid.equal(m_video_guild_info.anchor_pstid))//如果更换的主播为正在支持的主播，就直接返回错误吗
			{
				ui.OnChangeSupportAnchor(VideoResultType.VREST_Normal, VideoGuildResultCode.VGRC_SameAnchor);
				return;
			}			
			
			var req_ev:CEventVideoGuildChangeAnchor = new CEventVideoGuildChangeAnchor;
			req_ev.anchor_id = anchor_pstid;
			req_ev.trans_id.setZero();
			req_ev.vgid.setZero();
			req_ev.player_id.setZero();
			req_ev.anchor_nick = anchor_nick;
			anchor_pstidToChange = anchor_pstid;
			m_client.SendEvent(req_ev,Globals.SelfRoomID);
		}

		//修改自己的后援团描述，异步
		public function ModifySelfVideoGuildDesc(desc:String):void
		{
			var update_ev:CEventUpdateMyVideoGuildInfo = new CEventUpdateMyVideoGuildInfo;
			update_ev.vg_id = m_video_guild_info.vgid;
			update_ev.update_type = VideoGuildInfoUpdateType.VGIUT_UpdateDesc;//更改团描述
			update_ev.update_str = desc;
			m_client.SendEvent(update_ev,Globals.SelfRoomID);
		}
		//修改自己的后援团公告，异步
		public function ModifySelfVideoGuildNotice(notice:String):void
		{
			var update_ev:CEventUpdateMyVideoGuildInfo = new CEventUpdateMyVideoGuildInfo;
			update_ev.vg_id = m_video_guild_info.vgid;
			update_ev.update_type = VideoGuildInfoUpdateType.VGIUT_UpdateNotice;//更改团公告
			update_ev.update_str = notice;
		 	m_client.SendEvent(update_ev,Globals.SelfRoomID);
		}
		
		//修改自己的后援团名字，异步
		public function ModifySelfVideoGuildName(name:String):void
		{
			//如果重名，直接返回错误码
			if(name == m_video_guild_info.vg_name)
			{
				ui.OnModifySelfVideoGuildName(VideoGuildResultCode.VGRC_GuildNameDup);
				return;
			}
			var rename_ev:CEventVideoGuildRename = new CEventVideoGuildRename;
			rename_ev.vg_name = name;
			rename_ev.trans_id.setZero();
			rename_ev.vgid.setZero();
			rename_ev.anchor_id = m_video_guild_info.anchor_pstid;
			m_client.SendEvent(rename_ev,Globals.SelfRoomID);
		}
		
		//当日签到
		public function SendDailySignIn():void
		{
			var evt:CEventSendVideoGuildSignIn = new CEventSendVideoGuildSignIn;
			m_client.SendEvent(evt,Globals.SelfRoomID);
		}
		//送月票
		public function SendVideoGuildMonthTicket(cnt:int):void
		{
			var evt:CEventSendVideoGuildMonthTicket = new CEventSendVideoGuildMonthTicket;
			evt.ticket_cnt = cnt;
			m_client.SendEvent(evt,Globals.SelfRoomID);
		
		}
		//购买粉丝牌  boardtype粉丝牌类型 add_time增加时限（天）
		public function BuyVideoGuildBoard(boardtype:int,add_time:int):void
		{
			var evt:CEventVideoGuildBuyFansBoard = new CEventVideoGuildBuyFansBoard;
			evt.boardtype = boardtype;
			evt.add_time = add_time;
			m_client.SendEvent(evt,Globals.SelfRoomID);
		}
		
		//获取自己的后援团信息，(暂时无用！)
		public function  GetSelfVideoGuildInfo(info:VideoGuildInfoForUI):void
		{
			info = ToVideoGuildInfoForUI(m_video_guild_info);
		}
		
		//设置自己的后援团是否接受入团申请
		public function ForbidJoinApply(is_forbid:Boolean):void 
		{
			var forbid_ev:CEventForbidVideoGuildJoinApply = new CEventForbidVideoGuildJoinApply;
			forbid_ev.is_forbid = is_forbid;
			m_client.SendEvent(forbid_ev,Globals.SelfRoomID);
		}
		
		// (video guild)(主播)请求进行福利分配
		public function requestWelfareDistribution(anchor_id:Int64,page:int = 0,sortType:int = 0 ):void
		{
			var evt:CEventAnchorRequestWelfareDistribution = new CEventAnchorRequestWelfareDistribution;
			evt.page = page;
			evt.sort_type = sortType;
			m_client.SendEvent(evt,Globals.SelfRoomID);
		}
		
		// (video guild)(主播)进行一次福利分配（点击+50）
		public function doWelfareDistribution(anchor_id:Int64,guild_id:Int64):void
		{
			var evt:CEventAnchorDoWelfareDistribution = new CEventAnchorDoWelfareDistribution;
			evt.guild_id = guild_id;
			m_client.SendEvent(evt,Globals.SelfRoomID);
		}
		
		//打开月票和粉丝牌标签页
		public function LoadVideoGuildTicketBoardPage():void
		{
			
		}
				
		//获取后援团日志(排好序的，最新的在数组最后面)
		public function GetLogRecordOfVideoGuild(videoGuildID:Int64):void
		{
			//发送加载日志请求，判断是否需要更新日志缓存
			var evt:CEventLoadVideoGuildLogRecord = new CEventLoadVideoGuildLogRecord;
			evt.videoGuildId = videoGuildID;
			evt.newestLogTime = GetLogRecordNewestTimeOfVideoGuild();
			m_client.SendEvent(evt,Globals.SelfRoomID);
//			ui.OnGetLogRecordOfVideoGuild(ToVideoGuildLogRecordForUIVec(m_videoGuildLogRecords));
		}
		
		private function GetLogRecordNewestTimeOfVideoGuild():int
		{
			if (m_videoGuildLogRecords.length == 0)
			{
				return 0;
			}
			
			//m_videoGuildLogRecords.sort(LessByTime);
			var size:int = m_videoGuildLogRecords.length;
			return m_videoGuildLogRecords[size-1].recordTime;
		}
		
		private function ToVideoGuildLogRecordForUIVec(info:Array):Array
		{
			var t_info:Array = new Array;
			for each(var itr:VideoGuildLogRecord in info)
			{
				var temp:VideoGuildLogRecordForUI = new VideoGuildLogRecordForUI;
				temp.record_id_db = itr.record_id_db.toString();
				temp.video_guild_id_db = itr.video_guild_id_db.toString();
				temp.recordTime = itr.recordTime;
				temp.msg = itr.msg;
				t_info.push(temp);
			}
			return t_info;
		}
		
		//获取所属后援团支持的主播id(暂时没用)
		public function GetVideoGuildSurportAnchor():Int64
		{
			return m_video_guild_info.anchor_pstid;
		}
		
		//回调玩家是否有后援团，以及后援团所支持的主播是不是当前正在直播的主播，是否有邀请加入后援团的权限
		public function SetCurrLivingAnchorPstid(pstid:String = ""):void
		{
			if(curr_living_anchor_pstid != pstid && isHaveLoadMyGuild)
			{
				ui = GetUI();
				
				ui.OnHaveJoinGuild(m_video_guild_info.vgid.toString(),HasVideoGuildRight(1 << 1),(pstid == m_video_guild_info.anchor_pstid.toString() && pstid != "0"));				
			}
			
			curr_living_anchor_pstid = pstid;
		}
		
		public function SetVideoGuildID(vg_id:Int64 ):void
		{
			m_video_guild_info.vgid = vg_id;
			if(vg_id.isZero())
			{
				m_video_guild_info.anchor_pstid.setZero();
				//清理后援团日志缓存
				m_videoGuildLogRecords = new Array();;
				m_vg_positions = new Dictionary;
				m_vg_positions_forUI = new Array;
				m_vg_members = new Array;
				ui.NotifySurportAnchorChange(GetVideoGuildSurportAnchor());
			}
		}
		
		//上线时通知入团申请被批准
		public function ApproveVideoJoinApplyNotify(vg_name:String):void
		{
			ui = GetUI();
			ui.OperateJoinApplyNotify(true, vg_name);
		}
		
		//获得后援团重命名价格的接口，同步调用
		public function GetRenameVideoGuildCost():void
		{
			ui.OnGetRenameVideoGuildCost(m_rename_vg_cost);
		}
		
		//获得后援团更改主播价格的接口，同步调用
		public function GetChangeAnchorCost():void
		{
			ui.OnGetChangeAnchorCost(m_change_anchor_cost);
		}
		
		public function SetVideoGuildSPAnchor(anchor_qq:Int64):void
		{
			m_video_guild_info.anchor_pstid = anchor_qq;
		}
		
		//修改自己的粉丝牌名字，异步
		public function ModifyFansBoardName(name:String):void
		{
			var update_ev:CEventModifyFansBoardName = new CEventModifyFansBoardName;
			update_ev.vg_id = m_video_guild_info.vgid;
			update_ev.new_name = name;
			m_client.SendEvent(update_ev,Globals.SelfRoomID);
		}
	}	
}