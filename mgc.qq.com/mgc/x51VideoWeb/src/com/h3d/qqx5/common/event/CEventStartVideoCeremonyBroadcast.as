package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.comdata.RoomIdName;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventStartVideoCeremonyBroadcast extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventStartVideoCeremonyBroadcast;
		}
		
		public function CEventStartVideoCeremonyBroadcast()
		{
			registerFieldForList("addition_rooms", getQualifiedClassName(RoomIdName), Descriptor.Compound, 1);
			registerFieldForList("anchors", "", Descriptor.TypeString, 2);
		}
		
		public var addition_rooms : Array = new Array;
		public var anchors : Array = new Array;
	}
}
