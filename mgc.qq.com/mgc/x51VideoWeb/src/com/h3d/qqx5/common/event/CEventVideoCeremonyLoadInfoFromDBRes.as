package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyAnchorInfoDB;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyLoadInfoFromDBRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyLoadInfoFromDBRes;
		}
		
		public function CEventVideoCeremonyLoadInfoFromDBRes()
		{
			registerFieldForList("info", getQualifiedClassName(CeremonyAnchorInfoDB), Descriptor.Compound, 1);
		}
		
		public var info : Array = new Array;
	}
}
