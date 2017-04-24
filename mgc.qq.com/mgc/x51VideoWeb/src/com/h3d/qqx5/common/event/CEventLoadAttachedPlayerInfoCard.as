package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventLoadAttachedPlayerInfoCard extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventLoadAttachedPlayerInfoCard;
		}
		
		public function CEventLoadAttachedPlayerInfoCard()
		{
			registerField("transid", "", Descriptor.Int64, 1);
			registerField("attached_player_pstid", "", Descriptor.Int64, 2);
			registerField("anchor_id", "", Descriptor.Int64, 3);
			registerField("attached_player_zone", "", Descriptor.Int32, 4);
			registerField("attached_player_account", "", Descriptor.Int64, 5);
		}
		
		public var transid : Int64;
		public var attached_player_pstid : Int64;
		public var anchor_id : Int64;
		public var attached_player_zone : int;
		public var attached_player_account : Int64;
	}
}
