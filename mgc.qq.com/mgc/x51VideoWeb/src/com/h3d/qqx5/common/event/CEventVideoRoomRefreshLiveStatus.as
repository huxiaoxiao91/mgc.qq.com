package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomLiveStatus;
	import com.h3d.qqx5.videoclient.data.SplitScreenInfo;
	
	import flash.utils.getQualifiedClassName;

	public class CEventVideoRoomRefreshLiveStatus extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshLiveStatus;
		}
		
		public function CEventVideoRoomRefreshLiveStatus()
		{
			registerField("live_status", getQualifiedClassName(VideoRoomLiveStatus), Descriptor.Compound, 1);
			registerField("split_screen_info", getQualifiedClassName(SplitScreenInfo), Descriptor.Compound, 2);
		}
		
		public var live_status :VideoRoomLiveStatus = new VideoRoomLiveStatus;
		public var split_screen_info:SplitScreenInfo = new SplitScreenInfo();
	}
}
