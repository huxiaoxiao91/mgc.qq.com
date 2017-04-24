package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAnchorPKRank;
	import com.h3d.qqx5.common.event.eventid.AnchorPKEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	
	//刷新pk赛进度条信息，10s一次
	public class CEventRefreshPkProgressInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorPKEventID.CLSID_CEventRefreshPkProgressInfo;
		}
		public function CEventRefreshPkProgressInfo()
		{
			registerField("m_pk_id", "", Descriptor.Int32, 1);
			registerField("m_first_anchor_id", "", Descriptor.Int64, 2);
			registerField("m_first_anchor_url", "", Descriptor.TypeString, 3);
			registerField("m_first_anchor_name", "", Descriptor.TypeString, 4);
			registerField("m_first_anchor_pk_value", "", Descriptor.Int64, 5);
			registerField("m_second_anchor_id", "", Descriptor.Int64, 6);
			registerField("m_second_anchor_url", "", Descriptor.TypeString, 7);
			registerField("m_second_anchor_name", "", Descriptor.TypeString, 8);
			registerField("m_second_anchor_pk_value", "", Descriptor.Int64, 9);
		}
		
		//一场pk赛的唯一标识id
		public var m_pk_id : int;
		//第一个主播的id
		public var m_first_anchor_id : Int64;
		//第一个主播头像
		public var m_first_anchor_url : String;
		//第一个主播名字
		public var m_first_anchor_name : String;
		//第一个主播的pk值
		public var m_first_anchor_pk_value : Int64;
		//第二个主播的id
		public var m_second_anchor_id : Int64;
		//第二个主播头像
		public var m_second_anchor_url : String;
		//第二个名字
		public var m_second_anchor_name : String;
		//第二个主播的pk值
		public var m_second_anchor_pk_value : Int64;
	}
}
