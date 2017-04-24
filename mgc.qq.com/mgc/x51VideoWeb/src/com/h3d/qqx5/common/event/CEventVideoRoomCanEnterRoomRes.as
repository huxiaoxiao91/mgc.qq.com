package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventVideoRoomCanEnterRoomRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventVideoRoomCanEnterRoomRes;
		}
		public function CEventVideoRoomCanEnterRoomRes()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("video_room_type", "", Descriptor.Int32, 3);
			registerField("ticket_room", "", Descriptor.TypeBoolean, 4);
			registerField("is_living", "", Descriptor.TypeBoolean, 5);
			registerField("is_super_room", "", Descriptor.TypeBoolean, 6);
			registerField("is_nest_room", "", Descriptor.TypeBoolean, 7);
			registerField("is_special_room", "", Descriptor.TypeBoolean, 8);
			registerField("room_skin_level", "", Descriptor.Int32, 9);
			registerField("room_skin_id", "", Descriptor.Int32, 10);
			registerField("is_pk", "", Descriptor.TypeBoolean, 11);
		}
		public var room_id : int;
		public var result : int;
		public var video_room_type:int;
		public var ticket_room:Boolean;
		public var is_living:Boolean;//是否正在直播
		public var is_super_room:Boolean;//演唱会房间
		public var is_nest_room:Boolean;//是否是小窝房间
		public var is_special_room:Boolean;//是否是特殊房间
		public var room_skin_level:int;
		public var room_skin_id:int;
		public var is_pk:Boolean;//是否pk房间
	}
}