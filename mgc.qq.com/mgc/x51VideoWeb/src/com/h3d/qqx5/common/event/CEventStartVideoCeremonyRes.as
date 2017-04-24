package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.comdata.ceremony.CeremonyStartAnchorInfo;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.VideoCeremonyEventId;

	public class CEventStartVideoCeremonyRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return VideoCeremonyEventId.CLSID_CEventStartVideoCeremonyRes;
		}
		
		public function CEventStartVideoCeremonyRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerFieldForList("anchors", getQualifiedClassName(CeremonyStartAnchorInfo), Descriptor.Compound, 2);
			registerField("transid", "", Descriptor.Int64, 3);
			registerField("room_id", "", Descriptor.Int32, 4);
			registerField("main_room_id", "", Descriptor.Int32, 5);
		}
		
		public var result : int;
		public var anchors : Array = new Array;
		public var transid : Int64;
		public var room_id : int;
		public var main_room_id : int;
	}
}
