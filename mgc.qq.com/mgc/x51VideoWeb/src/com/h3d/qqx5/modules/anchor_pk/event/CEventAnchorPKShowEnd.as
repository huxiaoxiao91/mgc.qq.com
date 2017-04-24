package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventAnchorPKShowEnd extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKShowEnd;
		}
		
		public function CEventAnchorPKShowEnd()
		{
			registerField("activity_id", "", Descriptor.Int32, 1);
		}
		
		public var activity_id : int;
	}
}
