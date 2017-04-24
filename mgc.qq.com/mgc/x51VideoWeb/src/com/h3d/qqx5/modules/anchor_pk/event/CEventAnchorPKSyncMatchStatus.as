package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventAnchorPKSyncMatchStatus extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKSyncMatchStatus;
		}
		
		public function CEventAnchorPKSyncMatchStatus()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerField("old_status", "", Descriptor.Int32, 2);
			registerField("new_stauts_seconds", "", Descriptor.Int32, 3);
			registerField("extra_data", "", Descriptor.Int32, 4);
		}
		
		public var status : int;
		public var old_status : int;
		public var new_stauts_seconds : int;
		public var extra_data : int;
	}
}
