package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyRefreshInfo;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventRefreshVideoCeremonyActivity extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventRefreshVideoCeremonyActivity;
		}
		
		public function CEventRefreshVideoCeremonyActivity()
		{
			registerField("info", getQualifiedClassName(CeremonyRefreshInfo), Descriptor.Compound, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var info :CeremonyRefreshInfo = new CeremonyRefreshInfo;
		public var room_id : int;
	}
}
