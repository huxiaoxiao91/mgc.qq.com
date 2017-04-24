package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventAnchorPKStartMatch extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKStartMatch;
		}
		
		public function CEventAnchorPKStartMatch()
		{
			registerField("admin_qq", "", Descriptor.Int64, 1);
			registerField("anchor_a", "", Descriptor.Int64, 2);
			registerField("anchor_b", "", Descriptor.Int64, 3);
		}
		
		public var admin_qq : Int64;
		public var anchor_a : Int64;
		public var anchor_b : Int64;
	}
}
