package com.h3d.qqx5.common.event.roomskin {

	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	/**
	 * 魅力排名信息
	 * @author gaolei
	 *
	 */
	public class VideoRoomCharmRank extends ProtoBufSerializable {
		public function VideoRoomCharmRank() {
			super();

			registerField("anchor_id",		"", 	Descriptor.Int64, 		1);
			registerField("room_id",		"", 	Descriptor.Int32, 		2);
			registerField("room_name",		"", 	Descriptor.TypeString, 	3);
			registerField("session",		"", 	Descriptor.Int32, 		4);
			registerField("score",			"", 	Descriptor.Int64, 		5);
			registerField("last_order",		"", 	Descriptor.Int32, 		6);
			registerField("skin_level",		"", 	Descriptor.Int32, 		7);
			registerField("onboard_time",	"", 	Descriptor.Int32, 		8);
			registerField("record_id",		"", 	Descriptor.Int32, 		9);
			registerField("portrait_url",	"", 	Descriptor.TypeString, 	10);
			registerField("skin_id",		"", 	Descriptor.Int32, 		11);
			registerField("anchor_status",	"", 	Descriptor.Int32, 		12);
		}

		public var anchor_id:Int64 = new Int64();

		public var room_id:int;

		public var room_name:String;

		public var session:int;

		public var score:Int64     = new Int64();

		public var last_order:int;

		public var skin_level:int;

		public var onboard_time:int;
		
		public var record_id:int;
		
		public var portrait_url:String;
		
		public var skin_id:int;
		
		public var anchor_status:int;
	}
}
