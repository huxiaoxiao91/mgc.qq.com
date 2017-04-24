package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.NetBuffer;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadAttachedPlayerInfoCardRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfoCardRes;
		}
		
		public function CEventLoadAttachedPlayerInfoCardRes()
		{
			registerField("transid", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("attached_player_card", "", Descriptor.TypeNetBuffer, 3);
			registerField("anchor_id", "", Descriptor.Int64, 4);
		}
		
		public var transid : Int64;
		public var result : int;
		public var attached_player_card : NetBuffer;
		public var anchor_id : Int64;
	}
}
