package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventAnchorPKStopMatch extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKStopMatch;
		}
		
		public function CEventAnchorPKStopMatch()
		{
			registerField("admin_qq", "", Descriptor.Int64, 1);
		}
		
		public var admin_qq : Int64;
	}
}
