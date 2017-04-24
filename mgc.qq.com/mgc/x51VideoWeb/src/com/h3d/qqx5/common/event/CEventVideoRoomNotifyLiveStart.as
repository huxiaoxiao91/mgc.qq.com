package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomLiveStatusDetail;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomNotifyLiveStart extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomNotifyLiveStart;
		}
		
		public function CEventVideoRoomNotifyLiveStart()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("start_time", "", Descriptor.Int64, 2);
			registerField("anchor_id", "", Descriptor.Int64, 3);
			registerField("detail", getQualifiedClassName(VideoRoomLiveStatusDetail), Descriptor.Compound, 4);
		}
		
		public var room_id : int;
		public var start_time : Int64;
		public var anchor_id : Int64;
		public var detail :VideoRoomLiveStatusDetail = new VideoRoomLiveStatusDetail;
	}
}
