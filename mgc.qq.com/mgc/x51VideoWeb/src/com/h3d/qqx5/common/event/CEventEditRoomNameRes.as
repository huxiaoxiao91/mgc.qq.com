package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.AnchorLoginDatabaseEventID;

	public class CEventEditRoomNameRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorLoginDatabaseEventID.CLSID_CEventEditRoomNameRes;
		}
		
		public function CEventEditRoomNameRes()
		{
			registerField("new_name", "", Descriptor.TypeString, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("operator", "", Descriptor.Int64, 3);
		}
		
		public var new_name : String;
		public var result : int;
		public var operator : Int64;
	}
}
