package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.util.Int64;

	public class FollowAnchorAffinityInfoForUI
	{
		public function FollowAnchorAffinityInfoForUI()
		{
			Clear();
		}
		
		public function Clear():void
		{
			anchor_name = "";
			affinity = 0;
			guard_level = 0;
			nest_id = 0;
		}
		
		public var anchor_pstid:String ="";
		public var anchor_name:String;
		public var affinity:int;
		public var guard_level:int;
		public var guardIcon:String = ""//守护图标
		public var anchor_status:int;
		public var room_id:int;
		public var anchor_photo_url:String;
		public var nest_id:int;
		public var is_nest:Boolean = false;//是否在小窝中直播
		public var anchor_level:int;//主播等级
	}
}