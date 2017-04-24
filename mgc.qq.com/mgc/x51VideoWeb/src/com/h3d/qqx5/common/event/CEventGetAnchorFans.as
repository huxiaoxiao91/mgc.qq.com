package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoPersonalCardEventID;

	public class CEventGetAnchorFans extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoPersonalCardEventID.CLSID_CEventGetAnchorFans;
		}
		
		public function CEventGetAnchorFans()
		{
			registerField("trans_id", "", Descriptor.Int64, 1);
			registerField("anchor_id", "", Descriptor.Int64, 2);
		}
		
		public var trans_id : Int64;
		public var anchor_id : Int64;
	}
}
