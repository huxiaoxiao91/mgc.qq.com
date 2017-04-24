package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventAnchorWeekStarMatchSettleNotify  extends INetMessage
	{
		public override function CLSID():int
		{
			return WeekStarEventID.CLSID_CEventAnchorWeekStarMatchSettleNotify;
		}

		public function CEventAnchorWeekStarMatchSettleNotify()
		{
			registerField("last_week_score", "", Descriptor.Int32, 1);//枚举值
			registerField("total_score", "", Descriptor.Int32, 2);//主播总积分
			registerField("total_rank", "", Descriptor.Int32, 3);//总排名
			registerField("group_name", "", Descriptor.TypeString, 4);//分组名
			registerField("sub_rank", "", Descriptor.Int32, 5);//分组排名
			registerField("previous_diff", "", Descriptor.Int32, 6);//距离上一名的积分
		}
		public var last_week_score:int;
		public var total_score:int;
		public var total_rank:int;
		public var group_name:String;
		public var sub_rank:int;
		public var previous_diff:int;
	}
}