package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyChooseSupportAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyChooseSupportAnchor;
		}
		
		public function CEventVideoCeremonyChooseSupportAnchor()
		{
			registerField("support_anchor", "", Descriptor.Int64, 1);
			registerField("player_pstid", "", Descriptor.Int64, 2);
		}
		
		public var support_anchor : Int64;
		public var player_pstid : Int64;
	}
}
