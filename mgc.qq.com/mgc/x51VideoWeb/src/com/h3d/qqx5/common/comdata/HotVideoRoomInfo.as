package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class HotVideoRoomInfo extends ProtoBufSerializable
	{
		public function HotVideoRoomInfo()
		{
			registerField("room_name", "", Descriptor.TypeString, 1);
			registerField("room_pic_url", "", Descriptor.TypeString, 2);
			registerField("anchor_name", "", Descriptor.TypeString, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
		}
		public var room_name : String = "";
		public var room_pic_url : String = "";
		public var anchor_name : String = "";
		public var room_id : int;
	}
}
