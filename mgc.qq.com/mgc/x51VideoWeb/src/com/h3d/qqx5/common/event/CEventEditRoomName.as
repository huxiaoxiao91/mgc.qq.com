package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.AnchorLoginDatabaseEventID;

	public class CEventEditRoomName extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorLoginDatabaseEventID.CLSID_CEventEditRoomName;
		}
		
		public function CEventEditRoomName()
		{
			registerField("new_name", "", Descriptor.TypeString, 1);
			registerField("vsid", "", Descriptor.Int32, 2);
			registerField("operator", "", Descriptor.Int64, 3);
		}
		
		public var new_name : String;
		public var vsid : int;
		public var operator:Int64;
	}
}
