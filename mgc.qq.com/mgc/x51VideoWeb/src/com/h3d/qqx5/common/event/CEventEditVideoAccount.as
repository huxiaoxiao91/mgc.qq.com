package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAccount;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.AnchorLoginDatabaseEventID;

	public class CEventEditVideoAccount extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorLoginDatabaseEventID.CLSID_CEventEditVideoAccount;
		}
		
		public function CEventEditVideoAccount()
		{
			registerField("account", getQualifiedClassName(VideoAccount), Descriptor.Compound, 1);
			registerField("vsid", "", Descriptor.Int32, 2);
		}
		
		public var account : VideoAccount = new VideoAccount;
		public var vsid : int;
	}
}
