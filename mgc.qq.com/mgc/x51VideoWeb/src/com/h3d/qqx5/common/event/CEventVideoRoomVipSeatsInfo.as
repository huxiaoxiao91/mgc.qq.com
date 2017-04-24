package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomVipSeatsInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomVipSeatsInfo;
		}
		
		public function CEventVideoRoomVipSeatsInfo()
		{
			registerFieldForList("vipseat_player_infos", getQualifiedClassName(VideoRoomPlayerInfo), Descriptor.Compound, 1);
			registerField("is_fans", "", Descriptor.TypeBoolean, 2);
			registerFieldForList("vipseat_player_infos_new", getQualifiedClassName(VideoRoomPlayerInfo), Descriptor.Compound, 3);
		}
		
		public var vipseat_player_infos : Array = new Array();
		public var is_fans : Boolean;
		public var vipseat_player_infos_new : Array = new Array();
	}
}
