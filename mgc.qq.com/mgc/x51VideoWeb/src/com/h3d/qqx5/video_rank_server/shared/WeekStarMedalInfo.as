package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	
	public class WeekStarMedalInfo extends ProtoBufSerializable
	{
		public function WeekStarMedalInfo()
		{
			registerField("light_time","",Descriptor.Int32,1);//点亮时间
			registerField("grade","",Descriptor.Int32,2);//段位id
			registerField("grade_name","",Descriptor.TypeString,3);//段位名字
			registerField("desc","",Descriptor.TypeString,4);//段位描述
		}
		
		public var light_time :int;
		public var grade :int;
		public var grade_name:String;
		public var desc:String;
	}
}