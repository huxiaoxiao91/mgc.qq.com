package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoGuildMemberInfoForUI
	{
		public var m_member_id:String    ="0";
		public var m_member_sex:int      = 0;
		public var m_member_vip:int      = 0;
		public var m_position:int        = 0;
		public var m_position_name:String  = "";
		public var m_member_nick:String  = "";
		public var m_member_zone:String  = "";
		public var m_ctrbt:int           = 0;	//资产贡献
		public var m_member_score:int    = 0;
		public var m_enter_time:int      = 0;
//		public var last_sign_in_time:int = 0;//上次签到时间
		public var isSignToday:Boolean = false;//今天是否签到
		public var m_vg_id:String        ="0";
		public var m_member_qq:String    ="0";
		public var Manage:int = 0;//管理后援团信息 对后援团的描述文字进行编辑，以及控制后援团的升级
		public var InviteApprove:int = 0;//邀请和审核团员 拥有权限的成员，可以对玩家的入团申请进行通过或者拒绝。并且可以在视频房间直接对其他玩家进行入团邀请
		public var Kick:int = 0;//开除出团 拥有权限的成员，可以将低于自己职位的团员开除出团
		public var Ticket:int = 0;//月票&粉丝牌 拥有权限的成员，可以进行购买月票，以及为对应的主播献上月票；以及兑换或者调整粉丝牌的相关内容
		public var PositionManage:int = 0;//成员职位管理 可以对比自己职位低的团员进行职位调整，赋予职位或者撤销职位
		public var isChief:Boolean = false;//是否是团长
		public var wealth_level:int;//财富等级
	}
}