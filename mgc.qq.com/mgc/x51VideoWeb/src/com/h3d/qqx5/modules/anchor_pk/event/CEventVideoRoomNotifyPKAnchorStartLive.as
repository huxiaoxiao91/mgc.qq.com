package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventVideoRoomNotifyPKAnchorStartLive extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventVideoRoomNotifyPKAnchorStartLive;
		}
		
		public function CEventVideoRoomNotifyPKAnchorStartLive()
		{
			registerField("anchor_pstid", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var anchor_pstid : Int64;
		public var room_id : int;
	}
}
