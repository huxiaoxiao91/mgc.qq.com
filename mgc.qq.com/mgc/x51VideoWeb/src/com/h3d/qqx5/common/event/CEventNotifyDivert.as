package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.ConcertEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomSyncInfo;
	
	import flash.utils.getQualifiedClassName;

	public class CEventNotifyDivert extends INetMessage
	{
		public function CEventNotifyDivert()
		{
			registerFieldForList("top_quality_room", getQualifiedClassName(VideoRoomSyncInfo), Descriptor.Compound, 1);
			registerFieldForList("normal_room",getQualifiedClassName(VideoRoomSyncInfo), Descriptor.Compound, 2);
		}
		public override function CLSID() : int
		{
			return ConcertEventID.CLSID_CEventNotifyDivert;
		}
		
		public var top_quality_room : Array = new Array;
		public var normal_room : Array = new Array;
	}
}