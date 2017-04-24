package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventAnchorPKStopMatchRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKStopMatchRes;
		}
		
		public function CEventAnchorPKStopMatchRes()
		{
			registerField("admin_qq", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
		}
		
		public var admin_qq : Int64;
		public var result : int;
	}
}
