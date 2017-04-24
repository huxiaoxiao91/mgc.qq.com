package com.h3d.qqx5.videoclient.interfaces
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.videoclient.data.VideoGuildInfoForUI;
	import com.h3d.qqx5.videoclient.data.VideoGuildPositionInfoForUI;
	
	import flash.utils.Dictionary;

	/**
	 * @author liuchui
	 */
	public interface IVideoGuildClient
	{
//		//加载舞团列表 page从0开始
		function LoadVideoGuildList(page:int ,name_pattern:String="", sort_type:int = 0):void;
		
		//查看我的后援团界面
		function LoadMyVideoGuild(from_ui:Boolean = true,from_home:Boolean = false):void;
		
		//打开“成员管理”标签页
		function LoadVideoGuildMemberList():void;
		
		//开除成员
		function KickVideoGuildMember(player_id:Int64):void;
		
		//退出后援团
		function ExitVideoGuild():void;
		
		//修改成员职位
		function ModifyVideoGuildMemberPosition(player_id:Int64,new_position:int):void;
		
		//加载职位信息
		function LoadVideoGuildPositions():void;
		
		//修改职位信息
		function ModifyVideoGuildPositionInfo(info:VideoGuildPositionInfoForUI):void;
		
		//解散
		function DisbandVideoGuild(mibao:String = ""):void;
		
		//取消解散
		function CancelDisbandVideoGuild():void;
		
		//传位
		function DismissVideoGuild(player_id:Int64,mibao:String):void;
		
		//取消传位
		function CancelDemiseVideoGuild():void;
		
		//查询自己是否有XX权限
		function HasVideoGuildRight(check_right:int):Boolean;
		
		//返回满足被传位条件的成员列表，同步接口
		function GetMembersCanBeDismissed():void;
		
		function GetVideoGuildPositionMap():Array;
		
//		//获取关注的主播列表的接口已经有了IVideoCLientForUI::GetFollowingAnchorList
		//创建后援团，异步
		function CreateVideoGuild(guild_name:String, anchor_pstid:Int64,guild_desc:String):void;
		
		//打开申请审核标签页，异步
		function GetJoinApplyList():void;
		
		//向某个后援团发送入团申请
		function SendVideoGuildJoinApply(vgid:Int64):void;
		
		//批准或拒绝某个入团申请，异步
		function OperateJoinApply(player_zid:Int64, is_approve:Boolean):void;
		
		//邀请某人加入后援团，异步
		function InvitePlayerJoinVideoGuild(target_id:Int64,inv_from:int = 0):void;
		
		//同意（拒绝）加入后援团邀请，异步
		function OperateJoinInvitation(vgid:Int64,is_agree:int):void;
		//忽略加入后援团邀请，不需要回调
		function IgnoreJoinInvitation(vgid:Int64):void;
		//更换支持的主播，异步
		//昵称字段是因为系统广播需要，逻辑端根据id查昵称比较麻烦
		function ChangeSupportAnchor(anchor_pstid:Int64,anchor_nick:String):void;
		
		//查看后援团名片，异步
		function GetVideoGuildInfo(vgid:Int64):void;
			
		//修改自己的后援团描述，异步
		function ModifySelfVideoGuildDesc(desc:String):void;
		//修改自己的后援团公告，异步
		function ModifySelfVideoGuildNotice(notice:String):void;
		//修改自己的后援团名字，异步
		function ModifySelfVideoGuildName(name:String):void;
		//当日签到
		function SendDailySignIn():void;
		//送月票
		function SendVideoGuildMonthTicket(cnt:int):void;
		//购买粉丝牌  boardtype粉丝牌类型 add_time增加时限（天）
		function BuyVideoGuildBoard(boardtype:int,add_time:int):void;
										
	
		//获取自己的后援团信息，同步
		function  GetSelfVideoGuildInfo(info:VideoGuildInfoForUI):void;

		//获取自己所在的后援团ID，0表示没有所在的后援团
		function  GetSelfVideoGuildID():Int64;
		
		//设置自己的后援团是否接受入团申请
		function ForbidJoinApply(is_forbid:Boolean):void ;
		
		// (video guild)(主播)请求进行福利分配
		function requestWelfareDistribution(anchor_id:Int64,page:int = 0,sortT:int = 0 ):void;
		// (video guild)(主播)进行一次福利分配（点击+50）
		function doWelfareDistribution(anchor_id:Int64,guild_id:Int64):void;
		
	
		//打开月票&粉丝牌标签页
		function LoadVideoGuildTicketBoardPage():void;
		
		function HandleServerEvent(ev:INetMessage):Boolean;
		
		//获取后援团日志(排好序的，最新的在vector最后面)
		function GetLogRecordOfVideoGuild(videoGuildID:Int64):void;
		
		//获取所属后援团支持的主播id
		function GetVideoGuildSurportAnchor():Int64;
		
		function SetVideoGuildID(vg_id:Int64):void;
		
		//上线时通知入团申请被批准
		function ApproveVideoJoinApplyNotify(vg_name:String):void;
		
		//获得后援团重命名价格的接口，同步调用
		function GetRenameVideoGuildCost():void;
		
		//获得后援团更改主播价格的接口，同步调用
		function GetChangeAnchorCost():void;
		
		function SetVideoGuildSPAnchor(anchor_qq:Int64):void;
		
		//修改自己的粉丝牌名字，异步
		function ModifyFansBoardName(name:String):void;
		
		//设置正在直播的主播pstid，用以判断是否后援团所支持的主播
		function SetCurrLivingAnchorPstid(pstid:String = ""):void;
	}	
}