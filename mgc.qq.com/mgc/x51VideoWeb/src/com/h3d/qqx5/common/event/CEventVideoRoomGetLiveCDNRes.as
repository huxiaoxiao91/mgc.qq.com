package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.LiveCDNInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomGetLiveCDNRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomGetLiveCDNRes;
		}
		
		public function CEventVideoRoomGetLiveCDNRes()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("cdn_info", getQualifiedClassName(LiveCDNInfo), Descriptor.Compound, 3);
			registerField("room_type", "", Descriptor.Int64, 4);
		}
		
		public var room_id : int;
		public var player_id : Int64;
		public var cdn_info :LiveCDNInfo = new LiveCDNInfo;
		public var room_type:int;
	}
}
