package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadAttachedPlayerInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfoRes;
		}
		
		public function CEventLoadAttachedPlayerInfoRes()
		{
			registerField("transid", "", Descriptor.Int64, 1);
			registerField("attached_player_pstid", "", Descriptor.Int64, 2);
		}
		
		public var transid : Int64;
		public var attached_player_pstid : Int64;
	}
}
