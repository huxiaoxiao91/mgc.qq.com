package com.h3d.qqx5.videoclient.data
{
	import flash.utils.Dictionary;

	public class ActivityInfoForUI
	{
		public var id:int = 0;
		public var name:String = "";
		public var desc:String = "";
		public var tip:String = "";
		public var begin_time:int;
		public var end_time:int;
		public var rewards:Array = new Array;
		//std::pair<VideoInt64, VideoInt64> progress;  // first 完成需求进度，second 当前进度
		public var progress:Array = new Array;  // first 完成需求进度，second 当前进度
		public var status:int = 0;
	}
}