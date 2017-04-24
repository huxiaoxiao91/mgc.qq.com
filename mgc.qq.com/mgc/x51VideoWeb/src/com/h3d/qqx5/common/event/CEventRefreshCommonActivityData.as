package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.CommonActivityEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class CEventRefreshCommonActivityData extends INetMessage
	{
		public override function CLSID():int
		{
			return CommonActivityEventID.CLSID_CEventRefreshCommonActivityData;
		}
		//活动期间，直播房间，主播排名变化，房间内立即广播，主播底板等级变化，房间内立即广播，主播收到的通用礼物数量变化，房间内10s广播一次，进入直播房间，立即下发消息
		public function CEventRefreshCommonActivityData()
		{
			registerField("m_activity_id", "", Descriptor.Int32, 1);
			registerField("m_anchor_rank", "", Descriptor.Int32, 2);
			registerField("m_recv_gift_count", "", Descriptor.Int32, 3);
			registerField("m_pannel_level", "", Descriptor.Int32, 4);
			registerField("m_is_level_up", "", Descriptor.TypeBoolean, 5);
		}
		//活动id
		public var m_activity_id : int;
		//主播排名
		public var m_anchor_rank : int;
		//主播收到的通用礼物数量
		public var m_recv_gift_count : int;
		//主播底板等级
		public var m_pannel_level : int;		
		//主播底板是否升级
		public var m_is_level_up : Boolean;
	}
}