package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoRoomLiveInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	
	public class CEventGetVideoRoomLiveInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventGetVideoRoomLiveInfoRes;
		}
		public function CEventGetVideoRoomLiveInfoRes()
		{
			registerField("live_info", getQualifiedClassName(VideoRoomLiveInfo), Descriptor.Compound, 1);
		}
		public var live_info : VideoRoomLiveInfo;
	}
}