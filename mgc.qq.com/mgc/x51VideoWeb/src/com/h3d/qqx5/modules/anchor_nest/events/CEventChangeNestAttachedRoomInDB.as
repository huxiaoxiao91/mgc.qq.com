package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class CEventChangeNestAttachedRoomInDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventChangeNestAttachedRoomInDB;
		}
		
		public function CEventChangeNestAttachedRoomInDB()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
		}
		
		public var nest_id : int;
		public var room_id : int;
	}
}
