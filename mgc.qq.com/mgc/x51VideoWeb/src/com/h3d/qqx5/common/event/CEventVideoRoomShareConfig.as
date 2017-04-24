package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.Dictionary;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomShareConfig extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomShareConfig;
		}
		
		public function CEventVideoRoomShareConfig()
		{
			registerField("video_buname", "", Descriptor.TypeString, 1);
			registerField("pic_download_url", "", Descriptor.TypeString, 2);
			registerField("video_add_url", "", Descriptor.TypeString, 3);
			registerField("video_zone_id", "", Descriptor.Int32, 4);
			registerFieldForDict("video_room_icon", "", Descriptor.Int32, "", Descriptor.Int32, 5);
			registerField("vip_url", "", Descriptor.TypeString, 6);
			registerField("buy_concert_ticket_url", "", Descriptor.TypeString, 7);
			registerField("concert_static_image_url", "", Descriptor.TypeString, 8);
			registerField("m_qgame_item_image_url", "", Descriptor.TypeString, 9);
		}
		
		public var video_buname : String = "";
		public var pic_download_url : String = "";
		public var video_add_url : String = "" ;
		public var video_zone_id : int;
		public var video_room_icon : Dictionary = new Dictionary;
		public var vip_url : String = "";
		public var buy_concert_ticket_url : String = "";
		public var concert_static_image_url : String = "";
		public var m_qgame_item_image_url : String = "";
	}
}
