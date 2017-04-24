package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventVideoRoomLoadProgrammeRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventVideoRoomLoadProgrammeRes;
		}
		
		public function CEventVideoRoomLoadProgrammeRes()
		{
			registerField("result", "", Descriptor.Int32, 1);
			registerFieldForList("programme", getQualifiedClassName(VideoProgrammeInfo), Descriptor.Compound, 2);
			registerField("live", "", Descriptor.TypeBoolean, 3);
		}
		
		public var result : int;
		public var programme : Array = new Array;
		public var live : Boolean;
	}
}
