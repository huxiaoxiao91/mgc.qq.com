package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.VideoAccount;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.AnchorLoginDatabaseEventID;

	public class CEventEditVideoAccountRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorLoginDatabaseEventID.CLSID_CEventEditVideoAccountRes;
		}
		
		public function CEventEditVideoAccountRes()
		{
			registerField("account", getQualifiedClassName(VideoAccount), Descriptor.Compound, 1);
			registerField("succ", "", Descriptor.TypeBoolean, 2);
		}
		public var account : VideoAccount= new VideoAccount;
		public var succ : Boolean;
	}
}
