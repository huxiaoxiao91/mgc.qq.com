package com.h3d.qqx5.videoclient.data
{
	import flash.utils.Dictionary;

	public class AnchorInfocard
	{	
		public var basicData:ClientAnchorData = new ClientAnchorData;
		public var fans:Array = new Array;
		public var affinity:Array = new Array;
		public var guard_count:Dictionary = new Dictionary;
		public var current_guard_level:int = 0;//正在查看主播名片的玩家的守护等级
		public var current_guard_name:String = "";//当前等级守护名称
		public var guardIcon:String = "";//守护图标
		public var next_guard_level:int = 0;//下一守护级别，VIDEO_GUARD_LEVEL_INVALID表示没有下一级守护
		public var next_guard_name:String = "";//下一级别守护名称
		public var affinity_need:int = 0;//到下一守护级别还需要多少亲密度
		public var vg_cnt:int = 0;
		public var guild_list:Array = new Array;
		public var total_guard_cnt:int  = 0; // 守护总数
		public var annual2014_title:int = AnchorTitle.E_AT_None;	//年度最佳星主播 or 年度最佳人气主播
		public var nest_id:int;
		public var needMonthAffinity:int = 0;//对于天尊和守护来说，需要多少月亲密度，可以使下个月继续成为天尊或者超凡守护 为0表示已经达到条件，
		public var anchor_badge_vec:Array = new Array();
		
		public var nest_skin_info:AnchorNestSkinInfoUI;
		public var weekstarMatchInfo:WeekStarInfoUI = new WeekStarInfoUI;
	}
}