package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomDeleteRoomPicRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomDeleteRoomPicRes;
		}
		
		public function CEventVideoRoomDeleteRoomPicRes()
		{
			registerField("operator_qq", "", Descriptor.Int64, 1);
			registerField("pic_index", "", Descriptor.Int32, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
			registerField("res", "", Descriptor.Int32, 4);
		}
		
		public var operator_qq : Int64;
		public var pic_index : int;
		public var room_id : int;
		public var res : int;
	}
}
