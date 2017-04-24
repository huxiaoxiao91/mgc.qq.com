package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.AnchorData;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.AnchorSyncInfoEventID;

	public class CEventSyncAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorSyncInfoEventID.CLSID_CEventSyncAnchor;
		}
		
		public function CEventSyncAnchor()
		{
			registerField("acc_id", "", Descriptor.Int64, 1);
			registerField("data", getQualifiedClassName(AnchorData), Descriptor.Compound, 2);
		}
		
		public var acc_id : Int64;
		public var data :AnchorData = new AnchorData;
	}
}
