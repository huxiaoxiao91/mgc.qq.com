package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class CEventChangeNestStatusInDB extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventChangeNestStatusInDB;
		}
		
		public function CEventChangeNestStatusInDB()
		{
			registerField("nest_id", "", Descriptor.Int32, 1);
			registerField("stat", "", Descriptor.Int32, 2);
			registerField("reason", "", Descriptor.Int32, 3);
		}
		
		public var nest_id : int;
		public var stat : int;
		public var reason : int;
	}
}
