package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorNestNormalSupport extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventAnchorNestNormalSupport;
		}
		
		public function CEventAnchorNestNormalSupport()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
		}
		
		public var player_id : Int64;
	}
}
