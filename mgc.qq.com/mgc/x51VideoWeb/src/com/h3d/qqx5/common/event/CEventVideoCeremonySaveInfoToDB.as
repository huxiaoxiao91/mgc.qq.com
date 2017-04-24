package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyAnchorInfoDB;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonySaveInfoToDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonySaveInfoToDB;
		}
		
		public function CEventVideoCeremonySaveInfoToDB()
		{
			registerFieldForList("info", getQualifiedClassName(CeremonyAnchorInfoDB), Descriptor.Compound, 1);
		}
		
		public var info : Array = new Array;
	}
}
