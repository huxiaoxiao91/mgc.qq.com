package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomEnterRoom extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoom;
		}
		
		public function CEventVideoRoomEnterRoom()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("nick", "", Descriptor.TypeString, 2);
			registerField("gender", "", Descriptor.Int32, 3);
			registerField("level", "", Descriptor.Int32, 4);
			registerField("has_avatar", "", Descriptor.TypeBoolean, 5);
			registerField("avatar", "", Descriptor.TypeNetBuffer, 6);
			registerField("source", "", Descriptor.Int32, 7);
			registerField("invisible", "", Descriptor.TypeBoolean, 8);
			registerField("crowd_into", "", Descriptor.TypeBoolean, 9);
			registerField("subject", "", Descriptor.Int32, 10);
			registerField("tag", "", Descriptor.Int32, 11);
			registerField("offset", "", Descriptor.Int32, 12);
			registerField("module_type", "", Descriptor.Int32, 13);
			registerField("page_capacity", "", Descriptor.Int32, 14);
			registerField("room_list_pos", "", Descriptor.Int32, 15);
		}
		
		public var room_id : int;
		public var nick : String = "";
		public var gender : int;
		public var level : int;
		public var has_avatar : Boolean;
		public var avatar :NetBuffer = new NetBuffer;
		public var source : int;
		public var invisible : Boolean;
		public var crowd_into : Boolean;
		public var subject : int = -1;// 页签的类别
		public var tag : int;// 自定义页签id
		public var offset : int;// 快速进房偏移量
		public var module_type : int;// 热门推荐房间模块类别， 0:无模块	1:推荐模块1	2:推荐模块2	3:演唱会模块
		public var page_capacity : int;// 每页多少条
		public var room_list_pos : int;// 房间在总列表上的位置
	}
}
