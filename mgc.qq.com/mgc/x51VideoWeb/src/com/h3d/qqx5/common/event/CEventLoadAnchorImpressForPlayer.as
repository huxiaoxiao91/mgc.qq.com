package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoomExt;
	
	public class CEventLoadAnchorImpressForPlayer extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoomExt.CLSID_CEventLoadAnchorImpressForPlayer;
		}
		
		public function CEventLoadAnchorImpressForPlayer()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
		}
		
		public var player_id : Int64;
		public var anchor_id : Int64;
		public var trans_id : Int64;
	}
}
