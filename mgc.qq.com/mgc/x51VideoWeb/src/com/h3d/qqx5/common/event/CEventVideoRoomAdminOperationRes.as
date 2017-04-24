package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.video_service.serviceinf.RoomAdminInfo;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomAdminOperationRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomAdminOperationRes;
		}
		
		public function CEventVideoRoomAdminOperationRes()
		{
			registerField("add", "", Descriptor.Int32, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("added_admininfo", getQualifiedClassName(RoomAdminInfo), Descriptor.Compound, 3);
		}
		
		public var add : int;
		public var result : int;
		public var added_admininfo :RoomAdminInfo = new RoomAdminInfo;
	}
}
