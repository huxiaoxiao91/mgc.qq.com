package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyPlayerAffinityChanged extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyPlayerAffinityChanged;
		}
		
		public function CEventVideoCeremonyPlayerAffinityChanged()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("player_pstid", "", Descriptor.Int64, 2);
			registerField("pre_aff", "", Descriptor.Int32, 3);
			registerField("new_aff", "", Descriptor.Int32, 4);
			registerField("player_name", "", Descriptor.TypeString, 5);
			registerField("player_zone", "", Descriptor.TypeString, 6);
		}
		
		public var anchor_id : Int64;
		public var player_pstid : Int64;
		public var pre_aff : int;
		public var new_aff : int;
		public var player_name : String;
		public var player_zone : String;
	}
}
