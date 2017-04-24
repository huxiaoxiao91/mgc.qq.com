package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyAnchorInfo;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventVideoCeremonySyncDataInRoomServer extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventVideoCeremonySyncDataInRoomServer;
		}
		
		public function CEventVideoCeremonySyncDataInRoomServer()
		{
			registerField("ceremony_state", "", Descriptor.Int32, 1);
			registerFieldForList("anchors", getQualifiedClassName(CeremonyAnchorInfo), Descriptor.Compound, 2);
			registerField("room_id", "", Descriptor.Int32, 3);
		}
		
		public var ceremony_state : int;
		public var anchors : Array = new Array;
		public var room_id : int;
	}
}
