package com.h3d.qqx5.modules.anchor_nest.share
{
	public class NestInfoForUI
	{
		public var nest_id:int;
		public var nest_name:String = "";
		public var on_line_count:int;
		public var nest_popularity:String = "";
		public var nest_status:int ;//NestStatus{NS_CLOSED, NS_LIVE, NS_NOT_LIVE};
		public var attached_room_id:int;
		public var attached_room_name:String = "";
		public var pic_url :String = "";
		public var anchor_name :String = "";
		public var anchor_level:int;//主播等级
	}
}