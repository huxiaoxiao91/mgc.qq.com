package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.comdata.VideoCereActvityInfoForUI;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	//刷新pk比赛信息，包括比赛开始倒计时，开始比赛，比赛结束的结果通知
	public class CEventNotifyPkMatchInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorPKEventID.CLSID_CEventNotifyPkMatchInfo;
		}
		public function CEventNotifyPkMatchInfo()
		{
			registerField("m_pk_status", "", Descriptor.Int32, 1);
			registerField("m_begin_time", "", Descriptor.Int32, 2);
			registerField("m_end_time", "", Descriptor.Int32, 3);
			registerField("m_first_anchor_id", "", Descriptor.Int64, 4);
			registerField("m_second_anchor_id", "", Descriptor.Int64, 5);
			registerField("m_first_pk_value", "", Descriptor.Int64, 6);
			registerField("m_second_pk_value", "", Descriptor.Int64, 7);
			registerField("m_pk_id", "", Descriptor.Int32, 8);
			registerField("m_left_time", "", Descriptor.Int32, 9);
		}
		
		//比赛状态
		/**
		 * 1:倒计时中
		 * 2:pk进行中
		 * 3:pk结束
		 * 4:pk异常
		 */
		public var m_pk_status : int;
		//开始时间
		public var m_begin_time : int;
		//结束时间
		public var m_end_time : int;
		//第一个主播id
		public var m_first_anchor_id : Int64;
		//第二个主播id
		public var m_second_anchor_id : Int64;
		//第一个主播PK值
		public var m_first_pk_value : Int64;
		//第二个主播PK值
		public var m_second_pk_value : Int64;
		//pk_id
		public var m_pk_id : int;
		//剩余时间
		public var m_left_time : int;
	}
}
