package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class AnchorPKFansAvatar
	{
		public var m_player_id:int = 0;//玩家ID
		public var m_name:String;
		public var m_avatar_buff:String;
		public var m_avatar_size:int = 0;
		public var m_contribution:Int64;// 贡献
		public var m_vip_level:int = -1;// 贵族等级
		public var m_guild_name:String;// 后援团名称
		public var m_sex:int = 0;
		
		
		public function Clear():void
		{
			m_player_id = 0;
			m_name = null;
			m_avatar_buff = null;
			m_avatar_size = 0;
			m_contribution.low = m_contribution.high = 0;
			m_vip_level = -1;
			m_guild_name = null;
			m_sex = 0;
		}
	}
}