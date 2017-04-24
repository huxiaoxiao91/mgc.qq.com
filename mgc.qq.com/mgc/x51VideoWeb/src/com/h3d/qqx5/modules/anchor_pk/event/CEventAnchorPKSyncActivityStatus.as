package com.h3d.qqx5.modules.anchor_pk.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	public class CEventAnchorPKSyncActivityStatus extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoAnchorPKEventID.CLSID_CEventAnchorPKSyncActivityStatus;
		}
		
		public function CEventAnchorPKSyncActivityStatus()
		{
			registerField("status", "", Descriptor.Int32, 1);
			registerFieldForList("rooms", "", Descriptor.Int32, 2);
		}
		
		public var status : int;
		public var rooms : Array=new Array();
	}
}
