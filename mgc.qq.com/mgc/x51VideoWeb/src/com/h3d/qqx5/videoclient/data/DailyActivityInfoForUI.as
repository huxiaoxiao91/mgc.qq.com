package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.Dictionary;

	public class DailyActivityInfoForUI
	{
		public var id:int = 0;
		public var name:String;
		public var desc:String;
		public var rewards:Array = new Array;
		public var progress:Array = new Array;  //任务进度ActivityProcess
		public var status:int = 0;
	}
}