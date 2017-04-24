package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class CEventCommonActivityInfoEnd extends INetMessage
	{
		public override function CLSID():int
		{
			return CommonActivityEventID.CLSID_CEventCommonActivityInfoEnd;
		}
		//通用活动结束或者通用活动已经开始，pk活动开始，全房间广播
		public function CEventCommonActivityInfoEnd()
		{
			registerField("m_activity_id", "", Descriptor.Int32, 1);
		}
		
		//活动id
		public var m_activity_id : int;
	}
}