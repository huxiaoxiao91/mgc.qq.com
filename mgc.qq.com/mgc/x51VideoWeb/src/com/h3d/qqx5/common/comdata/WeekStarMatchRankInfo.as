package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;

	public class WeekStarMatchRankInfo extends ProtoBufSerializable
	{
		public function WeekStarMatchRankInfo()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);//主播id
			registerField("anchor_nick", "", Descriptor.TypeString, 2);//主播昵称
			registerField("anchor_status", "", Descriptor.Int32, 3);//开播状态
			registerField("grade_name", "", Descriptor.TypeString, 4);//段位名字
			registerField("onboard_time", "", Descriptor.Int32, 5); //上榜时间
			registerField("portrait_url", "", Descriptor.TypeString, 6);//头像url
			registerField("room_id", "", Descriptor.Int32, 7);//房间id
			registerField("session", "", Descriptor.Int32, 8);//赛季
			registerField("star_light", "", Descriptor.Int64, 9);//星耀值
			registerField("grade", "", Descriptor.Int32, 10);//段位
			registerField("sub_level", "", Descriptor.Int32, 11);//段位下的等级
			registerField("total_score", "", Descriptor.Int32, 12);//总分
		}
		public var anchor_id : Int64;
		public var anchor_nick : String = "";
		public var anchor_status : int;
		public var grade_name : String = "";
		public var onboard_time : int;
		public var portrait_url : String = "";
		public var room_id : int;
		public var session : int;
		public var star_light : Int64;
		public var grade : int;
		public var sub_level : int;
		public var total_score : int;
	}
}
