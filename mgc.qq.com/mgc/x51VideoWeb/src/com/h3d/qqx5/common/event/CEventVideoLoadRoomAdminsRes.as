package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.video_service.serviceinf.RoomAdminInfo;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoLoadRoomAdminsRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoLoadRoomAdminsRes;
		}
		
		public function CEventVideoLoadRoomAdminsRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerFieldForList("admins", getQualifiedClassName(RoomAdminInfo), Descriptor.Compound, 2);
		}
		
		public var result : int;
		public var admins : Array = new Array;
	}
}
