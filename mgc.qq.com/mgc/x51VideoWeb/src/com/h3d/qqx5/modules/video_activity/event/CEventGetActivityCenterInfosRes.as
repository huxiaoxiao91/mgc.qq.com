package com.h3d.qqx5.modules.video_activity.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.modules.video_activity.VideoActivityEventID;
	import com.h3d.qqx5.modules.video_activity.VideoActivityInfoToClient;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetActivityCenterInfosRes extends INetMessage
	{
		public override function CLSID():int
		{
			return VideoActivityEventID.CLSID_CEventGetActivityCenterInfosRes;
		}
		public function CEventGetActivityCenterInfosRes()
		{
			registerField("succ", "", Descriptor.Int32, 1);
			registerField("level", "", Descriptor.Int32, 2);
			registerField("exp", "", Descriptor.Int32, 3);
			registerField("levelup_exp", "", Descriptor.Int32, 4);
			registerField("video_money", "", Descriptor.Int32, 5);
			registerField("vip_level", "", Descriptor.Int32, 6);
			registerField("has_taken_wage_today", "", Descriptor.TypeBoolean, 7);
			registerField("wage", "", Descriptor.Int32, 8);
			registerField("attached_wage", "", Descriptor.Int32, 9);
			registerFieldForList("activity_infos", getQualifiedClassName(VideoActivityInfoToClient), Descriptor.Compound, 10);
			registerFieldForList("daily_activity_infos", getQualifiedClassName(VideoActivityInfoToClient), Descriptor.Compound, 11);
			registerFieldForList("activity_infos_web", getQualifiedClassName(VideoActivityInfoToClient), Descriptor.Compound, 12);
			registerFieldForList("dev_activity", getQualifiedClassName(VideoActivityInfoToClient), Descriptor.Compound, 13);
		}
		public var succ:int;
		public var level:int;
		public var exp:int;
		public var levelup_exp:int;// 升下一级经验为0代表已经满级
		public var video_money:int;
		public var vip_level:int;
		public var has_taken_wage_today:Boolean;
		public var wage:int;
		public var attached_wage:int;
		public var activity_infos:Array = new Array;
		public var daily_activity_infos:Array = new Array;
		public var activity_infos_web:Array = new Array;
		public var dev_activity:Array = new Array;
	}
}
