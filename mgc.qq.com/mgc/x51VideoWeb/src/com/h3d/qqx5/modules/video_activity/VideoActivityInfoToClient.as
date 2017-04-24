package com.h3d.qqx5.modules.video_activity
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.modules.video_activity.ProgressToClient;
	import com.h3d.qqx5.videoclient.data.CReward;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class VideoActivityInfoToClient extends ProtoBufSerializable
	{
		public function VideoActivityInfoToClient()
		{
			registerField("id", "", Descriptor.Int32, 1);
			registerField("name", "", Descriptor.TypeString, 2);
			registerField("desc", "", Descriptor.TypeString, 3);
			registerField("begin_time", "", Descriptor.Int32, 4);
			registerField("end_time", "", Descriptor.Int32, 5);
			registerFieldForList("rewards",getQualifiedClassName(CReward), Descriptor.Compound, 6);
			registerFieldForDict("completed_conditions", "", Descriptor.Int32, getQualifiedClassName(ProgressToClient), Descriptor.Compound, 7);
			registerField("status", "", Descriptor.Int32, 8);
			registerField("tip", "", Descriptor.TypeString, 9);
		}
		public var id:int;
		public var name:String ="";
		public var desc:String ="";
		public var tip:String ="";
		public var begin_time:int;
		public var end_time:int;
		public var rewards:Array = new Array;
		public var completed_conditions:Dictionary = new Dictionary;
		public var status:int;//0 未完成 1 完成未领奖 2 已领奖
	}
}
