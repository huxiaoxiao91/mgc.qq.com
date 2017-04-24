package com.h3d.qqx5.common.comdata
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.ProtoBufSerializable;
	public class VideoRoomDBData extends ProtoBufSerializable
	{
		public function VideoRoomDBData()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("type", "", Descriptor.Int32, 2);
			registerField("subject", "", Descriptor.Int32, 3);
			registerField("name", "", Descriptor.TypeString, 4);
			registerField("description", "", Descriptor.TypeString, 5);
			registerField("player_capacity", "", Descriptor.Int32, 6);
			registerField("flags", "", Descriptor.Int32, 7);
			registerField("pic_info", "", Descriptor.Int32, 8);
			registerField("public_chat_cd_on_enter", "", Descriptor.Int32, 9);
			registerField("is_closed_by_admin", "", Descriptor.Int32, 10);
			registerField("is_nest", "", Descriptor.TypeBoolean, 11);
			registerField("attached_room_id", "", Descriptor.Int32, 12);
		}
		
		public var room_id : int;
		public var type : int;
		public var subject : int;
		public var name : String;
		public var description : String;
		public var player_capacity : int;
		public var flags : int;
		public var pic_info : int;
		public var public_chat_cd_on_enter : int;
		public var is_closed_by_admin : int;
		public var is_nest : Boolean;
		public var attached_room_id : int;
	}
}
