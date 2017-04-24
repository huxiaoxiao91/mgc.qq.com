package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoVIPRankData
	{
		public function VideoVIPRankData()
		{
		//	m_player_id =Int64.fromNumber(0);
			m_vip_level = 0;
			//m_video_wealth = Int64.fromNumber(0);
		}
		
		public var m_player_id:String = "" ;
		public var m_player_nick:String = "";
		public var m_vip_level:int;
		public var m_vip_icon:String = ""//贵族图标
		public var m_video_wealth:String= "";
		public var m_player_zone:String = "";

	}
}