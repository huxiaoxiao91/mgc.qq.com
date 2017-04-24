package com.h3d.qqx5.common.comdata
{
		import com.h3d.qqx5.framework.network.Descriptor;
		import com.h3d.qqx5.framework.network.ProtoBufSerializable;
		import com.h3d.qqx5.util.Int64;
		
		public class VipSeatInfo extends ProtoBufSerializable
		{
			
			public function VipSeatInfo()
			{
				registerField("player_id", "", Descriptor.Int64, 1);
				registerField("nick", "", Descriptor.TypeString, 2);
				registerField("zone", "", Descriptor.TypeString, 3);
				registerField("has_portrait", "", Descriptor.TypeBoolean, 4);
				registerField("pic_url", "", Descriptor.TypeString, 5);
				registerField("gender", "", Descriptor.Int32, 6);
				registerField("guard_level", "", Descriptor.Int32, 7);
				registerField("level", "", Descriptor.Int32, 8);
				registerField("vip_level", "", Descriptor.Int32, 9);
				registerField("video_room_wealth", "", Descriptor.Int64, 10);
				registerField("taken_cnt", "", Descriptor.Int32, 11);
				registerField("take_cost", "", Descriptor.Int32, 12);
				registerField("wealth_level", "", Descriptor.Int32, 13);
				registerField("take_time", "", Descriptor.Int32, 14);
				registerField("cost_seat", "", Descriptor.TypeBoolean, 15);
			}
			
			public var player_id : Int64 = new Int64(0,0);
			public var nick : String = "";
			public var zone : String = "";
			public var has_portrait : Boolean ;
			public var pic_url : String = "";
			public var gender : int ;
			public var guard_level : int ;
			public var level : int;
			public var vip_level : int;
			public var video_room_wealth : Int64 = new Int64(0,0);
			public var taken_cnt : int;
			public var take_cost : int;
			public var wealth_level : int;
			public var take_time : int;
			public var cost_seat:Boolean;
		}
}