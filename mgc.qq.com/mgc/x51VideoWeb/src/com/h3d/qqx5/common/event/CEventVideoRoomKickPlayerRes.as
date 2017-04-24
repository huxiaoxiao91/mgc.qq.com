package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomKickPlayerRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomKickPlayerRes;
		}
		
		public function CEventVideoRoomKickPlayerRes()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
		}
		
		public var trans_id : Int64;
		public var result : int;
	}
}
