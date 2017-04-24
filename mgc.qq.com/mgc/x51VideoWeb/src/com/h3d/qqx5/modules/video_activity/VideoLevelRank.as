package com.h3d.qqx5.modules.video_activity
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	public class VideoLevelRank extends ProtoBufSerializable
	{
		public function VideoLevelRank()
		{
			registerField("pstid", "", Descriptor.Int64, 1);
			registerField("nick_str", "", Descriptor.TypeString, 2);
			registerField("zone_str", "", Descriptor.TypeString, 3);
			registerField("sex", "", Descriptor.Int32, 4);
			registerField("have_portrait", "", Descriptor.Int32, 5);
			registerField("onboard_time", "", Descriptor.Int64, 6);
			registerField("session", "", Descriptor.Int32, 7);
			registerField("score", "", Descriptor.Int32, 8);
			registerField("level", "", Descriptor.Int32, 9);
			registerField("record_id", "", Descriptor.Int64, 11);
		}
		public var pstid:Int64;
		public var nick_str : String = "";
		public var zone_str : String = "";
		public var sex : int;
		public var have_portrait : int;
		public var onboard_time : Int64;
		public var session : int;
		public var score : int;
		public var level : int;
		public var record_id : Int64;
	}
}
