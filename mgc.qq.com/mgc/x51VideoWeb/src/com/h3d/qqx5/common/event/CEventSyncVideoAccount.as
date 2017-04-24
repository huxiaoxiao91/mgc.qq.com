package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAccount;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.AnchorSyncInfoEventID;

	public class CEventSyncVideoAccount extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorSyncInfoEventID.CLSID_CEventSyncVideoAccount;
		}
		
		public function CEventSyncVideoAccount()
		{
			registerField("acc_id", "", Descriptor.Int64, 1);
			registerField("account", getQualifiedClassName( VideoAccount), Descriptor.Compound, 2);
		}
		
		public var acc_id : Int64;
		public var account :VideoAccount = new VideoAccount;
	}
}
