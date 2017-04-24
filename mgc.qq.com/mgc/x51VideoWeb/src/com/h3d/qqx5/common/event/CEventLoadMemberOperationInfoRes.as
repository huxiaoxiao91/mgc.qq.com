package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.VideoRoomPlayerInfo;
	import com.h3d.qqx5.videoclient.data.CMemberOperationInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	import flash.utils.getQualifiedClassName;

	public class CEventLoadMemberOperationInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadMemberOperationInfoRes;
		}
		public function CEventLoadMemberOperationInfoRes()
		{
			registerField("res", "", Descriptor.Int32, 1);
			registerField("mem_player", getQualifiedClassName(VideoRoomPlayerInfo), Descriptor.Compound, 2);
			registerField("banable", "", Descriptor.TypeBoolean, 3);
			registerField("unbanalbe", "", Descriptor.TypeBoolean, 4);
		}
		
		public var res : int ;
		public var mem_player : VideoRoomPlayerInfo = new VideoRoomPlayerInfo;
		public var banable :Boolean;
		public var unbanalbe :Boolean;
	}
}