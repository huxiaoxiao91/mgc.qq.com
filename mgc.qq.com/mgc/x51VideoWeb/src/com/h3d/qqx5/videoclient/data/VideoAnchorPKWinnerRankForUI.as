package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoAnchorPKWinnerRankForUI
	{
		public var m_anchor_id:String = "";
		public var m_anchor_nick:String;
		public var m_anchor_portraiturl:String;
		public var m_guild_id:String = "";
		public var m_guild_name:String;
		public var m_anchor_status:int;//主播状态 0 离线 1 在线为直播 2 直播中
		public var m_room_id:int;//直播中表示直播房间id
		public var m_is_nest:Boolean = false;//是否是在小窝中直波
	}
}