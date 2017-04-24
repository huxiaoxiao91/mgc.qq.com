package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;
	
	public class VideoAnchorPKRank extends ProtoBufSerializable
	{
		public function VideoAnchorPKRank()
		{
			registerField("m_anchor_id", "", Descriptor.Int64, 1);
			registerField("m_anchor_level", "", Descriptor.Int32, 2);
			registerField("m_anchor_name", "", Descriptor.TypeString, 3);
			registerField("m_anchor_starlight", "", Descriptor.Int64, 4);
			registerField("m_pk_value", "", Descriptor.Int64, 5);
			registerField("m_record_id", "", Descriptor.Int32, 6);
			registerField("m_session", "", Descriptor.Int32, 7);
			registerField("m_onboard_time", "", Descriptor.Int32, 8);
		}
		
		//主播ID
		public var m_anchor_id:Int64;
		//主播等级
		public var m_anchor_level:int;
		//主播昵称
		public var m_anchor_name:String;
		//主播星耀值
		public var m_anchor_starlight:Int64;
		//主播PK值
		public var m_pk_value:Int64;
		//记录ID
		public var m_record_id:int;
		//当前活动id
		public var m_session:int;
		//记录时间
		public var m_onboard_time:int;
	}
}