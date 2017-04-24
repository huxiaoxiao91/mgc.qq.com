package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.comdata.VideoCereActvityInfoForUI;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	//刷新pk值信息，1s一次
	public class CEventRefreshPkValue extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorPKEventID.CLSID_CEventRefreshPkValue;
		}
		public function CEventRefreshPkValue()
		{
			registerField("m_pk_id", "", Descriptor.Int32, 1);
			registerField("m_first_anchor_id", "", Descriptor.Int64, 2);
			registerField("m_first_anchor_pk_value", "", Descriptor.Int64, 3);
			registerField("m_second_anchor_id", "", Descriptor.Int64, 4);
			registerField("m_second_anchor_pk_value", "", Descriptor.Int64, 5);
		}
		
		//一场pk赛的唯一标识id
		public var m_pk_id : int;
		//第一个主播id
		public var m_first_anchor_id : Int64;
		//第一个主播pk值
		public var m_first_anchor_pk_value : Int64;
		//第二个主播id
		public var m_second_anchor_id : Int64;
		//第二个主播pk值
		public var m_second_anchor_pk_value : Int64;
	}
}
