package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomStartLiveRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomStartLiveRes;
		}
		
		public function CEventVideoRoomStartLiveRes()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
			registerField("pstid", "", Descriptor.Int64, 3);
			registerField("result", "", Descriptor.Int32, 4);
			registerField("vid", "", Descriptor.Int32, 5);
		}
		
		public var room_id : int;
		public var trans_id : Int64;
		public var pstid : Int64;
		public var result : int;
		public var vid : int;
	}
}
