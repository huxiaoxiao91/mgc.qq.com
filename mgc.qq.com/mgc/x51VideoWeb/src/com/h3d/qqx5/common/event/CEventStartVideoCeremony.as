package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyStartAnchorInfo;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventStartVideoCeremony extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventStartVideoCeremony;
		}
		
		public function CEventStartVideoCeremony()
		{
			registerFieldForList("anchors", getQualifiedClassName(CeremonyStartAnchorInfo), Descriptor.Compound, 1);
			registerField("sender_room_id", "", Descriptor.Int32, 2);
			registerField("transid", "", Descriptor.Int64, 3);
			registerField("sender_id", "", Descriptor.Int64, 4);
		}
		
		public var anchors : Array = new Array;
		public var sender_room_id : int;
		public var transid : Int64;
		public var sender_id : Int64;
	}
}
