package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class VideoRoomJacketDBData extends ProtoBufSerializable
	{
		
		public function VideoRoomJacketDBData()
		{
			registerField("roomid", "", Descriptor.Int32, 1);
			registerField("zoneid", "", Descriptor.Int32, 2);
			registerField("qq", "", Descriptor.Int64, 3);
			registerField("pstid", "", Descriptor.Int64, 4);
			registerField("jacket", "", Descriptor.Int32, 5);
			registerField("zone_name", "", Descriptor.TypeString, 6);
			registerField("player_name", "", Descriptor.TypeString, 7);
			registerField("gender", "", Descriptor.Int32, 8);
			registerField("wealth", "", Descriptor.Int64, 9);
		}
		
		public var roomid : int;
		public var zoneid : int;
		public var qq : Int64;
		public var pstid : Int64;
		public var jacket : int;
		public var zone_name : String;
		public var player_name : String;
		public var gender : int;
		public var wealth : Int64;
	}
}
