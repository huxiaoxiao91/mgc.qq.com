package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventAnchorPKNotifyClearAvatar extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyClearAvatar;
		}
		
		public function CEventAnchorPKNotifyClearAvatar()
		{
			registerField("anchorA_qq", "", Descriptor.Int64, 1);
			registerField("anchorB_qq", "", Descriptor.Int64, 2);
		}
		
		public var anchorA_qq : Int64;
		public var anchorB_qq : Int64;
	}
}
