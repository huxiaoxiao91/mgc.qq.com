package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class VideoPlayerInfo
	{
		public var m_pstid:Int64;
		public var m_nick:String ="";
		public var m_signature:String ="";
		public var m_photo_url:String ="";
		public var m_sex_male:Boolean;
		public var m_video_wealth:Int64;
		public var m_video_money_balance:int;
		public var m_free_gift_count:int;
		public var m_daily_free_whistle_count:int;
		public var m_vip_level:int;
		public var m_vip_expire_time:int;
		public var m_block_public_chat:Boolean;
		public var m_zone_name:String = "";
		public var m_video_dream_money: int;
		public var m_video_level:int ;
		public var followinfo_vec:Array= new Array;//std::vector<>,
	}
}