package com.h3d.qqx5.videoclient.interfaces
{
	/**
	 * @author liuchui
	 */
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.VideoGuildInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildMemberInfoForUI;
	
	import flash.media.Video;
	import flash.utils.Dictionary;

	public interface IUIVideoGuild
	{
		//加载舞团列表LoadVideoGuildList的回调
		function OnLoadVideoGuildList(video_guilds:Array,total_count:int ,page:int,result:int):void;		
		//查看我的后援团界面
		function OnLoadMyVideoGuild(type:int, info:VideoGuildInfoForUI ,self_info:VideoGuildMemberInfoForUI ,anchor_score:int ,anchor_rank:int ,members:Array ,url:String):void;		
		//打开“成员管理”标签页LoadVideoGuildMemberList的回调
		function OnLoadVideoGuildMemberList(members:Array):void;		
		//开除成员KickVideoGuildMember的回调
		function OnKickVideoGuildMember(result:int,target_id:String ):void;		
		//退出后援团ExitVideoGuild的回调
		function OnExitVideoGuild(result:int ):void;		
		//修改成员职位ModifyVideoGuildMemberPosition的回调
		function OnModifyVideoGuildMemberPosition(result:int,target_id:String,position_id:int ):void;		
		//修改职位信息ModifyVideoGuildPositionInfo的回调
		function OnModifyVideoGuildPositionInfo(result:int ):void;		
		//解散DisbandVideoGuild的回调
		function OnDisbandVideoGuild(result:int):void;	
		//取消解散CancelDisbandVideoGuild的回调
		function OnCancelDisbandVideoGuild(result:int):void;
		//传位DismissVideoGuild的回调
		function OnDesmissVideoGuild(result:int):void;		
		//取消传位CancelDemiseVideoGuild的回调
		function OnCancelDemiseVideoGuild(result:int):void;	
		//加载职位信息LoadVideoGuildPositions的回调
		function OnLoadVideoGuildPositions(positions:Array):void;		
		//创建后援团回调
		function OnCreateVideoGuild(result:int,vg_name:String):void;		
		//发送入团申请后，申请人收到的回调
		function OnSendVideoGuildJoinApply(result:int):void;		
		//获取加入后援团入团申请的回调
		function OnGetVideoGuildJoinApplyList(applys:Array):void;	
		//批准或者拒绝某个入团申请的回调
		function OnOperateJoinApply(result:int,is_approve:Boolean,player_id:String,player_name:String,player_zone:String):void;		
		//入团申请者收到的提示
		function OperateJoinApplyNotify(is_approve:Boolean , vgname:String):void;		
		//收到某人发出的加入后援团邀请
		function JoinInvitationNotify(player_name:String,zone_name:String, vgname:String, vgid:Int64):void;		
		//邀请某人加入后援团回调
		function OnInvitePlayerJoinVideoGuild(result:int ):void;			
		//邀请某人加入后援团,对方是同意，还是拒绝的回调函数。对方如果忽略，不会触发次函数
		function OnInvitePlayerJoinVideoGuildResult(accept:Boolean ,player_name:String,zone_name:String):void;	
		//同意加入后援团邀请回调（拒绝没有回调）
		function OnOperateJoinInvitation(result:int ,vgname:String):void;	
		//更换支持的主播回调
		function OnChangeSupportAnchor(type:int, result:int) :void;		
		//查看后援团名片回调
		function OnGetVideoGuildInfo(info:VideoGuildInfoForUI,myvgid:String):void;			
		//修改自己后援团描述回调
		function OnModifySelfVideoGuildDesc(result:int):void;
		//修改自己后援团公告回调
		function OnModifySelfVideoGuildNotice(result:int):void;	
		//修改自己后援团名字回调
		function OnModifySelfVideoGuildName(result:int ):void;	
		//当日签到回调 slef_score_add个人积分增加，vg_wealth_add团资产增加
		function OnSendDailySignIn(result:int , slef_score_add:int , vg_wealth_add:int ):void;	
		//献月票回调 result献月票结果：score_add主播增加积分数
		function OnSendVideoGuildMonthTicket(result:int, score_add:int,cur_ticket_acc:int):void;
		//购买粉丝牌回调
		function OnBuyVideoGuildBoard(type:int, result:int, boardtype:int , time:int ):void;	
		//收到被传位消息
		function BeDismissed(old_chief_name:String,old_chief_zone:String):void;
		//收到传位成功消息
		function DemiseSuccess(new_chief_name:String,new_chief_zone:String):void;
		//后援团最终解散的时候 通知UI
		function NotifyVideoGuildDisband():void;	
		//被开除后援团，通知被开除的玩家
		function BeKicked(name:String):void;	
		//更新后援团日志的回调
		function NotifyUpdateVideoGuildLog():void;	
		//后援团支持的主播变化
		function NotifySurportAnchorChange(anchor:Int64):void;	
		
		function requestWelfareDistributionRes(errCode:int , anchorid:Int64 , welfare:Int64 , guilds:Array ):void;		
		// (video guild)分配一次福利积分结果	
		function welfareDistributeRes(errcode:int , anchorid:Int64 , welfare:Int64 , guildID:Int64, guildCurrWelfare:int):void;		
		//修改粉丝牌回调
		function OnModifyFansBoardName( type:int, result:int, new_name:String, first:Boolean):void;
		
		//获取后援团日志回调
		function OnGetLogRecordOfVideoGuild(recordInfo:Array):void;
		
		//获取后援团重命名价格回调
		function OnGetRenameVideoGuildCost(reanmeCost:int):void;
		//获取更改支持主播价格的回调
		function OnGetChangeAnchorCost(changeAnchorCost:int):void;
		
		//满足被传位条件的成员列表
		function OnGetMembersCanBeDismissed(members:Array):void;
		
		//vgid后援团id，canInvite表示是否拥有邀请玩家加入后援团的权限，isSupport表示当前主播是否是自己支持的主播
		function OnHaveJoinGuild(vgid:String,canInvite:Boolean,isSupport:Boolean):void;
	}	
}