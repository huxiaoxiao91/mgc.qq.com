package com.h3d.qqx5.videoclient.data
{
	import com.h3d.qqx5.util.Int64;

	public class LiveTaskInfoForUI
	{
		public function LiveTaskInfoForUI()
		{
			task_id = 0;
			condition = "";
//			current_progress = new Int64(0,0);
//			finish_progress = new Int64(0,0);
			status = LiveTaskStatus.LTS_UnFinished;
		}
		
		public var task_id:int;
		public var condition:String = "";
		public var desc:String;
		public var current_progress:String = "";
		public var finish_progress:String = "";
		public var status:int;
	}
}