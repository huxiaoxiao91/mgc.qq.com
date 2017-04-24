package com.h3d.qqx5.video_service.serviceinf
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class VideoProgrammeInfo extends ProtoBufSerializable
	{
		
		public function VideoProgrammeInfo()
		{
			registerField("id", "", Descriptor.Int64, 1);
			registerField("name","", Descriptor.TypeString, 2);			///< 名称
			registerField("time_type","", Descriptor.Int32 , 3);			///< 时间类型（一次性、每天、每周、每月）
			registerField("time_flags", "", Descriptor.Int32, 4);
			registerField("time_begin", "", Descriptor.Int32, 5);
			registerField("time_end", "", Descriptor.Int32, 6);
			registerField("subscribe_num", "", Descriptor.Int32, 7);
		}
		
		public var id :Int64 = new Int64;
		public var name : String;
		public var time_type : int;
		public var time_flags : int;
		public var time_begin : int;
		public var time_end : int;
		public var subscribe_num : int;
	}
}
