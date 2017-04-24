package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPageSyncInfo;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomSyncInfo;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;

	public class CEventVideoRoomGetRoomListRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomGetRoomListRes;
		}
		
		public function CEventVideoRoomGetRoomListRes()
		{
			registerField("subject", "", Descriptor.Int32, 1);
			registerField("total_cnt", "", Descriptor.Int32, 2);
			registerFieldForList("rooms", getQualifiedClassName(VideoRoomSyncInfo), Descriptor.Compound, 3);
			registerField("show_ticket_link", "", Descriptor.TypeBoolean, 4);
			registerFieldForList("nests", getQualifiedClassName(VideoRoomSyncInfo), Descriptor.Compound, 5);
			registerFieldForDict("room_id_name", "", Descriptor.Int32, "", Descriptor.TypeString, 6);
			registerField("tag", "", Descriptor.Int32, 7);
			registerField("position", "", Descriptor.Int32, 8);
			registerField("operator", "", Descriptor.Int64, 9);
			registerFieldForList("page_rooms", getQualifiedClassName(VideoRoomPageSyncInfo), Descriptor.Compound, 10);
			registerFieldForList("page_nests", getQualifiedClassName(VideoRoomPageSyncInfo), Descriptor.Compound, 11);
			registerField("super_module_room_count","", Descriptor.Int32, 12);
			registerField("module_room_count","", Descriptor.Int32, 13);
		}
		
		public var subject:int;
		public var total_cnt:int;
		public var rooms:Array = new Array;
		public var show_ticket_link : Boolean;
		public var nests:Array = new Array;
		public var room_id_name:Dictionary = new Dictionary;
		public var tag:int;
		public var position:int;
		public var operator:Int64;
		public var page_rooms:Array = new Array;
		public var page_nests:Array = new Array;
		public var super_module_room_count:int;// 热门房间列表演唱会模块房间数量 web端轮播位显示演唱会房间用
		public var module_room_count:int;// 热门房间列表模块1或者模块2房间数量，包括推荐位房间数量，计算某个房间的模块id时使用
	}
}
