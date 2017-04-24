package com.h3d.qqx5.modules.anchor_pk.event
{
	
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class CEventAnchorPKMatchStop extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKMatchStop;
		}
		
		public function CEventAnchorPKMatchStop()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
		}
		
		public var activity_id : int;
	}
}
