package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.framework.network.Descriptor;
	public class CEventDelAnchorNestRank extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventDelAnchorNestRank;
		}
		
		public function CEventDelAnchorNestRank()
		{
			registerField("room_id", "", Descriptor.Int32, 1);
			registerField("nest_id", "", Descriptor.Int32, 2);
		}
		
		public var room_id : int;
		public var nest_id : int;
	}
}
