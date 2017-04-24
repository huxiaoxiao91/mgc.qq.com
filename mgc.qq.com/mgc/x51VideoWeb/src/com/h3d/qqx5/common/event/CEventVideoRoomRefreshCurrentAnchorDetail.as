package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomLiveStatusDetail;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomRefreshCurrentAnchorDetail extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomRefreshCurrentAnchorDetail;
		}
		
		public function CEventVideoRoomRefreshCurrentAnchorDetail()
		{
			registerField("live_detail", getQualifiedClassName(VideoRoomLiveStatusDetail), Descriptor.Compound, 1);
		}
		
		public var live_detail :VideoRoomLiveStatusDetail = new VideoRoomLiveStatusDetail;
	}
}
