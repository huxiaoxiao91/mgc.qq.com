package com.h3d.qqx5.common.event {

	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.EnterVideoRoomInitInfo;

	import flash.utils.getQualifiedClassName;

	public class CEventVideoRoomEnterRoomRes extends INetMessage {
		public override function CLSID():int {
			return EEventIDVideoRoom.CLSID_CEventVideoRoomEnterRoomRes;
		}

		public function CEventVideoRoomEnterRoomRes() {
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("info", getQualifiedClassName(EnterVideoRoomInitInfo), Descriptor.Compound, 3);
			registerField("cooldown", "", Descriptor.Int32, 4);
			registerField("nest_count", "", Descriptor.Int32, 5);
			registerField("is_special_room", "", Descriptor.TypeBoolean, 6);
			registerField("is_nest_room", "", Descriptor.TypeBoolean, 7);
			registerField("subject", "", Descriptor.Int32, 8);// 页签的类别
			registerField("tag", "", Descriptor.Int32, 9);// 自定义页签id
			registerField("offset", "", Descriptor.Int32, 10);// 快速切房偏移量
			registerField("m_switch", "", Descriptor.TypeBoolean, 11);//ios开关
			registerField("title", "", Descriptor.TypeString, 12);
			registerField("description", "", Descriptor.TypeString, 13);
			registerField("close_description", "", Descriptor.TypeString, 14);
			registerField("left_bekicked_time", "", Descriptor.Int32, 15);// 被踢出房间后，剩余可以进入房间的时间
			registerField("h5_url_profix", "", Descriptor.TypeString, 16);//h5分享页面url固定部分
			registerField("pic_location", "", Descriptor.TypeString, 17);//房间内 贵族、守护、财富值的图标显示位置 如"1.2.3"
			registerField("concert_id", "", Descriptor.Int32, 18);// 演唱会ID（新增）
		}

		public var room_id:int;
		public var result:int;
		public var info:EnterVideoRoomInitInfo = new EnterVideoRoomInitInfo();
		public var cooldown:int;
		public var nest_count:int;
		public var is_special_room:Boolean;
		public var is_nest_room:Boolean;
		public var subject:int;
		public var tag:int;
		public var offset:int;
		public var m_switch:Boolean;
		public var title:String;
		public var description:String;
		public var close_description:String;
		public var left_bekicked_time:int;
		public var h5_url_profix:String;
		public var pic_location:String;
		public var concert_id:int;
	}
}
