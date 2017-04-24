package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomChatBanRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomChatBanRes;
		}
		
		public function CEventVideoRoomChatBanRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerField("trans_id", "", Descriptor.Int64, 2);
		}
		
		public var result:int;
		public var trans_id:Int64;
	}
}
