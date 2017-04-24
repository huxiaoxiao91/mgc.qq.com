package com.h3d.qqx5.video_rank_server.shared
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	
	public class AnchorWeekStarMatchInfo extends ProtoBufSerializable
	{
		public function AnchorWeekStarMatchInfo()
		{
			registerField("status","",Descriptor.Int32,1);//周星赛活动状态  0：有参赛；2：未参赛
			registerField("total_score","",Descriptor.Int32,2);//总积分
			registerField("total_rank","",Descriptor.Int32,3);//总排名
			registerField("sub_rank","",Descriptor.Int32,4);//分组排名
			registerField("group_name","",Descriptor.TypeString,5);//分组名
			registerField("grade","",Descriptor.Int32,6);//段位
			registerField("sub_level","",Descriptor.Int32,7);//段位下的等级 
			registerFieldForList("week_star_medals",getQualifiedClassName(WeekStarMedalInfo), Descriptor.Compound,8);//包括点亮和为点亮的勋章
		}
		
		public var status :int;
		public var total_score :int;
		public var total_rank :int;
		public var sub_rank:int;
		public var group_name:String;
		public var grade : int;
		public var sub_level : int;
		public var week_star_medals: Array;
	}
}