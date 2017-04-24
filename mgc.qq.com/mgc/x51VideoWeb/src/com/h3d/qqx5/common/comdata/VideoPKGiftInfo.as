package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class VideoPKGiftInfo extends ProtoBufSerializable
	{
		
		public function VideoPKGiftInfo()
		{
			registerField("gift_id", "", Descriptor.Int32, 1);
			registerField("begin_time", "", Descriptor.Int32, 2);
			registerField("end_time", "", Descriptor.Int32, 3);
		}
		
		//礼物ID
		public var gift_id : int;
		//开始时间
		public var begin_time : int;
		//结束时间
		public var end_time : int;
	}
}
