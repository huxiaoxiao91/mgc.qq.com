package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.common.event.eventid.AnchorLoginDatabaseEventID;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorNameChangeNotify extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorLoginDatabaseEventID.CLSID_CEventAnchorNameChangeNotify;
		}
		
		public function CEventAnchorNameChangeNotify()
		{
			registerField("anchor_id", "", Descriptor.Int64, 1);
			registerField("name", "", Descriptor.TypeString, 2);
		}
		
		public var anchor_id : Int64 = new Int64(0,0);
		public var name : String = "";
	}
}
