package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	import com.h3d.qqx5.util.Int64;

	public class RoomPerpetualBanchatDBData extends ProtoBufSerializable
	{
		public function RoomPerpetualBanchatDBData()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("operator_id", "", Descriptor.Int64, 3);
			registerField("ban_time", "", Descriptor.Int32, 4);
		}
		
		public var room_id : int;
		public var player_id : Int64;
		public var operator_id : Int64;
		public var ban_time : int;
	}
}
