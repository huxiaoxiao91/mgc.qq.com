package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class CEventCommonActivityInfoBegin  extends INetMessage
	{
		public override function CLSID():int
		{
			return CommonActivityEventID.CLSID_CEventCommonActivityInfoBegin;
		}
		//通用活动开始或者pk活动结束，通用活动已经开始，全房间广播
		public function CEventCommonActivityInfoBegin()
		{
			registerField("m_activity_id", "", Descriptor.Int32, 1);
			registerField("m_end_time", "", Descriptor.Int32, 2);
			registerField("m_more_detail_url", "", Descriptor.TypeString, 3);
			registerField("m_gift_id", "", Descriptor.Int32, 4);
			registerField("m_max_send_num", "", Descriptor.Int32, 5);
		}
		
		//活动id
		public var m_activity_id : int;
		//结束时间
		public var m_end_time : int;
		//详细信息url
		public var m_more_detail_url : String;
		//活动礼物id
		public var m_gift_id : int;
		//活动礼物赠送最大值
		public var m_max_send_num : int;
	}
}