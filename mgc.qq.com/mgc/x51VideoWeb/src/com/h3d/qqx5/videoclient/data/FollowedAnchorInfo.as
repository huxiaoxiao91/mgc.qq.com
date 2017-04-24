package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class FollowedAnchorInfo
	{
		public function FollowedAnchorInfo()
		{
		}
		
		public var m_anchor:Int64;
		public var m_anchor_type:int;
		public var m_anchor_nick:String = "";
		public var m_starlight;int
		public var m_videoroom_id;int
		public var m_status:int;
		public var m_photo_url:String= "";
		public var m_nest_id:int;
		public var affinity:int    ;
		public var guard_level:int  ;
	}
}