package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyPlayerSendGift extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerSendGift;
		}
		
		public function CEventVideoCeremonyPlayerSendGift()
		{
			registerField("player_pstid", "", Descriptor.Int64, 1);
			registerField("player_name", "", Descriptor.TypeString, 2);
			registerField("player_zone", "", Descriptor.TypeString, 3);
			registerField("support_degree_add", "", Descriptor.Int32, 4);
			registerField("vip_level", "", Descriptor.Int32, 5);
		}
		
		public var player_pstid : Int64;
		public var player_name : String;
		public var player_zone : String;
		public var support_degree_add : int;
		public var vip_level : int;
	}
}
