package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventAnchorWeekStarLevelUpNotify  extends INetMessage
	{
		public override function CLSID():int
		{
			return WeekStarEventID.CLSID_CEventAnchorWeekStarLevelUpNotify ;
		}

		public function CEventAnchorWeekStarLevelUpNotify()
		{
			registerField("grade", "", Descriptor.Int32, 1);//段位
			registerField("sub_level", "", Descriptor.Int32, 2);//段位等级
			registerField("grade_name", "", Descriptor.TypeString, 3);//段位名
			registerField("posing_url", "", Descriptor.TypeString, 4);//主播头像
		}
		public var grade:int;
		public var sub_level:int;
		public var grade_name:String;
		public var posing_url:String;
	}
}