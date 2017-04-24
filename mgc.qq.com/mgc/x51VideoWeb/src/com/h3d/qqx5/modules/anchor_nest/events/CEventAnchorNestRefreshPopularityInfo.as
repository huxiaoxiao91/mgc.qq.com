package com.h3d.qqx5.modules.anchor_nest.events
{
	import com.h3d.qqx5.framework.network.Descriptor;
	import com.h3d.qqx5.framework.network.INetMessage;
	import com.h3d.qqx5.util.Int64;

	public class CEventAnchorNestRefreshPopularityInfo extends INetMessage
	{
		public override function CLSID() : int
		{
			return AnchorNestEventID.CLSID_CEventAnchorNestRefreshPopularityInfo;
		}
		
		public function CEventAnchorNestRefreshPopularityInfo()
		{
			registerField("popularity", "", Descriptor.Int64, 1);
			registerField("num", "", Descriptor.Int32, 2);
			registerField("gap", "", Descriptor.Int64, 3);
			registerField("daily_reduce", "", Descriptor.Int32, 4);
			registerField("owner_qq", "", Descriptor.Int64, 5);
			registerField("player_id", "", Descriptor.Int64, 6);
		}
		
		public var popularity : Int64;
		public var num : int;
		public var gap : Int64;
		public var daily_reduce : int;
		public var owner_qq : Int64;
		public var player_id : Int64;
	}
}
