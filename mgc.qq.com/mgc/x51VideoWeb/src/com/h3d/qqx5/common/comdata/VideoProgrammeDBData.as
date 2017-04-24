package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class VideoProgrammeDBData extends ProtoBufSerializable
	{
		public function VideoProgrammeDBData()
		{
			registerField("id", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("name", "", Descriptor.TypeString, 3);
			registerField("time_type", "", Descriptor.Int32, 4);
			registerField("time_flags", "", Descriptor.Int32, 5);
			registerField("time_begin", "", Descriptor.Int32, 6);
			registerField("time_end", "", Descriptor.Int32, 7);
			registerField("subscribe_num", "", Descriptor.Int32, 8);
		}
		
		public var id : Int64;
		public var room_id : int;
		public var name : String;
		public var time_type : int;
		public var time_flags : int;
		public var time_begin : int;
		public var time_end : int;
		public var subscribe_num : int;
	}
}
