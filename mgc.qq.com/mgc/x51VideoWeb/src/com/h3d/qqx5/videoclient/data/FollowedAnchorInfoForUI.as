package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;
	public class FollowedAnchorInfoForUI
	{
		public var m_anchor:String = "";
		public var m_anchor_type:int;
		public var m_anchor_nick:String = "";
		public var m_starlight:uint;
		public var m_videoroom_id:int;
		public var m_status:int;
		public var m_photo_url:String= "";
		public var m_nest_id:int;
		public var affinity:int    ;
		public var guard_level:int  ;
		public var guardIcon:String ="";
		public var is_nest:Boolean = false;//是否在小窝中直波
		public var anchor_level:int;//主播等级
	}
}