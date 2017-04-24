package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomLoadPlayerListRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomLoadPlayerListRes;
		}
		
		public function CEventVideoRoomLoadPlayerListRes()
		{
			registerField("total_page_cnt", "", Descriptor.Int32, 1);
			registerField("curr_page", "", Descriptor.Int32, 2);
			registerFieldForList("playerInfos", getQualifiedClassName(VideoRoomPlayerInfo), Descriptor.Compound, 3);
		}
		
		public var total_page_cnt : int;
		public var curr_page : int;
		public var playerInfos : Array = new Array();
	}
}
