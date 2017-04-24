package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyStartInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonyStartInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonyStartInfo;
		}
		
		public function CEventVideoCeremonyStartInfo()
		{
			registerField("info", getQualifiedClassName( com.h3d.qqx5.common.comdata.ceremony.CeremonyStartInfo), Descriptor.Compound, 1);
			registerField("ceremony_state", "", Descriptor.Int32, 2);
		}
		
		public var info :CeremonyStartInfo = new CeremonyStartInfo;
		public var ceremony_state : int;
	}
}
