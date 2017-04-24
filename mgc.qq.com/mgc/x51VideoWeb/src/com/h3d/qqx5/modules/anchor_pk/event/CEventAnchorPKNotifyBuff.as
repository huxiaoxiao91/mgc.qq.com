package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	public class CEventAnchorPKNotifyBuff extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKNotifyBuff;
		}
		
		public function CEventAnchorPKNotifyBuff()
		{
			registerField("anchor_qq", "", Descriptor.Int64, 1);
			registerField("time_len", "", Descriptor.Int32, 2);
		}
		
		public var anchor_qq : Int64;
		public var time_len : int;
	}
}
