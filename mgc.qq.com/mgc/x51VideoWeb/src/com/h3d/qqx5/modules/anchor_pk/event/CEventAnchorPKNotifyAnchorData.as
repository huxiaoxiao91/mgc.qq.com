package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorPKNotifyAnchorData extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyAnchorData;
		}
		
		public function CEventAnchorPKNotifyAnchorData()
		{
			registerField("anchorA", "", Descriptor.Int64, 1);
			registerField("anchorA_data", "", Descriptor.Int64, 2);
			registerField("anchorB", "", Descriptor.Int64, 3);
			registerField("anchorB_data", "", Descriptor.Int64, 4);
			registerField("anchorA_score", "", Descriptor.Int32, 5);
			registerField("anchorB_score", "", Descriptor.Int32, 6);
		}
		
		public var anchorA : Int64;
		public var anchorA_data : Int64;
		public var anchorB : Int64;
		public var anchorB_data : Int64;
		public var anchorA_score : int;
		public var anchorB_score : int;
	}
}
