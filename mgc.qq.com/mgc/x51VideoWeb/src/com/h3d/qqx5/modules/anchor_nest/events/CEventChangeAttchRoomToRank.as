package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import flash.utils.getQualifiedClassName;
	public class CEventChangeAttchRoomToRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventChangeAttchRoomToRank;
		}
		
		public function CEventChangeAttchRoomToRank()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("nest_id", "", Descriptor.Int32, 2);
			registerField("new_room_id", "", Descriptor.Int32, 3);
		}
		
		public var room_id : int;
		public var nest_id : int;
		public var new_room_id : int;
	}
}
