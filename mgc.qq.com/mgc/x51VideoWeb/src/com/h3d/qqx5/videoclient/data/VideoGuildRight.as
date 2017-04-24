package com.h3d.qqx5.videoclient.data
{
	public class VideoGuildRight
	{
		public static const VGR_Manage:int		 = 1 << 0;	//管理后援团信息 对后援团的描述文字进行编辑，以及控制后援团的升级
		public static const VGR_InviteApprove:int	 = 1 << 1;	//邀请和审核团员 拥有权限的成员，可以对玩家的入团申请进行通过或者拒绝。并且可以在视频房间直接对其他玩家进行入团邀请
		public static const VGR_Kick:int			 = 1 << 2;	//开除出团 拥有权限的成员，可以将低于自己职位的团员开除出团
		public static const VGR_Ticket:int		 = 1 << 3;	//月票&粉丝牌 拥有权限的成员，可以进行购买月票，以及为对应的主播献上月票；以及兑换或者调整粉丝牌的相关内容
		public static const VGR_PositionManage:int = 1 << 4;	//成员职位管理 可以对比自己职位低的团员进行职位调整，赋予职位或者撤销职位
			
		public static const VGR_ALLRight:int = VGR_Manage | VGR_InviteApprove | VGR_Kick | VGR_Ticket | VGR_PositionManage;
			
		public static const VGR_NoRight:int = 0;
	}
}