package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.util.Int64;

	public class CEventFreezeNestByOwnerQQ extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventFreezeNestByOwnerQQ;
		}
		
		public function CEventFreezeNestByOwnerQQ()
		{
			registerField("owner_qq", "", Descriptor.Int64, 1);
			registerField("room_id", "", Descriptor.Int32, 2);
			registerField("is_freeze", "", Descriptor.Int32, 3);
		}
		
		public var owner_qq : Int64;
		public var room_id : int;
		public var is_freeze : int;
	}
}
