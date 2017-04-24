package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class AnchorAffinityRankData
	{
		public var m_anchor_id:String = "";//主播qq
		public var m_player_id:String = "";//玩家qq
		public var m_anchor_nick:String = ""; // 主播昵称
		public var m_player_nick:String = "";//玩家昵称
		public var m_player_zonename:String = "";//玩家大区名
		public var m_score:String = "";	//亲密度
		public var m_session:int = 0;
		public var m_record_id:String = "";
		public var m_has_portrait:Boolean;
		public var playerPhotoUrl:String = "";//玩家头像
		public var anchor_status:int;//主播状态0 离线 1 在线为直播 2直播中
		public var room_id:int;//若主播正在直播，表示房间号
		public var anchorPhotoUrl:String = "";//主播头像
		public var palyerGender:int = 0;//玩家性别 0 女 1 男
		public var anchorGender:int = 0;//主播性别 0 女 1 男
		public var order_change:int = 0;//名次变化 0 无变化，大于零表示上升，小于0表示下降
		public var anchor_level:int = 0;//主播等级
	}
}