package com.h3d.qqx5.common.event
{
	import avmplus.getQualifiedClassName;
	
	import com.h3d.qqx5.common.event.eventid.WeekStarEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventWeekStarConfigReq  extends INetMessage
	{
		public override function CLSID():int
		{
			return WeekStarEventID.CLSID_CEventWeekStarConfigReq ;
		}
		//下发宝箱开启的差值，活动标题和活动内容
		public function CEventWeekStarConfigReq()
		{
			
		}
	}
}