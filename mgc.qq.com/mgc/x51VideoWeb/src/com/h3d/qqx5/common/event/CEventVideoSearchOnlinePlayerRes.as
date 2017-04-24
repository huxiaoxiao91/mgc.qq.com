package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoSearchOnlinePlayerRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoSearchOnlinePlayerRes;
		}
		
		public function CEventVideoSearchOnlinePlayerRes()
		{
			registerFieldForList("search_results", getQualifiedClassName(VideoRoomPlayerInfo), Descriptor.Compound, 1);
		}
		
		public var search_results : Array = new Array;
	}
}
