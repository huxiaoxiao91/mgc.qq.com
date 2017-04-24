package com.h3d.qqx5.common.event
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;
	import com.h3d.qqx5.common.event.eventid.EEventIDVideoRoom;

	public class CEventDelDeputyAnchor extends INetMessage
	{
		public override function CLSID() : int
		{
			return EEventIDVideoRoom.CLSID_CEventDelDeputyAnchor;
		}
		
		public function CEventDelDeputyAnchor()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("player_id", "", Descriptor.Int64, 2);
			registerField("is_anchor_or_admin", "", Descriptor.TypeBoolean, 3);
		}
		
		public var room_id : int;
		public var player_id : Int64;
		public var is_anchor_or_admin : Boolean;
	}
}
