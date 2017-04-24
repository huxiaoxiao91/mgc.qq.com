package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventWeekStarNotifySucc  extends INetMessage
	{
		public override function CLSID():int
		{
			return WeekStarEventID.CLSID_CEventWeekStarNotifySucc ;
		}

		public function CEventWeekStarNotifySucc()
		{
			registerField("flag", "", Descriptor.Int32, 1);//枚举值
		}
		public var flag:int;
	}
}