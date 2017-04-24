package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventAnchorPKPreAttack extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKPreAttack;
		}
		
		public function CEventAnchorPKPreAttack()
		{
			registerField("next_phase", "", Descriptor.Int32, 1);
		}
		
		public var next_phase : int;
	}
}
