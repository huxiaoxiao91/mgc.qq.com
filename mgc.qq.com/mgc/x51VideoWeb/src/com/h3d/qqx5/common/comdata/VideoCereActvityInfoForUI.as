package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class VideoCereActvityInfoForUI extends ProtoBufSerializable
	{
		
		public function VideoCereActvityInfoForUI()
		{
			registerField("m_pk_id", "", Descriptor.Int32, 1);
			registerField("m_pk_status", "", Descriptor.Int32, 2);
			registerField("m_begin_time", "", Descriptor.Int32, 3);
			registerField("m_end_time", "", Descriptor.Int32, 4);
			registerField("m_first_anchor_id", "", Descriptor.Int64, 5);
			registerField("m_second_anchor_id", "", Descriptor.Int64, 6);
		}
		
		//一场pk赛的唯一标识id
		public var m_pk_id : int;
		//比赛状态
		public var m_pk_status : int;
		//开始时间
		public var m_begin_time : int;
		//结束时间
		public var m_end_time : int;
		//第一个主播id
		public var m_first_anchor_id : Int64;
		//第二个主播id
		public var m_second_anchor_id : Int64;
		
	}
}
