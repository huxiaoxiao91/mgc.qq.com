package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorNestNormalSupportRes extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventAnchorNestNormalSupportRes;
		}
		
		public function CEventAnchorNestNormalSupportRes()
		{
			registerField("player_id", "", Descriptor.Int64, 1);
			registerField("result", "", Descriptor.Int32, 2);
			registerField("star", "", Descriptor.Int64, 3);
			registerField("add_popularity", "", Descriptor.Int32, 4);
		}
		
		public var player_id : Int64;
		public var result : int;
		public var star : Int64;
		public var add_popularity : int;
	}
}
