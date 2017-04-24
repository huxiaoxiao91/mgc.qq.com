package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventLoadAnchorNestInfoRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventLoadAnchorNestInfoRes;
		}
		
		public function CEventLoadAnchorNestInfoRes()
		{
			registerField("result", "", Descriptor.Int32, 2);
			registerField("trans_id", "", Descriptor.Int64, 3);
		}
		
		public var result : int;
		public var trans_id : Int64;
	}
}
