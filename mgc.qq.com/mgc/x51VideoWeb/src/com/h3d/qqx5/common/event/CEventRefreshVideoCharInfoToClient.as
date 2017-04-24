package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoCharInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventRefreshVideoCharInfoToClient extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRefreshVideoCharInfoToClient;
		}
		
		public function CEventRefreshVideoCharInfoToClient()
		{
			registerField("info", getQualifiedClassName(VideoCharInfo), Descriptor.Compound, 1);
		}
		
		public var info : VideoCharInfo = new VideoCharInfo;
	}
}
