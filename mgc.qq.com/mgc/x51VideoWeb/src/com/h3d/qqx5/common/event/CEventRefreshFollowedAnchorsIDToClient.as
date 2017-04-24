package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventRefreshFollowedAnchorsIDToClient extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventRefreshFollowedAnchorsIDToClient;
		}
		
		public function CEventRefreshFollowedAnchorsIDToClient()
		{
			registerFieldForList("ids", "", Descriptor.Int64, 1);
		}
		
		public var ids : Array= new Array;
	}
}
