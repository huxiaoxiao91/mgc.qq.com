package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomAdminOperation extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomAdminOperation;
		}
		
		public function CEventVideoRoomAdminOperation()
		{
			registerField("operator_qq", "", Descriptor.Int64, 1);
			registerField("target_qq", "", Descriptor.Int64, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("add", "", Descriptor.Int32, 4);
		}
		
		public var operator_qq : Int64;
		public var target_qq : Int64;
		public var room_id : int;
		public var add : int;
	}
}
